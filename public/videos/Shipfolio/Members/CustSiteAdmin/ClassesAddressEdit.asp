<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>
<% Current2 = "SiteAdmin" 
Current3 = "EditUsers" %> 
<!--#Include file="AdminHeader.asp"--> 
<br />
<!--#Include file="SiteAdminTabsInclude.asp"-->
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth -30%>" >
<tr><td height = "560" valign = "top">
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<%
UserID= Request.QueryString("UserID") 
If Len(UserID) < 2 then
UserID= Request.Form("UserID") 
End If 
dim PeopleIDArray(5000) 
dim BusinessNameArray(5000) 
dim PeopleFirstNameArray(5000) 
dim PeopleLastNameArray(5000) 
sql2 = "select * from People, Business where People.BusinessID = Business.BusinessID and not peopleID = 667 order by BusinessName"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
While Not rs2.eof  
PeopleIDArray(acounter) = rs2("PeopleID")
BusinessNameArray(acounter) = rs2("BusinessName")
PeopleFirstNameArray(acounter) = rs2("PeopleFirstName")
PeopleLastNameArray(acounter) = rs2("PeopleLastName")
acounter = acounter +1
rs2.movenext
Wend %>
<form  action="SiteAdmineditUser.asp" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td colspan ="30">
&nbsp;
</td>
<td class = "body">
<br>Select a User:
<select size="1" name="UserID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=PeopleIDArray(count)%>">
<%=BusinessNameArray(count)%> - <%=PeopleLastNameArray(count)%>, <%=PeopleFirstNameArray(count)%> 
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Edit" class = "regsubmit2" >
</td>
</tr>
</table>
 </form>
<% If Len(UserID) < 1 Then
 else 
Session("UserID")  = UserID
	sql = "select distinct People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = " & UserID
Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
if  Not rs.eof then   
AddressID = rs("address.AddressID")
Account = rs("Account")
PeoplePassword = rs("PeoplePassword")
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
 AddressStreet = rs("AddressStreet")
 WebsitesID = rs("WebsitesID")
PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Logo= rs("Logo")
Owners= rs("Owners")
AIPublish =rs("AIPublish")
AEPublish =rs("AEPublish")
AISubscription =rs("AISubscription")
AESubscription =rs("AESubscription")
custAIStartService=rs("custAIStartService")
custAIEndService=rs("custAIEndService")
accesslevel = rs("accesslevel")
SubscriptionLevel = rs("SubscriptionLevel")
MaxAnimals = rs("MaxAnimals")
maxHerdsires = rs("maxHerdsires")
MaxProducts  = rs("MaxProducts")
FreeMassEmailsPaidFor = rs("FreeMassEmailsPaidFor")
FreeMassEmailsUsed  = rs("FreeMassEmailsUsed")
HomepageadsPaidfor = rs("HomepageadsPaidfor")
HomepageadsUsed  = rs("HomepageadsUsed")
HeaderadsPaidfor = rs("HeaderadsPaidfor")
HeaderadsUsed = rs("HeaderadsUsed")
FreeAnimalEntryPaidFor  = rs("FreeAnimalEntryPaidFor")
FreeAnimalEntryUsed  = rs("FreeAnimalEntryUsed")
custFooterEndDate =rs("custFooterEndDate")
custFooterStartDate =rs("custFooterStartDate")
ReceiveStatusEmails =rs("ReceiveStatusEmails")

  end if
   rs.close
 sql = "select distinct BusinessName, BusinessLogo, Business.BusinessID from People, Business where People.BusinessID = Business.BusinessID and  people.PeopleID = " & UserID & " order by Business.BusinessID Asc"

'response.write (sql)
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
 BusinessName = rs("BusinessName")
 BusinessLogo = rs("BusinessLogo")
 BusinessID = rs("BusinessID")
end if



if len(WebsitesID) > 0 then
 sql = "select distinct * from Websites where WebsitesID = " & WebsitesID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
PeopleWebsite = rs("Website")
end if
end if	
rs.close 

Set rs2 = Server.CreateObject("ADODB.Recordset") 
if len(addressID) > 0 then
sql2 = "select * from Address where AddressID = " & AddressID
 rs2.Open sql2, conn, 3, 3   
 If not rs2.eof Then
AddressID =rs2("AddressID")
AddressStreet =rs2("AddressStreet")
AddressApt=rs2("AddressApt")
AddressCity=rs2("AddressCity")
AddressState=rs2("AddressState")
AddressZip=rs2("AddressZip")
AddressCountry=rs2("AddressCountry")
End If
rs2.close 

else


Query =  "INSERT INTO Address ( AddressStreet, AddressApt, AddressCity,  AddressState,  AddressZip, AddressCountry)" 
Query =  Query & " Values (' "& AddressStreet & "' , '" & AddressApt & "' , '" &  AddressCity & "' , '" &  AddressState & "' , '" & AddressZip & "', '" &  AddressCountr & "')"
'response.write("query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query)
DataConnection.close
set DataConnection = Nothing 

sql2 = "select * from Address Order by AddressID Desc "
 rs2.Open sql2, conn, 3, 3   
 If not rs2.eof Then
AddressID =rs2("AddressID")
AddressStreet =rs2("AddressStreet")
AddressApt=rs2("AddressApt")
AddressCity=rs2("AddressCity")
AddressState=rs2("AddressState")
AddressZip=rs2("AddressZip")
AddressCountry=rs2("AddressCountry")
End If
rs2.close 

end if

if len(WebsitesID)> 0 then
sql2 = "select * from Websites where WebsitesID = " & WebsitesID
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

If not rs2.eof Then
Website =rs2("Website")
End If

else


Query =  "INSERT INTO Websites ( Website)" 
Query =  Query & " Values (' ')"
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query)
DataConnection.close
set DataConnection = Nothing 
sql2 = "select WebsitesID from Websites Order by WebsitesID Desc "
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If not rs2.eof Then
    WebsitesID =rs2("WebsitesID")
    Website = ""
    End If
end if 
   
   %>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H2>Edit Member:  <%= BusinessName%><br>
			</H2>
			<br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<form action= 'SiteAdminEditUserhandleform.asp' method = "post">
<tr><td width = "190" class = "body2" align = "right">
Access Level:
</td>
<td>
<select size="1" name="AccessLevel">
<% if Accesslevel = 1 then %>
<option name = "AID0" value= "1" selected>Basic User</option>
<option name = "AID0" value= "3" >Administrator</option>
<% else %>
<option name = "AID0" value= "3" selected>Administrator</option>
<option name = "AID0" value= "1" >Basic User</option>
<% end if %>			
</select>
</td>
</tr>
<tr>
		<td  class = "body2" align = "right">
			<%=PeopleID%>First Name:
		</td>
		<td>
			<input name="PeopleFirstName" size = "50" value = "<%=PeopleFirstName%>">
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
        			Last Name:
		</td>
		<td>
			<input name="PeoplelastName" size = "50" value = "<%=PeopleLastName%>">
		</td>
	</tr>
	
	<tr>
		<td  class = "body2" align = "right">
			Street Address:
		</td>
		<td>
			<input name="AddressStreet" size = "50"  value = "<%=AddressStreet%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			Address 2:
		</td>
		<td>
			<input name="AddressApt" size = "50"  value = "<%=AddressApt%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			City:
		</td>
		<td>
			<input name="AddressCity" size = "50"  value = "<%=AddressCity%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			State:
		</td>
		<td>
			<input name="AddressState" size = "50"  value = "<%=AddressState%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			Zip:
		</td>
		<td>
			<input name="AddressZip" size = "50"  value = "<%=AddressZip%>" >
		</td>
	</tr>
<tr>
		<td  class = "body2" align = "right">
			Cell:
		</td>
		<td>
			<input name="PeopleCell" size = "50"  value = "<%=PeopleCell%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			FAX:
		</td>
		<td>
			<input name="PeopleFax" size = "50"  value = "<%=PeopleFax%>" >
		</td>
	</tr>
<tr>
		<td  class = "body2" align = "right">
			Phone:
		</td>
		<td>
			<input name="PeoplePhone" size = "50"  value = "<%=PeoplePhone%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			Email:
		</td>
		<td>
			<input name="PeopleEmail" size = "50"  value = "<%=PeopleEmail%>" >
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			Password
		</td>
		<td>
			<input name="PeoplePassword" size = "50" type = "Password" value = "<%=PeoplePassword%>" >
		</td>
</tr>
</table>	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -40%>">
<tr><td  align = "center" valign = "middle" align ="center">
<input type="hidden" value = "<%=WebsitesID%>"  name = "WebsitesID" >
<input type="hidden" value = "<%= UserID%>" name = "PeopleID" >
<input type="hidden" value = "<%= BusinessID%>" name = "BusinessID" >
<input type="hidden" value = "<%= addressID%>" name = "AddressID" >
<center><input type=submit value = "Submit Changes"  class = "regsubmit2" ></center>
</form>
</td></tr></table><br /><br />
<% End if %>
</td></tr></table>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>