local speed = require("speed")

local tutorial_cmds = {
  ["toggle"]= speed.toggle
}

vim.api.nvim_create_user_command("Speed", function(args)
  local cmd = args.args:sub(1, (args.args:find(" ") or (#args.args + 1)) - 1)

  if vim.tbl_contains(vim.tbl_keys(tutorial_cmds), cmd) then
    tutorial_cmds[cmd]()
  end
end, {
  nargs = "?",
  bang = true,
  -- sets up completion for the `:Do` command
  complete = function(_, cmd_line)
    local params = vim.split(cmd_line, "%s+", { trimempty = true, })

    if #params == 1 then
      return vim.tbl_keys(tutorial_cmds)
    end
  end,
})
