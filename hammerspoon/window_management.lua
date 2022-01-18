local window = require "hs.window"
local alert = require "hs.alert"

-- Make the alerts look nicer.
-- hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
-- hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
-- hs.alert.defaultStyle.radius =  10

hs.hotkey.bind({"cmd", "alt"}, "Left", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "alt"}, "Right", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"shift", "cmd", "alt"}, "Left", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 5 * 2
  f.h = max.h
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"shift", "cmd", "alt"}, "Right", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 5 * 2)
  f.y = max.y
  f.w = max.w / 5 * 3
  f.h = max.h
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "alt"}, "Up", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "alt"}, "Down", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "1", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "2", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "3", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "4", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  resizeAllAppWindows(win, f)
end)


function toggleFullScreen(s)
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = s or win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  resizeAllAppWindows(win, f)
end

hs.hotkey.bind({"cmd", "alt"}, "f", toggleFullScreen)

hs.hotkey.bind({"cmd", "alt"}, "c", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 5)
  f.y = max.y + (max.h / 5)
  f.w = max.w / 1.5
  f.h = max.h / 1.5
  win:setFrame(f)
end)

function resizeAllAppWindows(win, f)
  local app = win:application()
  local allAppWindows = app:allWindows()
  for _, w in ipairs(allAppWindows) do
    if (string.find(w:title(), "DevTools")) then
      return
    end
    w:setFrame(f)
  end
end

function moveWindowNext()
  local s = hs.screen.mainScreen():next()
  toggleFullScreen(s)
end

function moveWindowPrev()
  local s = hs.screen.mainScreen():previous()
  toggleFullScreen(s)
end

hs.hotkey.bind({"ctrl", "cmd"}, "up", moveWindowNext)
hs.hotkey.bind({"ctrl", "cmd"}, "down", moveWindowPrev)

hs.hotkey.bind({"cmd", "alt"}, "y", function()
  alert.show(window.focusedWindow():application():name(), 0.5)
end)

-- Show date time and battery
hs.hotkey.bind({"ctrl", "cmd"}, "t", function()
  local message = os.date("%I:%M%p") .. "\n" .. os.date("%a %b %d") .. "\nBattery: " ..
     hs.battery.percentage() .. "%"
  hs.alert.show(message)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function() hs.reload() end)

