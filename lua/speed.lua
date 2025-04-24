local config = require("speed.config")

local Speed = {
  enabled = true,
  buf = nil,
  win = nil,
  keypressess = {}
}

function Speed.open()
  if Speed.enabled then
    if not Speed.buf then
      Speed.buf = vim.api.nvim_create_buf(false, true)
    end

    Speed.win = vim.api.nvim_open_win(Speed.buf, false, config.options.edit_win_config)
    vim.api.nvim_set_option_value("swapfile", false, { buf = Speed.buf, })

    Speed.update()
  end
end

function Speed.close()
  if Speed.win then
    vim.api.nvim_win_close(Speed.win, true)
    Speed.win = nil
  end

  if Speed.buf then
    vim.api.nvim_buf_delete(Speed.buf, { force = true, })
    Speed.buf = nil
  end
end

function Speed.toggle()
  Speed.enabled = not Speed.enabled
  if Speed.enabled then
    Speed.open()
  else
    Speed.close()
  end
end

-- drop the first n elements from a table in O(2n) time
local function drop_first_n(t, n)
  local len = #t
  -- shift elements n+1..len down to 1..len-n
  table.move(t, n + 1, len, 1)
  -- nil out the tail slots
  for i = len, len - n + 1, -1 do
    t[i] = nil
  end
end

function Speed.update()
  local curr_time = os.time()

  local old = 0
  for _, value in ipairs(Speed.keypressess) do
    if value < (curr_time - 5) then
      old = old + 1
    end
  end

  drop_first_n(Speed.keypressess, old)

  table.insert(Speed.keypressess, curr_time)

  vim.api.nvim_buf_set_lines(Speed.buf, 0, -1, false, {
    " " .. (#Speed.keypressess / 5) .. " keys/s",
  })
end

---@param opts SpeedOptions
function Speed.setup(opts)
  config.options = vim.tbl_deep_extend("force", config.default_opts, opts or {})
  Speed.enabled = config.options.enabled

  vim.api.nvim_create_autocmd({ "BufEnter", }, {
    callback = Speed.open,
  })

  vim.on_key(
    function(_, _)
      Speed.update()
    end,
    vim.api.nvim_create_namespace("speed_keypress")
  )
end

return Speed
