
<HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">

<% peopleid= session("PeopleID")
'response.write("peopleid=" & session("PeopleID"))
WebSiteName = "Shipfolio"

databasename = "LivestockOfTheWorldDB (LOTWDB)"

Set conn = Server.CreateObject("ADODB.Connection") 

Set rs = Server.CreateObject("ADODB.Recordset")

'Conn.close
'set Conn = nothing

'On Error Resume Next

Set Conn  = Server.CreateObject("ADODB.Connection")

Conn.ConnectionString = "Driver={SQL Server};" _ 
       & " Server=centralusdbserver.database.windows.net,1433;" _
       & " Database=OatmealAILive;" _
       & " UID=Frosty;" _ 
       & " PWD=Snowman31415926!;" _
       & " Encrypt=yes;" _
       & " TrustServerCertificate=False;"
  


Conn.Open  
Set rs = Server.CreateObject("ADODB.Recordset")
%>

	<link rel="icon" type="image/x-icon" href="/shipfolio/images/Shipfoliofavicon.png">
    <link rel="shortcut icon" type="image/png" href="/shipfolio/images/Shipfoliofavicon.png"/>
 <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/navbars/">

 <link href="/shipfolio/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="/shipfolio/Members/MembersStyle.css">
	



 