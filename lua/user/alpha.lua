-- local status_ok, alpha = pcall(require, "alpha")
-- if not status_ok then
--   return
-- end
--
-- local dashboard = require "alpha.themes.dashboard"
-- dashboard.section.header.val = {
--   -- [[                               __                ]],
--   -- [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--   -- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--   -- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--   -- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--   -- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- [[⣿⡟⠙⠛⠋⠩⠭⣉⡛⢛⠫⠭⠄⠒⠄⠄⠄⠈⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
-- [[⣿⡇⠄⠄⠄⠄⣠⠖⠋⣀⡤⠄⠒⠄⠄⠄⠄⠄⠄⠄⠄⠄⣈⡭⠭⠄⠄⠄⠉⠙]],
-- [[⣿⡇⠄⠄⢀⣞⣡⠴⠚⠁⠄⠄⢀⠠⠄⠄⠄⠄⠄⠄⠄⠉⠄⠄⠄⠄⠄⠄⠄⠄]],
-- [[⣿⡇⠄⡴⠁⡜⣵⢗⢀⠄⢠⡔⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
-- [[⣿⡇⡜⠄⡜⠄⠄⠄⠉⣠⠋⠠⠄⢀⡄⠄⠄⣠⣆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸]],
-- [[⣿⠸⠄⡼⠄⠄⠄⠄⢰⠁⠄⠄⠄⠈⣀⣠⣬⣭⣛⠄⠁⠄⡄⠄⠄⠄⠄⠄⢀⣿]],
-- [[⣏⠄⢀⠁⠄⠄⠄⠄⠇⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⡇⠄⠄⡇⠄⠄⠄⠄⢀⣾⣿]],
-- [[⣿⣸⠈⠄⠄⠰⠾⠴⢾⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣾⢀⠁⠄⠄⠄⢠⢸⣿⣿]],
-- [[⣿⣿⣆⠄⠆⠄⣦⣶⣦⣌⣿⣿⣿⣿⣷⣋⣀⣈⠙⠛⡛⠌⠄⠄⠄⠄⢸⢸⣿⣿]],
-- [[⣿⣿⣿⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠈⠄⠄⠄⠄⠄⠈⢸⣿⣿]],
-- [[⣿⣿⣿⠄⠄⠄⠘⣿⣿⣿⡆⢀⣈⣉⢉⣿⣿⣯⣄⡄⠄⠄⠄⠄⠄⠄⠄⠈⣿⣿]],
-- [[⣿⣿⡟⡜⠄⠄⠄⠄⠙⠿⣿⣧⣽⣍⣾⣿⠿⠛⠁⠄⠄⠄⠄⠄⠄⠄⠄⠃⢿⣿]],
-- [[⣿⡿⠰⠄⠄⠄⠄⠄⠄⠄⠄⠈⠉⠩⠔⠒⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠘⣿]],
-- [[⣿⠃⠃⠄⠄⠄⠄⠄⠄⣀⢀⠄⠄⡀⡀⢀⣤⣴⣤⣤⣀⣀⠄⠄⠄⠄⠄⠄⠁⢹]]
-- }
-- dashboard.section.buttons.val = {
 --  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
 --  -- dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
 --  dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
 --  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
 -- -- dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
 --  dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
 --  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
-- }
-- local function footer()
--   return "こんばんは \n  ニール"
-- end
--
-- dashboard.section.footer.val = footer()
--
-- dashboard.section.footer.opts.hl = "Type"
-- dashboard.section.header.opts.hl = "Include"
-- dashboard.section.buttons.opts.hl = "Keyword"
--
-- dashboard.opts.opts.noautocmd = true
-- alpha.setup(dashboard.opts)


local present, alpha = pcall(require, "alpha")
if not present then
	return
end

local header = {
	type = "text",
	val = {
    [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠋⠉⣉⣉⠙⠿⠋⣠⢴⣊⣙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⢀⠔⡩⠔⠒⠛⠧⣾⠊⢁⣀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⡡⠊⠀⠀⣀⣠⣤⣌⣾⣿⠏⠀⡈⢿⡜⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⣤⣶⠏⢁⠈⢻⡏⠙⠛⠀⣀⣁⣤⢢⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣄⡀⠣⣌⡙⠀⣘⡁⠜⠈⠑⢮⡭⠴⠚⠉⠀⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⠁⠀⢀⠔⠁⣀⣤⣤⣤⣤⣤⣄⣀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠁⠀⢀⣠⢠⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⡀⠀⢸⠀⢼⣿⣿⣶⣭⣭⣭⣟⣛⣛⡿⠷⠶⠶⢶⣶⣤⣤⣤⣶⣶⣾⡿⠿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠈⠉⠉⠉⠉⠉⠙⠛⠛⠻⠿⠿⠿⠷⣶⣶⣶⣶⣶⣶⣶⣶⡾⢗⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣝⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],

-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣀⡀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⣠⣴⡶⢶⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⣾⠋⠙⢿⣆⣤⣤⣄⠀⠀⠀]],
-- [[⠀⠀⢰⣿⠁⠀⠀⠀⠙⢷⡄⠀⠀⠀⠀⠀⢸⡿⠀⠀⠀⠛⠉⠀⠹⣧⠀⠀]],
-- [[⠀⠀⣠⡿⠆⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⢠⣿⠀⠀]],
-- [[⢀⣾⠋⠀⠀⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀⢸⣧⠀⠀⠀⠀⢀⣴⡿⠁⠀⠀]],
-- [[⠀⠻⣶⣤⣤⣀⣀⣀⣠⣤⣤⣿⡇⠀⠀⠀⠈⣿⣀⣠⣤⡾⠟⠋⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⡀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⢀⣤⡾⠛⠋⠹⣷⠀⠀⠀⢸⣿⠛⠛⠉⠉⠉⠙⠛⠛⢷⣦⠀]],
-- [[⠀⠀⠀⠀⣴⡟⠉⠀⠀⠀⠀⣿⡇⠀⠀⠘⣿⡀⠀⠀⠀⠀⠀⠀⠀⣠⡿⠁]],
-- [[⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠘⣷⡀⠀⠀⠀⠀⢴⣾⠋⠀⠀]],
-- [[⠀⠀⠀⢻⣇⠀⠀⢀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠙⢷⣄⠀⠀⠀⠀⣿⠇⠀⠀]],
-- [[⠀⠀⠀⠀⠙⠷⠾⠛⢷⣄⣀⣾⠇⠀⠀⠀⠀⠀⠀⠙⠻⠶⠾⠟⠋⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	},
	opts = {
		position = "center",
		hl = "AlphaAscii",
	},
}

local plugins_gen = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" ')
local plugins = plugins_gen:read("*a")
plugins_gen:close()

local date_gen = io.popen('echo "$(date +%d)/$(date +%m)/$(date +%y)($(date +%a))$(date +%X)" | tr -d "\n"')
local date = date_gen:read("*a")
date_gen:close()

local id_gen = io.popen('shuf -i 10000000-99999999 -n 1 | tr -d "\n"')
local id = id_gen:read("*a")
id_gen:close()

local id_1 = tostring(tonumber(id) - 1)
local id_2 = tostring(tonumber(id) - 2)

-- local phrase_gen = io.popen('sh "$HOME"/scripts/other/random_4chin_word.sh | tr -d "\n"')
-- local phrase = phrase_gen:read("*a")
-- phrase_gen:close()

local heading = {
	type = "text",
	val = "  Anonymous " .. date .. " No." .. id .. " ",
	opts = {
		position = "center",
		hl = "AlphaButtons",
	},
}

local post_buttons = {
	type = "text",
	val = " They don't get it. For me, it's nvim.",
	opts = {
		position = "center",
		hl = "AlphaFooter",
	},
}

local pre_foot = {
	type = "text",
	val = " >>" .. id_2 .. "(OP)                      ",
	opts = {
		position = "center",
		hl = "AlphaEmphasis",
	},
}

local footer = {
	type = "text",
	val = " I've " .. plugins .. " plugins, it launches instantly kek.",
	opts = {
		position = "center",
		hl = "AlphaFooter",
	},
}

local pre_foot_2 = {
	type = "text",
	val = " >>" .. id_1 .. "                                ",
	opts = {
		position = "center",
		hl = "AlphaEmphasis",
	},
}

-- local footer_2 = {
-- 	type = "text",
-- 	val = " " .. phrase .. "      ",
-- 	opts = {
-- 		position = "center",
-- 		hl = "AlphaFooter",
-- 	},
-- }

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 0,
		width = 44,
		align_shortcut = "right",
		hl_shortcut = "AlphaShortcuts",
		hl = "AlphaHeader",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
  button("f", ">find file", ":Telescope find_files <CR>"),
  button("p", ">find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  button("r", ">recent files", ":Telescope oldfiles <CR>"),
  button("s", ">scratchpad", ":e ~/documents/scratchpad <CR>"),
  button("t", ">todolist", ":e ~/documents/todolist <CR>"),
  button("c", ">config", ":e ~/.config/nvim/init.lua <CR>"),
  button("q", ">quit", ":qa<CR>"),
	},
	opts = {
		spacing = 0,
	},
}

local section = {
	header = header,
	buttons = buttons,
	heading = heading,
	post_buttons = post_buttons,
	pre_foot = pre_foot,
	footer = footer,
	pre_foot_2 = pre_foot_2,
	-- footer_2 = footer_2,
}

local opts = {
	layout = {
		{ type = "padding", val = 3 },
		section.header,
		{ type = "padding", val = 1 },
		section.heading,
		{ type = "padding", val = 1 },
		section.buttons,
		-- section.post_buttons,
		-- { type = "padding", val = 1 },
		-- section.pre_foot,
		-- section.footer,
		-- { type = "padding", val = 1 },
		-- section.pre_foot_2,
		-- section.footer_2,
	},
	opts = {
		margin = 44,
	},
}
alpha.setup(opts)
