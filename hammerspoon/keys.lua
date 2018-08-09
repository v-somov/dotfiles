local alert = require "hs.alert"
local hotkey = require "hs.hotkey"

local shortcuts = {}
Keys = {
  ["triggers"] = {
    ["Alacritty"] = {{"cmd"}, "\\"},
    ["Safari"] = {{"cmd", "alt"}, "1"},
    ["Xcode"] = {{"cmd", "alt"}, "2"},
    ["iA Writer"] = {{"cmd", "alt"}, "3"},
    ["Mattermost"] = {{"cmd", "alt"}, "4"},
    ["Mail"] = {{"cmd", "alt"}, "5"},
    ["Firefox"] = {{"cmd", "alt"}, "6"},
    ["Finder"] = {{"cmd", "alt"}, "7"},
    ["Simulator"] = {{"cmd", "alt"}, "8"},
    ["PDF Expert"] = {{"cmd", "alt"}, "9"},
    ["Postman"] = {{"cmd", "alt"}, "p"},
    ["Sketch"] = {{"cmd", "alt"}, "k"},
    ["Notes"] = {{"cmd", "alt"}, "n"},
    -- ["Messages"] = {{"cmd", "alt"}, "i"},
    ["iTunes"] = {{"cmd", "alt"}, "x"},
    ["Adobe Photoshop CC 2018"] = {{"cmd", "alt"}, "["},
    ["iBooks"] = {{"cmd", "alt"}, "b"},
    ["Telegram"] = {{"cmd", "alt"}, "t"},
    ["Visual Studio Code"] = {{"cmd", "alt"}, "v"},
  },
}

function Keys.keyFor(name)
  return Keys.triggers[name]
end

function Keys.bindKeyFor(appName, fn)
  keys = Keys.keyFor(appName)
  normalKeys = keys
  shortcuts[appName] = hotkey.new(normalKeys[1], normalKeys[2], fn)
end

function Keys.deactivateKeys()
  for _, keys in pairs(shortcuts) do
      keys:disable()
  end
end

function Keys.activateKeys()
  for _, keys in pairs(shortcuts) do
    keys:enable()
  end
end

return Keys
