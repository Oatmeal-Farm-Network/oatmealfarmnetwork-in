<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
            <link rel="stylesheet" type="text/css" href="style.css">

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
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminDetailDBInclude.asp"--> 

<% 'GET TYPE OF DATA TO UPDATE *****************************************************
	  FormID=Request.Form("FormID" ) 
      If FormID = "GeneralStats" then
%>
<!--#Include file="AdminSecurityInclude.asp"--> 
<%

ID=Request.Form("ID" ) 
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
	'response.write(PercentPeruvian)

str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name= Replace(str1, "'", "''")
End If

str1 = CLAA
str2 = "'"
If InStr(str1,str2) > 0 Then
	CLAA= Replace(str1, "'", "''")
End If


str1 = ARI
str2 = "'"
If InStr(str1,str2) > 0 Then
	ARI= Replace(str1, "'", "''")
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

			 sql2 = "select Animals.ID from Animals where CustID = " & session("custID") & " and id = " & id & "" 
			'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

Query =  " UPDATE Animals  Set FullName = '" &  Name & "', "
Query =  Query & " ARI = '" &  ARI & "', " 
Query =  Query & " CLAA = '" &  CLAA & "', " 
Query =  Query & " DOBMonth = '" &  DOBMonth & "', " 
Query =  Query & " DOBDay = '" &  DOBDay & "', " 
Query =  Query & " DOBYear = '" &  DOBYear & "', " 
Query =  Query & " Category = '" &  Category & "', " 
Query =  Query & " Breed = '" &  Breed & "' " 
Query =  Query & " where ID = " & ID & ";" 
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

Query =  " UPDATE AncestryPercents Set PercentPeruvian = '" &  PercentPeruvian & "', "
Query =  Query & " PercentBolivian = '" &  PercentBolivian & "', " 
Query =  Query & " PercentChilean = '" &  PercentChilean & "', " 
Query =  Query & " PercentUnknownOther = '" &  PercentUnknownOther & "', " 
Query =  Query & " PercentAccoyo = '" &  PercentAccoyo & "', " 
Query =  Query & " PercentUSA = '" &  PercentUSA & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
response.write(query)
DataConnection.Execute(Query) 


Query =  " UPDATE Colors Set Color1 = '" &  Color1 & "', "
Query =  Query & " Color2 = '" &  Color2 & "', " 
Query =  Query & " Color3 = '" &  Color3 & "', " 
Query =  Query & " Color4 = '" &  Color4 & "', " 
Query =  Query & " Color5 = '" &  Color5 & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
	
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





<% 'SHOW ANIMAL DATA*****************************************************************
redirectpath = "AdminAnimalEdit.asp?ID=" &  ID
response.redirect(redirectpath)
%>

</TD>
</TR>
</TABLE>	

<br><br><br>

<% 'FOOTER   ***************************************************************** %>

<!--#Include File="AdminFooter.asp"--> </Body>
</HTML>
