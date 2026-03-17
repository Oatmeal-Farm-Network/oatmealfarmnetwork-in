<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-55422332-1', 'auto');
    ga('send', 'pageview');

</script>
<% showwebheadertabs = false
if  showwebheadertabs = True then
CurrentWebsite = "LivestockofAmerica" %>
<!--#Include virtual="/WebHeaderTabs.asp"-->
<% end if %>
<table width="<%=screenwidth %>" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td align="left" width = "<%=screenwidth %>" height = "100" ><img src = "/images/LOALogoMenu.png" align = "center" width = "463" height = "144" alt = "Livestock">
</td><td align = "center" valign = 'top'><% 
showads = True
if showads = True then
Query =  "Select * from Ads  where adWebsite = 'Livestock of America' and AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Mega Ad Combo' or adType = 'Banner Ad' and AdPaidFor=True order by AdImageBackground Desc" 	
rs.Open Query, conn, 3, 3
'response.write("rs.recordcount=" & rs.recordcount)
if rs.eof then 
AdID = 671
TargetLink = "_top"
HeaderAdpeopleID = 102
Adfound = True
else
AdID = rs("AdID")
Adfound = True
AdpeopleID = rs("PeopleID")
if len(rs("AdImage")) > 3 then
AdImage = rs("AdImage")
end if
if len(rs("AdLink")) > 3 then
 AdLink = "http://" & rs("AdLink")
 TargetLink = "_Blank"
else
 AdLink ="/Ranches/RanchHome.asp?CurrentPeopleID=" & AdpeopleID
     TargetLink = "_top"
end if
end if
AdLink = "/AdForwarding.asp?AdID=" & AdID
rs.close 
if len(HeaderAdpeopleID) > 1 then
Query =  "Select Businessname, Logo from People, Business where People.BusinessID = Business.BusinessID and peopleID= " &  HeaderAdpeopleID
rs.Open Query, conn, 3, 3
if not rs.eof then 
HeaderBusinessName = rs("BusinessName")
HeaderLogo = rs("Logo")
end if
rs.close
end if
TempAdFound = False
 if Adfound = True then 
 if len(AdImage) > 4 then 
TempAdFound = True %>
<a href = "<%=AdLink%>" target="<%=TargetLink %>" ><img src =  "<%=AdImage %>" border = "0" alt = "<%=BusinessName %>" width = "400" height = "75"  /></a>
<% end if 
if TempAdFound = false and len(Logo) > 1 then 
TempAdFound = True %>
<center><a href = "<%=AdLink%>" target="<%=TargetLink %>" ><img src =  "<%=Logo %>" border = "0" alt = "<%=BusinessName %>"  height = "75" /></a></center>
<% end if
end if 
if TempAdFound = false then %><iframe src="/BannerAdFrame.asp" frameborder =0 width = "400" height = "100" scrolling = "no"  align = "center" name="navigate"></iframe><% end if %>
<% end if %></td></tr></table>