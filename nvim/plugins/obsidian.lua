return {
	"moberst/obsidian.nvim",
	lazy = false,
	dev = true,
	opts = {
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
					desc = "[W]iki [N]ew [M]eeting",
				})
				vim.keymap.set("n", "<leader>wnd", function()
					new_from_template("daily-plan", "dailyplan", "Daily Plan")
				end, {
					buffer = true,
					desc = "[W]iki [N]ew [D]aily Plan",
				})
				vim.keymap.set("n", "<leader>wnw", function()
					new_from_template("weekly-plan", "weeklyplan", "Weekly Plan")
				end, {
					buffer = true,
					desc = "[W]iki [N]ew [W]eekly Plan",
				})
				vim.keymap.set("n", "<leader>wld", function()
					require("obsidian.actions").insert_link_by_tag("planning/daily-plan", "Previous Daily Plan", 1)
				end, {
					buffer = true,
					desc = "[W]iki [L]ink Prior [D]ailiy plan",
				})
				vim.keymap.set("n", "<leader>wlw", function()
					require("obsidian.actions").insert_link_by_tag("planning/weekly-plan", "Weekly Plan")
				end, {
					buffer = true,
					desc = "[W]iki [L]ink [W]eekly plan",
				})
				vim.keymap.set("x", "<leader>wx", ":Obsidian extract_note<CR>", {
					buffer = true,
					desc = "[W]iki E[x]tract Note",
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
			enabled = true,
			folder = "diary",
			date_format = "%Y-%m-%d",
			alias_format = nil,
			default_tags = {},
			workdays_only = false,
			template = "daily.md",
		},
		templates = {
			folder = vim.fn.expand("$HOME") .. "/.config/obsidian-templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
			customizations = {
				dailyplan = {
					notes_subdir = "plans",
				},
				weeklyplan = {
					notes_subdir = "plans",
				},
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
