local alert = require "hs.alert"

local keys = require "keys"
require "window_management"
require "capslock_to_esc_and_ctrl"
require "app_shortcuts"
require "websites"

keys.deactivateKeys()
keys.activateKeys()

hs.window.animationDuration = 0
hs.logger.defaultLogLevel="info"

hyper = {"ctrl","cmd"}
shift_hyper = {"ctrl","alt","shift"}

col = hs.drawing.color.x11

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/zzamboni/zzSpoons",
  desc = "zzamboni's spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true

Install=spoon.SpoonInstall

local wm=hs.webview.windowMasks
Install:andUse("PopupTranslateSelection",
               {
                 disable = false,
                 config = {
                   popup_style = wm.utility|wm.HUD|wm.titled|wm.closable|wm.resizable,
                 },
                 hotkeys = {
                   translate_to_en = { hyper, "e" },
                   translate_to_de = { hyper, "d" },
                 }
               }
)

Install:andUse("TextClipboardHistory",
               {
                 disable = false,
                 config = {
                   show_in_menubar = false,
                 },
                 hotkeys = {
                   toggle_clipboard = { hyper, "v" } },
                 start = true,
               }
)

alert.show("Hammerspoon loaded!")
