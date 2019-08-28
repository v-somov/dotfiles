local choices = {
 {
   ["text"] = "My issues",
   ["subText"] = "https://git.saltedge.com/dashboard/issues?assignee_username=vladislavs",
 },
 {
   ["text"] = "DOCS",
   ["subText"] = "https://git.saltedge.com/saltedge/docs/issues",
 },
 {
   ["text"] = "SSO",
   ["subText"] = "https://git.saltedge.com/internal/sso/issues",
 },
 {
   ["text"] = "Doctor",
   ["subText"] = "https://git.saltedge.com/enrichment/doctor/issues",
 },
 {
   ["text"] = "Bucket",
   ["subText"] = "https://git.saltedge.com/saltedge/bucket/issues",
 },
 {
  ["text"] = "Categorizer git",
  ["subText"] = "https://git.saltedge.com/enrichment/categorizer/merge_requests",
 },
 { ["text"] = "Devops Global",
   ["subText"] = "https://git.saltedge.com/devops/global/issues",
 },
 {
   ["text"] = "Infosec Global",
   ["subText"] = "https://git.saltedge.com/infosec/global/issues",
 },
 {
   ["text"] = "Calendar SE",
   ["subText"] = "https://calendar.google.com/calendar/b/1/r",
 },
 {
   ["text"] = "Thief",
   ["subText"] = "https://git.saltedge.com/service/thief/issues",
 },
 {
   ["text"] = "Priora",
   ["subText"] = "https://git.saltedge.com/psd2/priora/issues",
 },
 {
   ["text"] = "New Deploy",
   ["subText"] = "https://git.saltedge.com/new_deploy/prototype/merge_requests",
 },
 {
   ["text"] = "Priora Dashboard",
   ["subText"] = "https://priora.saltedge.com/clients/dashboard",
 },
 {
   ["text"] = "Spectre Dashboard",
   ["subText"] = "https://www.saltedge.com/clients/dashboard",
 },
 {
   ["text"] = "Staging Categorizer-Rails",
   ["subText"] = "https://logstash.banksalt.com/app/kibana#/discover?_g=()&_a=(columns:!(_source),index:'categorizer-rails-*',interval:auto,query:(language:lucene,query:''),sort:!('@timestamp',desc))",
 },
 {
   ["text"] = "Production Categorizer-Rails",
   ["subText"] = "https://logstash.saltedge.com/app/kibana#/discover?_g=()&_a=(columns:!(_source),index:'categorizer-rails-*',interval:auto,query:(match_all:()),sort:!('@timestamp',desc))",
 },
 {
   ["text"] = "Messenger Chat",
   ["subText"] = "https://www.messenger.com",
 },
 {
   ["text"] = "Gitlab Switch iOS",
   ["subText"] = "https://gitlab.com/pilotpros/Remote_switch/boards",
 },
 {
   ["text"] = "TPP Verifier",
   ["subText"] = "https://git.saltedge.com/psd2/tpp_verifier/issues",
 },
 {
   ["text"] = "Fentury iOS git",
   ["subText"] = "https://git.saltedge.com/fentury/ios/merge_requests",
 },
 {
   ["text"] = "Norvik iOS git",
   ["subText"] = "https://git.saltedge.com/fentury/norvik-pfm-ios/merge_requests",
 },
 {
   ["text"] = "Developer Apple",
   ["subText"] = "https://developer.apple.com/account/ios/certificate/?teamId=8QFQG87EDC",
 },
 {
   ["text"] = "Appstore Connect",
   ["subText"] = "https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app",
 }
}


hs.hotkey.bind({"cmd", "alt"}, "g", function()
    local chooser = hs.chooser.new(function(choosen)
      hs.urlevent.openURL(choosen.subText)
    end)

  chooser:choices(choices)


  chooser:show()
end)
