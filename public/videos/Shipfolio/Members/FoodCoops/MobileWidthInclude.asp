<script>
function setCookie(c_name, value, exdays) {
var exdate = new Date();
exdate.setDate(exdate.getDate() + exdays);
var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
document.cookie = c_name + "=" + c_value;
}
</script> 
<script>
setCookie("ScreenWidth", self.innerWidth, 365);
</script>
<%
Dim ScreenWidth, user_agent, mobile_browser, Regex, match, mobile_agents, mobile_ua, i, size
 
user_agent = Request.ServerVariables("HTTP_USER_AGENT")
 
mobile_browser = 0
 
Set Regex = New RegExp
With Regex
   .Pattern = "(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|windows ce|pda|mobile|mini|palm|googlebot|baiduspider|ia_archiver|r6_feedfetcher|netcraftsurveyagent|sogou web spider|bingbot|yahoo!|slurp|facebookexternalhit|printfulBot|msnbot|Twitterbot|UnwindFetchor|urlresolver|butterfly|tweetmemeBot)"
   .IgnoreCase = True
   .Global = True
End With
 
match = Regex.Test(user_agent)
 
If match Then mobile_browser = mobile_browser+1
 
If InStr(Request.ServerVariables("HTTP_ACCEPT"), "application/vnd.wap.xhtml+xml") Or Not IsEmpty(Request.ServerVariables("HTTP_X_PROFILE")) Or Not IsEmpty(Request.ServerVariables("HTTP_PROFILE")) Then
   mobile_browser = mobile_browser+1
end If
 
mobile_agents = Array("w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac", "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs", "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi", "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port", "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem", "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v", "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-", "googlebot", "baiduspider", "ia_archiver","r6_feedfetcher", "netcraftsurveyagent", "sogou web spider", "bingbot",  "bing",  "msn", "yahoo", "slurp", "facebookexternalhit", "printfulBot", "msnbot", "twitterbot", "unwindfetchor", "urlresolver", "butterfly", "tweetmemebot")
size = Ubound(mobile_agents)
mobile_ua = LCase(Left(user_agent, 4))

  

For i=0 To size
   If mobile_agents(i) = mobile_ua Then
      mobile_browser = mobile_browser+1
      Exit For
   End If
Next
if mobile_browser = 1 then
mobiledevice = True
else
mobiledevice = False
end if

'response.write("mobile_browser=" & mobile_browser)

 If InStr(1, user_agent, "ipad", 1) Then
        is_iPad = true
    Else
        is_iPad = false
    End If
 

  
'mobile_browser = 1
   
Error=Request.querystring("Error")
  ScreenWidth=Request.querystring("ScreenWidth")
  RealScreenWidth =  ScreenWidth



   if ScreenWidth = "undefined" or len(ScreenWidth) < 3  then
      if mobiledevice = False then
   ScreenWidth = 1200
   else
   'ScreenWidth = 640
   end if
 end if

' response.Write("ScreenWidth2=" & ScreenWidth & "hhhh" )   
  if len(trim(ScreenWidth)) > 0 then
   else
   ScreenWidth=Request.Cookies("ScreenWidth")
   end if
  ' response.Write("ScreenWidth3=" & ScreenWidth & "hhhh" )

if len(Screenwidth) > 0 then
 if len(session("Screenwidth")) < 3 then
  '  session("Screenwidth") = Screenwidth
 end if
else
 Screenwidth = session("Screenwidth")
end if
'response.write("Screenwidth=" & Screenwidth )

if len(trim(ScreenWidth)) > 0 then
   else
  ' ScreenWidth=800
   end if
   
   if ScreenWidth = "undefined" then
   ScreenWidth =1200
   end if

if len(ScreenWidth) > 0 then
if ScreenWidth > 0 then
else
   if mobiledevice = False then
  ' ScreenWidth = 640
else
  ' ScreenWidth = 800
end if
  PageWidth=1100
end if
end if
    
'response.Write("ScreenWidth4=" & ScreenWidth & "hhhh" )
if len(ScreenWidth) > 0 then
else
   ScreenWidth = 479
end if
 'response.Write("ScreenWidth=" & ScreenWidth )
If cint(ScreenWidth) > 1200 then
   Pagewidth = 1200
   screenwidth = 1200
end if
   
if cint(ScreenWidth) < 989 and cint(ScreenWidth) > 769 then
      PageWidth = 769
end if
   
if cint(ScreenWidth) < 770 and cint(ScreenWidth) > 480 then
      PageWidth = 480
end if
if cint(ScreenWidth) < 481 then
      PageWidth = "100%"
end if
 'response.Write("ScreenWidth5=" & ScreenWidth & "hhhh" )
   SmallMobile = False

if screenwidth < 650 and screenwidth > 320 then
'mobiledevice = True
'screenwidth= 640
end if

if len(screenwidth) < 3 then
mobiledevice = True
screenwidth= 320
end if


if Current = "Ranches" then %>
<link rel="stylesheet" type="text/css" href="/Ranchstyle.css" />
<% else
if mobiledevice = True then %>
<link rel="stylesheet" type="text/css" href="/Mobilestyle.css" />
<% else %>
<link rel="stylesheet" type="text/css" href="/style.css" />
<% end if 
end if %>