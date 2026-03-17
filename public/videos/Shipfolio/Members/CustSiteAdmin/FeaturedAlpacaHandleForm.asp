<HEAD>
 <title>Featured Alpacas Page</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

		<!--#Include virtual="/Administration/Header.asp"-->

 
<table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">




<%

'rowcount = CInt
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text

ID= Request.Form("ID")

	Query =  " UPDATE PageLayout Set FeaturedID = '" & ID & "' "
    Query =  Query & " where PageName = 'Home Page ';"  
	response.write(Query)	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 




IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>



</td>
</tr>
</table>

<% 

Response.Redirect("HomePageAdmin.asp") 
 
 %>

</Body>
</HTML>

 </Body>
</HTML>
