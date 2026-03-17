<HEAD>
 <title>News</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"-->
		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
 
 <!--#Include virtual="/Administration/NewsHeader.asp"-->
<table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">




<%

Dim NewsTitle2 
Dim  NewsDate2
Dim NewsText2
Dim NewsID2

'rowcount = CInt
rowcount = 1

NewsTitle2 = Request.Form("NewsTitle") 
NewsDate2 = Request.Form("Newsdate")  
NewsText2 = Request.Form("NewsText")  
NewsID2 = Request.Form("NewsID")  
 
'response.write(PageText)
Dim str1
Dim str2
str1 = NewsTitle2
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "''")
End If  


str1 = NewsTitle2
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "</br>")
End If  


str1 = NewsTitle2
str2 = vbtab
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = NewsTitle2
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = NewsTitle2
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "&nbsp;")
End If 



str1 = NewsTitle2
str2 = vbCr
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "</br>")
End If  


str1 = NewsTitle2
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "</br>")
End If  

str1 = NewsTitle2
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "&nbsp;")
End If 


str1 = NewsTitle2
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "</br>")
End If  



str1 = NewsText2
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "''")
End If  


str1 = NewsText2
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "</br>")
End If  


str1 = NewsText2
str2 = vbtab
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = NewsText2
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = NewsText2
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "&nbsp;")
End If 



str1 = NewsText2
str2 = vbCr
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "</br>")
End If  


str1 = NewsText2
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "</br>")
End If  

str1 = NewsText2
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "&nbsp;")
End If 


str1 = NewsText2
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "</br>")
End If  





    Query =  " UPDATE News Set NewsTitle = '" & NewsTitle2 & "' ,"
	Query =  Query & " NewsText = '" & NewsText2 & "' ,"
	Query =  Query & " NewsDate = '" & Newsdate2 & "' "
    Query =  Query & " where NewsID = " & NewsID2 & ";" 


'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<br><h1>Your Changes Have Been Made</h1>

<!--#Include virtual="/administration/NewsMantainanceInclude.asp"-->
</td>
</tr>
</table>


		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
