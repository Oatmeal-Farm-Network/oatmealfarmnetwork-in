<!DOCTYPE html>
<html>

<head>

<!--#Include virtual="/members/membersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Harvest Hub</title>

<link rel="stylesheet" type="text/css" href="Style.css">

</head>

<BODY   >

<!--#Include virtual="/members/MembersHeader.asp"--> 

<!--#Include virtual="/members/Scripts.asp"--> 

<%
ExistingSite = False
EventID = Request.form("EventID") 
ReturnPage= Request.form("ReturnPage") 
BusinessID = Request.form("BusinessID") 
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
website =Request.Form("BusinessWebsite") 
email =Request.Form("BusinessEmail") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
city  = Request.Form("AddressCity")
stateProvince  = Request.Form("stateProvince")
AddressZip = Request.Form("AddressZip")
Phone  = Request.Form("BusinessPhone")
Cell  = Request.Form("BusinessCell")
Fax  = Request.Form("BusinessFax")
BusinessName  = Request.Form("BusinessName")
country  = Request.Form("country")
firstName  = Request.Form("BusinessFirstName")
lastName  = Request.Form("BusinessLastName")
address = Request.Form("address")
aptSuite = Request.Form("aptSuite")

response.write("Cell =" & Cell )


sql = "select AddressID, WebsitesID, BusinessID, Contact1PeopleID, PhoneID from business where BusinessID = " & BusinessID & ""
response.write("sql=" & sql)		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
		WebsitesID  =rs("WebsitesID") 
		BusinessID  =rs("BusinessID")
		Contact1PeopleID=rs("Contact1PeopleID") 
		PhoneID = rs("PhoneID")
End If 

rs.close


str1 = firstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	firstName= Replace(str1,  str2, "''")
End If  

str1 = lastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	lastName= Replace(str1,  str2, "''")
End If  


str1 = PeopleTitleID
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleTitleID= Replace(str1,  str2, "''")
End If  


str1 = website
str2 = "'"
If InStr(str1,str2) > 0 Then
	website= Replace(str1,  str2, "''")
End If  

str1 = lcase(website)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	website= right(website, len(website) - 7)
End If  


str1 = email
str2 = "'"
If InStr(str1,str2) > 0 Then
	email= Replace(str1,  str2, "''")
End If 

str1 = password
str2 = "'"
If InStr(str1,str2) > 0 Then
	password= Replace(str1,  str2, "''")
End If 

str1 = confirm
str2 = "'"
If InStr(str1,str2) > 0 Then
	confirm= Replace(str1,  str2, "''")
End If 

str1 = AddressStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "''")
End If 

str1 = StreetApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "''")
End If 

str1 = AddressApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "''")
End If

str1 = city
str2 = "'"
If InStr(str1,str2) > 0 Then
	city= Replace(str1,  str2, "''")
End If

str1 = AddressZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "''")
End If

str1 = Phone
str2 = "'"
If InStr(str1,str2) > 0 Then
	Phone= Replace(str1,  str2, "''")
End If

str1 = Cell
str2 = "'"
If InStr(str1,str2) > 0 Then
	Cell= Replace(str1,  str2, "''")
End If

str1 = Fax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	Fax= Replace(str1,  str2, "''")
End If

	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " Addresscity = '" &  city & "'," 
    Query =  Query & " AddressState = '" &  stateProvince & "'," 
    Query =  Query & " country_id = '" &  country & "'," 
    Query =  Query & " AddressZip= '" &   AddressZip& "'" & " where AddressID = " & AddressID & ";" 

response.write("<br>Website query = " & Query & "<br>")	


Conn.Execute(Query) 

	Query =  " UPDATE Websites Set Website = '" &  website & "' " 
	Query =  Query & " where WebsitesID = " & WebsitesID & ";" 


response.write("<br>Website query = " & Query & "<br>")	

Conn.Execute(Query) 



 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & city & "' and AddressZip= '" & AddressZip & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close

sql = "select WebsitesID from Websites where Website = '" & website & "'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close



Conn.Execute(Query) 



if len(PhoneID)> 1 then

	Query =  " UPDATE Phone Set "
    Query =  Query & " Phone = '" &  phone & "'," 
    Query =  Query & " Fax = '" &  Fax & "',"
    Query =  Query & " CellPhone = '" & Cell & "'"
	Query =  Query & " where PhoneID = " & PhoneID & ";" 
response.write("People query = " & Query & "<br>")

Conn.Execute(Query) 

else
Query = "INSERT INTO Phone (" 
  ' List of columns to insert into:
  Query = Query & "Phone, Fax, CellPhone"
  Query = Query & ") VALUES ("
  Query = Query & "'" & Phone & "'," 
  Query = Query & "'" & Fax & "',"
  Query = Query & "'" & Cell & "'"
Query = Query & ");"
  Conn.Execute(Query) 

 Query = "SELECT @@IDENTITY AS NewID;"

  ' Execute the SELECT query and open the recordset
  Set rs = Conn.Execute(Query)
  
  ' Check if a record was returned and assign the value
  If Not rs.EOF Then
      ' Get the value from the "NewID" column (aliased in the query)
      PhoneID = rs("NewID")
  Else
     PhoneID = 0 ' Set to 0 or handle error appropriately
  End If

end if







if len(Contact1PeopleID)> 1 then

	Query =  " UPDATE People Set "
	Query =  Query & " PeopleFirstName = '" &  firstName & "'," 
    Query =  Query & " PeopleLastName = '" &  lastName & "'," 
    Query =  Query & " Peopleemail = '" &  email & "'" 
	Query =  Query & " where PeopleID = " & Contact1PeopleID & ";" 
response.write("People query = " & Query & "<br>")

Conn.Execute(Query) 

else
Query = "INSERT INTO People (" 
  ' List of columns to insert into:
  Query = Query & "PeopleFirstName, PeopleLastName, Phone, email, Peoplefax, PeopleCell"
  Query = Query & ") VALUES ("
  Query = Query & "'" & PeopleFirstName & "'," 
  Query = Query & "'" & PeopleLastName & "'," 
  Query = Query & "'" & email & "'" 
Query = Query & ");"
  Conn.Execute(Query) 

 Query = "SELECT @@IDENTITY AS NewID;"

  ' Execute the SELECT query and open the recordset
  Set rs = Conn.Execute(Query)
  
  ' Check if a record was returned and assign the value
  If Not rs.EOF Then
      ' Get the value from the "NewID" column (aliased in the query)
      Contact1PeopleID = rs("NewID")
  Else
      Contact1PeopleID = 0 ' Set to 0 or handle error appropriately
  End If

end if




 if len(PeopleTitleID) > 0 then 
	sql = "select PeopleTitle from PeopleTitleLookup where PeopleTitleID = " & PeopleTitleID & ""
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
PeopleTitle = rs("PeopleTitle")


  end if 
end if

if len(BusinessID) > 0 then
        Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "', " 
		Query =  Query & "  AddressID = " &  AddressID & ", " 
		Query =  Query & "  Contact1PeopleID = " &  Contact1PeopleID & ", " 
		Query =  Query & " WebsitesID = " &  WebsitesID & "" 
    	Query =  Query & " where BusinessID = " & BusinessID & ";" 
'response.write(Query)
        Conn.Execute(Query) 
end if


 if len(ReturnPage) > 1 then
 '' response.redirect(ReturnPage)
else
'response.redirect("ContactsEdit.asp?BusinessID=" & BusinessID )
end if 
 %>
<br><br><br>

		<!--#Include file="membersFooter.asp"-->

</Body>
</HTML>

