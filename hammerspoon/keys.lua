local alert = require "hs.alert"
local hotkey = require "hs.hotkey"

local shortcuts = {}
Keys = {
  ["triggers"] = {
    ["Alacritty"] = {{"cmd"}, "\\"},
    ["Google Chrome"] = {{"cmd", "alt"}, "s"},
    ["Arc"] = {{"cmd", "alt"}, "1"},
    ["Spark Desktop"] = {{"cmd", "alt"}, "2"},
    ["Zoom.us"] = {{"cmd", "alt"}, "3"},
    ["Slack"] = {{"cmd", "alt"}, "4"},
    ["Routine"] = {{"cmd", "alt"}, "5"},
    ["Docker Desktop"] = {{"cmd", "alt"}, "6"},
    ["Finder"] = {{"cmd", "alt"}, "7"},
    ["Miro"] = {{"cmd", "alt"}, "8"},
    ["WhatsApp"] = {{"cmd", "alt"}, "9"},
    ["ChatGPT"] = {{"cmd", "alt"}, "g"},
    ["Postman"] = {{"cmd", "alt"}, "p"},
    ["Calendars"] = {{"cmd", "alt"}, "e"},
    ["Notion"] = {{"cmd", "alt"}, "n"},
    ["Viber"] = {{"cmd", "alt"}, "["},
    ["Spotify"] = {{"cmd", "alt"}, "x"},
    ["Kindle"] = {{"cmd", "alt"}, "b"},
    ["Telegram"] = {{"cmd", "alt"}, "t"},
    ["Numi"] = {{"cmd", "alt"}, "l"},
    ["Figma"] = {{"cmd", "alt"}, "k"},
    ["Obsidian"] = {{"cmd", "alt"}, "o"},
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
