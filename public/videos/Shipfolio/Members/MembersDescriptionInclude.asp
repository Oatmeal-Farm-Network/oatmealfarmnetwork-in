<%

str1 = Description
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'Description= Replace(str1, str2 , vbCrLf)
	
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


%>
 <a name="Description"></a><br /><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Description</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">

<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<form action= 'MembersDescriptionHandleForm.asp' method = "post" name = "d1">
	
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
    <tr >
		<td class = "body" valign = "top">
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "100%";
    mysettings.Height = "300px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('Description', mysettings);
</script>


<textarea name="Description"  cols="110" rows="20"   class = "body"  ID="Description"><%= Description%></textarea>


	</td>	
	</tr>
	</table>
	<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
	<td  align = "center">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >

			<div align = "right">
				<input type="submit" class = "regsubmit2" value="Submit"  >
	</div>
		</td>
</tr>
</table></form>
	</td>
</tr>
</table>

<% 

str1 = StudDescription
str2 = "</br>"
If InStr(str1,str2) > 0 Then
'	StudDescription= Replace(str1, str2 , vbCrLf)
	
End If  


str1 = StudDescription
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, " ")
End If 

str1 = StudDescription
str2 = "''"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, "'")
End If 
%>


<%

If category = "Experienced Male" or trim(category) = "Inexperienced Male"  then%>



	 <a name="StudDescription"></a><br /><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Stud Breeding Description</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<form action= 'StudDescriptionHandleForm.asp' method = "post" name = "d2">
	
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
    <tr >
		<td class = "body" valign = "top">
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "100%";
    mysettings.Height = "300px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('StudDescription', mysettings);
</script>

<textarea name="StudDescription" ID="StudDescription"  cols="110" rows="20"   class = "body"   ><%= StudDescription%></textarea>
	</td>	
	</tr>
	</table>

<table width = "800" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<div align = "Right">
				<input type="submit" class = "regsubmit2" value="Submit"  >
	</div>
		</td>
</tr>
</table></form>
</td>
</tr>
</table>
<% End If %>
