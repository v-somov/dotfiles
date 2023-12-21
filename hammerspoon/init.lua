local alert = require "hs.alert"

local keys = require "keys"
require "window_management"
require "capslock_to_esc_and_ctrl"
require "app_shortcuts"

keys.deactivateKeys()
keys.activateKeys()

hs.window.animationDuration = 0
hs.logger.defaultLogLevel="info"

hyper = {"ctrl","cmd"}
shift_hyper = {"ctrl","alt","shift"}

col = hs.drawing.color.x11

alert.show("Hammerspoon loaded!")
