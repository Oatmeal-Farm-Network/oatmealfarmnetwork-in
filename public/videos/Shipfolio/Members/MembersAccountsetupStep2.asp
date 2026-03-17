<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>


<!--#Include file="MembersGlobalVariables.asp"-->
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >

<% 
Current2="Account"
Current3="AccountHome" %> 
<!--#Include virtual="/MembersHeader.asp"-->
<br>
<!--#Include file="MembersAccountTabsInclude.asp"-->
<%
ExistingSite = True
Update = "True"
custAIStartService=Request.Form("custAIStartService")  
custAIEndService=Request.Form("custAIEndService")  
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
if len(Peopleemail)> 0  then
else
Peopleemail =Request.querystring("PeopleEmail") 
end if
ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
PeoplePhone  = Request.Form("PeoplePhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
PeopleID = Request.Form("PeopleID")
if len(PeopleID) > 0 then
else
PeopleID = Request.querystring("PeopleID")
end if 
Owners = Request.Form("Owners")
Membership = Request.querystring("Membership")
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


str1 = PeopleWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(PeopleWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= right(PeopleWebsite, len(PeopleWebsite) - 7)
End If  


str1 = PeopleEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "''")
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

str1 = PeoplePhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeoplePhone= Replace(str1,  str2, "''")
End If

str1 = PeopleCell
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleCell= Replace(str1,  str2, "''")
End If

str1 = PeopleFax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFax= Replace(str1,  str2, "''")
End If

ExistingAccount = False
sql = "select * from People  where  accesslevel > 0 and (Peopleemail = '" & Peopleemail & "')"
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		ExistingAccount = True

End If 

rs.close
if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if

if ExistingAccount = False or Update = "True"  then
if len(PeopleID)> 0 then
sql = "select AddressID, WebsitesID, BusinessID from People where PeopleID = " & PeopleID & ""
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
		WebsitesID  =rs("WebsitesID") 
		BusinessID  =rs("BusinessID") 
End If 

rs.close

else


end if

if len(PeopleID) > 0 then
ExistingSite = True
end if
Dim str1
Dim str2

if (ExistingSite = False and Update = "False") or len(WebsitesID) < 1 then
		Query =  "INSERT INTO Websites (Website)" 
		Query =  Query + " Values ('" & PeopleWebsite & "')" 

		Conn.Execute(Query) 
		Conn.close
Set Conn = Nothing %>

<!--#Include virtual="/Conn.asp"-->
	
<%
else
	Query =  " UPDATE Websites Set Website = '" &  PeopleWebsite & "' " 
	Query =  Query & " where WebsitesID = " & WebsitesID & ";" 

		Conn.Execute(Query) 
		Conn.close
Set Conn = Nothing %>

<!--#Include virtual="/Conn.asp"-->
	
<%
end if 

sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' order by WebsitesID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close

if len(BusinessID) < 1 then
Query =  "INSERT INTO Business (BusinessName)" 
Query =  Query & " Values ('" & BusinessName & "')" 
Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="/Conn.asp"-->
<%		
		
		sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		BusinessID = rs("BusinessID")
	End If 
rs.close
end if


if (ExistingSite = False and Update = "False") or len(BusinessID) < 1  then
		

else
	Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "' " 
	Query =  Query & " where BusinessID = " & BusinessID & ";" 

end if 


'response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="/Conn.asp"-->
<%

 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
		else 
		ExistingSite = False
		Update = "False"
	End If 
rs.close
Conn.close
set Conn = nothing %>
<!--#Include virtual="/Conn.asp"-->

<%
if ExistingSite = False and Update = "False" then
		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  AddressState & "', " 
		Query =  Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 
'response.Write("Query=" & Query )
Conn.close
set Conn = nothing %>
<!--#Include virtual="/Conn.asp"-->
<%

sql = "select AddressID from Address  Order by AddressID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 

End If 

rs.close


else
	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " AddressState = '" &  AddressState & "'," 
    Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 

Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="/Conn.asp"-->
<%

end if 
daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext =  monthnow & "/" & daynow & "/" & (yearnow +1 )
datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("datenow = " & datenow)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )

'response.write("Membership=" & Membership)

	Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
	Query =  Query & " WebsitesID = " &  WebsitesID & "," 
	Query =  Query & " AISubscription  = True ," 
	Query =  Query & " AESubscription  = True ,"
	 
	if Membership = "copper" then
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 1 ," 
	Query =  Query & " MaxAnimals  = 5 ," 
	Query =  Query & " maxHerdsires  = 1 ," 
	Query =  Query & " MaxProducts  = 5 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if



   	if Membership = "silver" then
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 2 ," 
	Query =  Query & " MaxAnimals  = 20," 
	Query =  Query & " maxHerdsires  = 3 ," 
	Query =  Query & " MaxProducts  = 5 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 20 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if

   	if Membership = "gold" then
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 3 ," 
	Query =  Query & " MaxAnimals  = 9999 ," 
	Query =  Query & " maxHerdsires  = 9999 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 1 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 30 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if

   if Membership = "Platinum" then
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 4 ," 
	Query =  Query & " MaxAnimals  = 9999 ," 
	Query =  Query & " maxHerdsires  = 9999 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 1 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 2 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 30 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if
   
	Query =  Query & " Owners  = '" &  Owners & "'," 
	Query =  Query & " BusinessID  = " &  BusinessID & "," 
    Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
    Query =  Query & " PeopleLastName = '" &  PeopleLastName & "'," 
    Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
    Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
    Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
    Query =  Query & " PeopleCell = '" &  PeopleCell & "'"
    Query =  Query & " where PeopleID = " & PeopleID & ";" 



'response.Write("Query=" & Query)	
		Conn.Execute(Query) 
		Conn.close
Set Conn = Nothing %>

<!--#Include virtual="/Conn.asp"-->
	
<%

 sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
	End If 
rs.close


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


Session("LoggedIn") = true
 Response.Cookies("LoggedIn")= true
Response.Cookies("PeopleFirstName")= PeopleFirstName
Session("Update") = true
 
if len(PeopleID) > 0 then
'response.write("PeopleID=" & PeopleID)	
'response.write("AddressID=" & AddressID)	
else
sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"

'response.write("sql=" & sql)	
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
		Response.Cookies("PeopleID")= PeopleID
	End If 
rs.close

end if
 
'
'Remove second single quote before displaying data
'
str1 = PeopleFirstName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "'")
End If  

str1 = Owners
str2 = "''"
If InStr(str1,str2) > 0 Then
	Owners= Replace(str1,  str2, "'")
End If 

str1 = BusinessName
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "'")
End If 

str1 = PeopleFirstName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "'")
End If 

str1 = PeopleLastName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleLastName= Replace(str1,  str2, "'")
End If  

str1 = PeopleTitleID
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleTitleID= Replace(str1,  str2, "'")
End If  

str1 = PeopleWebsite
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= Replace(str1,  str2, "'")
End If  

str1 = PeopleEmail
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "'")
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

str1 = PeoplePhone
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeoplePhone= Replace(str1,  str2, "'")
End If

str1 = PeopleCell
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleCell= Replace(str1,  str2, "'")
End If

str1 = PeopleFax 
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFax= Replace(str1,  str2, "'")
End If

%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" height = "530">
<tr><td  valign = "top" class = "roundedtopandbottom">
        
<table border = "0" width = "780" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5>
	<tr>
		<td class = "body2" colspan = "2" align = "left">
				<h1>Your Account Information</h1>
                	Please review your information below: 


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "390" height = "180">
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>
<tr>
	<td class = "body2" align = "right" width = "120">
		First Name: &nbsp;
	</td>
	<td class = "body2" align = "left" >
		<%=PeopleFirstName%>
	</td>
</tr>
<tr>
	<td class = "body2" align = "right">
		Last Name: &nbsp;
	</td>
	<td class = "body2" align = "left">
		<%=PeopleLastName%>
	</td>
</tr><tr>
	<td  class = "body2" align = "right">
		Owners: &nbsp;
	</td>
	<td class = "body2" width = "350" align = "left" >
			<%=Owners %>
    	</td>
	</tr>
<tr>
	<td  class = "body2" align = "right">
		Business Name: &nbsp;
	</td>
	<td class = "body2" width = "350" align = "left" >
			<%=BusinessName %>
    	</td>
	</tr>
	
<tr>
	<td class = "body2" align = "right">
			Your Website: &nbsp;
		</td>
		<td class = "body2" align = "left">
			http://<%=PeopleWebsite%>
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			Email: &nbsp;
		</td>
		<td  align = "left" valign = "top" class = "body2" align = "left">
			<%=PeopleEmail%>
		</td>
	</tr>
	<tr>
		<td class ="body2" valign = "top" colspan = "2" height = "72">
			<br>
		</td>
	</tr>
</table>

</td>
<td width = "50%" valign = "Top">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "390" height = "180">
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>
<tr>
						  <td   class = "body2" align = "right" width = "120">
								Mailing Address: &nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2" align = "left">
								<%=AddressStreet%>
							</td>
						</tr>
						<tr>
						<td   class = "body2"  align = "right">
								Apartment / Suite: &nbsp;

						</td>
						<td  valign = "top" class = "body2" align = "left">
								<%=AddressApt%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2" align = "left">
								<%=AddressCity%>
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=AddressState%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=AddressZip%>
							</td>
						</tr>

						<tr>
							<td   class = "body2" align = "right">
								Phone: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=PeoplePhone%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Cell: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=PeopleCell%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Fax: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=PeopleFax%>
							</td>
						</tr>
						<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<table width = "780"  align = "center"  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<tr>
	<td class ="body2" valign = "top"  align = "center">
			<h2><center>Make Change</center></h2>
			<a href = "setupaccount.asp?Membership=Platinum&PeopleID=<%=PeopleID%>&EventID=<%=EventID%>&ReturnFileName=<%=ReturnFileName%>&ReturnEventID=<%=ReturnEventID%>&Update=True" class = "body2">Click here to go back and make changes.</a><br><br>
	</td>
	<td class ="body2" valign = "top"  align = "center">
		

 <% if membership = "copper" then %>
	<a href = "SignUpCompletion.asp?PeopleID=<%=PeopleID%>" class = "body2"><h2><center>Next Step</center></h2></a>
	<a href = "SignUpCompletion.asp?PeopleID=<%=PeopleID%>" class = "body2">Click Here to Proceed</a><br><br>

<% else %>

<% discount = 0
  returnaddress = "http://www.AlpacaInfinity.com/SignUpCompletion.asp?PeopleID=" & PeopleID
If membership = "silver" then
  Rate = 45
    returnaddress = "http://www.AlpacaInfinity.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
 
 If membership = "gold" then
   Rate = 89
   returnaddress = "http://www.AlpacaInfinity.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
If membership = "platinum" then
   Rate = 189
   returnaddress = "http://www.AlpacaInfinity.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
   '	TempMinusAccount
 
 test = False
  if test = True then%>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% end if %>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="ContactUs@AlpacaInfinity.com">   
<input type="hidden" name="currency_code" value="US">
<input type="hidden" name="notify_url" value="http://www.theandresengroup.com/AIOrderCompletion.asp">  

<input type="hidden" name="item_name_1" value="Alpaca Infinity <%=membership %> Membership">
<% if Discount > 0 then %>
<input type="hidden" name="amount_1" value="<%=Rate*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_1" value="<%=Rate%>">
<% end if %>

<input name="custom" type="hidden" id="custom" value="<%=PeopleID %>"> 
<input type="hidden" name="return" value="<%= returnaddress %>">
<input type="hidden" name="cbt" value="Return to Alpaca Infinity">
<input type="hidden" name="cancel_return" value="http://www.alpacainfinity.com/SetupAccountStep2.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
 
<input type="image" src="/Membersistration/images/paynow.jpg" border="0" name="submit" >
 </form>

<%end if %>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>

<%end if %>
		
  </td></tr></table>
  
<!--#Include Virtual="/Footer.asp"-->
</Body>
</HTML>

