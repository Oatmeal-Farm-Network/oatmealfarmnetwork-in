<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/Administration/adminglobalvariables.asp"--> 
<%
AddressID = Session("AddressID")
Query =  " UPDATE Address Set AddressImage = ''  " 
Query =  Query & " where AddressID = " & AddressID & ";" 
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
Response.Redirect("AdminClassesAddressEdit.asp?AddressID=" & AddressID) %>
</Body>
</HTML>
