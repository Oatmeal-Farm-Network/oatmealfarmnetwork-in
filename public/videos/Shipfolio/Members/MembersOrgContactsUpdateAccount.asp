<!DOCTYPE html>
<html>
<head>    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY  >
<%

BusinessID = Request.QueryString("BusinessID")
ReturnPage= Request.form("ReturnPage") 
BusinessName  =Request.Form("BusinessName") 
BusinessTitleID =Request.Form("BusinessTitleID") 
BusinessWebsite =Request.Form("BusinessWebsite") 
BusinessEmail =Request.Form("BusinessEmail") 


StateIndex = Request.Form("StateIndex") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
BusinessPhone  = Request.Form("BusinessPhone")
BusinessCell  = Request.Form("BusinessCell")
BusinessFax  = Request.Form("BusinessFax")
AddressCountry  = Request.Form("AddressCountry")
Owners  = Request.Form("Owners")
country_id = Request.Form("country_id")
AddressStreet = Request.Form("AddressStreet")
AddressApt = Request.Form("AddressApt")

BusinessLinkedin  = Request.Form("BusinessLinkedin")
BusinessFacebook  = Request.Form("BusinessFacebook")
BusinessX  = Request.Form("BusinessX")
BusinessInstagram = Request.Form("BusinessInstagram")
BusinessPinterest  = Request.Form("BusinessPinterest") 
BusinessTruthSocial  = Request.Form("BusinessTruthSocial")
BusinessBlog  = Request.Form("BusinessBlog")




sql = "select AddressID, PhoneID from Business where BusinessID = " & BusinessID & ""
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	EBusinessXistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
		PhoneID= rs("PhoneID")

		response.write("PhoneID=" & PhoneID)
End If 
rs.close


str1 = BusinessName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "''")
End If  


str1 = BusinessEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessEmail= Replace(str1,  str2, "''")
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

str1 = BusinessPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessPhone= Replace(str1,  str2, "''")
End If

str1 = BusinessCell
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessCell= Replace(str1,  str2, "''")
End If


str1 = BusinessLinkedin
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessLinkedin= Replace(str1,  str2, "''")
End If


str1 = BusinessFacebook 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessFacebook = Replace(str1,  str2, "''")
End If

str1 = BusinessX 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessX = Replace(str1,  str2, "''")
End If

str1 = BusinessInstagram 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessInstagram = Replace(str1,  str2, "''")
End If

str1 = BusinessPinterest 
str2 = "'"
If InStr(str1,str2) > 0 Then
BusinessPinterest = Replace(str1,  str2, "''")
End If

str1 = BusinessTruthSocial 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessTruthSocial = Replace(str1,  str2, "''")
End If

str1 = BusinessBlog 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessBlog = Replace(str1,  str2, "''")
End If


if len(PhoneID)> 0 then
	Query =  " UPDATE Phone Set Phone = '" &  BusinessPhone & "', " 
	Query =  Query & " Cellphone = '" &  BusinessCell & "'," 
	Query =  Query & " Fax = '" & BusinessFax & "'" & " where PhoneID = " & PhoneID & ";"
	
	response.Write("<br>query=" & Query)
	Conn.Execute(Query)
else
	Query =  "INSERT INTO Phone (Phone, Cellphone, Fax) " 
	Query =  Query & "VALUES ('" & BusinessPhone & "', '" & BusinessCell & "', '" & BusinessFax & "'); " 

	Conn.Execute(Query)


	sql = "select PhoneID from Phone where Phone = '" & BusinessPhone & "' order by PhoneID Desc"
	response.Write("query=" & Query)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PhoneID= rs("PhoneID")

		response.write("PhoneID=" & PhoneID)
End If 
rs.close


end if


	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " StateIndex = '" &  StateIndex & "'," 
    Query =  Query & " country_id = '" &  country_id & "'," 
     Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 


response.Write("query=" & Query)

Conn.Execute(Query) 

Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "' , " 
Query =  Query & " PhoneID = '" &  PhoneID  & "'," 
Query =  Query & " BusinessLogo = '" &  BusinessLogo & "'," 
Query =  Query & " BusinessLinkedin= '" & BusinessLinkedin & "'," 
Query =  Query & " BusinessFacebook = '" & BusinessFacebook & "'," 
Query =  Query & " BusinessX = '" & BusinessX & "'," 
Query =  Query & " BusinessInstagram= '" & BusinessInstagram & "'," 
Query =  Query & " BusinessPinterest = '" & BusinessPinterest & "'," 
Query =  Query & " BusinessTruthSocial= '" & BusinessTruthSocial & "'," 
Query =  Query & " BusinessBlog= '" & BusinessTruthSocial & "'" 

Query =  Query & " where BusinessID = " & BusinessID & ";" 


response.write("<br>Query="	& Query )
Conn.Execute(Query) 


 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close


	Query =  " UPDATE Business Set AddressID = " &  AddressID & ", " 
    Query =  Query & " BusinessName = '" &  BusinessName & "'," 
    Query =  Query & " Businessemail = '" &  Businessemail & "'" 
    Query =  Query & " where BusinessID = " & BusinessID & ";" 


response.write("<br>Query="	& Query )
Conn.Execute(Query) 
Conn.close



 if len(BusinessTitleID) > 0 then 
	sql = "select BusinessTitle from BusinessTitleLookup where BusinessTitleID = " & BusinessTitleID & ""
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
BusinessTitle = rs("BusinessTitle")


  end if 
end if
'if len(ReturnPage) > 1 then
'response.redirect(ReturnPage)
'else
	response.redirect("MembersOrgAccountContactsEdit.asp?BusinessID=" & BusinessID & "&changesmade=True")
'end if 
 %>
<br><br><br>
</Body>
</HTML>