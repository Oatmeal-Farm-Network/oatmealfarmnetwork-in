<script>
function setCookie(c_name, value, exdays) {
var exdate = new Date();
exdate.setDate(exdate.getDate() + exdays);
var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
document.cookie = c_name + "=" + c_value;
}
</script> 
<script>
setCookie("ScreenWidth", self.innerWidth, 0);
setUseWideViewPort(true)
</script>
<%
Dim ScreenWidth, user_agent, mobile_browser, Regex, match, mobile_agents, mobile_ua, i, size
 
user_agent = Request.ServerVariables("HTTP_USER_AGENT")
 
mobile_browser = 0
 
Set Regex = New RegExp
With Regex
   .Pattern = "(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|windows ce|pda|mobile|mini|palm)"
   .IgnoreCase = True
   .Global = True
End With
 
match = Regex.Test(user_agent)
 
If match Then mobile_browser = mobile_browser+1
 
If InStr(Request.ServerVariables("HTTP_ACCEPT"), "application/vnd.wap.xhtml+xml") Or Not IsEmpty(Request.ServerVariables("HTTP_X_PROFILE")) Or Not IsEmpty(Request.ServerVariables("HTTP_PROFILE")) Then
   mobile_browser = mobile_browser+1
end If
 
mobile_agents = Array("w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac", "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs", "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi", "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port", "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem", "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v", "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-")
size = Ubound(mobile_agents)
mobile_ua = LCase(Left(user_agent, 4))
 
For i=0 To size
   If mobile_agents(i) = mobile_ua Then
      mobile_browser = mobile_browser+1
      Exit For
   End If
Next
 If InStr(1, user_agent, "ipad", 1) Then
        is_iPad = true
    Else
        is_iPad = false
    End If
If  mobile_browser  = 1 then
mobiledevice = True
else
 mobiledevice = False
end if
  
'mobile_browser = 1
   
Error=Request.querystring("Error")
 
  ScreenWidth=Request.querystring("ScreenWidth")
  
  if len(ScreenWidth) > 0 then
  else
ScreenWidth=Request.cookies("ScreenWidth")
  end if
  RealScreenWidth =  ScreenWidth

  

   if len(ScreenWidth) < 3  then
      if mobiledevice = False then
   ScreenWidth = 1200
   else
   ScreenWidth = 640
   end if
 end if

  if len(trim(ScreenWidth)) > 0 then
   else
   ScreenWidth=Request.Cookies("ScreenWidth")
   end if
 ' response.Write("ScreenWidth3=" & ScreenWidth & "hhhh" )
   if len(trim(ScreenWidth)) > 0 then
   else
   ScreenWidth=1200
   end if
   
   if ScreenWidth = "undefined" then
   ScreenWidth =1200
   end if
    if cint(ScreenWidth) > 0 then
   else
   if mobiledevice = False then
   ScreenWidth = 800
   else
   ScreenWidth = 800
   end if
 ' screenWidth=1200
   end if
     
'response.Write("ScreenWidth4=" & ScreenWidth & "hhhh" )
   if len(ScreenWidth) > 0 then
   else
   ScreenWidth = 479
   end if
 'response.Write("ScreenWidth=" & ScreenWidth )
   If cint(ScreenWidth) > 1200 then
   screenwidth = 1200
   end if
   
if cint(ScreenWidth) < 1200 and cint(ScreenWidth) > 989 then
'ScreenWidth = 989
end if
'response.write("ScreenWidth=" & ScreenWidth )
if cint(ScreenWidth) < 780 then
 'mobiledevice = True
end if 
if cint(ScreenWidth) < 989 and cint(ScreenWidth) > 970 then
 ScreenWidth = 973
end if

if cint(ScreenWidth) < 969 and cint(ScreenWidth) > 786 then
    ScreenWidth = 840
end if
   
if cint(ScreenWidth) < 785 and cint(ScreenWidth) > 698 then
ScreenWidth =700
end if

if cint(ScreenWidth) < 698 and cint(ScreenWidth) > 599 then
ScreenWidth =600
end if

if cint(ScreenWidth) < 481 then
ScreenWidth= 480
end if
'response.Write("ScreenWidth=" & ScreenWidth & "hhhh" )
   SmallMobile = False
   cssassigned = False
If mobile_browser > 0 and not(is_iPad) Then
mobiledevice = True
if  ScreenWidth > 479 then 
   cssassigned =True%>

 <link rel="stylesheet" type="text/css" href="/styleSmallScreen.css">
<% Else 
SmallMobile = True
cssassigned =True %>
 <link rel="stylesheet" type="text/css" href="/style.css">
<% End If
else %>

<% if Frame = True then 
cssassigned =True%>
  <link rel="stylesheet" type="text/css" href="/Style.css">
<% else %>
  <% if  Alpacas = True then 
  cssassigned =True%>
 <link rel="stylesheet" type="text/css" href="/Alpacas.css">
<% else 
cssassigned =True%>
 <link rel="stylesheet" type="text/css" href="/Style.css">
<% end if %>
<% End If %>
<% end if %>

<% if cssassigned =False then %>
 <link rel="stylesheet" type="text/css" href="/Style.css">
<% end if

'response.write("screenwidthLast = " & ScreenWidth)
%>
