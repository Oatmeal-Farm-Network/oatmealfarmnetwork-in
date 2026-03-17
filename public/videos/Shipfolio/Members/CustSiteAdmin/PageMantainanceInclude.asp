<% 
	
If Len(PageName) = 0 then
	PageName=Request.Form("PageName" ) 
End If
If Len(PageName) = 0 then
	PageName=Request.Querystring("PageName" ) 
End If

 If PageName = "About Us" Then
	Response.Redirect("AboutUsAdmin.asp")
End if


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Pagelayout where PageName='" & PageName & "';"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
PageName = rs("PageName")
PageTitle = rs("PageTitle")

str1 = PageTitle
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1, str2 , vbCrLf)
End If  


str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 

PageText = rs("PageText")

str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  


str1 = PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

'response.write("PageText=")
'response.write(PageText)


Dim PageNameList(40000)



	
	sql2 = "select * from Pagelayout where PageAvailable = True"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
	
		PageNameList(acounter) = rs2("PageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td Class = "body">
			<H2><% = PageName%> Content<br>
			<% If PageName = "Alpacas for Sale" Then %>
					This is the text that shows up on the top of the page.
			<% End If %>
			<img src = "images/underline.jpg" width = "600"></H2>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<td valign = "top">
			 <form action= 'PageHandleForm.asp' method = "post">
			<input name="PageName"  size = "60" value = "<%=rs("PageName")%>" type = "hidden">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
  	<tr>
			<td  align = "right"   class = "body">
					<b>Title</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="PageTitle"  size = "60" value = "<%=rs("PageTitle")%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Page Text:</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="PageText" cols="80" rows="22" wrap="file"><%=PageText%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>
