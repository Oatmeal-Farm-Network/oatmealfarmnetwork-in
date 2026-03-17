
				
						<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "280" border = "0">
						<% If Len(rs("studfee")) > 2 Then %>	
									<tr>
										<td valign = "top"  class = "body"  colspan = "2">
											
												Stud Fee:
												<b><%=(rs("StudFee"))%></b><br>
											</td>
									<tr>
									<% End If %>
 						<tr>
    							<td valign = "top"  class = "body"  colspan = "2">ARI#: <%=ARI%><br></td>
                		</tr>		
						<tr>
							<td valign = "top"  class = "body"  colspan = "2"> Color: <%=Color%><br></td>
                		</tr>		
						<tr>
    						<td valign = "top"  class = "body"  colspan = "2">DOB: &nbsp;<%=DOB%><br></td>
                		</tr>	
						<tr>
							<td valign = "top"  class = "body"  colspan = "2"><br><%=rs("Description") %>
							</td>
                		</tr>	
				</table>
