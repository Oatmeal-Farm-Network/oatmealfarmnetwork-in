<% ' Clean directory NEA 4/2012 %>
		<%
	If Len(TempImageCaption) < 2 Then
	TempImageCaption = " "
	End if

	found = false
	If Len(TempImage) > 2 And TempOrientation = "Right" Then 
	found = True %> 		
					<table  width = "<%=textwidth - 20%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
							<tr>
								<td class = "body" valign = "top">
									<table  width = "<%=imagewidth + 5%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>" width = "<%=imagewidth%>" border = "3" align = "right" ></td></tr><tr><td align = "center" class = "body"><%=TempImageCaption%></td></tr></table>
								<h2><%=TempHeading%></h2>
								<%=TempPageText %>
									
								</td>
							</tr>
						</table>
						<br>
			<% End If  %>
				<% If Len(TempImage) > 2 And TempOrientation = "Middle" Then 
				found = True%> 		
					<table  width = "<%=textwidth - 20%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
							<tr>
								<td class = "body" valign = "top"><table  width = "<%=imagewidth + 5%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>"  border = "3" align = "right"></td></tr><tr><td align = "center" class = "body"><%=TempImageCaption%></td></tr></table>
								<h2><%=TempHeading%></h2>
								<%=TempPageText %>
									
								</td>
							</tr>
						</table>
						<br>
			<% End If  %>
		<% If Len(TempImage) > 2 And TempOrientation = "Left" Then 
		found = True%> 		
				<table  width = "<%=textwidth - 20%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
							<tr>
								<td class = "body" valign = "top"><table  width = "<%=imagewidth + 5%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "<%=TempOrientation%>"><tr><td align = "center"><img src = "<%=TempImage%>" width = "<%=imagewidth%>" border = "3" align = "left"></td></tr><tr><td align = "center" class = "body"><%=TempImageCaption%></td></tr></table>
		
								<h2><%=TempHeading%></h2>
								<%=TempPageText %>
									
								</td>
							</tr>
						</table>
						<br>
			<% End If  %>
			<% If Len(TempImage) < 2 Or found = False Then %> 		
					<table  width = "<%=textwidth - 20%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
							<tr>
								<td class = "body" valign = "top">
								<h2><%=TempHeading%></h2>
								<%=TempPageText %>
								</td>
							</tr>
						</table>
			<% End If  %>
