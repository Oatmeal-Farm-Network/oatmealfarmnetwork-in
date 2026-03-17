<TABLE width = "180"  height = "430" BGCOLOR = "WHITE">
<TR>
 <td>
<% packageid= rs("Packageid")
		Backgroundcolor = ""
		BorderColor = ""
		MouseoverColor  = ""
		adImage	  = ""
		HeaderTextFontType  = ""
		HeaderTextFontColor  = ""
		BodyTextFontType  = ""
		BodyTextFontColor  = ""
		LinkColor = ""

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(databasepath) & ";" & _
			"User Id=;Password=;" '& _ 
' Get marketing text for the top of the page:
conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(databasepath) & ";" & _
				"User Id=;Password=;" '& _ 
' Get marketing text for the top of the page:

sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
'response.write (sql)
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
if rsc.eof then
	rsc.close
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

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

	DataConnection.Execute(Query) 

	sql = "SELECT  ListingDesignID from ListingDesign order by ListingDesignID DESC"
	Set rsc = Server.CreateObject("ADODB.Recordset")
	 rsc.Open sql, conn, 3, 3   
	if Not rsc.eof then
		ListingDesignID  = rsc("ListingDesignID")
		Query =  " UPDATE Package Set ListingDesignID = " &  ListingDesignID & "" 
		Query =  Query & " where PackageID = " & PackageID & ";" 
		DataConnection.Execute(Query) 
		DataConnection.Close
		Set DataConnection = Nothing 
	End If 
 Else
  rsc.close
 End If 
 

sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid

'response.write(sql)
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
'response.write("BackgroundColor=" & BackgroundColor)
HeaderTextColor = rsc("HeaderTextColor")
If Len(HeaderTextColor) > 1 Then
Else
HeaderTextColor = "Black"
End If 
LinkMouseoverColor = rsc("LinkMouseoverColor")
If Len(LinkMouseoverColor) > 1 Then
Else
LinkMouseoverColor = "navy"
End If 
BackgroundColor = rsc("BackgroundColor")
If Len(BackgroundColor) > 1 Then
Else
BackgroundColor = "Antiquewhite"
End If 
BorderColor = rsc("BorderColor")
If Len(BorderColor) > 1 Then
Else
BorderColor= "Brown"
End If 
Image	 = rsc("Image")
HeaderTextFontType = rsc("HeaderTextFontType")
If Len(HeaderTextFontType) > 1 Then
Else
HeaderTextFontType= "Arial, san-serif"
End If 
HeaderTextFontColor = rsc("HeaderTextFontColor")
If Len(HeaderTextFontColor) > 1 Then
Else
HeaderTextFontColor= "Brown"
End If 
BodyTextColor = rsc("BodyTextColor")
If Len(BodyTextColor) > 1 Then
Else
BodyTextColor = "Black"
End If 
BodyTextFontType = rsc("BodyTextFontType")
If Len(BodyTextFontType) > 1 Then
Else
BodyTextFontType= "Arial, san-serif"
End If 
BodyTextFontColor = rsc("BodyTextFontColor") 
If Len(BodyTextFontColor) > 1 Then
Else
BodyTextFontColor = "Black"
End If 
LinkColor = rsc("LinkColor")
If Len(LinkColor) > 1 Then
Else
LinkColor = "brown"
End If 


sql = "SELECT  * from Package, sfcustomers where cint(package.custid) = cint(sfcustomers.custid) and packageID=" & packageID 

Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
 
if Not rsc.eof then
PackagePrice = rsc("PackagePrice")
PackageName = rsc("PackageName")
PackageID = rsc("PackageID")
CustID = rsc("package.CustID")
custFirstName = rsc("custFirstName")
custMiddleInitial  = rsc("custMiddleInitial")
custLastName  = rsc("custLastName")
custCompany   = rsc("custCompany")
custAddr1  = rsc("custAddr1")
custAddr2  = rsc("custAddr2")
custCity  = rsc("custCity")
custState   = rsc("custState")
custZip   = rsc("custZip")
custCountry   = rsc("custCountry")
custPhone   = rsc("custPhone")
custPhone2   = rsc("custPhone2")
custFAX   = rsc("custFAX")
Logo   = rsc("Logo")
custEmail =  rsc("custEmail")
PackageDescription = rsc("Description")
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
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn2, 3, 3   
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
TotalPrice  = TotalPrice + rs2("Price")
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
</style>
<table  border = "2"  width = "180"  height = "430"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "<%=bordercolor %>">
		<tr>
			<td>
<table bgcolor = "<%=Backgroundcolor %>" border = "0" bordercolor = "<%=bordercolor %>" width = "180" height = "430"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		<tr>
			<td>
		<table bgcolor = "<%=Backgroundcolor %>" border = "0"  width = "180"  height = "450" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=3 cellspacing=0>
		<tr>
			<td class = "pagetext"  valign = "top"><img src = "images/px.gif" height = "5" width = "100%"><center><a href ="#" class = "title"><%=PackageName %></a></center><img src = "images/px.gif" height = "1" width = "100%"><% if TotalPrice > PackagePrice Then %>
				Full Price: <%= FormatCurrency(TotalPrice,0) %><br>
			<% End If %>
			 <font color = "brown">Package Price: <b><% If IsNumeric(PackagePrice) Then %>
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
<%= left(PackageDescription, descriptionlength) %>...</font>
<br>
<div align = "right"><a href ="PackageDetails.asp?packageid=<%=packageid %>&CustID=<%=CustID %>&TotalPrice=<%=TotalPrice %>" class = "pagetext">Learn More...</a>&nbsp;&nbsp;</div>
		<br>
			<% if Len(Logo) > 2 Then %>
				<center><a href = "#" class = "body"><img src = "/Uploads/Logos/<%=Logo %>" border = "0" height = "50" align = "center"></a></center><br>
			<% End If %>
					<center><a href = "#" class = "pagetext"><%=custCompany%></a></center><br>
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
	 </td>
		</tr>
     </table>