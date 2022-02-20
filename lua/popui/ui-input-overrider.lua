local popfix = require"popfix"
local borders = require"popui/borders"

local popupReference = nil

local customUIInput = function(opts, onConfirm)
  assert(
    popupReference == nil,
    "Busy in other LSP popup."
  )

  popupReference = popfix:new({
    close_on_bufleave = true,
    keymaps = {
      i = {
        ['<Cr>'] = function(popup)
          popup:close(function(_, text) onConfirm(text) end)
          popupReference = nil
        end,
        ['<Esc>'] = function(popup)
          popup:close()
          popupReference = nil
        end
      },
    },
    callbacks = {
      close = function()
        popupReference = nil
      end
    },
    mode = 'cursor',
    prompt = {
		border = true,
		numbering = true,
		title = opts.prompt,
        border_chars = borders[vim.g.popui_border_style or "rounded"],
		highlight = 'Normal',
		prompt_highlight = 'Normal'
	},
    data = {"textinput"}
  })
end

return customUIInput
