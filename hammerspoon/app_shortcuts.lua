local application = require "hs.application"
local keys = require "keys"

-- Simple triggers
for applicationName, _ in pairs(keys.triggers) do
  keys.bindKeyFor(applicationName, function()
    if hs.application.frontmostApplication():name() ~= applicationName then
      if applicationName == "Telegram" then
        hs.keycodes.setLayout("Russian - PC")
      end
      if applicationName == "Alacritty" then
        hs.keycodes.setLayout("ABC")
      end
      application.launchOrFocus(applicationName)
    else
      if applicationName == "Telegram" then
        hs.keycodes.setLayout("ABC")
      end
      application.get(applicationName):hide()
    end
  end)
end
