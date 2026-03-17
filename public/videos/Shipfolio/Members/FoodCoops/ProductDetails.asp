<!DOCTYPE >
<head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
prodID= Request.QueryString("prodID") 

CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Session("PeopleID") 
End if

if len(prodID) < 1 and len(CurrentPeopleID) > 0 then
    'response.Redirect("RanchStore.asp?CurrentpeopleID=" & CurrentpeopleID )
end if

if len(prodID) < 1 and len(CurrentPeopleID) < 1 then
    'response.Redirect("Default.asp"  )
end if

If len(CurrentPeopleID) < 1  Then
		sql = "select PeopleID from sfProducts where prodID=" & prodID & ""
	'response.write(sql)
	rs.Open sql, conn, 3, 3 
	if not rs.eof then
	    currentPeopleID = rs("PeopleID")
	end if
	rs.close
End if	
if len(currentPeopleID) > 0 then
else
response.Redirect("Default.asp")
end if
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
	'RanchHomeText= Replace(str1, str2 , "</br>")
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
   AddressCountry= rs("AddressCountry")
      AddressZip= rs("AddressZip")
end if 
rs.close
%>
<title><%=BusinessName%> | Products for Sale </title>
<META name="Title" content="<%=BusinessName%> | Products for Sale">
<META name="description" content="Products for Sale at <%=BusinessName%>  - <%=PeopleState%> Farm /  Ranch" />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="Products" />
<link rel="stylesheet" type="text/css" href="/style.css">

<% sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
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
if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if  %>
<style type="text/css">
H1 {font: 24pt arial; color: <%=TitleColor %>}
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 12pt arial; color: <%=TitleColor %>}
H4 {font: 12pt arial; color: <%=MenuBackgroundColor%>}
.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body:hover { color: <%=PageTextMouseOverColor%>}
.Heading {font: 10pt arial; color: <%=MenuBackgroundColor%>}
A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&CurrentPeopleID=<%=CurrentPeopleID %>&ProdID=<%=ProdID %>' );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<!--#Include file="ProdDetailDBInclude.asp"-->
<!--#Include file="RanchHeader.asp"-->


<% CurrentPage = CurrentWebsiteURL & "/Ranches/ProductDetails.asp?prodid=" & ProdID & "&CurrentPeopleID=" & CurrentPeopleID
'response.write("CurrentPage=" & CurrentPage )
Current3 = "Products" %>
<!--#Include file="RanchPagesTabsInclude.asp"-->
<% if screenwidth < 800 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth - 80 %>" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Products for Sale</div></H1>
</td></tr>
 <tr><td class = "roundedBottom" align = "left">
 <table width = "<%=screenwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" ><tr>
 
 <% if screenwidth > 640 then %>
 <td width = "200" valign = "top" bgcolor = "#eeeeee">
<a href ="StoreHome.asp?CurrentPeopleID=<%=CurrentpeopleID %>" class = "menu3"><b>Products Home Page</b></a><br>

<% sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = True and sfproducts.peopleID = " & CurrentpeopleID & " order by catname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<a href = "RanchStore.asp?catID=<%=rs2("CatID")%>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "menu3"><%=rs2("CatName")%></a><br>
<% 
rs2.movenext
Wend %>
</td>
<td  width = "<%=screenwidth - 200 %>" >
<% else %>

<td  width = "<%=screenwidth %>" >
<% end if %>
<br />

<%
prodPeopleID = CurrentPeopleID

shippingcount = 0
rs.close
Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
USShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
'response.write("USShippingCost=" & USShippingCost )
rs.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Mexico'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
MXShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("MXShippingCost=" & MXShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Canada'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
CAShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("CAShippingCost=" & CAShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Other'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
OtherShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("OtherShippingCost=" & OtherShippingCost )
%>


<table border="0"   cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "left" width = "<%=screenwidth -230 %>">
<tr>
<td class = "body"  valign = "top">
<table  valign = "top">
<tr><td valign = "top">
<%
if not rsA.eof And foundimagecount > 1 Then
%>
<table border="0" cellspacing="0" align = "left" valign = "top" >
<tr><%rsA.movefirst
counter = 0
counttotal = rsA.recordcount
counttotal = 8
'response.write("counttotal=" & counttotal)
While counter < counttotal
counter = counter +1
If counter = 5 Then
%>
</tr>
<tr><%
End if
if Len(buttonimages(counter)) > 10  then
%><td valign = "top" align = "center">
<font 
onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "75" alt = "<%=buttontitle(counter)%>" border = "0">
<% If Len(buttontitle(counter)) > 1 Then %>
<br>
<small><%=buttontitle(counter)%></small></font>
<% End If %>
</td>
<%
end if
if counter< counttotal then
'rsA.movenext
end if
Wend %>
</tr>
</table>
<% end if%>
</td></tr>
<tr><td valign = "top" >
<% if foundimagecount < 1 then%>
<table valign = "top" border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td  valign = "top">
<%=click%>
</td></tr></table>
<% else %>
<table border = "0"  valign = "top" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<tr><td valign = "top">
<IMG alt="main image" class = "pictures my-foto" border=0  name='but1' src="<%=buttonimages(1)%>" align = "center" width = "400">
</td></tr></table>
<% end if%>
</td></tr></table>
</td>
<% if screenwidth < 800 then %>
</tr>
<tr>
<% else %>
<td width = "5"><img src = "images/px.gif" width = "1" height = "1" alt = "Products for Sale"/></td>
<% end if %>

<td valign = "top">
<!--#Include virtual="/Products/ProdDetailFactspaypal.asp"--> 
</td></tr></table>
</td></tr></table>

<!--#Include virtual="/Products/ProductCount.asp"-->
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>