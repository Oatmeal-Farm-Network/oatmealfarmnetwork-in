<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Untitled Page</title>
</head>
<body>
<%  
DSN_Name3 = request.form("DSN_Name3")
UID = request.form("UID")
PW = request.form("PW")


' DSN_Name2 = "TestTAG182"
'UID=TestTAG18;PWD=Test18TAG"
'peopleid = 802
'Set DestinationConn  = Server.CreateObject("ADODB.Connection")
'DestinationConn.Mode = 3  
'DestinationConn.Open "DSN=" & DSN_Name3 & ";UID=" & UID & ";PWD=" & PW
  



Set rs = Server.CreateObject("ADODB.Recordset")

SourcePeopleID = request.form("PeopleID")
 %>

<% 
ID = 4155
If Len(ID) > 0 then %>
<!--#Include virtual="/Membersistration/Transfers/GatherAnimalData.asp"-->

<% hidex = True
if hidex = True then %>
<!--#Include virtual="/Membersistration/Transfers/TransferMovedata.asp"-->
<% end if %>

<% end if

'response.redirect("MembersTransferToCustWebsite.asp") %>
</body>
</html>
