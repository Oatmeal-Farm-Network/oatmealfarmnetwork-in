<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Update Basic Facts</title>
                          <link rel="stylesheet" type="text/css" href="/administration/style.css">


						  <SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.Name.value=="") {
themessage = themessage + " -Name \r";
}
if (document.form.Breed.value=="") {
themessage = themessage + " -Breed \r";
}
if (document.form.Category.value=="") {
themessage = themessage + " -Category \r";
}
//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
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



'response.write(AlpacasID)


	Query =  "INSERT INTO AncestryPercents (ID, PercentPeruvian, PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo)" 
		Query =  Query & " Values (" &  AlpacasID & "," 
		Query =  Query & " '" &  PercentPeruvian & "'," 
		Query =  Query & " '" &  PercentBolivian & "'," 
		Query =  Query & " '" & PercentChilean & "'," 
		Query = Query & " '"  &  PercentUnknownOther & "'," 
		Query =  Query & " '" & PercentAccoyo & "')"
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


		DataConnection.Close
		Set DataConnection = Nothing 

 %>
<div align = "center"><H2>
<%

  %></H2>
</div>
<% End If %>




<br><br><br>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
