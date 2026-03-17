<table border = "0" cellspacing="5" cellpadding = "5" align = "center" >
 <tr><td class = "roundedBottom" align = "center"><TABLE width = "180"  height = "430" BGCOLOR = "WHITE" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=1 cellspacing=0>
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
sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
if rsc.eof then
rsc.close
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

	sql = "SELECT  ListingDesignID from ListingDesign order by ListingDesignID DESC"
	Set rsc = Server.CreateObject("ADODB.Recordset")
	 rsc.Open sql, conn, 3, 3   
	if Not rsc.eof then
		ListingDesignID  = rsc("ListingDesignID")
		Query =  " UPDATE Package Set ListingDesignID = " &  ListingDesignID & "" 
		Query =  Query & " where PackageID = " & PackageID & ";" 
		Conn.Execute(Query) 
	End If 
 Else
  rsc.close
 End If 
 sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
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
str1 = lcase(Image) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
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
sql = "SELECT  * from Package, People where package.Peopleid = People.Peopleid and packageID=" & packageID 
Set rsc = Server.CreateObject("ADODB.Recordset")
'response.write("sql=" & sql)
rsc.Open sql, conn, 3, 3   
if Not rsc.eof then
PackagePrice = rsc("PackagePrice")
PackageValue = rsc("PackageValue")
PackageName = rsc("PackageName")
PackageID = rsc("PackageID")
CurrentPeopleid = rsc("Peopleid")
Logo   = rsc("Logo")
 If Len(logo) > 1 and Len(logo) < 131 then
 str1 = lcase(Logo) 
str2 = "/uploads/"
If  not (InStr(str1,str2) > 0) Then
	Logo = "/uploads/" & Logo
End If 
End If  
PeopleEmail =  rsc("PeopleEmail")
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
Set rsX = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where Peopleid= " & CurrentPeopleid
rsX.Open sql, conn, 3, 3
If not rsX.eof then
PeopleFirstName = rsX("PeopleFirstName")
PeopleLastName = rsX("PeopleLastName")
RanchHomeText = rsX("RanchHomeText")
BusinessID   = rsX("BusinessID")
AddressID  = rsX("AddressID")
WebsitesID= rsX("WebsitesID")
RanchHomeText = rsX("RanchHomeText")
Logo = rsX("Logo")
Header = rsX("Header")
Phone = rsX("PeoplePhone")
Cellphone = rsX("PeopleCell")
Fax = rsX("PeopleFax")
Owners = rsX("Owners")
ScreenBackground=rsX("ScreenBackground")
if len(trim(Owners)) > 2 then
else
	Owners = PeopleFirstName & " " & PeopleLastName
end if
screenbackground = rsX("screenbackground")

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
rsX.close
if len(WebsitesID) > 0 then
 sql = "select distinct * from Websites where WebsitesID = " & WebsitesID
'response.write (sql)
    Set rsX = Server.CreateObject("ADODB.Recordset")
    rsX.Open sql, conn, 3, 3   
 if  Not rsX.eof then 
PeopleWebsite = rsX("Website")
end if
rsX.close

end if

sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rsX.Open sql, conn, 3, 3
If not rsX.eof then
	BusinessName = rsX("BusinessName")
end if 

rsX.close
sql = "select  * from Address where AddressID= " & AddressID
rsX.Open sql, conn, 3, 3
If not rsX.eof then
AddressStreet = rsX("AddressStreet")
AddressApt = rsX("AddressApt")
AddressCity = rsX("AddressCity")
AddressState = rsX("AddressState")
AddressCountry = rsX("AddressCountry")
AddressZip = rsX("AddressZip")
end if 
rsX.close
sql2 = "SELECT * from animals,  packageanimals where animals.id = packageanimals.animalid and packageanimals.PackageID = " & PackageID 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3  
'response.write("recordcount = " & rs2.recordcount)
While Not rs2.eof 
PackageType = rs2("PackageType")
If PackageType = "ForSale" then
If rs2("BreedID") = 2 And rs2("category") = "Experienced Male" Then
HuacayaStuds = HuacayaStuds + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("BreedID") = 2 And rs2("category") = "Inexperienced Male" Then
HuacayaJrStuds = HuacayaJrStuds + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("BreedID") = 2 And rs2("category") = "Experienced Female" Then
HuacayaDams = HuacayaDams + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("BreedID") = 2 And rs2("category") = "Inexperienced Female" Then
HuacayaMaidens = HuacayaMaidens  + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("BreedID") = 2 And rs2("category") = "Non-Breeder" Then
HuacayaNB = HuacayaNB + 1
TotalHuacayas = TotalHuacayas + 1
End If 
If rs2("BreedID") = 1 And rs2("category") = "Experienced Male" Then
				SuriStuds = SuriStuds + 1
				TotalSuris = TotalSuris + 1
		End If 
		If rs2("BreedID") = 1 And rs2("category") = "Inexperienced Male" Then
				SuriJrStuds = SuriJrStuds + 1
				TotalSuris = TotalSuris + 1
		End If 
			If rs2("BreedID") = 1 And rs2("category") = "Experienced Female" Then
				SuriDams = SuriDams + 1
				TotalSuris = TotalSuris + 1
		End If 
		If rs2("BreedID") = 1 And rs2("category") = "Inexperienced Female" Then
				SuriMaidens = SuriMaidens  + 1
				TotalSuris = TotalSuris + 1
		End If 
		If rs2("BreedID") = 1 And rs2("category") = "Non-Breeder" Then
				SuriNB = SuriNB + 1
				TotalSuris = TotalSuris + 1
		End If
		

		
		 
End If 
If PackageType = "Stud" Then
If rs2("BreedID") = 2  Then
	HuacayaStudsBreeding = HuacayaStudsBreedings + 1
End If 
If rs2("BreedID") = 1  Then
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
<table  border = "3"  width = "180"  height = "430"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "<%=bordercolor %>">
		<tr>
			<td>
<table bgcolor = "<%=Backgroundcolor %>" border = "0" bordercolor = "<%=bordercolor %>" width = "180" height = "430"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		<tr>
			<td>
<table bgcolor = "<%=Backgroundcolor %>" border = "0"  width = "180"  height = "450" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=3 cellspacing=0>
<tr>
<td class = "PageText"  valign = "top"><center>
<a href ="/ranches/RanchPackageDetails.asp?packageid=<%=packageid %>&CurrentPeopleid=<%=CurrentPeopleid %>&TotalPrice=<%=PackageValue %>" class = "PageText">
<FONT size = "4" COLOR="<%=HeaderTextFontColor %>"
			onMouseOver="this.style.color = '<%=LinkMouseoverColor %>'"
			onMouseOut="this.style.color = '<%=HeaderTextFontColor %>'">
<%=PackageName %></a></font></center>
			
<font size = "2" color = "<%=BodyTextFontColor%>" face="<%=BodyTextFontType%>">
<% if PackageValue > PackagePrice Then %>
	Full Price: <%= FormatCurrency(PackageValue,0) %><br>
<% End If %>
Package Price: <b><% If IsNumeric(PackagePrice) Then %>
		<%= FormatCurrency(PackagePrice,0)%><br>
<% Else %>
		<%= PackagePrice %><br>
<% End If %></b>
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
		 &nbsp;<%=SuriMaidens%> Suri Maidens<br>
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
<% if Len(PackageDescription) > 2 then  %>
<% descriptionlength = 130 - Len(PackageName) %>
<%= left(PackageDescription, descriptionlength) %>...</font>
<% end if %>


<br>
<div align = "right"><a href ="/ranches/RanchPackageDetails.asp?packageid=<%=packageid %>&CurrentPeopleid=<%=CurrentPeopleid %>&TotalPrice=<%=TotalPrice %>" class = "PageText">
<FONT size = "2" COLOR="<%=LinkColor %>"
			onMouseOver="this.style.color = '<%=LinkMouseoverColor %>'"
			onMouseOut="this.style.color = '<%=LinkColor %>'">
			Learn More...</a></font>&nbsp;&nbsp;</div>
		<br>
			<% 
				
 If Len(logo) > 1 and Len(logo) < 131 then
 str1 = lcase(Logo) 
str2 = "/uploads/"
If  not (InStr(str1,str2) > 0) Then
	Logo = "/uploads/" & Logo
End If 
End If  
		
        str1 = lcase(Logo) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo =   Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  	
			if Len(Logo) > 2 Then %>
				<center><a href = "/ranches/RanchHome.asp?CurrentPeopleid=<%=CurrentPeopleid%>" class = "PageText"><img src = "<%=Logo %>" border = "0" height = "50" align = "center"></a></center><br>
			<% End If %>
					<center><a href = "/ranches/RanchHome.asp?CurrentPeopleid=<%=CurrentPeopleid%>" class = "PageText"><FONT size = "2" COLOR="<%=LinkColor %>"
			onMouseOver="this.style.color = '<%=LinkMouseoverColor %>'"
			onMouseOut="this.style.color = '<%=LinkColor %>'"><%=BusinessName%></font></a></center><br>
		</td>
		</tr>
     </table>

	</td>
		</tr>
     </table>
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