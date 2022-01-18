local choices = {
 {
   ["text"] = "Chrome Inspect",
   ["subText"] = "chrome://inspect",
 },
}

hs.hotkey.bind({"cmd", "alt"}, "g", function()
    local chooser = hs.chooser.new(function(choosen)
      hs.urlevent.openURL(choosen.subText)
    end)

  chooser:choices(choices)


  chooser:show()
end)
