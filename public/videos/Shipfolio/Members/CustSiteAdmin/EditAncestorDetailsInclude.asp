<%
	if Ancestorname="0" then
		Ancestorname= ""
	end if

str1 = Ancestorname
str2 = "''"
If InStr(str1,str2) > 0 Then
	Ancestorname= Replace(str1, "''", "'")
End If

	%>
	
	<form action= 'Ancestryhandleform2.asp' method = "post">
	<table border=1 width="160">
					<tr>
						<td  class = "small">
						<% If gender = "male" Then %>
							<table width = "237" height = "100" background = "images/male.jpg">
						<% Else %>
							<table width = "237" height = "100" background = "images/female.jpg">
						<% End if %>

							<tr>
								<td  class = "small" >Name:	</td>
								<td  class = "small" ><input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" size = "26"></td>
							</tr>
							<tr>
								<td  class = "small" >Color:</td>
								<td  class = "small" ><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "26"></td>
							</tr>
							<tr>
								<td  class = "small">ARI:</td>
								<td  class = "small"><input name="<%=AncestorARIField%>" value= "<%=AncestorARI%>" size = "12"></td>
							</tr>
							<tr>
								<td  class = "small">CLAA:</td>
								<td  class = "small"><input name="<%=AncestorCLAAField%>" value= "<%=AncestorCLAA%>" size = "12"></td>
							</tr>
				</table>
				</td>
							</tr>
				</table>