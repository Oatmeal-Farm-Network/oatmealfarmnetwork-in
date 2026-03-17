<%
			DBname= name
			str1 = name
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBname= Replace(str1, "'", "''")
				DBName = trim(DBName)
			End If
			Set rsCria = Server.CreateObject("ADODB.Recordset")
			'response.write(gender)
			 If gender = "male" then
					sqlCria = "select distinct Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID and animals.ID = Photos.ID and ShowWithSire = True and (trim(DamName) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"
			Else
					sqlCria = "select distinct Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID  and animals.ID = Photos.ID and ShowWithDam = True and (trim(DamName) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"
			End If
			
			'response.write(sqlCria)

			rsCria.Open sqlCria, conn, 3, 3 
		
			if not rsCria.eof then %>
			<table border="0" cellspacing="2" width = "610" align = "center" >
<tr>
					<td  class = "Details"><br><big><b>Progeny</b></big><br><img src = "/images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "<%=bodywidth%>" height = "2">	</td>
				</tr>
		<tr>
			<td   valign = "top" height = "2" valign = "bottom" background = "/images/Underline.jpg"><img src = "/images/px.gif" height = "2" border = "0"></td>
		</tr>
</table>
			<table border="0" cellspacing="2"   >
				<%
				Counter = 1
				Row = 0
				totalrows = 0
				while not rsCria.eof 
				Row = Row + 1 
				totalrows = totalrows +1
				If row = 3 Then 
				     Row = 1
				 End if
				
				CriaName 	= trim(rsCria("FullName"))
				CriaID 	= rsCria("Animals.ID")


				 If row = 1 Then %>
						<tr>
				  <%end If  %>
				
					<td  class = 'body' align = "center" width = "140">
					  <% response.write(CriaLink) 
					  If CriaLink = "False" Then %>
							<% If Len(rsCria("ListPageImage"))	> 7  Then %>
								<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" ><tr><td><img src= "/uploads/Listpage/<%=rsCria("ListPageImage") %>" width = "130" border = "0"></td></tr></table> 
							<% Else %>
							<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
									<img src= "/uploads/Listpage/NotAvailableL.jpg" width = "130" border = "0">
								</td>
							</tr>
							</table>
							<% End If %>
		
						<% Else If Len(rsCria("ListPageImage"))> 7  Then %>
							<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" ><tr><td><a href = "Details.asp?ID=<%=CriaID%>&DetailType=other&Detail.x=53&Detail.y=21" class = "body"><img src= "/uploads/Listpage/<%=rsCria("ListPageImage") %>" width = "130" border = "0"></a></td></tr></table>
								
						<% Else %>
							<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
									<a href = "Details.asp?ID=<%=CriaID%>&DetailType=other&Detail.x=53&Detail.y=21" class = "body"><img src= "/uploads/Listpage/NotAvailableL.jpg" width = "130" border = "0"></a>
								</td>
						</tr>
						</table>
						<% End If %>
						 <% End If %>
					<td>
					<td  class = 'body' colspan = "2" >
						 <%If CriaLink = "False" Then %>
								<%=rsCria("FullName")%><br>
						<% Else %>
								<a href = "Details.asp?ID=<%=CriaID%>&DetailType=other&Detail.x=53&Detail.y=21" class = "body"><%=rsCria("FullName")%></a><br>
						<% End If %>
						Color: <%=rsCria("Color")%><br>
						Category: <%=rsCria("Category")%>
						<br>
						<br><br>

				</td>
				<% If row = 3 Then %>
						<tr>
				  <%end If  %>
			<% 
			counter = counter +1
			rsCria.movenext
			wend%>

		
		
		
		<%If 	totalrows = 1 Or 	totalrows = 2 Or 	totalrows = 4  Or 	totalrows = 5  Or 	totalrows = 7 Or 	totalrows = 8 then 
		%>
		</tr>
	<% End If %>
	
	<%
	rsCria.close
	set rsCria=nothing%>
	
	</table>
	<% End If %>