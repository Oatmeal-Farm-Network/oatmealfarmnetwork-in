<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/includefiles/globalvariables.asp"--> 

</head>
<body border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<%

PropStreet1=Request.Form("PropStreet1" ) 
PropStreet2=Request.Form("PropStreet2" ) 
PropCity=Request.Form("PropCity" ) 
PropState=Request.Form("PropState" ) 
PropZip=Request.Form("PropZip" ) 
PropStyle=Request.Form("PropStyle" ) 
PropYearBuilt=Request.Form("PropYearBuilt" ) 

	PropName=Request.Form("PropName" ) 
	PropMLS=Request.Form("PropMLS" ) 
	propPrice=Request.Form("propPrice" ) 
	propTaxes=Request.Form( "propTaxes" ) 
	PropSqFeet=Request.Form( "PropSqFeet" ) 
	PropAcres=Request.Form( "PropAcres" ) 
	PropBedrooms=Request.Form("PropBedrooms")
	PropBathrooms=Request.Form("PropBathrooms")
	PropFirePlaces=Request.Form("PropFirePlaces") 
	PropGarage=Request.Form("PropGarage") 
	PropRoof=Request.Form("PropRoof") 
	PropDescription=Request.Form("PropDescription") 
	PropOutBuildings=Request.Form("PropOutBuildings") 
	PropForSale=Request.Form("PropForSale") 
 
str1 = propPrice
str2 = ","
If InStr(str1,str2) > 0 Then
	propPrice= Replace(str1, ",", "")
End If

str1 = propTaxes
str2 = ","
If InStr(str1,str2) > 0 Then
	propTaxes= Replace(str1, ",", "")
End If

If len(PropStreet1) = 0 then
	PropStreet1 = "0"
End If
If len(PropStreet2) = 0 then
	PropStreet2= "0"
End If
If len(PropCity) = 0 then
	PropCity = "0"
End If
If len(PropState) = 0 then
	PropState = "0"
End If
If len(PropZip) = 0 then
	PropZip = "0"
End If
If len(PropStyle) = 0 then
	PropStyle = "0"
End If
If len(PropYearBuilt) = 0 then
	PropYearBuilt = "0"
End If

If PropForSale = "True" then
	PropForSale = 1
else
	PropForSale = 1
End If

str1 = PropDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	PropDescription= Replace(str1, "'", "''")
End If


str1 = PropName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PropName= Replace(str1, "'", "''")
End If

If len(PropPrice) = 0 then
	PropPrice = 0
End If

If len(PropMLS) = 0 then
	PropMLS = "0"
End If

If len(propTaxes) = 0 then
	propTaxes = "0"
End if

If len(PropSqFeet) = 0 then
	PropSqFeet = "0"
End If


If len(PropAcres) = 0 then
	PropAcres = " "
End If


If len(PropBedrooms) = 0 then
	PropBedrooms = 1
End If

If len(PropBathrooms) = 0 then
	PropBathrooms = 1
End If

If len(PropFirePlaces) = 0 then
	PropFirePlaces = 0
End If

If len(PropGarage) = 0 then
	PropGarage = 0
End If

If len(PropRoof) = 0 then
	PropRoof = " "
End If

If len(PropDescription) = 0 then
	PropDescription = " "
End If

If len(PropOutBuildings) = 0 then
	PropOutBuildings = " "
End If


	 sql2 = "select * from Properties where PeopleID = " & session("PeopleID") & " and PropName = '" & PropName & "'" 
	'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
PropID = rs2("PropID")

	else

Query =  "INSERT INTO Properties (PropName, PropStreet1, PeopleID, PropMLS, propPrice, propTaxes, PropSqFeet, PropAcres, PropBedrooms, PropBathrooms, PropFirePlaces,  PropGarage, PropRoof, PropDescription,   PropStreet2, PropCity, PropState, PropZip, PropYearBuilt, PropForSale, PropStyle, PropOutBuildings)" 
Query =  Query + " Values ('" &  PropName & "'," 	
Query = Query & " '"  &  PropStreet1 & "', " 
Query =  Query & " " &  Session("PeopleID") & "," 
Query =  Query & " '" &  PropMLS & "'," 
Query =  Query & " " &  propPrice & "," 
Query =  Query & " '" &  propTaxes & "'," 
Query =  Query & " '" &  PropSqFeet & "'," 
Query =  Query & " '" &  PropAcres & "'," 
Query = Query & " "  &  PropBedrooms & ", " 
Query = Query & " "  &  PropBathrooms & ", " 
Query = Query & " "  &  PropFirePlaces & ", " 
Query = Query & " '"  &  PropGarage & "', " 
Query = Query & " '"  &  PropRoof & "', " 
Query = Query & " '"  &  PropDescription & "', " 
Query = Query & " '"  &  PropStreet2 & "', " 
Query = Query & " '"  &  PropCity & "', " 
Query = Query & " '"  &  PropState & "', " 
Query = Query & " '"  &  PropZip & "', " 
Query = Query & " '"  &  PropYearBuilt & "', " 
Query = Query & " "  &  PropForSale & ", " 
Query = Query & " '"  &  PropStyle & "', " 
Query =  Query & " '" & PropOutBuildings  & "')"
response.write(query)


Conn.Execute(Query) 
End if
 
 sql2 = "select * from Properties where PeopleID = " & session("PeopleID") & " and PropName = '" & PropName & "'" 
	response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
PropID = rs2("PropID")
Query =  "INSERT INTO PropertyPhotos (PropID)" 
Query =  Query + " Values (" &   PropID  & ")"
'response.write(query)
Conn.Execute(Query) 
	 End If	
Conn.Close
Set Conn = Nothing 
 response.redirect("EditProperty0.asp?propID=" & PropID )
 %>
</body>
</HTML>
