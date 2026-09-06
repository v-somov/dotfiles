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

function appearanceChanged()
    local appearance = hs.host.interfaceStyle() or "Light"
    alert.show("Appearance changed to " .. appearance)
    if appearance == "Dark" then
        os.execute(os.getenv("HOME") .. "/dotfiles/scripts/switch_theme.sh dark")
    else
        os.execute(os.getenv("HOME") .. "/dotfiles/scripts/switch_theme.sh light")
    end
end

appearanceWatcher = hs.watchable.new("AppleInterfaceThemeChangedNotification", appearanceChanged)
appearanceChanged()

alert.show("Hammerspoon loaded!")
