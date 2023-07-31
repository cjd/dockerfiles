return {
  'anuvyklack/hydra.nvim',
  config = function()
    local Hydra = require('hydra')
    local cmd = require('hydra.keymap-util').cmd

    local hint = [[
    _f_: files        _m_: marks
    _o_: old files    _g_: live grep
    _p_: projects     _/_: search in file
    _r_: resume       _u_: undo
    _h_: vim help     _c_: citc workspaces
    _b_: file browser _;_: commands history 
    _d_: diagnostics  _n_: notifications
    _t_: terminal     _q_: quit
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
        { 'b', cmd 'Telescope file_browser' },
        { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
        { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
        { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
        { 'n', cmd 'Telescope noice'},
        { 'r', cmd 'Telescope resume' },
        { 'p', cmd 'Telescope project', { desc = 'projects' } },
        { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
        { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
        { 'c', cmd 'Telescope citc workspaces', { desc = 'workspaces' } },
        { 'u', cmd 'Telescope undo', { desc = 'undo' }},
        { 'd', cmd 'Telescope diagnostics' },
        { 't', cmd 'lua require("FTerm").toggle()',{desc = 'terminal'}},
        { 'q', cmd 'qa' },
        { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
      }
    })
  end
}
