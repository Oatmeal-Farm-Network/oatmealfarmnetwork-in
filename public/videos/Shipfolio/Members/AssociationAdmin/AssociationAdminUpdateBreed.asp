<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/GlobalVariables.asp"--> 

<% 
totalcount = Request.form("totalcount")
AssociationID = Request.Form("AssociationID")
dim BreedIDarray(100)
dim SpeciesIDarray(100)

response.write("totalcount=" & totalcount & "<br>" )
i = 0
if cint(totalcount) > 0 then


Query =  "delete from Speciesassociationlinks where AssociationID = " & AssociationID
response.write("Query=" & Query )
Conn.Execute(Query)


while i < cint(totalcount)
i  = i + 1
BreedIDArray(i) = Request.Form("BreedID" & i)
SpeciesIDArray(i)= Request.Form("SpeciesID" & i) 

response.write("BreedIDArray(i)=" & BreedIDArray(i) & "<br>" )
response.write("SpeciesIDArray(i)=" & SpeciesIDArray(i) & "<br>" )

Query =  "Insert into Speciesassociationlinks (AssociationID,"
if len(BreedID) > 0 then
Query = Query & " BreedLookupID,"
end if
Query = Query & " SpeciesID )"
 
Query =  Query & " Values (" & AssociationID  & "," 
if len(BreedID) > 0 then
Query =  Query & " " &  BreedIDArray(i) & ", " 
end if
Query =  Query & " " &  SpeciesIDArray(i) & ")" 

response.write("Query=" & Query )

if len(SpeciesIDArray(i)) > 0 then 
Conn.Execute(Query)
end if

wend

 end if

Conn.Close
Set Conn = Nothing 

response.Redirect("SiteAdminAssociationsEdit.asp?AssociationID=" & AssociationID & "#species")

 %>

 </Body>
</HTML>
