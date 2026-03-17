
<% 
	  
CustID = session("CustID")

sql = "select * from sfCustomers where custID=" & custID & ";"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	custCompany = rs("custCompany")
    custRanchdescription = rs("custRanchdescription")
	AboutUsHeading = rs("AboutUsHeading")
	AboutUsPageImage = rs("AboutUsPageImage")


str1 = AboutUsHeading
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, " ")
End If 

str1 = AboutUsHeading
str2 = "''"
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "'")
End If 


str1 = custRanchdescription
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1, str2 , vbCrLf)
End If  

str1 = custRanchdescription
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, " ")
End If 

str1 = custRanchdescription
str2 = "''"
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "'")
End If 



%>





<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Ranch About Us Content<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			To update your text make your changes below and select the "submit Changes" button at the bottom of the form. To update your image please <a href = "#images" class = "body">click here</a>.<br><br>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'AboutUsPageHandleForm.asp' method = "post">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
  	<tr>
			<td  align = "right"   class = "body">
					<b>Page Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="AboutUsHeading"  size = "80" value = "<%=AboutUsHeading%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Ranch Description: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="custRanchdescription" cols="60" rows="20" wrap="file"><%=custRanchdescription%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table></form>

<a Name = "images"></a>
<!-- #include virtual="/administration/AboutUsPagePhotoFormInclude.asp" -->

</td>
</tr>
</table>