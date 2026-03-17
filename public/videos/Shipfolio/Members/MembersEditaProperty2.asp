<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Pricing Page</title>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="MembersGlobalVariables.asp"--> 
<%
	PropID = Request.Form("PropID" ) 
	PropName=Request.Form("PropName" ) 
	PropForSale=Request.Form("PropForSale") 
	PropSold=Request.Form("PropSold") 
	PropStreet1=Request.Form("PropStreet1") 
	PropStreet2=Request.Form("PropStreet2")
	PropCity=Request.Form("PropCity") 
	PropState=Request.Form("PropState") 
	PropZip=Request.Form("PropZip") 
	PropMLS=Request.Form("PropMLS" ) 
	propPrice=Request.Form("propPrice" ) 
	propTaxes=Request.Form( "propTaxes" ) 
	PropSqFeet=Request.Form( "PropSqFeet" ) 
	PropAcres=Request.Form( "PropAcres" ) 
	PropStyle=Request.Form( "PropStyle" ) 
	propYearBuilt=Request.Form( "propYearBuilt" ) 
	PropBedrooms=Request.Form("PropBedrooms")
	PropBathrooms=Request.Form("PropBathrooms")
	PropFirePlaces=Request.Form("PropFirePlaces") 
	PropGarage=Request.Form("PropGarage") 
	PropRoof=Request.Form("PropRoof") 
	PropDescription=Request.Form("PropDescription") 
	PropOutBuildings=Request.Form("PropOutBuildings") 

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



str1 = PropOutBuildings
str2 = "'"
If InStr(str1,str2) > 0 Then
	PropOutBuildings= Replace(str1, "'", "''")
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


	Query =  " UPDATE Properties Set PropName = '" & PropName & "' ,"
	Query =  Query & "propTaxes = '" & propTaxes & "' , "
    if len( propPrice) > 0 then	
Query =  Query & "propPrice = '" & propPrice & "' , "
end if
	Query =  Query & "PropForSale = " & PropForSale & ", "
	Query =  Query & "PropSold = " & PropSold & ", "
	Query =  Query & "PropStreet1 = '" & PropStreet1 & "', "
	Query =  Query & "PropStreet2 = '" & PropStreet2 & "', "
	Query =  Query & "PropCity = '" & PropCity & "', "
	Query =  Query & "PropState = '" & PropState & "', "
	Query =  Query & "propYearBuilt = '" & propYearBuilt & "', "
	Query =  Query & "PropZip = '" & PropZip & "', "
	Query =  Query & "PropMLS = '" & PropMLS & "' ,"
	Query =  Query & "PropSqFeet = '" & PropSqFeet & "' , "
	Query =  Query & "PropAcres = '" & PropAcres & "' , "
	Query =  Query & "PropStyle = '" & PropStyle & "' , "
	Query =  Query & "PropBedrooms = '" & PropBedrooms & "' , "
	Query =  Query & "PropBathrooms = '" & PropBathrooms & "' , "
    if len(PropFirePlaces) > 0 then
	Query =  Query & "PropFirePlaces = " & PropFirePlaces & " , "
    end if
	Query =  Query & "PropGarage = '" & PropGarage & "' , "
	Query =  Query & "PropRoof= '" & PropRoof & "' , "
	Query =  Query & "PropDescription = '" & PropDescription & "' , "
	Query =  Query & "PropOutBuildings = '" & PropOutBuildings & "' "
    Query =  Query & " where propID = " & propID & ";" 
response.write(query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("EditProperty0.asp?propID=" & PropID )
 %>
 </Body>
</HTML>
