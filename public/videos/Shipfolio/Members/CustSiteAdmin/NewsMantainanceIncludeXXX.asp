<% 
	  
If Len(NewsID2) = 0 then
	NewsID2=Request.Form("NewsID" ) 
End if

If Len(NewsID2) > 0 then
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

If Len(NewsID2) > 0 then
			  sql = "select * from News where NewsID=" & NewsID2 & ";"

	'response.write(sql)	
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
NewsTitle2 = rs("NewsTitle")
NewsDate2 = rs("NewsDate")
NewsText2 = rs("NewsText")

str1 = NewsTitle2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1, str2 , vbCrLf)
End If  


str1 = NewsTitle2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, " ")
End If 

str1 = NewsTitle2
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "'")
End If 


str1 = NewsText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1, str2 , vbCrLf)
End If  


str1 = NewsText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, " ")
End If 

str1 = NewsText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "'")
End If 

'response.write("PageText=")
'response.write(PageText)

End If 



%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>News<br>
			<img src = "images/underline.jpg" width = "600"></H2>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'NewsHandleForm.asp' method = "post">

			<input name="NewsID"  size = "60" value = "<%=NewsID2%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
  	<tr>
			<td  align = "right"   class = "body">
					<b>Title</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="NewsTitle"  size = "60" value = "<%=NewsTitle2%>">
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body">
					<b>Date</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="NewsDate"  size = "60" value = "<%=NewsDate2%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Page Text:</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="NewsText" cols="55" rows="20" wrap="file"><%=NewsText2%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
		</td>
		</tr>
		</table></form>
		</td>
		</tr>
		</table>

<% Else %>

 <!--#Include virtual="/administration/EditNewsInclude.asp"--> 
<% End If %>
