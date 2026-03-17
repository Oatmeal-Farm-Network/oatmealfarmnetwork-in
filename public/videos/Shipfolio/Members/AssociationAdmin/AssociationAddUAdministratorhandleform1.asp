<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="stylesheet" type="text/css" href="/members/membersstyle.css" />
<!--#Include file="associationGlobalVariables.asp"-->
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Account"
Current2 = "AccountInfo" %>
<!--#Include file="AssociationHeader.asp"--> 
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<br />
<%
ExistingAssociationAccount = True
ExistingUser = False
Update = "False"
PeopleFirstName = request.form("PeopleFirstName")
PeopleLastName = request.form("PeopleLastName")
PeopleEmail = request.form("PeopleEmail")
ConfirmEmail = request.form("ConfirmEmail")
MemberPosition = request.form("MemberPosition")

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


str1 = MemberPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberPosition= Replace(str1,  str2, "''")
End If  


str1 = PeopleEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "''")
End If 


ExistingAssociationAccount = False
sql = "select * from associationmembers  where  MemberEmail = '" & PeopleEmail & "' and associationID=" & session("AssociationID")
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	ExistingAssociationAccount = True
    tempAssociationMemberID = rs("AssociationMemberID")
End If 
response.write("ExistingAssociationAccount=" & ExistingAssociationAccount & "<br>")

'response.write("tempAssociationMemberID=" & tempAssociationMemberID & "<br>")

rs.close
if ExistingAssociationAccount = True then
 response.redirect("AssociationAddnewUser.asp?ExistingAssociationAccount=True")
end if
'response.write("ExistingAccount=" & ExistingAccount)



sql = "select * from People where PeopleEmail = '" & PeopleEmail & "'"
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	ExistingUser = True
    ExistingPeopleID = rs("PeopleID")
End If 
response.write("ExistingUser=" & ExistingUser & "<br>")

'*****************************************************************
' If NEW LOTW MEMER
'*****************************************************************
if ExistingUser = False then


daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext =  monthnow & "/" & daynow & "/" & (yearnow +1 )
datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("datenow = " & datenow)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )

Query =  "INSERT INTO Websites (Website)" 
Query =  Query & " Values (' ')" 
'response.write("Query=" & Query )
Conn.Execute(Query) 


sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' order by WebsitesID Desc"
response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close

Query =  "INSERT INTO Business (BusinessName)" 
Query =  Query & " Values ('" & BusinessName & "')" 
Conn.Execute(Query) 


sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"
rs.Open sql, conn, 3, 3   
ExistingEvent = False
If Not rs.eof Then
  BusinessID = rs("BusinessID")
End If 
rs.close

Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressCountry, AddressZip)" 
Query =  Query & " Values (' '," 
Query =  Query & " ' ', " 
Query =  Query & " ' ', " 
Query =  Query & " ' ', " 
Query =  Query & " ' ', " 
Query =  Query & " ' ')" 
response.Write("Query=" & Query )
Conn.Execute(Query) 


sql = "select AddressID from Address  Order by AddressID Desc"
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	AddressID  =rs("AddressID") 
End If 
rs.close

Function CreateRandomString(iSize)
Const VALID_TEXT = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890" 
Dim sNewSearchTag
Dim I      
For I = 0 To 7

'txt="This is a beautiful day!"
'response.write(Mid(txt,1))

 Randomize   
 sNewSearchTag = sNewSearchTag & Mid(VALID_TEXT,Round(Rnd * Len(VALID_TEXT)),1)    
Next      

CreateRandomString = sNewSearchTag 
End Function 

  
temppassword = temppassword & CreateRandomString(7) 

max=1000
min=1
Randomize
temppassword = temppassword &  (Int((max-min+1)*Rnd+min))

'response.write("temppassword=" & temppassword )

Query =  "INSERT INTO People (AddressID, CustCountry, Custstate, WebsitesID, Accesslevel, custAIStartService, custAIEndService, SubscriptionLevel, MaxAnimals, maxHerdsires, MaxProducts,  FreeMassEmailsPaidFor, FreeMassEmailsUsed, HomepageadsPaidfor, HomepageadsUsed, HeaderadsPaidfor, HeaderadsUsed, FreeAnimalEntryPaidFor, FreeAnimalEntryUsed, AISubscription, AESubscription, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive, peoplepassword,  PeopleCreationDate )" 
Query =  Query & " Values (" &  AddressID & ","
Query =  Query & " '" &   AddressCountry & "', " 
Query =  Query & " '" &   AddressState & "', " 
Query =  Query & " " &   WebsitesID & ", " 
Query =  Query & " 0 , " 
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
Query =  Query & " 0 , " 'SubscriptionLevel
Query =  Query & " 0, "  'MaxAnimal
Query =  Query & " 0 , " 'maxHerdsires
Query =  Query & " 0 , " 'MaxProducts
Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
Query =  Query & " 0 , " 'FreeMassEmailsUsed
Query =  Query & " 0 , " 'HomepageadsPaidfor
Query =  Query & " 0 , " 'HomepageadsUsed
Query =  Query & " 0 , " 'HeaderadsPaidfor
Query =  Query & " 0 , " 'HeaderadsUsed
Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
Query =  Query & " 0 , " 'FreeAnimalEntryUsed
Query =  Query & " 1 , " 	
Query =  Query & " 1 , " 
Query =  Query & " '" &   Owners & "', " 
Query =  Query & " " &   BusinessID & ", " 
Query =  Query & " '" &  PeopleFirstName & "', " 
Query =  Query & " '" &  PeopleLastName & "', " 
Query =  Query & " '" &  PeoplePhone & "', " 
Query =  Query & " '" &  Peopleemail & "', " 
Query =  Query & " '" &  Peoplefax & "', " 
Query =  Query & " '" &  Peoplecell & "', " 
Query =  Query & " 1, " 
Query =  Query & " '" & temppassword & "', " 
Query =  Query & " " &  FormatDateTime(Now,2) & ") "
response.Write("Query = " & Query)

'response.Write("Membership=" & Membership)	
response.Write("Query=" & Query)	
Conn.Execute(Query) 

end if

'*****************************************************************
' End If NEW LOTW MEMBER
'*****************************************************************




'*****************************************************************
' ADD MEMBER TO ASSOCIATION TABLE
'*****************************************************************
if rs.state =0 then
else
rs.close
end if

sql = "select * from People  where   (Peopleemail = '" & Peopleemail & "')"
response.write("sql!!!!=" & sql & "<br>")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
  ExistingAccount = True 
  CurrentPeopleID= rs("PeopleID") 
end if
rs.close

Query =  "INSERT INTO AssociationMembers ( AccessLevel, PeopleID, associationid, memberposition, MemberFirstName, MemberLastName, MemberEmail )" 
Query = Query & " Values ( 2, " 
Query = Query & " '" &  CurrentPeopleID & "', " 
Query = Query & " " &  session("associationid") & ", " 	

Query = Query & " '" &  MemberPosition & "', " 	
Query = Query & " '" &  PeopleFirstName & "', " 
Query = Query & " '" &  PeopleLastName & "', " 
Query = Query & " '" &  CurrentPeopleID &  "') " 

response.write("<br>Query!!! =" & Query  )
Conn.Execute(Query) 


conn.close
set conn = nothing

response.redirect("AssociationAddnewUser.asp?AssociationID=253&Added=True")
%>
</Body>
</HTML>
