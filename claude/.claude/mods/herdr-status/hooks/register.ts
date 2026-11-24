import type { EngineInterface, Register } from 'claude-code'

// Publishes the session's state for Herdr's mods: plan limits to
// ~/.cache/herdr-claude/limits.json (jj-limits), and the session, its folder,
// model, effort and context use as claude.* labels on the Herdr terminal
// (jj-agents, jj-spaces, jj-pane).

// "claude-opus-5-5[1m]" -> "Opus 5.5"; anything else as it is.
function modelName(model: string): string {
  const m = model.match(/^claude-([a-z]+)-(\d+)(?:-(\d{1,2})(?!\d))?/)
  if (!m || !m[1] || !m[2]) return model
  return `${m[1][0]?.toUpperCase()}${m[1].slice(1)} ${m[2]}${m[3] ? `.${m[3]}` : ''}`
}

let effort: string | undefined
let lastLimits = ''
let lastLabels = ''

async function publish($: EngineInterface) {
  const [usage, id, root, model, home, terminal] = await Promise.all([
    $.session.usage(),
    $.session.id(),
    $.session.root(),
    $.session.model(),
    $.env.get('HOME'),
    $.env.get('HC_TERMINAL_ID'),
  ])

  const limits = JSON.stringify(
    Object.fromEntries(
      usage.rateLimits.map(r => [
        r.kind,
        {
          used_percentage: r.percentUsed,
          resets_at: r.resetsAt ? Math.round(Date.parse(r.resetsAt) / 1000) : undefined,
        },
      ]),
    ),
  )
  if (home && usage.rateLimits.length > 0 && limits !== lastLimits) {
    await $.fs.write(`${home}/.cache/herdr-claude/limits.json`, `${limits}\n`)
    lastLimits = limits
  }

  if (!terminal) return
  const argv = [
    'hc',
    'label',
    terminal,
    `claude.session=${id}`,
    `claude.cwd=${root}`,
    `claude.model=${modelName(model)}`,
    `claude.effort=${effort ?? ''}`,
    `claude.context=${usage.context.percent ?? ''}`,
    `claude.context_size=${usage.context.window}`,
  ]
  const labels = argv.join('\0')
  if (labels === lastLabels) return
  const { exitCode } = await $.process.run(argv)
  if (exitCode === 0) lastLabels = labels
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    const result = await next(e)
    effort ??= await $.env.get('CLAUDE_EFFORT')
    await publish($).catch(() => {})
    return result
  })

  on('turn.step', async function* ($, e, next) {
    if (e.agentId === undefined && typeof e.effort === 'string') effort = e.effort
    const result = yield* next(e)
    if (e.agentId === undefined) await publish($).catch(() => {})
    return result
  })

  on('session.compact', async ($, e, next) => {
    const result = await next(e)
    await publish($).catch(() => {})
    return result
  }).catch(($, e, next) => next(e))
}
