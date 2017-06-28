local alert = require "hs.alert"

local keys = require "keys"
require "window_management"
require "capslock_to_esc_and_ctrl"
require "app_shortcuts"
require "anycomplete"

keys.deactivateKeys()
keys.activateKeys()

hs.window.animationDuration = 0

alert.show("Hammerspoon loaded!")

