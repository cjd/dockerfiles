return {
  'anuvyklack/hydra.nvim',
  config = function()
    local Hydra = require('hydra')
    local cmd = require('hydra.keymap-util').cmd

    local hint = [[
    _f_: files        _/_: search in file
    _o_: old files    _g_: live grep
    _r_: resume       _u_: undo
    _t_: terminal     _q_: quit
    _;_: commands history 
    ^
    _<Enter>_: Telescope           _<Esc>_ ]]

    Hydra({
      name = 'Telescope',
      hint = hint,
      config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
          position = 'middle',
          border = 'rounded',
        },
      },
      mode = 'n',
      body = '<Leader> ',
      heads = {
        { 'f', cmd 'Telescope find_files' },
        { 'g', cmd 'Telescope live_grep' },
        { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
        { 'r', cmd 'Telescope resume' },
        { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
        { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
        { 'u', cmd 'Telescope undo', { desc = 'undo' }},
        { 't', cmd 'lua require("FTerm").toggle()',{desc = 'terminal'}},
        { 'q', cmd 'qa' },
        { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
      }
    })
  end
}
