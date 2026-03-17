<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Untitled Page</title>
</head>
<body>
<%  

 DSN_Name2 = "Test19DSN"
Set DestinationConn  = Server.CreateObject("ADODB.Connection")
DestinationConn.Mode = 3  
DestinationConn.Open "DSN=" & DSN_Name2 & ";UID=TestDSN19;PWD=TestDSN195"
  

Set rs = Server.CreateObject("ADODB.Recordset")

SourcePeopleID = 2011
 %>

<% 
ID = request.form("ID")
If Len(ID) > 0 then %>
<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->

<% hidex = True
if hidex = True then %>
<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>

<% end if

response.redirect("default.asp") %>
</body>
</html>
