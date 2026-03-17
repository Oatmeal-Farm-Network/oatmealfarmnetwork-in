<!DOCTYPE html>
<html>
<head>
<!--#Include file="AssociationGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<%
AssociationAddressID = Request.form("AssociationAddressID")
AddressID = AssociationAddressID 
AssociationTypeID = Request.form("AssociationTypeID")
AssociationCountry_id= Request.Form("AssociationCountry_id")
AssociationID = Request.Form("AssociationID")

response.write("AssociationID=" & AssociationID  & "<br>")
response.write("AssociationAddressID=" & AssociationAddressID  & "<br>")
response.write("AssociationCountry_id=" & AssociationCountry_id  & "<br>")
response.write("<br>AssociationTypeID=" & AssociationTypeID & "<br>" )


ReturnPage = Request.form("ReturnPage")

AssociationName = Request.Form("AssociationName")
AssociationAcronym = Request.Form("AssociationAcronym")
Associationwebsite = Request.Form("Associationwebsite")
AssociationEmailaddress = Request.Form("AssociationEmailaddress")
	
AssociationStreet1 = Request.Form("AssociationStreet1")
AssociationStreet2= Request.Form("AssociationStreet2")
AssociationCity = Request.Form("AssociationCity")
AssociationStateIndex= Request.Form("AssociationStateIndex")
AssociationZip = Request.Form("AssociationZip")


AssociationPhone = Request.Form("AssociationPhone")
AssociationDescription= Request.Form("AssociationDescription")
AssociationPassword= Request.Form("AssociationPassword")
AssociationContactPosition= Request.Form("AssociationContactPosition")
AssociationContactEmail= Request.Form("AssociationContactEmail")
AssociationContactName= Request.Form("AssociationContactName")
AssociationShowaddress = Request.Form("AssociationShowaddress")
Registry = request.form("Registry")
FoodHub = request.form("FoodHub")
CSA = request.form("CSA") 
Livestock = request.form("Livestock")
FarmAg= request.form("FarmAg")
FarmersMarket = request.form("FarmersMarket")
AssociationFacebook= request.form("AssociationFacebook")
AssociationX= request.form("AssociationX")
AssociationInstagram= request.form("AssociationInstagram")
AssociationPinterest= request.form("AssociationPinterest")
AssociationTruthSocial= request.form("AssociationTruthSocial")
AssociationBlog= request.form("AssociationBlog")
AssociationYouTube= request.form("AssociationYouTube")
AssociationOtherSocial1= request.form("AssociationOtherSocial1")
AssociationOtherSocial2= request.form("AssociationOtherSocial2")
AssociationLinkedIn= request.form("AssociationLinkedIn")
AssociationTollFreePhone = request.form("AssociationTollFreePhone")
AssociationFax = request.form("AssociationFax")

str1 = AssociationName
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationName= Replace(str1,  str2, "''")
End If 


str1 = AssociationAcronym
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationAcronym= Replace(str1,  str2, "''")
End If 


str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
End If 


str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
End If  


str1 = Associationwebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	Associationwebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(Associationwebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Associationwebsite= right(Associationwebsite, len(Associationwebsite) - 7)
End If  

str1 = AssociationFacebook
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationFacebook= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationFacebook)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationFacebook= right(AssociationFacebook, len(AssociationFacebook) - 7)
End If 


str1 = AssociationLinkedIn
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationLinkedIn= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationLinkedIn)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationLinkedIn= right(AssociationLinkedIn, len(AssociationLinkedIn) - 7)
End If 




str1 = AssociationX
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationX= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationX)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationX= right(AssociationX, len(AssociationX) - 7)
End If 



	str1 =AssociationInstagram
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationInstagram= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationInstagram)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationInstagram= right(AssociationInstagram, len(AssociationInstagram) - 7)
End If 


	str1 = AssociationPinterest
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPinterest= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationPinterest)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationPinterest= right(AssociationPinterest, len(AssociationPinterest) - 7)
End If 



	str1 = AssociationTruthSocial
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationTruthSocial= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationTruthSocial)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationTruthSocial= right(AssociationTruthSocial, len(AssociationTruthSocial) - 7)
End If 



	str1 = AssociationBlog
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationBlog= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationBlog)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationBlog= right(AssociationBlog, len(AssociationBlog) - 7)
End If 


str1 = AssociationYouTube
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationYouTube= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationYouTube)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationYouTube= right(AssociationYouTube, len(AssociationYouTube) - 7)
End If 


str1 = AssociationOtherSocial1
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial1= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationOtherSocial1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial1= right(AssociationOtherSocial1, len(AssociationOtherSocial1) - 7)
End If 

str1 = AssociationOtherSocial2
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial2= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationOtherSocial2)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial2= right(AssociationOtherSocial2, len(AssociationOtherSocial2) - 7)
End If 



str1 = AssociationEmailaddress
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationEmailaddress= Replace(str1,  str2, "''")
End If 

str1 = AssociationPassword
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPassword= Replace(str1,  str2, "''")
End If 

str1 = AssociationStreet1
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet1= Replace(str1,  str2, "''")
End If 

str1 = AssociationStreet2
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet2= Replace(str1,  str2, "''")
End If 

str1 = AssociationCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationCity= Replace(str1,  str2, "''")
End If

str1 = AssociationStateIndex
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStateIndex= Replace(str1,  str2, "''")
End If

str1 = AssociationZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationZip= Replace(str1,  str2, "''")
End If

str1 = AssociationPhone 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPhone = Replace(str1,  str2, "''")
End If

str1 = AssociationDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationDescription= Replace(str1,  str2, "''")
End If

str1 = AssociationDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationDescription= Replace(str1,  str2, "''")
End If

if len(AssociationAddressID) < 1 then

		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressZip,"
		If len(AssociationstateIndex) > 0 then	
		Query =  Query &  " StateIndex, "
		end if
		Query =  Query &  "	Country_id )" 
		Query =  Query & " Values ('" & AssociationStreet1  & "'," 
		Query =  Query & " '" &  AssociationStreet2 & "', " 
		Query =  Query & " '" &  AssociationCity & "', " 
		Query =  Query & " '" &  AssociationZip & "', " 
		If len(AssociationstateIndex) > 0 then
		Query =  Query & " " &  AssociationstateIndex & " ," 
		end if
		Query =  Query & " " &  Associationcountry_id  & " ) " 

		response.Write("Query=" & Query )
		Conn.Execute(Query) 

	
		sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' order by AddressID Desc"
		
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
			If Not rs.eof Then
				AddressID = rs("AddressID")
			End If 
		rs.close
		response.write("<br>AddressID=" & AddressID & "<br><br>")



else
		Query =  "Update Address Set AddressStreet = '" & AssociationStreet1 & "'," 
		Query =  Query & " AddressApt = '" &  AssociationStreet2 & "'," 
		Query =  Query & " AddressCity = '" &  AssociationCity & "'," 

			If len(Associationcountry_id) > 0 then
		Query =  Query & " country_id = " &  Associationcountry_id & ","
		end if	
			If len(AssociationstateIndex) > 0 then
		Query =  Query & " stateIndex = " &  AssociationstateIndex  & ", " 
			end if

		Query =  Query & " AddressZip = '" &  AssociationZip & "'" 
		Query =  Query & " where AddressID = " & AssociationAddressID & ";" 
		response.Write("<br>Query=" & Query )
		Conn.Execute(Query) 

end if



	

Query =  " UPDATE Associations Set AssociationName = '" &  AssociationName & "'," 
Query =  Query & " Registry = '" &  Registry & "'," 
Query =  Query & " AssociationAcronym = '" &  AssociationAcronym & "'," 
Query =  Query & " Associationwebsite = '" &  Associationwebsite & "'," 
Query =  Query & " AssociationEmailaddress = '" &  AssociationEmailaddress & "'," 
Query =  Query & " AssociationPhone = '" &  AssociationPhone & "',"
Query =  Query & " AssociationContactPosition = '" &  AssociationContactPosition & "',"
Query =  Query & " AssociationContactEmail = '" &  AssociationContactEmail & "',"

	Query =  Query & " AddressID = '" &  AddressID & "',"
Query =  Query & " AssociationTypeID = '" &  AssociationTypeID & "',"
Query =  Query & " AssociationTollFreePhone = '" &  AssociationTollFreePhone & "',"
Query =  Query & " AssociationFax  = '" &  AssociationFax & "',"
Query =  Query & " AssociationFacebook = '" & AssociationFacebook & "',"
Query =  Query & " AssociationX = '" & AssociationX & "',"
Query =  Query & " AssociationInstagram = '" & AssociationInstagram & "',"
Query =  Query & " AssociationPinterest = '" & AssociationPinterest & "',"
Query =  Query & " AssociationTruthSocial = '" & AssociationTruthSocial & "',"
Query =  Query & " AssociationBlog = '" & AssociationBlog & "',"
Query =  Query & " AssociationYouTube = '" & AssociationYouTube & "',"
Query =  Query & " AssociationOtherSocial1 = '" & AssociationOtherSocial1 & "',"
Query =  Query & " AssociationOtherSocial2 = '" & AssociationOtherSocial2 & "',"
Query =  Query & " AssociationLinkedIn= '" & AssociationLinkedIn & "',"

	

if FarmersMarket = 1 then
Query =  Query & " FarmersMarket = 1,"
else
Query =  Query & " FarmersMarket = 0,"
end if

if FarmAg = 1 then
Query =  Query & " FarmAg = 1,"
else
Query =  Query & " FarmAg = 0,"
end if

if AssociationShowaddress = 1 then
Query =  Query & " AssociationShowaddress = 1,"
else
Query =  Query & " AssociationShowaddress = 0,"
end if

if Livestock = 1 then
Query =  Query & " Livestock = 1,"
else
Query =  Query & " Livestock = 0,"
end if

if CSA = 1 then
Query =  Query & " CSA = 1,"
else
Query =  Query & " CSA = 0,"
end if

if FoodHub = 1 then
Query =  Query & " FoodHub = 1"
else
Query =  Query & " FoodHub = 0"
end if

Query =  Query & " where AssociationID = " & AssociationID & ";" 


response.write("<br>Query="	& Query &"<br><br>" )
Conn.Execute(Query) 

  
   
    


Conn.close
Set Conn = Nothing %>
<!--#Include virtual="/includefiles/Conn.asp"-->
<%

response.write("ReturnPage=" & ReturnPage )
if len(ReturnPage) > 1 then
   response.redirect(ReturnPage)
else
   response.redirect("AssociationListingEdit.asp?AssociationID=" & AssociationID )
end if 
 %>
<br><br><br>

</Body>
</HTML>