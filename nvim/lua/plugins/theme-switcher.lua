local utils = require("config.utils")

function SwitchTheme(theme)
	if theme == "dark" then
		vim.cmd("colorscheme nightfox")
		vim.cmd("set background=dark")
		os.execute("sh ~/switch_theme.sh dark")
	else
		vim.cmd("colorscheme solarized8")
		vim.cmd("set background=light")
		os.execute("sh ~/switch_theme.sh light")
	end
end

utils.lua_command("SetThemeDark", 'SwitchTheme("dark")')
utils.lua_command("SetThemeLight", 'SwitchTheme("light")')
utils.nmap("<leader>td", ":SetThemeDark<cr>")
utils.nmap("<leader>tl", ":SetThemeLight<cr>")
