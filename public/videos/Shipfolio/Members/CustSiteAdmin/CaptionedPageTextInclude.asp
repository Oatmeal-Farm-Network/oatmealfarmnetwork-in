<% textwidth = screenwidth
if len(blockalight) >0 then
else
 blockalight = "Center"
end if

if len(TempPageText) > 4 or len(tempImage) > 4  then
	If Len(TempImageCaption) < 2 Then
	TempImageCaption = " "
	End if

found = false
 if len(TempImageOrientation) > 4 then
else
TempImageOrientation = "Right"
end if
If Len(tempImage) > 2 And TempImageOrientation = "Right" Then 
	found = True %> 
<table  width = "<%=textwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=blockalight %>"><tr><td class = "body" valign = "top">
<table  width = "340"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempImageOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>" width = "300"  align = "right" class = "pictures"></td></tr><tr><td align = "center" class = "Body2"><%=TempImageCaption%></td></tr></table>
<% if len(TempHeading)> 1 then %>
<h2><%=TempHeading%></h2>
<% end if %>
<%=TempPageText %>
</td></tr></table>
<% End If  %>
<% If Len(TempImage) > 2 And TempImageOrientation = "Middle" Then 
found = True%> 		
<table  width = "<%=textwidth %>"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=blockalight %>">
<tr><td class = "Body" valign = "top"><table  width = "340" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempImageOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>"   align = "right" class = "pictures"></td></tr><tr><td align = "center" class = "Body2"><%=TempImageCaption%></td></tr></table>
<% if len(TempHeading)> 1 then %>
<h2><%=TempHeading%></h2>
<% end if %>
<%=TempPageText %>
</td>
</tr>
</table>
<% End If  %>
<% If Len(TempImage) > 2 And TempImageOrientation = "Left" Then 
found = True%> 		
<table  width = "<%=textwidth %>"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=blockalight %>">
<tr><td class = "Body" valign = "top"><table  width = "340" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempImageOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>" width = "300" align = "left" class = "pictures"></td></tr><tr><td align = "center" class = "Body2"><%=TempImageCaption%></td></tr></table>
<% if len(TempHeading)> 1 then %>
<h2><%=TempHeading%></h2>
<% end if %>
<%=TempPageText %>
</td></tr></table>
<% End If  %>
<% If Len(TempImage) < 2 Or found = False Then %> 		
<table  width = "<%=textwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=blockalight %>"><tr><td class = "body" valign = "top">
<% if len(TempHeading)> 1 then %>
<h2><%=TempHeading%></h2>
<% end if %>
<%=TempPageText %>
</td></tr></table>
<% End If  %>

<% End If  %>