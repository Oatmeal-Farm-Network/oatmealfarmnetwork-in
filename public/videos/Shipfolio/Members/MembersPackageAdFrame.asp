	
<%@ Language=VBScript %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<link rel="stylesheet" type="text/css" href="/Membersistration/Framestyle.css">
<!--#Include file="MembersGlobalVariables.asp"-->

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" width = "193"  height = "400">
<TABLE width = "193"  height = "450"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white">
<TR><td valign = "top">

<% 
packageid= request.querystring("Packageid")
Backgroundcolor = ""
BorderColor = ""
MouseoverColor  = ""
adImage	  = ""
HeaderTextFontType  = ""
HeaderTextFontColor  = ""
BodyTextFontType  = ""
BodyTextFontColor  = ""
LinkColor = ""
     
	sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
	if Not rs.eof then
Backgroundcolor = rs("BackgroundColor")
BorderColor = rs("BorderColor")
adImage= rs("Image") 
MouseoverColor  = rs("LinkMouseoverColor") 
HeaderTextFontType = rs("HeaderTextFontType") 
HeaderTextFontColor  = rs("HeaderTextFontColor") 
BodyTextFontType  = rs("BodyTextFontType") 
BodyTextFontColor  = rs("BodyTextFontColor") 
LinkColor = rs("LinkColor") 
rs.close
	Else
rs.close


Query =  "INSERT INTO ListingDesign (BackgroundColor, BorderColor,  LinkMouseoverColor, image, HeaderTextFontColor,  HeaderTextFontType, BodyTextFontType, BodyTextFontColor, LinkColor)" 
Query =  Query & " Values ('" &  BackgroundColor & "', "
Query =  Query &   " '" & BorderColor & "' , "
Query =  Query &   " '" & LinkMouseoverColor & "' , " 
Query =  Query &   " '" & adImage & "' , " 
Query =  Query &   " '" & HeaderTextFontColor & "' , " 
Query =  Query &   " '" & HeaderTextFontType & "' , " 
Query =  Query &   " '" & BodyTextFontType & "' , " 
Query =  Query &   " '" & BodyTextFontColor & "' , " 
Query =  Query &   " '" & LinkColor & "' )" 

Conn.Execute(Query) 
Conn.close
%>	
<!--#Include virtual="/Conn.asp"-->
<%
sql = "SELECT  ListingDesignID from ListingDesign order by ListingDesignID DESC"
Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
if Not rs.eof then
	ListingDesignID  = rs("ListingDesignID")
	Query =  " UPDATE Package Set ListingDesignID = " &  ListingDesignID & "" 
	Query =  Query & " where PackageID = " & PackageID & ";" 

	Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 
End If 
End If 

sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

DBHeaderTextColor = rs("HeaderTextColor")
DBLinkMouseoverColor = rs("LinkMouseoverColor")
DBBackgroundColor = rs("BackgroundColor")
DBBorderColor = rs("BorderColor")
DBImage	 = rs("Image")
DBHeaderTextFontType = rs("HeaderTextFontType")
DBHeaderTextFontColor = rs("HeaderTextFontColor")
DBBodyTextColor = rs("BodyTextColor")
DBBodyTextFontType = rs("BodyTextFontType")
DBBodyTextFontColor = rs("BodyTextFontColor") 
DBLinkColor = rs("LinkColor")

If Len(Session("LinkMouseoverColor")) > 1  then
	LinkMouseoverColor = Session("LinkMouseoverColor")
Else
	Session("LinkMouseoverColor") = DBLinkMouseoverColor
	LinkMouseoverColor = DBLinkMouseoverColor
End If

If Len(Session("Backgroundcolor")) > 1  then
	BackgroundColor = Session("BackgroundColor")
Else
	Session("BackgroundColor") = DBBackgroundColor
	BackgroundColor = DBBackgroundColor
End If

If Len(Session("BorderColor")) > 1  then
	BorderColor = Session("BorderColor")
Else
	Session("BorderColor") = DBBorderColor
	BorderColor = DBBorderColor
End If

If Len(Session("Image")) > 1  then
	Image = Session("Image")
Else
	Session("Image") = DBImage
	Image= DBImage
End If

If Len(Session("HeaderTextFontColor")) > 1  then
	HeaderTextColor = Session("HeaderTextFontColor")
Else
	Session("HeaderTextFontColor") = DBHeaderTextFontColor
	HeaderTextColor= DBHeaderTextFontColor
End If

If Len(Session("HeaderTextFontType")) > 1  then
	HeaderTextFontType = Session("HeaderTextFontType")
Else
	Session("HeaderTextFontType") = DBHeaderTextFontType
	HeaderTextFontType= DBHeaderTextFontType
End If

If Len(Session("HeaderTextFontColor")) > 1  then
	HeaderTextFontColor = Session("HeaderTextFontColor")
Else
	Session("HeaderTextFontColor") = DBHeaderTextFontColor
	HeaderTextFontColor= DBHeaderTextFontColor
End If

If Len(Session("BodyTextColor")) > 1  then
	BodyTextColor = Session("BodyTextColor")
Else
	Session("BodyTextColor") = DBBodyTextColor
	BodyTextColor= DBBodyTextColor
End If

If Len(Session("BodyTextFontType")) > 1  then
	BodyTextFontType = Session("BodyTextFontType")
Else
	Session("BodyTextFontType") = DBBodyTextFontType
	BodyTextFontType =  DBBodyTextFontType
End If

If Len(Session("BodyTextFontColor")) > 1  then
	BodyTextFontColor = Session("BodyTextFontColor")
Else
	Session("BodyTextFontColor") = DBBodyTextFontColor
	BodyTextFontColor =  DBBodyTextFontColor
End If

If Len(Session("LinkColor")) > 1  then
	LinkColor= Session("LinkColor")
Else
	Session("LinkColor") = LinkColor
	LinkColor=  DBLinkColor
End If

If Len(bordercolor) > 1 Then
else
bordercolor = "Brown"
End If 
If Len(Backgroundcolor) >  1 then 
else
Backgroundcolor = "antiquewhite"
End If 

if rs.state = 0 then
else
rs.close
end if
sql = "SELECT  * from Package, People where package.PeopleID = People.PeopleID and packageID=" & packageID 
rs.Open sql, conn, 3, 3   
 
if Not rs.eof then
PackagePrice = rs("PackagePrice")
PackageName = rs("PackageName")
PackageID = rs("PackageID")
PeopleID = rs("PeopleID")
BusinessID =rs("BusinessID")
Logo   = rs("Logo")

peopleEmail =  rs("PeopleEmail")
PackageDescription = rs("Description")
str1 = PackageDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
	PackageDescription= Replace(str1, str2 , "</br>")
End If  
str1 = PackageDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
	PackageDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  

sql2 = "SELECT * from animals, colors, Pricing, packageanimals where colors.ID = animals.ID and pricing.ID = animals.ID and animals.id = packageanimals.animalid and packageanimals.PackageID = " & PackageID  
'response.write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
HuacayaStuds = 0
HuacayaJrStuds = 0
HuacayaNB = 0
HuacayaDams  = 0
HuacayaMaidens  = 0
SuriStuds = 0
SuriJrStuds = 0
SuriNB = 0
SuriDams  = 0
SuriMaidens  = 0
TotalPrice  = 0
TotalHuacayas = 0
TotalSuris = 0
HuacayaStudsBreeding = 0
SuriStudsBreeding = 0

While Not rs2.eof 
TotalPrice  = TotalPrice + cLng(rs2("Price"))
PackageType = rs2("PackageType")
	If PackageType = "ForSale" then
If rs2("Breed") = "Huacaya" And rs2("category") = "Experienced Male" Then
HuacayaStuds = HuacayaStuds + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("Breed") = "Huacaya" And rs2("category") = "Inexperienced Male" Then
HuacayaJrStuds = HuacayaJrStuds + 1
TotalHuacayas = TotalHuacayas + 1
End If 
	If rs2("Breed") = "Huacaya" And rs2("category") = "Experienced Female" Then
HuacayaDams = HuacayaDams + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("Breed") = "Huacaya" And rs2("category") = "Inexperienced Female" Then
HuacayaMaidens = HuacayaMaidens  + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("Breed") = "Huacaya" And rs2("category") = "Non-Breeder" Then
HuacayaNB = HuacayaNB + 1
TotalHuacayas = TotalHuacayas + 1
End If 
	If rs2("Breed") = "Suri" And rs2("category") = "Experienced Male" Then
SuriStuds = SuriStuds + 1
TotalSuris = TotalSuris + 1
End If 
If rs2("Breed") = "Suri" And rs2("category") = "Inexperienced Male" Then
SuriJrStuds = SuriJrStuds + 1
TotalSuris = TotalSuris + 1
End If 
	If rs2("Breed") = "Suri" And rs2("category") = "Experienced Female" Then
SuriDams = SuriDams + 1
TotalSuris = TotalSuris + 1
End If 
If rs2("Breed") = "Suri" And rs2("category") = "Inexperienced Female" Then
SuriMaidens = SuriMaidens  + 1
TotalSuris = TotalSuris + 1
End If 
If rs2("Breed") = "Suri" And rs2("category") = "Non-Breeder" Then
SuriNB = SuriNB + 1
TotalSuris = TotalSuris + 1
End If 
End If 
If PackageType = "Stud" Then
If rs2("Breed") = "Huacaya"  Then
	HuacayaStudsBreeding = HuacayaStudsBreedings + 1
End If 
If rs2("Breed") = "Suri"  Then
	SuriStudsBreeding = SuriStudsBreedings + 1
End If 
End If 
rs2.movenext 
Wend 
 %>
<style type="text/css"> 
b.rtop, b.rbottom{display:block;background: #FFF} 
b.rtop b, b.rbottom b{display:block;height: 1px; 
overflow: hidden; background: <%=bordercolor %>} 
b.r1{margin: 0 5px} 
b.r2{margin: 0 3px} 
b.r3{margin: 0 2px} 
b.rtop b.r4, b.rbottom b.r4{margin: 0 1px;height: 2px} 
.rs1{margin: 0 2px} 
.rs2{margin: 0 1px} 
div.container{ margin: 0 1%;background: <%=bordercolor %>} 
A.title { FONT-FAMILY: <%=HeaderTextFontType%>; 
 color: <%=HeaderTextFontColor %>;
Font-size: 14pt;
	  text-decoration: none
}
 A.title.hover {  color: <%=LinkColor %>	; 
	  text-decoration: none} 
.PageText{ FONT-FAMILY: <%=BodyTextFontType%>; 
	 Font-size: 10pt;
     color: <%=BodyTextFontColor%>;
	 text-decoration: none }
A.PageText{ FONT-FAMILY: <%=BodyTextFontType%>; 
	Font-size: 10pt;
     color: <%=LinkColor%>; 
	  text-decoration: none }
A.PageText:hover{  color: <%=LinkMouseoverColor %>;
	  text-decoration: none }
	  
 .rounded{
border-top:1px solid <%=bordercolor %>;
border-left:1px solid <%=bordercolor %>;
border-right:1px solid <%=bordercolor %>;
border-bottom:1px solid <%=bordercolor %>;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #EEDD99 ;
margin:0px;
background:<%=Backgroundcolor %>;
border-top-left-radius:5px;
border-top-right-radius:5px;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}
</style>
<table  border = "0"  width = "190"  height = "400"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 ">
<tr>
	<td class = "rounded">
<table  border = "0"  width = "190" height = "400"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
	<td>
<table  border = "0"  width = "190"  height = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=3 cellspacing=0>
<tr>
	<td class = "pagetext"  valign = "top"><img src = "images/px.gif" height = "5" width = "100%"><center><a href ="#" class = "title"><%=PackageName %></a></center><img src = "images/px.gif" height = "1" width = "100%"><% if TotalPrice > PackagePrice Then %>
Full Price: <%= FormatCurrency(TotalPrice,0) %><br>
	<% End If %>
	Package Price: <b><% If IsNumeric(PackagePrice) Then %>
<%= FormatCurrency(PackagePrice,0)%><br>
<% Else %>
<%= PackagePrice %><br>
<% End If %></font></b>
<br>
<font size = "1" color = "<%=BodyTextFontColor%>" face="<%=BodyTextFontType%>">
Contains:<br>	
<% If HuacayaStuds = 1 Then %>
	     &nbsp;<%=HuacayaStuds%> Huacaya Herdsire <br>
<% End If %>
<% If HuacayaJrStuds = 1 Then %>
   &nbsp;<%=HuacayaJrStuds%> Huacaya Jr. Herdsire <br>
<% End If %>
<% If HuacayaDams = 1 Then %>
   &nbsp;<%=HuacayaDams%> Huacaya Dam <br>
<% End If %>
<% If HuacayaMaidens   = 1 Then %>
   &nbsp;<%=HuacayaMaidens%> Huacaya Maiden<br>
<% End If %>
<% If HuacayaNB  = 1 Then %>
 &nbsp;<%=HuacayaNB%> Huacaya Non-Breeder<br>
<% End If %>
<% If SuriStuds = 1 Then %>
	    &nbsp;<%=SuriStuds%> Suri Herdsire<br>
<% End If %>
<% If SuriJrStuds = 1  Then %>
 &nbsp;<%=SuriJrStuds%> Suri Jr. Herdsire<br>
<% End If %>
<% If SuriDams = 1  Then %>
   &nbsp;<%=SuriDams%> Suri Dam<br>
<% End If %>
<% If SuriMaidens = 1  Then %>
 &nbsp;<%=SuriMaidens%> Suri Maiden<br>
<% End If %>
<% If SuriNB  = 1   Then %>
&nbsp;<%=SuriNB%> Non-Breeding Suri<br>
<% End If %>
<% If HuacayaStudsBreeding  =1 Then %>
&nbsp;<%=HuacayaStudsBreeding%> Huacaya Stud Breeding<br>
<% End If %>

<% If SuriStudsBreeding  =1 Then %>
&nbsp;<%=SuriStudsBreeding%> Suri Stud Breeding<br>
	<% End If %>
<% If HuacayaStuds > 1 Then %>
	     &nbsp;<%=HuacayaStuds%> Huacaya Herdsires<br>
	<% End If %>
	<% If HuacayaJrStuds > 1 Then %>
   &nbsp;<%=HuacayaJrStuds%> Huacaya Jr. Herdsires<br>
	<% End If %>
	
	<% If HuacayaDams  > 1 Then %>
   &nbsp;<%=HuacayaDams%> Huacaya Dams<br>
	<% End If %>
	<% If HuacayaMaidens   > 1 Then %>
   &nbsp;<%=HuacayaMaidens%> Huacaya Maidens<br>
	<% End If %>
<% If HuacayaNB  > 1 Then %>
 &nbsp;<%=HuacayaNB%> Non-Breeding Huacayas<br>
	<% End If %>

	<% If SuriStuds > 1 Then %>
	    &nbsp;<%=SuriStuds%> Suri Herdsires<br>
	<% End If %>
	<% If SuriJrStuds > 1 Then %>
 &nbsp;<%=SuriJrStuds%> Suri Jr. Herdsires<br>
	<% End If %>
	
	<% If SuriDams  > 1 Then %>
   &nbsp;<%=SuriDams%> Suri Dams<br>
	<% End If %>
	<% If SuriMaidens   > 1 Then %>
 &nbsp;<%=SuriMaidens%>Suri Maidens<br>
	<% End If %>
<% If SuriNB  > 1 Then %>
&nbsp;<%=SuriNB%> Non-Breeding Suris<br>
	<% End If %>

	<% If HuacayaStudsBreeding  > 1 Then %>
&nbsp;<%=HuacayaStudsBreeding%> Huacaya Stud Breedings<br>
	<% End If %>

<% If SuriStudsBreeding  > 1 Then %>
&nbsp;&<%=SuriStudsBreeding%> Suri Stud Breedings<br>
	<% End If %>
<br>
<% descriptionlength = 130 - Len(PackageName) %>

<%= left(PackageDescription, 120) %></font>

<div align = "right"><a href ="#" class = "pagetext">Learn More...</a>&nbsp;&nbsp;</div>
<br><br>
<%str1 = lcase(Logo) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If    %>
	<% if Len(Logo) > 2 Then %>
<center><a href = "#" class = "body"><img src = "<%=Logo %>" border = "0" height = "50" align = "center"></a></center><br>
	<% End If %>
	<center><a href = "#" class = "pagetext"><%=BusinessName%></a></center><br>
</td>
</tr>
     </table>
<% End If  %>
	</td>
</tr>
     </table>
</td>
</tr>
     </table>
</body>
</html>