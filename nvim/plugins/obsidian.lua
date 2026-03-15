require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "main",
			path = "~/obsidian/main",
		},
		{
			name = "journal",
			path = "~/obsidian/journal",
		},
	},
	picker = {
		name = nil,
		note_mappings = {
			new = "<C-x>",
			insert_link = "<C-l>",
		},
		tag_mappings = {
			tag_note = "<C-j>",
			insert_tag = "<C-l>",
			rename_tag = "<C-x>",
		},
	},
	callbacks = {
		enter_note = function(note)
			local new_from_template = function(title, template, label)
				local api = require("obsidian.api")
				local original_buf = vim.api.nvim_get_current_buf()
				local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

				api.new_from_template(title, template, function(nte)
					vim.api.nvim_set_current_buf(original_buf)

					local link = nte:format_link({ label = label or nte:display_name() })

					-- Append to current line
					local line = vim.api.nvim_buf_get_lines(original_buf, cursor_line - 1, cursor_line, false)[1]
					vim.api.nvim_buf_set_lines(
						original_buf,
						cursor_line - 1,
						cursor_line,
						false,
						{ line .. " " .. link }
					)

					vim.cmd("silent! write")
					nte:open({ sync = false })
				end)
			end

			-- Create new meeting
			vim.keymap.set("n", "<leader>wnm", function()
				local ok, name = pcall(vim.fn.input, "Meeting with: ")
				if not ok or not name or name == "" then
					return
				end
				new_from_template("meeting", "meeting", name)
			end, {
				buffer = true,
				desc = "[N]ew [M]eeting",
			})
			vim.keymap.set("n", "<C-Up>", "<cmd>Obsidian dailies<CR>", {
				buffer = true,
				desc = "Open Dailies",
			})
			-- Next/prior link
			vim.keymap.set("n", "<Tab>", function()
				require("obsidian.api").nav_link("next")
			end, {
				buffer = true,
				desc = "Go to next link",
			})
			vim.keymap.set("n", "<S-Tab>", function()
				require("obsidian.api").nav_link("prev")
			end, {
				buffer = true,
				desc = "Go to previous link",
			})
		end,
	},
	daily_notes = {
		folder = "diary",
		date_format = "%Y-%m-%d",
		template = "daily.md",
	},
	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		substitutions = {},
		customizations = {
			meeting = {
				notes_subdir = "meetings",
				note_id_func = function(title, path)
					return tostring(os.date("%Y-%m-%d-%H%M%S"))
				end,
			},
			project = {
				notes_subdir = "projects",
			},
		},
	},
	ui = {
		enable = false,
	},
	checkbox = {
		enabled = true,
		create_new = true,
		order = { " ", "x" },
	},
	note_id_func = function(title)
		local suffix = ""
		if title ~= nil then
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.date("%Y-%m-%d-%H%M%S")) .. "-" .. suffix
	end,
})
-- vim: ts=2 sts=2 sw=2 et
