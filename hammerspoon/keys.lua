local alert = require "hs.alert"
local hotkey = require "hs.hotkey"

local shortcuts = {}
Keys = {
  ["triggers"] = {
    ["Firefox"] = {{"cmd", "alt"}, "1"},
    ["Xcode"] = {{"cmd", "alt"}, "2"},
    ["Skype"] = {{"cmd", "alt"}, "3"},
    ["Mattermost"] = {{"cmd", "alt"}, "4"},
    ["Mail"] = {{"cmd", "alt"}, "5"},
    ["Safari"] = {{"cmd", "alt"}, "6"},
    ["Finder"] = {{"cmd", "alt"}, "7"},
    ["Simulator"] = {{"cmd", "alt"}, "8"},
    ["Preview"] = {{"cmd", "alt"}, "9"},
    ["Postman"] = {{"cmd", "alt"}, "p"},
    ["Sketch"] = {{"cmd", "alt"}, "k"},
    ["Notes"] = {{"cmd", "alt"}, "n"},
    ["Messenger"] = {{"cmd", "alt"}, "i"},
    ["Vox"] = {{"cmd", "alt"}, "x"},
    ["Adobe Photoshop CC 2017"] = {{"cmd", "alt"}, "["},
    ["iBooks"] = {{"cmd", "alt"}, "b"},
    ["Telegram"] = {{"cmd", "alt"}, "t"},
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
