<table width="985" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td align="left" width = "980" height = "118" >
<img src = "/images/LOALogoMenu.png" align = "center" width = "463" height = "144" alt = "Livestock">
</td><td align = "center"><% Query =  "Select * from Ads  where AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Mega Ad Combo' and AdPaidFor=True order by AdImageBackground Desc" 	
rs.Open Query, conn, 3, 3
'response.Write("<font color = 'white'>query=" & Query & "</font><br>")
if rs.eof then 
AdID = 671
TargetLink = "_top"
' AdImage = "/Uploads/AALogoHeaderAd.jpg"
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
 AdLink ="/AlpacaRanchQuest/RanchHome.asp?CurrentPeopleID=" & AdpeopleID
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
TempAdFound = false
 if Adfound = True then %>
<%  if len(AdImage) > 4 then 
TempAdFound = True %>
<a href = "<%=AdLink%>" target="<%=TargetLink %>" ><img src =  "<%=AdImage %>" border = "0" alt = "<%=BusinessName %>" width = "400" height = "75"  /></a>
 <% end if %>
 <%  if TempAdFound = false and len(Logo) > 1 then 
  TempAdFound = True%>
<center><a href = "<%=AdLink%>" target="<%=TargetLink %>" ><img src =  "<%=Logo %>" border = "0" alt = "<%=BusinessName %>"  height = "75" /></a></center>
<% end if %>
<% end if %>
</td></tr>
</table>