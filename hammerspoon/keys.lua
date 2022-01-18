local alert = require "hs.alert"
local hotkey = require "hs.hotkey"

local shortcuts = {}
Keys = {
  ["triggers"] = {
    ["Alacritty"] = {{"cmd"}, "\\"},
    ["Google Chrome"] = {{"cmd", "alt"}, "1"},
    ["zoom.us"] = {{"cmd", "alt"}, "2"},
    ["iA Writer"] = {{"cmd", "alt"}, "3"},
    ["Slack"] = {{"cmd", "alt"}, "4"},
    ["Spark"] = {{"cmd", "alt"}, "5"},
    ["Docker Desktop"] = {{"cmd", "alt"}, "6"},
    ["Finder"] = {{"cmd", "alt"}, "7"},
    ["Xcode"] = {{"cmd", "alt"}, "8"},
    ["PDF Expert"] = {{"cmd", "alt"}, "9"},
    ["Postman"] = {{"cmd", "alt"}, "p"},
    ["Sketch"] = {{"cmd", "alt"}, "k"},
    ["Notes"] = {{"cmd", "alt"}, "n"},
    ["Viber"] = {{"cmd", "alt"}, "["},
    ["Spotify"] = {{"cmd", "alt"}, "x"},
    ["iBooks"] = {{"cmd", "alt"}, "b"},
    ["Telegram"] = {{"cmd", "alt"}, "t"},
    ["Visual Studio Code"] = {{"cmd", "alt"}, "v"},
    ["Calendar"] = {{"cmd", "alt"}, "e"},
    ["Chromium"] = {{"cmd", "alt"}, "d"},
    ["Safari"] = {{"cmd", "alt"}, "s"},
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
