<HEAD>
 <title>I Love Alpacas Page</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">
       <!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="AdminHeader.asp"--> 

 
<table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">




<%

'rowcount = CInt
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text

TextBlock= Request.Form("TextBlock")
Heading = Request.Form("Heading")
Text= Request.Form("Text") 
TBID= Request.Form("TBID") 
Order= Request.Form("Order") 

	Dim str1
	Dim str2
	str1 = text
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "''")
	End If  

	str1 = text
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  



	str1 =Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "''")
	End If  

	str1 = Heading
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 =Heading
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = Heading
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = Heading
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 =Heading
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  


If TextBlock = "Heading" Then

	Query =  " UPDATE PageLayout Set PageTitle = '" & Text & "' "
    Query =  Query & " where PageName = 'I Love Alpacas';"  
	'response.write(Query)	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 

End If 

response.write(TB)
If TextBlock = "TB" Then

	Query =  " UPDATE PageLayout Set PageHeading" & TBID & " = '" & Heading & "', "
	Query =  Query & " PageText" & TBID & " = '" & Text & "'"  
	'Query =  Query & " Order" & TBID & " = '" & Order & "'"  
    Query =  Query & " where PageName = 'I Love Alpacas';"  
	response.write(Query)	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 

End If 





IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<br><h1>Your Changes Have Been Made</h1>


</td>
</tr>
</table>

<% = Response.Redirect("ILoveAlpacasAdmin.asp") %>
		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
