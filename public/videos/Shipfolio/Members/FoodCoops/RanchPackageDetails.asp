<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#Include virtual="/GlobalVariables.asp"-->
<% 	
CurrentPeopleID = request.QueryString("CurrentPeopleID")
if len(CurrentPeopleID) < 1 then
CurrentPeopleID = request.form("CurrentPeopleID")
end if

sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
end if 
rs.close
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
<title><%=StateName %> Livestock Package Deals - <%= BusinessName %></title>
<meta name="Title" content="<%=StateName %> Livestock Package Deals - <%= BusinessName %>"/>
<meta name="description" content="<%=StateName %> Livestock Packages at <%= BusinessName %> in <%= AddressCity %>&nbsp; <%= AddressState %>. <%= BusinessName %> are Livestock breeders / farmers. " />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="14 days"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=StateName %> Animal Packages" />
<link rel="stylesheet" type="text/css" href="/style.css">
<% SetLocale("en-us") 
packageid=Request.Form("packageid") 
If Not Len(packageid)> 0 Then 
	packageid=Request.QueryString("packageid") 
End if
TotalPrice=Request.QueryString("TotalPrice") 
If Len(packageid) < 1 Then
response.redirect("PackagesByPriceHightoLow.asp")
End If 
CurrentPeopleID = request.QueryString("CurrentPeopleID")
if len(CurrentPeopleID) < 1 then
CurrentPeopleID = PeopleID
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
if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
%>
<style type="text/css">
H1 {font: 24pt arial; color: <%=TitleColor %>}
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 12pt arial; color: <%=TitleColor %>}
H4 {font: 12pt arial; color: <%=MenuBackgroundColor%>}
.heading2 {font: 12pt arial; color: <%=TitleColor %>}
A.heading2 {font: 12pt arial; color: <%=TitleColor %>}
.Body {font: 10pt arial; color:  <%=TitleColor %>}
A.Body {font: 10pt arial; color:  <%=TitleColor %>}
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
</style>
 <%	
sql = "select * from Package where  PackageID= " & PackageID & ""
rs.Open sql, conn, 3, 3
If not rs.eof Then
PackagePrice = rs("PackagePrice")
PackageName = rs("PackageName")
Description = rs("Description")
packageid = rs("packageid")
packageOBO = rs("packageOBO")
packagesold = rs("packagesold")
End if
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeopleLastName")
RanchHomeText = rs("RanchHomeText")
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
WebsitesID= rs("WebsitesID")
RanchHomeText = rs("RanchHomeText")
Logo = rs("Logo")
Header = rs("Header")
Phone = rs("PeoplePhone")
Cellphone = rs("PeopleCell")
Fax = rs("PeopleFax")
ScreenBackground=rs("ScreenBackground")
if len(trim(Owners)) > 12 then
else
Owners = PeopleFirstName & " " & PeopleLastName
end if
screenbackground = rs("screenbackground")
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
if len(WebsitesID) > 0 then
sql = "select distinct * from Websites where WebsitesID = " & WebsitesID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
PeopleWebsite = rs("Website")
end if
rs.close
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
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
AddressCountry = rs("AddressCountry")
AddressZip = rs("AddressZip")
end if 
rs.close
end if
 %>
 </head>
<BODY onload="addEvents();" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Packages" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left"><%= PackageName %></div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left">

<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=screenwidth -20%>">
		<tr>
			 <td  class = "body" valign = "top"  colspan ="2"  > 
		
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   >

<tr><td class = "body" valign = "top" width = "<%=screenwidth /2%>" align = "left">
<br>
<% if PackageSold = 1 then %>
<b>SOLD!</b>
<% else %>
<% if PackageValue > PackagePrice Then %>
	Full Price: <%= FormatCurrency(PackageValue,0) %>
<% End If %>
 
<% If IsNumeric(PackagePrice)  Then 
   if PackagePrice > 1 then %>
	<b>Package Price: <%= FormatCurrency(PackagePrice,0)%></b>
    <% end if %>
<% Else %>
	<b>Package Price: <%= PackagePrice %></b>
<% End If %>
<% End If %>
<% 
HideOBO = False
If PackageOBO = 1 And Sold = False and not HideOBO = True Then %><form  name=form method="post" action="PlacePackageOBObid.asp?PackageID=<%=PackageID%>&CurrentPeopleID=<%=PeopleID %>&PackageName=<%=PackageName %>">
Make an <a class="tooltip" href="#">OBO offer<span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>About OBO</em>Sellers that offer OBO (Or Best Offer) are willing to consider any offer that you want to make them.</span></a>:<br />
$<INPUT TYPE="text" NAME="OBOOffer"  size="16">
<INPUT TYPE="hidden" NAME="CurrentPeopleID"  value="<%=CurrentPeopleID %>">
<input type=Submit value="Submit" class = "regsubmit2">
</form>
<%End If %>
<br>
<%	str1 = Description
str2 = vblf
If InStr(str1,str2) > 0 Then
'Description= Replace(str1, str2 , "</br>")
End If  
str1 = Description
str2 = vbtab
If InStr(str1,str2) > 0 Then
Description= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  %>
<%= Description %><br><br>
</td>
<td class = "body" valign = "top">
<% 	
sql = "SELECT distinct Animals.*, Pricing.*, Photos.*, Ancestors.*, Colors.*  FROM packageanimals, Animals, Pricing, Photos, Ancestors, Colors WHERE packageanimals.animalID = animals.ID and Animals.ID=Pricing.ID And Animals.ID=Colors.ID And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID  And Animals.ID=Ancestors.ID and Packagetype = 'ForSale' and packageanimals.packageid = " & packageid & " and animals.PeopleID =" & CurrentPeopleID & " order by Price, animals.ID"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof then  %>
 <b>Animals for Sale:</b>
<!--#Include file="PackageDetailInclude.asp"--> 
<% End If %>
<%	sql = "SELECT distinct Animals.*, Pricing.*, Photos.*, Ancestors.*, Colors.*, packageanimals.QTYBreedings  FROM packageanimals, Animals, Pricing, Photos, Ancestors, Colors WHERE packageanimals.animalID = animals.ID and Animals.ID=Pricing.ID And Animals.ID=Colors.ID And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID  And Animals.ID=Ancestors.ID and Packagetype = 'Stud' and packageanimals.packageid = " & packageid & " and animals.PeopleID =" & CurrentPeopleID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof then 
%><br>
 <b>Stud Breedings:</b>
<!--#Include file="StudPackageDetailInclude.asp"--> 
<% End If %>
<br>
</td>
</tr>
</table> 
<br><br></td></tr></table>
</td></tr></table>
<br /><br />
<!--#Include file="PackageCount.asp"-->
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

