<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<% Current = "Ranches"%>
<!--#Include virtual="/GlobalVariables.asp"-->
<% 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("PeopleID") 
End if

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.querystring("custID") 
End if

tempCurrentPeopleID=Request.querystring("PeopleID") 
If Not Len(tempCurrentPeopleID)> 0 and Len(CurrentPeopleID)> 0 Then 
	response.redirect("ranchhome.asp?Peopleid=" & CurrentPeopleID)
End if


If Not Len(CurrentPeopleID)> 0 Then 
	Response.Redirect("/Default.asp")
End if
If CurrentPeopleID = 1016 Then 
	'Response.Redirect("/Brokering/Default.asp")
End if

PeopleID = CurrentPeopleID
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	 PageTitle = rs("RanchHomeHeading")
    RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
	str1 = RanchHomeText
str2 = vblf
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("/default.asp")
end if
if len(BusinessID) > 0 then
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
end if
if len(AddressID) > 0 then
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
end if
%>
<title><%= BusinessName %></title>
<meta name="Title" content=" <%= BusinessName %>">
<meta name="description" content=" Animals for Sale at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %>." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="Livestock" >

<%	Set rs = Server.CreateObject("ADODB.Recordset")
RanchAboutUsText = ""

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 1"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") 
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 2 "
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText")
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 3"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText")
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 4"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText")
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 5"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText")
end if
rs.close


sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
 WebLink = rs("WebLink")
RanchHomeText = rs("RanchHomeText")
If Len(RanchHomeText) > 1 Then
Else
RanchHomeText  = " "
End If 
News = rs("RanchHomeText2")
PageText1 = rs("RanchHomeText")
PageText2 = rs("RanchHomeText2")
PageText3 = rs("RanchHomeText3")
PageText4 = rs("RanchHomeText4")
Image1= rs("RanchHomeImage1")
Image2= rs("RanchHomeImage2")
Image3= rs("RanchHomeImage3")
Image4= rs("RanchHomeImage4")
ImageOrientation1= rs("RanchHomeImageOrientation1")
ImageOrientation2= rs("RanchHomeImageOrientation2")
ImageOrientation3= rs("RanchHomeImageOrientation3")
ImageOrientation4= rs("RanchHomeImageOrientation4")
RanchHomeheading= rs("RanchHomeheading")

PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName	= rs("PeopleLastName")
str1 =News
str2 = vblf
If InStr(str1,str2) > 0 Then
	News= Replace(str1, str2 , "</br>")
End If  
str1 = News
str2 = vbtab
If InStr(str1,str2) > 0 Then
	News= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
str1 =RanchAboutUsText
str2 = vblf
If InStr(str1,str2) > 0 Then
	RanchAboutUsText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchAboutUsText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	RanchAboutUsText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
str1 = WebLink
str2 = "http://"
If InStr(str1,str2) > 0 Then
	WebLink= Replace(str1,  str2, "")
End If 
str1 = Aboutusheading
str2 = vblf
If InStr(str1,str2) > 0 Then
	Aboutusheading= Replace(str1, str2 , "</br>")
End If  
str1 = Aboutusheading
str2 = vbtab
If InStr(str1,str2) > 0 Then
	Aboutusheading= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
rs.close
End If 
If Not(ImageOrientation1 = "Left") then
 ImageOrientation1 = "Right"
End if

ranchtextfound = False
%>
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&PeopleID=<%=tempCurrentPeopleID %>' );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<% Current3 = "FarmHome" %>
<!--#Include file="RanchHeader.asp"-->
<!--#Include file="RanchPagesTabsInclude.asp"-->

<!--#Include virtual="/Footer.asp"--></body>
</html>