return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	dev = true,
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "main",
				path = "~/obsidian/main",
			},
		},
		callbacks = {
			enter_note = function(note)
				local new_from_template = function(title, template)
					local api = require("obsidian.api")
					local original_buf = vim.api.nvim_get_current_buf()
					local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

					api.new_from_template(title, template, function(nte)
						vim.api.nvim_set_current_buf(original_buf)

						local link = nte:format_link({ label = nte:display_name() })

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
				vim.keymap.set("n", "<leader>nm", function()
					local title = "meeting"
					local template = "meeting"
					new_from_template(title, template)
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
			-- Optional, if you keep daily notes in a separate directory.
			folder = "diary",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-plan" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "daily.md",
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
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
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.date("%Y-%m-%d-%H%M%S")) .. "-" .. suffix
		end,
	},
}
