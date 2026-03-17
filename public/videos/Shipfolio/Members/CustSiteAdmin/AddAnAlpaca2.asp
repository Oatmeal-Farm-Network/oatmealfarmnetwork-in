<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add an Alpaca Step 2</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 
<%
dim	Name
dim	ARI
dim	CLAA
dim	DOBMonth
dim	DOBDay
dim	DOBYear
dim	Category
dim	Breed
dim	Color1
dim	Color2
dim	Color3
dim	Color4
dim	Color5
dim	PercentPeruvian
dim	PercentChilean
dim	PercentBolivian
dim	PercentUnknownOther
dim	PercentAccoyo
dim	PercentUSA


	Name=Request.Form("Name" ) 
	ARI=Request.Form("ARI" ) 
	CLAA=Request.Form("CLAA" ) 
	DOBMonth=Request.Form( "DOBMonth" ) 
	DOBDay=Request.Form( "DOBDay" ) 
	DOBYear=Request.Form( "DOBYear" ) 
	Category=Request.Form("Category")
	Breed=Request.Form("Breed")
	Color1=Request.Form("Color1") 
	Color2=Request.Form("Color2") 
	Color3=Request.Form("Color3") 
	Color4=Request.Form("Color4") 
	Color5=Request.Form("Color5") 
	PercentPeruvian=Request.Form("PercentPeruvian") 
	PercentChilean=Request.Form("PercentChilean") 
	PercentBolivian=Request.Form("PercentBolivian") 
	PercentUnknownOther=Request.Form("PercentUnknownOther") 
	PercentAccoyo=Request.Form("PercentAccoyo") 
	PercentUSA=Request.Form("PercentUSA") 
	

str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name= Replace(str1, "'", "''")
End If

If len(ARI) = 0 then
	ARI = "0"
End If

If len(CLAA) = 0 then
	CLAA = "0"
End if

If len(color1) = 0 then
	color1 = " "
End If


If len(color2) = 0 then
	color2 = " "
End If


If len(color3) = 0 then
	color3 = " "
End If

If len(color4) = 0 then
	color4 = " "
End If

If len(color5) = 0 then
	color5 = " "
End If

If len(PercentPeruvian) = 0 then
	PercentPeruvian = " "
End If

If len(Percentbolivian) = 0 then
	Percentbolivian = " "
End If

If len(Percentbolivian) = 0 then
	Percentbolivian = " "
End If

If len(PercentUnknownOther) = 0 then
	PercentUnknownOther = " "
End If

If len(PercentAccoyo) = 0 then
	PercentAccoyo = " "
End If

If len(PercentUSA) = 0 then
	PercentUSA = " "
End If


If len(DOBMonth) = 0 then
	DOBMonth = "0"
End If
If len(DOBDay) = 0 then
	DOBDay = "0"
End If
If len(DOBYear) = 0 then
	DOBYear = "0"
End If

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql2 = "select Animals.ID from Animals where CustID = " & session("custID") & " and FullName = '" & Name & "'" 
			'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
		AlpacasID = rs2("ID")
		ID = rs2("ID")

	else

		Query =  "INSERT INTO Animals (FullName, custID, ARI, CLAA, DOBMonth, DOBDay, DOBYear, Category, Breed)" 
		Query =  Query + " Values ('" &  Name & "'," 
		Query =  Query & " " &  Session("custID") & "," 
		Query =  Query & " '" &  ARI & "'," 
		Query =  Query & " '" &  CLAA & "'," 
		Query =  Query & " " &  DOBMonth & "," 
		Query =  Query & " " &  DOBDay & "," 
		Query =  Query & " " &  DOBYear & "," 
		Query = Query & " '"  &  Category & "', " 
		Query =  Query & " '" & Breed  & "')"
		'response.write(query)

	Set DataConnection = Server.CreateObject("ADODB.Connection")
		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


		DataConnection.Execute(Query) 

	DataConnection.Close
		Set DataConnection = Nothing 	
		Set DataConnection = Server.CreateObject("ADODB.Connection")
		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";"

		conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(DatabasePath) & ";" & _
		"User Id=;Password=;" '& _ 
		
		sql2 = "select Animals.ID from Animals where Animals.FullName = '" & Name & "'" 
		Set rs2 = Server.CreateObject("ADODB.Recordset")


		rs2.Open sql2, conn2, 3, 3   
	
		AlpacasID = rs2("ID")
		ID = rs2("ID")

		rs2.close
		set rs2=nothing
		set conn2 = nothing
		
		Set DataConnection = Server.CreateObject("ADODB.Connection")
		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


'response.write("AlpacasID=")
'response.write(AlpacasID)


	Query =  "INSERT INTO AncestryPercents (ID, PercentUSA, PercentPeruvian, PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo)" 
		Query =  Query & " Values (" &  AlpacasID & "," 
				Query =  Query & " '" &  PercentUSA & "'," 
		Query =  Query & " '" &  PercentPeruvian & "'," 
		Query =  Query & " '" &  PercentBolivian & "'," 
		Query =  Query & " '" & PercentChilean & "'," 
		Query = Query & " '"  &  PercentUnknownOther & "'," 
		Query =  Query & " '" & PercentAccoyo & "')"
'response.write(query)

DataConnection.Execute(Query) 

		Query =  "INSERT INTO Colors (ID, Color1, Color2, Color3, Color4, Color5)" 
		Query =  Query & " Values (" &  AlpacasID & "," 
		Query =  Query & " '" &  Color1 & "'," 
		Query =  Query & " '" &  Color2 & "'," 
		Query =  Query & " '" & Color3 & "'," 
		Query = Query & " '"  &  Color4 & "'," 
		Query =  Query & " '" & Color5 & "')"
	
'response.write(query)
	DataConnection.Execute(Query) 


		Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 


		DataConnection.Close
		Set DataConnection = Nothing 

 %>
<div align = "center"><H2>
<%

  %></H2>
</div>
<% End If %>














<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body"><img src = "images/WizardHeader.jpg">
			<a name="Add"></a><br><br>
		<blockquote>	<H1>Step 2: Ancestry</H1>
			Please enter the following information for your alpaca. It's okay if you are missing some information except where required fields are indicated with an asterisk. <br>
</blockquote>
		</td>
	</tr>
	
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "775">
	<tr>
		<td class = "body">
			<h2><font color = "brown">Step 2: Ancestry</font> <small>(* = Required Fields)</small></h2><br>
		
		</td>
	</tr>
	</table>

<form action= 'AddanAlpaca3.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "775">
  		<tr> 
    			<td rowspan="8" align=center class = "list">

			</td>
    			<td rowspan="4" class = "list">Sire<br>
				<%
					Ancestorname = "Sire"
					AncestorColor = "SireColor"
					AncestorARI = "SireARI"
					AncestorCLAA = "SireCLAA"
					gender = "male"
					%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" nowrap class = "list">Paternal Grandsire
				<br>
				<%
Ancestorname = "SireSire"
AncestorColor = "SireSireColor"
AncestorARI = "SireSireARI"
AncestorCLAA = "SireSireCLAA"
gender = "male"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td nowrap>
				<br>
				<%
Ancestorname = "SireSireSire"
AncestorColor = "SireSireSireColor"
AncestorARI = "SireSireSireARI"
AncestorCLAA = "SireSireSireCLAA"
gender = "male"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = "SireSireDam"
AncestorColor = "SireSireDamColor"
AncestorARI = "SireSireDamARI"
AncestorCLAA = "SireSireDamCLAA"
gender = "Female"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
		</tr>
		<tr> 
    			<td rowspan="2" class = "list">Paternal Granddam<br>
				<%
Ancestorname = "SireDam"
AncestorColor = "SireDamColor"
AncestorARI = "SireDamARI"
AncestorCLAA = "SireDamCLAA"
gender = "Female"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = "SireDamSire"
AncestorColor = "SireDamSireColor"
AncestorARI = "SireDamSireARI"
AncestorCLAA = "SireDamSireCLAA"
gender = "male"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = "SireDamDam"
AncestorColor = "SireDamDamColor"
AncestorARI = "SireDamDamARI"
AncestorCLAA = "SireDamDamCLAA"
gender = "Female"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="4" class = "list">Dam<br>
				<%
Ancestorname = "Dam"
AncestorColor = "DamColor"
AncestorARI = "DamARI"
AncestorCLAA = "DamCLAA"
gender = "Female"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" class = "list">Maternal Grandsire<br>
				<%
Ancestorname = "DamSire"
AncestorColor ="DamSireColor"
AncestorARI = "DamSireARI"
AncestorCLAA = "DamSireCLAA"
gender = "male"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = "DamSireSire"
AncestorColor = "DamSireSireColor"
AncestorARI = "DamSireSireARI"
AncestorCLAA = "DamSireSireCLAA"
gender = "male"
%>
				
				<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = "DamSireDam"
AncestorColor = "DamSireDamColor"
AncestorARI = "DamSireDamARI"
AncestorCLAA = "DamSireDamCLAA"
gender = "Female"
%>
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="2" class = "list">Maternal Granddam<br>
				<%
Ancestorname = "DamDam"
AncestorColor = "DamDamColor"
AncestorARI = "DamDamARI"
AncestorCLAA = "DamDamCLAA"
gender = "Female"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = "DamDamSire"
AncestorColor = "DamDamSireColor"
AncestorARI = "DamDamSireARI"
AncestorCLAA = "DamDamSireCLAA"
gender = "male"
%>
				
					<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = "DamDamDam"
AncestorColor = "DamDamDamColor"
AncestorARI = "DamDamDamARI"
AncestorCLAA = "DamDamDamCLAA"
gender = "Female"
%>
				
				<!--#Include virtual="/Administration/AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
	</table>


<tr>
		<td  align = "center" colspan ="3">
			<br>
					<input type = "hidden" name="ID" value= "<%= AlpacasID %>" >
			<input type=submit value = "Next ->" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 		</td>
	</tr>
	
</table>


<br><br><br>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
