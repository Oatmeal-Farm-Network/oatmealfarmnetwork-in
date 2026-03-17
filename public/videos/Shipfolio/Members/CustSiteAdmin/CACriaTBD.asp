 <%' Cria %>

 <td valign = "top">
		<% RecentProgenyID = rs("RecentProgenyID")
		' response.write(RecentProgenyID)
		click2= ""
		DueDate = ""
		CriaName = " "
		CriaColor = " "
		
		if rs("ShowCurrentStud") = true then 
			click2 =  " <img  src=""/uploads/ListPage/NotHereYet.jpg""  border=0 >"
			DueDate = "Due: " & RS("Duedate")
			CriaName = " "
			CriaColor = " "
			%>
			<table>
				<tr>
					<td align=center  valign = "top" width = "180" valign = "top">                          
                        <table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
						<tr>
							<td><%=click2%></td></tr></table>	
					</td>
				</tr>
			<%
		end if
		%>
		
			
				<tr>
					<td align=center  valign = "top" width = "180" valign = "top"> 
					

					






                        <% if len(CriaName)> 1 then %>
							<b><%=CriaName%></b><br>
						<% end if %>
						<% if len(CriaColor)> 1 then %>
							<%=CriaColor%><br>
						<% end if %>
                            <%=DueDate%><br><br>
                         <BR><%=hiddenInput%></font></b>
					</td>
				</tr>
			</table>
		</td>

	