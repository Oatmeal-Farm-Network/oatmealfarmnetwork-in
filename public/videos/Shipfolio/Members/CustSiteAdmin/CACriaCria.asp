 <%' Cria %>

 <td valign = "top">
		<% RecentProgenyID = rs("RecentProgenyID")
		'response.write(rs("CriaLink"))
		click2= ""
		DueDate = ""
		CriaName = " "
		CriaColor = " "
		if rs("CriaLink") = False then 
			Linktype = 2
		End if
		
		    DBname= rs("FullName")
			str1 = rs("FullName")
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBname= Replace(str1, "'", "''")
				DBName = trim(DBName)
			End If

					sqlCria = "select Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID and animals.ID = Photos.ID  and (trim(DamName) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"

			'response.write (sqlCria)
			Set rsp = Server.CreateObject("ADODB.Recordset")
			rsp.Open sqlCria, conn, 3, 3   
			if not rsp.eof then
				CriaName = rsp("FullName")
				CriaColor = (rsp("Color"))
				DueDate = " "
				ID2 = rsp("Ancestors.ID")
				photoID = "x"
				photoID = rsp("ListPageImage")
		
				If Len(rsp("ListPageImage"))<300 Or rsp("ListPageImage") = null Then
						click2= "NotAvailableL.jpg"
						
					
				else		
   					 click2 = photoID                    
				End If
			end If
			%>
			<table>
				<tr>
					<td align=center  valign = "top" width = "180" valign = "top"> 
					<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
				

					<% If Linktype = 2 Then %>
						<img src= "/uploads/ListPage/<%=click2%>" border = "0" width = "110">

					<%else%>
                        <a href = "Details.asp?ID=<%=ID2%>&DetailType=Other&Detail.x=53&Detail.y=21" class = "body">
						<img src= "/uploads/ListPage/<%=click2%>" border = "0" width = "110"></a>	
					<%End If %>

															</td>
						</tr>
			</table>
					</td>
				</tr>

			
			
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
	