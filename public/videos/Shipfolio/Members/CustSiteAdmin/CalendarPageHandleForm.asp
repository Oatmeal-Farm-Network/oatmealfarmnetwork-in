<HEAD>
 <title>Account Maintanance</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"-->
		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
 
<table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">




<%

Dim PageName 
Dim PageTitle
Dim PageText


'rowcount = CInt
rowcount = 1

PageName = Request.Form("PageName") 
PageTitle = Request.Form("PageTitle")  
PageText = Request.Form("PageText")  
ID = Request.Form("ID")  
 
'response.write(PageText)
Dim str1
Dim str2
str1 = PageTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "''")
End If  


str1 = PageTitle
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "</br>")
End If  


str1 = PageTitle
str2 = vbtab
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = PageTitle
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = PageTitle
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;")
End If 



str1 = PageTitle
str2 = vbCr
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "</br>")
End If  


str1 = PageTitle
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "</br>")
End If  

str1 = PageTitle
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;")
End If 


str1 = PageTitle
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "</br>")
End If  



str1 = PageText
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "''")
End If  


str1 = PageText
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  


str1 = PageText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = PageText
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = PageText
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "&nbsp;")
End If 



str1 = PageText
str2 = vbCr
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  


str1 = PageText
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  

str1 = PageText
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "&nbsp;")
End If 


str1 = PageText
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  










    Query =  " UPDATE PageLayout Set PageTitle = '" & PageTitle & "' ,"
	Query =  Query & " PageText = '" & PageText & "' "
    Query =  Query & " where pageName = '" & PageName & "';" 


response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

	RedirectToPage = "CalendarTopMantainance.asp" 
Response.Redirect(RedirectToPage)
%>
<br><h1>Your Changes Have Been Made</h1>
<!'--#Include virtual="/administration/PageMantainanceInclude.asp"-->
<!'-- #include virtual="/administration/PagePhotoFormInclude.asp" -->

</td>
</tr>
</table>


		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
