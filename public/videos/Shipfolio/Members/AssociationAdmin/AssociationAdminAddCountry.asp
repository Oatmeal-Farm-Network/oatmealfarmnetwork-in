<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/includefiles/GlobalVariables.asp"--> 

<% AssociationID = Request.Form("AssociationID")
country_id = Request.Form("country_id")


Query =  "INSERT INTO associationcountries (AssociationID,"
Query = Query & " country_id )"
 
Query =  Query & " Values (" & AssociationID  & "," 
Query =  Query & " '" &  country_id  & "')" 

response.write("Query=" & Query )

Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 

response.Redirect("AssociationDirectoryCountries.asp?AssociationID=" & AssociationID & "#Countries")

 %>

 </Body>
</HTML>
