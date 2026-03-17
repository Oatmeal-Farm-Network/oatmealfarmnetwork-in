<!DOCTYPE HTML>
<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
                          <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include File="AdminSecurityInclude.asp"--> 
<!--#Include File="AdminHeader.asp"--> 
<%

dim ID
dim	Name
dim	ARI
dim	DOB
dim	Color
dim	ColorCategory
dim	Male 
dim	Category
dim	Breed
dim	Comments
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated

	ID=Request.Form("ID" ) 
	Name=Request.Form("Name" ) 
	ARI=Request.Form("ARI" ) 
	DOB=Request.Form( "DOB" ) 
	Color=Request.Form("Color") 
	ColorCategory=Request.Form("ColorCategory") 
	Category=Request.Form("Category")
	Breed=Request.Form("Breed")
	Comments=Request.Form("Comments") 



If len(ARI) = 0 then
	ARI = "0"
End if


str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name= Replace(str1, "'", "''")
End If

str1 = Meaning
str2 = "'"
If InStr(str1,str2) > 0 Then
	Meaning= Replace(str1, "'", "''")
End If


str1 = Comments
str2 = "'"
If InStr(str1,str2) > 0 Then
	Comments= Replace(str1, "'", "''")
End If

if len(DOB) < 3 then
	DOB = "0"
end if


		Query =  "INSERT INTO Animals ( FullName,  ARI,  DOB, Color, Category, Breed, Description)" 
		Query =  Query + " Values ('" +  Name + "'," 
		Query =  Query + " '" +  ARI + "'," 
		Query =  Query + " '" +  DOB + "'," 
		Query =  Query + " '"  +  Color + "'," 
		Query = Query + " '"  +  Category + "'," 
		Query =  Query + " '" +  Breed + "'," 
		Query =  Query + " '" +  Comments + "')"
		

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

'response.write(sql2)
		rs2.Open sql2, conn2, 3, 3   
	
		AlpacasID = rs2("ID")
		
		rs2.close
		set rs2=nothing
		set conn2 = nothing
		
		Set DataConnection = Server.CreateObject("ADODB.Connection")
		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

		Query =  "INSERT INTO Awards (ID)" 
		Query =  Query + " Values (" &  AlpacasID & ")" 
		DataConnection.Execute(Query) 

		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values (" &  AlpacasID & ")" 
		DataConnection.Execute(Query) 


		Query =  "INSERT INTO Photos (ID)" 
		Query =  Query + " Values (" &  AlpacasID & ")" 
		DataConnection.Execute(Query) 

		Query =  "INSERT INTO Pricing (ID)" 
		Query =  Query + " Values (" &  AlpacasID & ")" 
		DataConnection.Execute(Query) 

	
			Query =  "INSERT INTO MaleData (ID)" 
			Query =  Query + " Values (" &  AlpacasID & ")" 
			DataConnection.Execute(Query) 
		
			Query =  "INSERT INTO FemaleData (ID)" 
			Query =  Query + " Values (" &  AlpacasID & ")" 
			DataConnection.Execute(Query) 
		

		Query =  "INSERT INTO Ancestors (ID)" 
		Query =  Query + " Values (" &  AlpacasID & ")" 
		'response.write (Query)
		DataConnection.Execute(Query) 


		DataConnection.Close
		Set DataConnection = Nothing 

 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 


%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="AdminAnimalAdd1.asp"> Return to Add a new Animal Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include File="AdminFooter.asp"--> </Body>
</HTML>
