<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<% 
file_name = "SetupAccountPlusstep3.asp"

script_name = request.servervariables("script_name")

str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 
'response.write("sitePath=" & sitePath & "<br>")
sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close
BusinessTypeID=request.form("BusinessTypeID")
PeopleLastName=request.form("PeopleLastName")
BusinessName=request.form("BusinessName")
BusinessWebsite=request.form("BusinessWebsite")
BusinessEmail=request.form("BusinessEmail")


AddressStreet=request.form("AddressStreet")
variables = "?AddressStreet=" & AddressStreet
AddressApt=request.form("AddressApt")
variables = variables & "&AddressApt=" & AddressApt
AddressCity=request.form("AddressCity")
variables = variables & "&AddressCity=" & AddressCity
AddressZip=request.form("AddressZip")
variables = variables & "&AddressZip=" & AddressZip
PeoplePhone=request.form("PeoplePhone")
variables = variables & "&PeoplePhone=" & PeoplePhone
StateIndex=request.form("StateIndex")
'response.write("StateIndex=" & StateIndex )




'response.write("confirmpassword=" & confirmpassword & "!")
'response.write("passwordmismatch=" & passwordmismatch & "!")


if len(Password) > 2 then
else
MissingPassword = True
MissingData = True
end if




if len(BusinessEmail) > 0  then
session("BusinessEmail") = BusinessEmail
else
BusinessEmail =Request.querystring("BusinessEmail") 
end if

if len(BusinessEmail) > 0  then
session("BusinessEmail") = BusinessEmail
else
BusinessEmail =session("BusinessEmail")
end if



%>

  

<div class="container-fluid" >
  <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Add An Organization</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br />
<div class="container d-flex justify-content-center" style = "max-width:460px; min-height: 400px">
  <div class="row">
  <div class="col">

<% response.write("addressid!=" & Addressid)
if len(cint(AddressID)) > 0 then
else



sql = "select addresscountry from Address where AddressID = " & AddressID & " order by AddressID Desc"

 rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	addresscountry = rs("addresscountry")
End If 

end if






BusinessName = Request.Form("BusinessName")


str1 = BusinessName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName = Replace(str1,  str2, "''")
End If 

str1 = Owners
str2 = "'"
If InStr(str1,str2) > 0 Then
	Owners= Replace(str1,  str2, "''")
End If  

str1 = PeopleFirstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "''")
End If  

str1 = PeopleLastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleLastName= Replace(str1,  str2, "''")
End If  


str1 = PeopleTitleID
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleTitleID= Replace(str1,  str2, "''")
End If  


str1 = BusinessWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= right(BusinessWebsite, len(BusinessWebsite) - 7)
End If  


str1 = BusinessEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessEmail= Replace(str1,  str2, "''")
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

str1 = AddressCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "''")
End If

str1 = AddressZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "''")
End If


Dim str1
Dim str2


Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, StateIndex, country_id, AddressZip)" 
Query =  Query + " Values ('" & AddressStreet  & "'," 
Query =  Query & " '" &  AddressApt & "', " 
Query =  Query & " '" &  AddressCity & "', " 
Query =  Query & " '" &  StateIndex & "', " 
Query =  Query & " '" &  country_id & "', " 
Query =  Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 
response.Write("Query=" & Query )


sql = "select AddressID from Address  Order by AddressID Desc"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
ExistingEvent = False
If Not rs.eof Then
AddressID  =rs("AddressID") 
End If 

rs.close

Query =  "INSERT INTO Websites (Website)" 
Query =  Query + " Values ('" & BusinessWebsite & "')" 
Conn.Execute(Query) 


sql = "select WebsitesID from Websites where Website = '" & BusinessWebsite & "' order by WebsitesID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close

Query =  "INSERT INTO Business (BusinessName, BusinessTypeID, WebsitesID, AddressID)" 
Query =  Query & " Values ('" & BusinessName & "', " & BusinessTypeID & ",  " & WebsitesID & ", " & AddressID & ")" 
response.write("Query=" & Query )



Conn.Execute(Query) 
	
sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		BusinessID = rs("BusinessID")
	End If 
rs.close


Query =  "INSERT INTO BusinessAccess (BusinessID, PeopleID, AccessLevelID )" 
Query =  Query & " Values (" & BusinessID & ", " & session("PeopleID") & ", 1 )" 
	response.write("Query=" & Query )



Conn.Execute(Query) 


'response.write("Website query = " & Query & "<br>")	

'Conn.Execute(Query) 




daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext = DateAdd("m", 6, datenow)
years = request.form("years")

datenownext =  monthnow & "/" & daynow & "/" & (yearnow + years )

datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )


Session("LoggedIn") = False
Response.Cookies("LoggedIn")= False
Response.Cookies("PeopleFirstName")= PeopleFirstName
Session("Update") = true
 
' response.write("Membership=" & Membership )
if len(PeopleID) > 0 then
'response.write("PeopleID=" & PeopleID)	
'response.write("AddressID=" & AddressID)	
else
sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
		Response.Cookies("PeopleID")= PeopleID
	End If 
rs.close

end if
 

str1 = BusinessName
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "'")
End If 


str1 = BusinessWebsite
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= Replace(str1,  str2, "'")
End If  

str1 = BusinessEmail
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessEmail= Replace(str1,  str2, "'")
End If 


str1 = confirm
str2 = "''"
If InStr(str1,str2) > 0 Then
	confirm= Replace(str1,  str2, "'")
End If 

str1 = AddressStreet
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "'")
End If 

str1 = StreetApt
str2 = "''"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "'")
End If 

str1 = AddressApt 
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "'")
End If

str1 = AddressCity
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "'")
End If

str1 = AddressZip
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "'")
End If



If ExistingAccount = False Then
Query =  "INSERT INTO emaillist (ReceiveEmails, EmailFirstName, EmailLastName, "

if  InStr(Interest, "Products") > 0  Then
Query =  Query & " Products, "
end if 

if  InStr(Interest, "Alpacas") > 0  Then
Query =  Query & " Alpacas, "
end if

if  InStr(Interest, "Bison") > 0  Then
Query =  Query & " Bison, "
end if 

if  InStr(Interest, "Cattle") > 0  Then
Query =  Query & " Cattle, "
end if 

if  InStr(Interest, "Chickens") > 0  Then
Query =  Query & " Chickens, "
end if 

if  InStr(Interest, "Dogs") > 0  Then
Query =  Query & " Dogs, "
end if 

if  InStr(Interest, "Donkeys") > 0  Then
Query =  Query & " Donkeys, "
end if 

if  InStr(Interest, "Goats") > 0  Then
Query =  Query & " Goats, "
end if 
if  InStr(Interest, "Horses") > 0  Then
Query =  Query & " Horses, "
end if 

if  InStr(Interest, "Llamas") > 0  Then
Query =  Query & " Llamas, "
end if 

if  InStr(Interest, "Pigs") > 0  Then
Query =  Query & " Pigs, "
end if 

if  InStr(Interest, "Rabbits") > 0  Then
Query =  Query & " Rabbits, "
end if 

if  InStr(Interest, "Sheep") > 0  Then
Query =  Query & " Sheep, "
end if 
 
if  InStr(Interest, "Turkeys") > 0  Then
Query =  Query & " Turkeys, "
end if 

if  InStr(Interest, "Yaks") > 0  Then
Query =  Query & " Yaks, "
end if 


 Query =  Query & " Address)" 
Query =  Query & " Values (1,"
Query =  Query &   " '" & FirstName & "' , " 
Query =  Query &    " '" & lastName & "',"
if  InStr(Interest, "Products") > 0  Then
Products = True
Query =  Query & " 1, "
end if 
if  InStr(Interest, "Alpacas") > 0  Then
Alpacas = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Bison") > 0  Then
Bison = True
Query =  Query & " 1, "
end if

if  InStr(Interest, "Cattle") > 0  Then
Cattle = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Chickens") > 0  Then
Chickens = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Dogs") > 0  Then
Dogs = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Donkeys") > 0  Then
Donkeys = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Goats") > 0  Then
Goats = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Horses") > 0  Then
Horses = True
Query =  Query & " 1, "
end if

if InStr(Interest, "Llamas") > 0  Then
Llamas = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Pigs") > 0  Then
Pigs = True
Query =  Query & " 1, "
end if 

if InStr(Interest, "Rabbits") > 0  Then
Rabbits = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Sheep") > 0  Then
Sheep = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Turkeys") > 0  Then
Turkeys = True
Query =  Query & " 1, "
end if 
 
if  InStr(Interest, "Yaks") > 0  Then
Yaks = True
Query =  Query & " 1, "
end if 

Query =  Query &   " '" & Email  & "' )" 
'response.write("Query=" & Query )
conn.Execute(Query) 

end if



Response.redirect("MembersOrgAccountContactsEdit.asp?BusinessID=" & BusinessID)	
	%>
</div>
</div>
</div>
<!--#Include virtual="/members/MembersFooter.asp"--> </body>
</HTML>