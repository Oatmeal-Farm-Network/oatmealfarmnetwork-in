<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include virtual="/GlobalVariablesNoBackground.asp"-->
<% CurrentAnimalID = request.QueryString("CurrentAnimalID")
CurrentPeopleID = request.QueryString("CurrentPeopleID")
Ceiling = request.QueryString("Ceiling")
Floor = request.QueryString("Floor")
startdate = request.QueryString("startdate")

if len(Ceiling) > 0 and len(Floor) > 0 then
'  if DateDiff("d", startdate, now) < 8 then
 '   Preview = true
  '  CurrentPrice =ceiling
  'else
' auctionstartdate = dateadd("d",7 , startdate)
auctionstartdate = startdate
Rate = formatcurrency((Ceiling-Floor) / 50400,3)
TimePast = DateDiff("s", auctionstartdate, now) / 60
CurrentPrice = ceiling - (Rate * TimePast) 
  'end if
end if


 if not Preview = true then%>
 <meta http-equiv="refresh" content="30" />
 <% end if %>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" bgcolor = "white" valign = 'top'>
<form  name=form method="post" target = "top" action="PlaceDutchAuctionbid.asp?ID=<%= CurrentAnimalID%>&CurrentPeopleID=<%=CurrentPeopleID %> ">
<table bgcolor = "white" width = "300" height = "70" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" valign = "top"><tr><td align = "top" class = "body2" valign = "top" align = "right" width = "130"><div align = "right"><font size="2"><b>Current Price:</b></font></div></td>
<td align = "top" class = "body" valign = "top"><font size="2"><b><%= formatcurrency(CurrentPrice, 2) %></b></font> </td></tr>
<tr><td  class = "body" align = "right" ></td>
<td  class = "body" align = "left" ><INPUT TYPE="hidden" NAME="DutchAuctionOffer"  value = "<%= formatcurrency(CurrentPrice, 2) %>"><input type=Submit value="Buy Now!" class = "regsubmit2">
</td></tr></table></form>
</body>
</html>