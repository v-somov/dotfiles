local window = require "hs.window"

hs.hotkey.bind({"cmd", "alt"}, "Left", function()
  local win = window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
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
  win:setFrame(f)
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
  win:setFrame(f)
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
  win:setFrame(f)
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
  win:setFrame(f)
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
