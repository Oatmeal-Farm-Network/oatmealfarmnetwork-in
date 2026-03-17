<!DOCTYPE html>
<html>
<head>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<%
BusinessTypeID = Request.Form("BusinessTypeID")
ExistingSite = False
Preferedspecies = Request.form("Preferedspecies") 
PreferedBreed = Request.form("PreferedBreed") 
BusinessTitleID =Request.Form("BusinessTitleID") 
BusinessWebsite =Request.Form("BusinessWebsite") 
WebsitesID =Request.Form("WebsitesID") 
BusinessEmail =Request.Form("BusinessEmail") 

AddressID = Request.Form("AddressID") 
response.write("AddressID  =" & AddressID  )
StateIndex = Request.Form("StateIndex") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressZip  = Request.Form("AddressZip")
BusinessPhone  = Request.Form("BusinessPhone")
PhoneID  = Request.Form("PhoneID")
response.write("PhoneID =" & PhoneID & "<br>"  )

BusinessCell  = Request.Form("BusinessCell")
BusinessFax  = Request.Form("BusinessFax")
BusinessName  = Request.Form("BusinessName")
AddressCountry  = Request.Form("AddressCountry")
country_id = Request.Form("country_id")
AddressStreet = Request.Form("AddressStreet")
AddressApt = Request.Form("AddressApt")

BusinessFacebook= request.form("BusinessFacebook")
BusinessX= request.form("BusinessX")
BusinessInstagram= request.form("BusinessInstagram")
BusinessPinterest= request.form("BusinessPinterest")
BusinessTruthSocial= request.form("BusinessTruthSocial")
BusinessBlog= request.form("BusinessBlog")
BusinessYouTube= request.form("BusinessYouTube")
BusinessOtherSocial1= request.form("BusinessOtherSocial1")
BusinessOtherSocial2= request.form("BusinessOtherSocial2")
BusinessAcronym = request.form("BusinessAcronym")

'sql = "select AddressID from Business where BusinessID = " &  BusinessID & ""
'	response.write("<br>sql=" & sql & "<br>")	
'	Set rs = Server.CreateObject("ADODB.Recordse't")
'    rs.Open sql, conn, 3, 3   '
	EBusinessXistingEvent = False
'	If Not rs.eof Then
'		AddressID  =rs("AddressID") 
'End If 

'rs.close

str1 = BusinessFacebook
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessFacebook= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessFacebook)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessFacebook= right(BusinessFacebook, len(BusinessFacebook) - 7)
End If 




	str1 = BusinessX
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessX= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessX)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessX= right(BusinessX, len(BusinessX) - 7)
End If 



	str1 =BusinessInstagram
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessInstagram= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessInstagram)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessInstagram= right(BusinessInstagram, len(BusinessInstagram) - 7)
End If 


	str1 = BusinessPinterest
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessPinterest= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessPinterest)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessPinterest= right(BusinessPinterest, len(BusinessPinterest) - 7)
End If 



	str1 = BusinessTruthSocial
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessTruthSocial= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessTruthSocial)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessTruthSocial= right(BusinessTruthSocial, len(BusinessTruthSocial) - 7)
End If 



str1 = BusinessBlog
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessBlog= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessBlog)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessBlog= right(BusinessBlog, len(BusinessBlog) - 7)
End If 


str1 = BusinessYouTube
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessYouTube= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessYouTube)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessYouTube= right(BusinessYouTube, len(BusinessYouTube) - 7)
End If 


str1 = BusinessOtherSocial1
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessOtherSocial1= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessOtherSocial1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessOtherSocial1= right(BusinessOtherSocial1, len(BusinessOtherSocial1) - 7)
End If 

str1 = BusinessOtherSocial2
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessOtherSocial2= Replace(str1,  str2, "''")
End If  

str1 = lcase(BusinessOtherSocial2)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessOtherSocial2= right(BusinessOtherSocial2, len(BusinessOtherSocial2) - 7)
End If 



str1 = BusinessName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "''")
End If 

str1 = Owners
str2 = "'"
If InStr(str1,str2) > 0 Then
	Owners= Replace(str1,  str2, "''")
End If 

str1 = BusinessFirstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessFirstName= Replace(str1,  str2, "''")
End If  

str1 = BusinessLastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessLastName= Replace(str1,  str2, "''")
End If  


str1 =BusinessTitleID
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessTitleID= Replace(str1,  str2, "''")
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

str1 = BusinessFax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessFax= Replace(str1,  str2, "''")
End If

	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " StateIndex = '" &  StateIndex & "'," 
    Query =  Query & " country_id = '" &  country_id & "'," 
    Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 


response.Write("query=" & Query)

Conn.Execute(Query) 



Query =  " UPDATE Phone Set Phone = '" &  BusinessPhone & "' ,"
Query =  Query & " Cellphone = '" &  BusinessCell & "'," 	
Query =  Query & " Fax = '" &  BusinessFax & "'" 

Query =  Query & " where PhoneID = " & PhoneID & ";" 
'response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 


response.write("<br>BusinessWebsite2=" & BusinessWebsite )


if len(WebsitesID) > 0 then
	Query =  " UPDATE Websites Set Website = '" &  BusinessWebsite & "' " 
	Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 


else
Query =  "INSERT INTO Websites (Website)" 
 Query =  Query & " Values ('" & PeopleWebsite  & "')" 

Conn.Execute(Query) 

end if 


 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close

'sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' Order by WebsitesID Desc "
'response.write(sql)
		
'	Set rs = Server.CreateObject("ADODB.Recordset")
 '   rs.Open sql, conn, 3, 3   
	'ExistingEvent = False
	'If Not rs.eof Then
	'	WebsitesID = rs("WebsitesID")
	'End If 
'rs.close



if len(BusinessID) > 0 then
        Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "'," 
		Query =  Query & " BusinessTypeID = " & BusinessTypeID & "," 
		Query =  Query & " BusinessFacebook = '" & BusinessFacebook & "'," 
		Query =  Query & " BusinessX = '" & BusinessX & "'," 
		Query =  Query & " BusinessInstagram = '" & BusinessInstagram & "'," 
		Query =  Query & " BusinessPinterest = '" & BusinessPinterest & "'," 
		Query =  Query & " BusinessTruthSocial = '" & BusinessTruthSocial & "'," 
		Query =  Query & " BusinessBlog = '" & BusinessBlog & "'," 
		Query =  Query & " BusinessYouTube = '" &  BusinessYouTube & "'," 
		Query =  Query & " BusinessOtherSocial1 = '" &  BusinessOtherSocial1 & "'," 
		Query =  Query & " BusinessOtherSocial2 = '" &  BusinessOtherSocial2 & "' ,"
		Query =  Query & " Businessemail = '" &  Businessemail & "'," 
		Query =  Query & " BusinessAcronym = '" & BusinessAcronym & "',"
		Query =  Query & " PhoneID = " &  PhoneID & "," 
		Query =  Query & " WebsitesID = " &  WebsitesID & "," 
 		Query =  Query & " AddressID = " &  AddressID & "" 
		'Query =  Query & " Preferedspecies = " &  Preferedspecies & "," 
		'Query =  Query & " PreferedBreed = " &  PreferedBreed & "" 


		'Query =  Query & " BusinessPhone = '" &  BusinessPhone & "'"

        Query =  Query & " where BusinessID = " & BusinessID & ";" 
	'	response.write(Query)
Conn.Execute(Query) 
end if




 sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		'BusinessID = rs("BusinessID")
	End If 
	rs.close




	 Query =  " UPDATE Address Set country_id = " &  country_id & ""
	if len(StateIndex) > 0 then
		Query =  Query & ", StateIndex = " &  StateIndex & " "

	end if
        Query =  Query & " where AddressID = " & AddressID & ";" 
response.write(Query)
Conn.Execute(Query) 






response.write("<br><br>BusinessID=" & BusinessID)



 'if len(PeopleTitleID) > 0 then 
	'sql = "select PeopleTitle from PeopleTitleLookup where PeopleTitleID = " & PeopleTitleID & ""
'response.write(sql)
		
	'Set rs = Server.CreateObject("ADODB.Recordset")
    'rs.Open sql, conn, 3, 3   
	'ExistingEvent = False
	'If Not rs.eof Then
'PeopleTitle = rs("PeopleTitle")


'  end if 
'end if
'if len(ReturnPage) > 1 then
'response.redirect(ReturnPage)
'else
	response.redirect("BusinessAccountSummary.asp?BusinessID=" & businessID & "&changesmade=True")
'end if 
 %>
<br><br><br>
</Body>
</HTML>