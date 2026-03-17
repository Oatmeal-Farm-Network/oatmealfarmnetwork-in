<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>General Animal Data Results Page</title>
                          <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

dim ID
dim	Name
dim	ARI
dim	DOB
dim	Price
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
	Price=Request.Form("Price") 
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


		Query =  "INSERT INTO Products ( FullName,  ARI,  DOB, price, Category, Breed, Description)" 
		Query =  Query + " Values ('" +  Name + "'," 
		Query =  Query + " '" +  ARI + "'," 
		Query =  Query + " '" +  DOB + "'," 
		Query =  Query + " '"  +  price + "'," 
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
		
		sql2 = "select ProductID from Products where FullName = '" & Name & "'" 
		Set rs2 = Server.CreateObject("ADODB.Recordset")

'response.write(sql2)
		rs2.Open sql2, conn2, 3, 3   
	
		productID = rs2("productID")
		
		rs2.close
		set rs2=nothing
		set conn2 = nothing
		
		Set DataConnection = Server.CreateObject("ADODB.Connection")
		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

		
		Query =  "INSERT INTO ProductsPhotos (ID)" 
		Query =  Query + " Values (" &  productID & ")" 
		DataConnection.Execute(Query) 

		Query =  "INSERT INTO ProductsAdditionalPhotos (ID)" 
		Query =  Query + " Values (" &  productID & ")" 
		DataConnection.Execute(Query) 

		Query =  "INSERT INTO ProductColor (productID)" 
		Query =  Query + " Values (" &  productID & ")" 
		DataConnection.Execute(Query) 

		Query =  "INSERT INTO ProductSizes (productID)" 
		Query =  Query + " Values (" &  productID & ")" 
		DataConnection.Execute(Query) 
		


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
			<br><a  class = "Links" href="AddProduct.asp"> Return to Add a new Product Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
