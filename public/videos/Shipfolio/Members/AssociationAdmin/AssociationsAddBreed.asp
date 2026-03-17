<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/GlobalVariables.asp"--> 

<% AssociationID = Request.Form("AssociationID")
BreedID = Request.Form("BreedID")
SpeciesID= Request.Form("SpeciesID") 
Set rs4 = Server.CreateObject("ADODB.Recordset")

if isnumeric(SpeciesID) = True then
else
if len(SpeciesID) > 0 then
sql4 = "select SpeciesID from Speciesavailable where lower(trim((species))) = '" & lcase(trim((SpeciesID))) & "'"
'response.write("sql4=" & sql4)
rs4.Open sql4, conn, 3, 3 
if Not rs4.eof then
SpeciesID = rs4("SpeciesID")
end if
rs4.close
End if
end if




if isnumeric(BreedID) = True then
else
if len(BreedID) > 0 then

str1 = BreedID
str2 = "'"
If InStr(str1,str2) > 0 Then
	BreedID= Replace(str1,  str2, "''")
End If 

sql4 = "select BreedlookupID from Speciesbreedlookuptable where lower(trim((Breed))) = '" & lcase(trim((BreedID))) & "'"
response.write("sql4=" & sql4)
rs4.Open sql4, conn, 3, 3 
if Not rs4.eof then
BreedID = rs4("BreedlookupID")
end if
rs4.close
End if
end if




Query =  "INSERT INTO speciesassociationlinks (AssociationID,"
if len(BreedID) > 0 then
Query = Query & " BreedLookupID,"
end if
Query = Query & " SpeciesID )"
 
Query =  Query & " Values (" & AssociationID  & "," 
if len(BreedID) > 0 then
Query =  Query & " " &  BreedID & ", " 
end if
Query =  Query & " " &  SpeciesID & ")" 

response.write("Query=" & Query )
if len(BreedID) > 0 then
Conn.Execute(Query) 
end if

Conn.Close
Set Conn = Nothing 

response.Redirect("AssociationListingEdit.asp?AssociationID=" & AssociationID & "#Associations")

 %>

 </Body>
</HTML>
