<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Add Ad Link</title>
       <link rel="stylesheet" type="text/css" href="/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Membersistration/MembersGlobalVariables.asp"--> 


<%

AdID=request.QueryString("AdID")
response.Write("adid=" & adid)
PeopleID=request.QueryString("PeopleID")
AdType=request.QueryString("AdType")
AdLink=request.form("AdLink")
response.Write("AdLink=" & AdLink )
Returnpage = request.form("Returnpage")
str1 = AdLink
str2 = "'"
If InStr(str1,str2) > 0 Then
	AdLink= Replace(str1,  str2, "''")
End If

str1 = lcase(AdLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AdLink= Replace(str1,  str2, "")
End If

str1 = lcase(AdLink)
str2 = "http:/" 
If InStr(str1,str2) > 0 Then
	AdLink= Replace(str1,  str2, "")
End If

str1 = lcase(AdLink)
str2 = "http:" 
If InStr(str1,str2) > 0 Then
	AdLink= Replace(str1,  str2, "")
End If

if len(AdID) > 0 then
Query =  " UPDATE Ads Set AdLink = '" & AdLink & "'" 
Query =  Query & " where adID = " & adID  & ";" 
else
Query =  " UPDATE Ads Set AdLink = '" & AdLink & "'" 
Query =  Query & " where PeopleID = " & PeopleID & " and AdType ='" & AdType & "';" 
end if
response.write(Query)	

Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing 
 	redirect = "Advertisinghome.asp?PeopleID=" & PeopleID
 	Response.Redirect(Returnpage)
%>


 </Body>
</HTML>
