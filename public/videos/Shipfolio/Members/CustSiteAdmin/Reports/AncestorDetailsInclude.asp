	
	<% If Len(Ancestorname) < 2 Then
			Ancestorname =""
		End If %>
	<table border=1 width="160">
					<tr>
						<td  class = "small"><%=Ancestorname%>&nbsp;<br>
						<%=AncestorColor%>&nbsp;<br>
						<% If Len (AncestorARI) > 1 Then %>
								<%=AncestorARI%>&nbsp;<br>
						<% End If %>
						<% If Len (AncestorCLAA) > 1 Then %>
								<%=AncestorCLAA%>&nbsp;<br>
						<% End If %>
					</tr>
				</table>