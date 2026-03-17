<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
If Len(CurrentPeopleID) > 0 Then 
else
CurrentPeopleID=Request.Form("CurrentPeopleID") 
End if
If len(CurrentPeopleID) > 0 Then
else
Response.Redirect("Default.asp")
End if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
RanchHomeText = rs("RanchHomeText")
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
Header = rs("Header")
str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("default.asp")
end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
%>
<title><%=StateName %> Animals | <%= BusinessName %></title>
<meta name="description" content="<%=StateName %> Animals at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %>. Presented by Livestock of America" >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> Animals, <%=StateName %> Animals for Sale" >
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select * from RanchPages where PeopleID= " & CurrentPeopleID
				rs.Open sql, conn, 3, 3
				If not rs.eof Then
						Logo = rs("Logo")
						Header = rs("Header")
						MenuBackgroundColor = rs("MenuBackgroundColor")
						MenuColor = rs("MenuColor")
						MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
						TitleColor = rs("TitleColor")
						PageBackgroundColor = rs("PageBackgroundColor")
						PageTextColor = rs("PageTextColor")
						LayoutStyle = rs("LayoutStyle")
			
				End If
			rs.close

		%>

<% if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
	rs.Open sql, conn, 3, 3
	If not rs.eof Then

		MenuBackgroundColor = rs("MenuBackgroundColor")
		MenuColor = rs("MenuColor")
		MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
		TitleColor = rs("TitleColor")
		PageBackgroundColor = rs("PageBackgroundColor")
		PageTextColor = rs("PageTextColor")
		LayoutStyle = rs("LayoutStyle")
		PageTextMouseOverColor = rs("PageTextMouseOverColor")
		
	End If
rs.close 
%>
	
<style>
		H1 {font: 24pt arial; color: <%=TitleColor %>}
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 12pt arial; color: <%=PageTextColor %>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuColor %>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName= rs("PeopleLastName")
rs.close
End If 
dim Layout
target = request.querystring("target")
Layout = request.querystring("Layout")
if len(Layout) = 0 then
Layout=3
end if
SortOrder = request.form("SortOrder")
Sortby = "Price Asc"
if SortOrder = "Name" or len(SortOrder) < 3 then Sortby = "FullName Asc"
if SortOrder = "Price - Ascending" or len(SortOrder) < 3 then Sortby = "Price Asc"
if SortOrder = "Price - Descending" or len(SortOrder) < 3 then Sortby = "Price Desc"
if SortOrder = "Color" or len(SortOrder) < 3 then Sortby = "Color1"
if SortOrder = "DOB" or len(SortOrder) < 3 then Sortby = "DOBYear Desc, DOBMonth Desc, DOBYear Desc"
Current3 = "AnimalsForSale" %>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
<% Current3 = "Auctions"%>
<!--#Include file="RanchPagesTabsInclude.asp"-->

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
	<tr>
	<td class = "roundedtopandbottom" align = "left" >
	 <% if TotalAllStuds > 0 or TotalHuacayas > 0 or TotalSuris > 0 then 
	 aboutuswidth = "450"
	 else
	 aboutuswidth = "680"
	 end if
	 %>
     <% screenwidth = screenwidth - 90 %>
<table width = "<%=screenwidth %>" border="0"  cellspacing="3" cellpadding="3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" height = "200" align = "center">		
  <tr>
  <td valign = "top">
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left"><h1>Dutch Auctions</h1>
		        </td></tr>
                <tr><td class = "roundedBottom body" align = "center" width = "<%=screenwidth %>" valign = "top">
		<img src ="/Auctions/images/LOAauctionsLogo.jpg" width = "150" align = "left"/><h1>Livestock Of America Dutch Auctions</h1>
 Get a great price on animals! Livestock Of America Dutch Auctions are fun and easy to use. Best of all, the prices are constantly falling! <br />
             <br />
Each animal starts at a "ceiling" price, after that for 4 weeks each Livestock's price will drop until it hits it's "floor" price or until someone buys it, so don't wait to long or you will miss your chance! <b>Every few seconds the auctions will flash showing that the costs have dropped!</b>
           <br />
  
    <br /><br />     
  </td></tr>  
<tr><td>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  >
<% 
if rs.state = 0 then
else
rs.close
end if

sql = "select Count(*) as count from AuctionDutch  where length(AuctionStartDateDay)> 0 and length(AuctionStartDateMonth)> 0 and length(AuctionStartDateYear)> 0 and length(AnimalID1) > 1 and PeopleID='" & CurrentPeopleID & "' order by AuctionLevel"
rs.Open sql, conn, 3, 3 
if not rs.eof then
auctioncount = clng(rs("count"))
end if
rs.close

sql = "select * from AuctionDutch  where length(AuctionStartDateDay)> 0 and length(AuctionStartDateMonth)> 0 and length(AuctionStartDateYear)> 0 and length(AnimalID1) > 1 and PeopleID='" & CurrentPeopleID & "' order by AuctionLevel"
rs.Open sql, conn, 3, 3 
if rs.eof then 
 else 
  redcount = 1    
	rowcount = 1
    acount = 0
 While  acount < auctioncount
acount = acount + 1
 startdate = rs("AuctionStartDateMonth") & "/" & rs("AuctionStartDateDay") & "/" & rs("AuctionStartDateYear")
 if len(startdate) > 7 then
  stopx = true
  if datediff("d",  startdate, now) > -1  and datediff("w",  startdate, now) < 7  then
  
	AuctionDutchID=   rs("AuctionDutchID")
	AuctionDutchTitle =   rs("AuctionDutchTitle")
	AuctionLevel =   rs("AuctionLevel")
	CurrentPeopleIDarray =   rs("PeopleID")
    AnimalID1array =  rs("AnimalID1")
    AuctionName = rs("AuctionDutchTitle")
    AuctionDescription = rs("AuctionDutchDescription")
       
  str1 = AuctionDescription
str2 = vbcr
If InStr(str1,str2) > 0 Then
	AuctionDescription= Replace(str1, str2 , "</br>")
End If 
   AuctionLevel = rs("AuctionLevel")
Animal1ceiling= rs("Animal1ceiling")

Animal1Floor= rs("Animal1Floor")

  AnimalID1 = rs("AnimalID1")
  AuctionStartDateday = rs("AuctionStartDateDay")
   AuctionStartDateMonth = rs("AuctionStartDateMonth")
    AuctionStartDateYear = rs("AuctionStartDateYear")
AuctionStartDate = AuctionStartDateMonth & "/" & AuctionStartDateday & "/" & AuctionStartDateYear


    
CurrentPeopleID = CurrentPeopleIDarray
if len(CurrentPeopleID) > 0 then
  Set rs2 = Server.CreateObject("ADODB.Recordset")

	sql2 = "select  * from People where PeopleID= " & CurrentPeopleID
rs2.Open sql2, conn, 3, 3
If not rs2.eof then
PeopleFirstName = rs2("PeopleFirstName")
PeopleLastName = rs2("PeopleLastName")
BusinessID   = rs2("BusinessID")
AddressID  = rs2("AddressID")
WebsitesID= rs2("WebsitesID")
Logo = rs2("Logo")
Owners = rs2("Owners")

if len(trim(Owners)) < 2 then
	Owners = PeopleFirstName & " " & PeopleLastName
end if
end if 
rs2.close

sql2 = "select  BusinessName from Business where BusinessID= " & BusinessID
rs2.Open sql2, conn, 3, 3
If not rs2.eof then
	BusinessName = rs2("BusinessName")
end if 
rs2.close
 If Len(BusinessLogo) > 1 and Len(BusinessLogo) < 131 then
 str1 = lcase(BusinessLogo) 
str2 = "/uploads/"
If  not (InStr(str1,str2) > 0) Then
	Logo = "/uploads/" & BusinessLogo
End If 
End If 
end if 

if redcount = 1 or redcount = 5  or redcount = 9  or redcount = 13  or redcount = 17 then
 %>
 <TR>
<% end if %>
<td>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=(screenwidth/4) -10 %>"  class = "roundedtopandbottom"><tr><td align = "center">
<H4><%=AuctionDutchTitle %></h4>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr>
  <% CurrentAnimalID = AnimalID1array
 if len(CurrentAnimalID) > 1 then %> 	
 <td width = "<%=(screenwidth/4) -10 %>" align = "center" valign = "top">
<iframe src ="/auctions/DutchAuctionDetailFrame.asp?CurrentAnimalID=<%=CurrentAnimalID %>&Ceiling=<%= Animal1ceiling%>&Floor=<%= Animal1Floor%>&startdate=<%=AuctionStartDate %>" width="<%=(screenwidth/4) -10 %>" height="290" frameborder = "0" scrolling = "no" valign = "top" align = "center" style="background-color:white">
<p>Your browser does not support iframes.</p>
</iframe>
 </td>
 <% end if %>


</tr>
 </table>
	</td>
</tr>
</table>
</td>
<%
redcount = redcount + 1
if  redcount = 5  or redcount = 9  or redcount = 13  or redcount = 17 then %>
</tr>
<% 
  end if
  end if
  end if
		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
end if %>
<% if not(redcount = 5  or redcount = 9  or redcount = 13  or redcount = 17) then %>
</tr>
  <% set rs=nothing
  set conn = nothing
  end if 

%>
</table>
</td>
</tr>
</table>
	</td>
</tr>

</table>
</td>

</td>
</tr>
</table><!--#Include virtual="/Footer.asp"--> 
</body></html>