<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if
If CurrentPeopleID = "notselected" Then
Response.Redirect("http://www.livestockofamerica.com/ranches/default.asp")
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
'response.write (sql)
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
<title><%=StateName %> Alpaca Package Deals - <%= BusinessName %></title>
<meta name="Title" content="<%=StateName %> Alpaca Package Deals - <%= BusinessName %>"/>
<meta name="description" content="<%=StateName %> Alpaca Packages at <%= BusinessName %> in <%= AddressCity %>, <%=StateName %>. <%= BusinessName %> are alpaca breeders." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> Alpaca Packages, <%=StateName %> Alpacas for Sale ">
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" Then
	Response.Redirect("Ranches.asp")
End if	
	
BreedSort = request.Form("BreedSort")
OrderBy = 	request.Form("Orderby")

if len(BreedSort)<1 then
BreedSort = request.querystring("BreedSort")
end if 
BreedsortSQL = " "
CurrentSort  = ""   
Heading = "Huacaya and Suri Alpaca Packages"
If BreedSort = "Huacayas" Then
 CurrentSort  = "Huacayas"
 BreedsortSQL = " and ( BreedType = 'Huacaya' or BreedType = 'Huacaya & Suri' ) "
 Heading = "Huacaya Alpaca Packages"
End If 
If BreedSort = "Suris" Then
 CurrentSort  = "Suris" 
 BreedsortSQL = " and ( BreedType = 'Suri' or BreedType = 'Huacaya & Suri' ) "
 Heading = "Suri Alpaca Packages"
End If 

currentminprice = 	request.Form("MinPrice") 
If Not currentminprice="Any" then
If currentminprice > 0  Then
	BreedsortSQL = BreedsortSQL & " and PackagePrice > " & currentminprice
End If 
End If 

currentmaxprice = 	request.Form("MaxPrice") 
if Not currentmaxprice="Any" then
If currentminprice > 0   Then
	BreedsortSQL= BreedsortSQL & " and PackagePrice < " & currentmaxprice
End If 
End If 

Quantity = 	request.Form("Quantity") 
CurrentQuantity = Quantity
If Quantity = "2-3" And Not Quantity ="Any"  Then
	BreedsortSQL= BreedsortSQL & " and AnimalCount < 4 " 
End If 
If Quantity = "4-6" And Not Quantity ="Any"  Then
	BreedsortSQL= BreedsortSQL & " and AnimalCount > 3 and AnimalCount < 6 " 
End If 
If Quantity = "7-10" And Not Quantity ="Any"  Then
	BreedsortSQL= BreedsortSQL & " and AnimalCount > 6 and AnimalCount < 11 " 
End If 
If Quantity = "12 + " And Not Quantity ="Any"  Then
	BreedsortSQL= BreedsortSQL & " and AnimalCount > 11 " 
End If 


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

if PageBackgroundColor= "Black" Then
			TitleColor = "white"
			PageTextColor = "white"
		end if 
	%>	
<style type="text/css">
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 12pt arial; color: <%=TitleColor %>}
		H4 {font: 12pt arial; color: <%=MenuBackgroundColor%>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuBackgroundColor%>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
ul.LinkedList { display: block; 
    list-style-type : none; 
	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}
li 
{ line-height : 22px;
  	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}
/* ul.LinkedList ul { display: none; } */
.HandCursorStyle { cursor: pointer; cursor: hand; }  /* For IE */
  </style>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Packages" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Package Deals</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "700" valign ="top">
	<tr>		
		 <td  align = "center" valign ="top">
	<!--#Include virtual="/Conn.asp"--> 
<% sql = "SELECT  distinct PackageID, PackagePrice from Package where packagedisplay = true and peopleID = " & CurrentPeopleID & " order by PackagePrice Desc" 
'response.write("sql=" & sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then 
	i = 1%>
	<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "225" valign ="top">
	
	<% While Not rs.eof 
		
	If i=1 Or i = 4 Then 
	  i=1
	  %>
	 <tr>
	<% End If 
	i= i + 1%>
	 <td  align = "center" valign ="top" >
		<!--#Include file="RanchPackageListInclude.asp"-->
	</td>
<%
rs.movenext
Wend %>
<%  If i=1  or  i=4 Then 
	  %>
	 </tr>
	
<% End If %>
</table>



 <% Else%>
<div>We do not currently have any packages available.</div><br><br>

<% End If %>
</td>
</tr>
</table>
</td>
</tr>
</table>
<center><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></center><br><br>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

