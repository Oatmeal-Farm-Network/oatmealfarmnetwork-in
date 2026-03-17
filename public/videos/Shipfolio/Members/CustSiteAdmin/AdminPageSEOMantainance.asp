<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% 




if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + 'pagename=<%=Pagename %>);">
<% end if%>

<!--#Include File="AdminHeader.asp"--> 
<br />
<table width = "100%" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	
<td class = " body" valign = "top">

<% 
PageName=Request.Form("PageName" ) 
If Len(PageName) < 3 then
'PageName= request.querystring("PageName")	
  
End if

If Len(PageName) < 1 then
   PageName = "Home Page"
End if
sql = "select * from PageSEO where trim(PageName)='" & PageName & "';"
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

Title = rs("Title")
Description = rs("Description")


str1 = Description
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , vbCrLf)
End If  


str1 = Description
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, " ")
End If 

str1 = Description
str2 = "''"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "'")
End If 


rs.close

Dim PageNameList(40000)	
	sql2 = "select PageSEO.* from Pagelayout, PageSEO where Pagelayout.PageLayoutId = PageSEO.PageLayoutId and  PageAvailable = True"	
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
<br /><br />
<form  action="AdminPageSEOMantainance.asp" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" class = roundedtopandbottom>
<tr>
	<td Class = "body" >
		<h2>Select a Different Page</h2>
	</td>
</tr>
 <tr>

	 <td class = "body">
		<br>Select one of your pages:
		<select size="1" name="PageName">
		<option name = "AID0" value= "" selected></option>
		<% count = 1
			while count < acounter%>
				<option name = "AID1" value="<%=PageNameList(count)%>"><%=PageNameList(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
		<input type=submit value = "Edit" class = "regsubmit2" >
		</td>
	</tr>
</table>
</form>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100%" class = "roundedtopandbottom">
	<tr>
		<td Class = "body"><br />
			<H2><% = PageName%> Content</H2><br />
		</td>
	</tr>
	<tr>
		<td valign = "top">
			 <form action= 'AdminPageSEOHandleForm.asp' method = "post">
			<input name="PageName"  size = "60" value = "<%=PageName%>" type = "hidden">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
  	<tr height= 40>
			<td  align = "right"  valign = top class = "body2">
					<b>Title&nbsp;</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Title"  size = "40" value = "<%=Title%>">
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body2" valign = "top" >
					<b>Description&nbsp;</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Description" cols="55" rows="10" wrap="file" class=body><%=Description%></textarea>
			</td>
		</tr>
		

		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" Class = "regsubmit2" >
		</td>
		</tr>
		</table></form>

</td>
</tr>
</table>

</Body>
</HTML>