local application = require "hs.application"
local keys = require "keys"

-- Simple triggers
for applicationName, _ in pairs(keys.triggers) do
  keys.bindKeyFor(applicationName, function()
    if hs.application.frontmostApplication():name() ~= applicationName then
      application.launchOrFocus(applicationName)
    else
      application.get(applicationName):hide()
    end
  end)
end
