 <%' Cria %>

 <td valign = "top">
		<% RecentProgenyID = rs("RecentProgenyID")
		' response.write(RecentProgenyID)
		click2= ""
		DueDate = ""
		CriaName = " "
		CriaColor = " "
		if rs("ShowRecentCria") = true then 
		
		    DBname= rs("animals.FullName")
			str1 = rs("animals.FullName")
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
               	If photoID = "nophoto" then 
			     click2 =  "NotYet.jpg"
				Else
   			     click2 = photoID                    
                
                End If
			end If
			%>
			<table>
				<tr>
					<td align=center  valign = "top" width = "180" valign = "top">                          
                        <a href = "Details.asp?ID=<%=ID2%>&DetailType=Other&Detail.x=53&Detail.y=21" class = "body">
						<img src= "/uploads/ListPage/<%=click2%>" border = "0" width = "110"></a>	
					</td>
				</tr>

			<%
		End If
		if rs("ShowCurrentStud") = true then 
			click2 =  " <img  src=""/uploads/ListPage/NotYet.jpg""  border=0 >"
			DueDate = "Due: " & RS("Duedate")
			CriaName = " "
			CriaColor = " "
			%>
			<table>
				<tr>
					<td align=center  valign = "top" width = "180" valign = "top">                          
                        <%=click2%>
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
							<b><%=CriaColor%></b><br>
						<% end if %>
                            <%=DueDate%><br><br>
                         <BR><%=hiddenInput%></font></b>
					</td>
				</tr>
			</table>
		</td>
		</tr>