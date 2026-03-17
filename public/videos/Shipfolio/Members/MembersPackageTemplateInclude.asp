	<% PackagePrice = rs("PackagePrice")
					PackageName = rs("PackageName")
					PackageID = rs("PackageID")
					CustID = rs("package.CustID")
					  custFirstName = rs("custFirstName")
				   custMiddleInitial  = rs("custMiddleInitial")
					custLastName  = rs("custLastName")
					custCompany   = rs("custCompany")
					custAddr1  = rs("custAddr1")
					custAddr2  = rs("custAddr2")
					custCity  = rs("custCity")
					custState   = rs("custState")
					custZip   = rs("custZip")
					custCountry   = rs("custCountry")
					custPhone   = rs("custPhone")
					custPhone2   = rs("custPhone2")
					custFAX   = rs("custFAX")
					Logo   = rs("Logo")
					custEmail =  rs("custEmail")

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
	'response.write (sql2)


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
	If PackageType = ForSale then
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

	If PackageType = Stud then
		If rs2("Breed") = "Huacaya"  Then
				HuacayaStudsBreeding = HuacayaStudsBreedings + 1
		End If 
	
	If rs2("Breed") = "Suri"  Then
			SuriStudsBreeding = SuriStudsBreedings + 1
		End If 
	
End If 
%>







	<% 
		rs2.movenext 
		Wend 
%>	
		
		<% If PackageNumber = 38 Then 
				TotalHuacayas = 3 %>
		 	<% End If %>

	<%	If TotalHuacayas > 0 Or PackageNumber = 38 Then %>
<table background = "images/Listbackground.jpg" border = "0" bordercolor = "black">
		<tr>
			<% If TotalHuacayas > 0 And TotalSuris > 0  Then %>
			<td align="center"  valign = "top" class = "list" width = "20" bgcolor = "#A97274" rowspan = "2"><img src = "images/px.gif" width = "20" height= "1"><b>&nbsp;
			<br>H &
			<br>U S
			<br>A U
			<br>C R
			<br>A  I
			<br>Y S
			<br>A
			<br>S
			<br></b></td>
			<% else %>
		<% If TotalSuris > 0  Then %>
				<td align="center"  valign = "top" class = "list" width = "20" bgcolor = "#8892A9" rowspan = "2"><img src = "images/px.gif" width = "20" height= "1"><b>&nbsp;<br>S<br>U<br>R<br>I<br>S</b><br></td>
			<% End If %>
			<% If TotalHuacayas > 0  Then %>
			<td align="center"  valign = "top" class = "list" width = "20" bgcolor = "#A97274" rowspan = "2"><img src = "images/px.gif" width = "20" height= "1"><b>&nbsp;<br>H<br>U<br>A<br>C<br>A<br>Y<br>A<br>S<br></b></td>
			<% End If %>
		<% End If %>	

			<td class = "body" width = "400">

			  <a href ="Package.asp?PackageNumber=<%=PackageNumber %>&CustID=<%=CustID %>&TotalPrice=<%=TotalPrice %>" class = "body"><b><%=PackageName %></b></a><br>
			  <% if TotalPrice > PackagePrice Then %>
				<b>Full Price: <%= FormatCurrency(TotalPrice,0) %></b><br>
			<% End If %>
			 <font color = "brown">Package Price: <b><% If IsNumeric(PackagePrice) Then %>
						<%= FormatCurrency(PackagePrice,0)%><br>
				<% Else %>
						<%= PackagePrice %><br>
				<% End If %></font></b>

 This Package Contains:<br>	
	<% If HuacayaStuds = 1 Then %>
	     &nbsp;&nbsp;   <%=HuacayaStuds%> Experienced Huacaya Male <br>
	<% End If %>
	<% If HuacayaJrStuds = 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaJrStuds%> Inexperienced Huacaya Male <br>
	<% End If %>
	
	<% If HuacayaDams = 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaDams%> Experienced Huacaya Female <br>
	<% End If %>
	<% If HuacayaMaidens   = 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaMaidens%> Inexperienced Huacaya Female <br>
	<% End If %>
<% If HuacayaNB  = 1 Then %>
		 &nbsp;&nbsp;       <%=HuacayaNB%> Non-Breeding Huacaya<br>
	<% End If %>

	<% If SuriStuds = 1 Then %>
	    &nbsp;&nbsp;    <%=SuriStuds%> Experienced Suri Male <br>
	<% End If %>
	<% If SuriJrStuds = 1  Then %>
		 &nbsp;&nbsp;       <%=SuriJrStuds%> Inexperienced Suri Male <br>
	<% End If %>
	
	<% If SuriDams = 1  Then %>
		   &nbsp;&nbsp;     <%=SuriDams%> Experienced Suri Female <br>
	<% End If %>
	<% If SuriMaidens = 1  Then %>
		 &nbsp;&nbsp;       <%=SuriMaidens%> Inexperienced Suri Female <br>
	<% End If %>
<% If SuriNB  = 1   Then %>
		&nbsp;&nbsp;        <%=SuriNB%> Non-Breeding Suri<br>
	<% End If %>






<% If HuacayaStuds > 1 Then %>
	     &nbsp;&nbsp;   <%=HuacayaStuds%> Experienced Huacaya Males <br>
	<% End If %>
	<% If HuacayaJrStuds > 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaJrStuds%> Inexperienced Huacaya Males <br>
	<% End If %>
	
	<% If HuacayaDams  > 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaDams%> Experienced Huacaya Females <br>
	<% End If %>
	<% If HuacayaMaidens   > 1 Then %>
		   &nbsp;&nbsp;     <%=HuacayaMaidens%> Inexperienced Huacaya Females <br>
	<% End If %>
<% If HuacayaNB  > 1 Then %>
		 &nbsp;&nbsp;       <%=HuacayaNB%> Non-Breeding Huacayas<br>
	<% End If %>

	<% If SuriStuds > 1 Then %>
	    &nbsp;&nbsp;    <%=SuriStuds%> Experienced Suri Males <br>
	<% End If %>
	<% If SuriJrStuds > 1 Then %>
		 &nbsp;&nbsp;       <%=SuriJrStuds%> Inexperienced Suri Males <br>
	<% End If %>
	
	<% If SuriDams  > 1 Then %>
		   &nbsp;&nbsp;     <%=SuriDams%> Experienced Suri Females <br>
	<% End If %>
	<% If SuriMaidens   > 1 Then %>
		 &nbsp;&nbsp;       <%=SuriMaidens%> Inexperienced Suri Females <br>
	<% End If %>
<% If SuriNB  > 1 Then %>
		&nbsp;&nbsp;        <%=SuriNB%> Non-Breeding Suris<br>
	<% End If %>

	<% If HuacayaStudsBreeding  > 1 Then %>
		&nbsp;&nbsp;        <%=HuacayaStudsBreeding%> Huacaya Stud Breeding<br>
	<% End If %>


HuacayaStudsBreeding = 0
SuriStudsBreeding = 0

<% If PackageNumber = 38 Then 
				TotalHuacayas = 3 %>
		   &nbsp;&nbsp;     2 Experienced Huacaya Females <br>
		   		   &nbsp;&nbsp;     1 Experienced Huacaya Males <br>
	<% End If %>








<br>

<div align = "right"><a href ="Package.asp?PackageNumber=<%=PackageNumber %>&CustID=<%=CustID %>&TotalPrice=<%=TotalPrice %>" class = "body"><b> Click here to View This Package</b></a>&nbsp;&nbsp;&nbsp;</div>
			</td>
			<td class = "body" valign = "top">
Presented by<br>
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width = "200" border = "0">
	
	<tr>
		<td class = "body"  align = "center" valign = "top">
		
			<% if Len(Logo) > 2 Then %>
				<a href = "/alpacaRanchQuest/RanchHome.asp?CustID=<%=CustID%>" class = "body"><img src = "/Uploads/Logos/<%=Logo %>" border = "0" width = "100" align = "center"></a><br>
			<% End If %>
		</td>
	</tr>
	<tr>
		<td class = "body">
			<b><%=custCompany%></b><br>
				
				<a href = "/alpacaRanchQuest/RanchHome.asp?CustID=<%=CustID%>" class = "body"><b>View their AI RanchSite</b></big></a><br>
				
			
		</td>
	</tr>
</table>
				
		
		</td>
		</tr>
     </table>



<br><br>
<% 
End If %>