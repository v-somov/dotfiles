-- Initial theme from the macOS appearance, so there's no flash before
-- auto-dark-mode.nvim takes over.
if vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }):match("Dark") then
  vim.o.background = "dark"
  vim.cmd.colorscheme("catppuccin-macchiato")
else
  vim.o.background = "light"
  vim.cmd.colorscheme("solarized8")
end
