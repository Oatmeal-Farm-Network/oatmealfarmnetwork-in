
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body" colspan = "2">
			<a name="Add"></a>
			<H1>Maintain Categories <br>
			<img src = "images/underline.jpg"></H1>
			<br><br>
		</td>
	</tr>
</table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "300" valign = "top">
		<h2>Existing Categories 
			<img src = "images/underline.jpg" width = "300" ></H2>
		
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>

		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>   

					<% 
					Dim CategoryID(100)
					Dim CategoryName(100)

					conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from ProductCategories order by CategoryID " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter) = rs("CategoryID")
		CategoryName(CatCounter) = rs("CategoryName")
		%>
		<tr><td valign = "top"><b><%=CategoryName(CatCounter)%></b></td></tr>
		<%
		
		
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

		CatCounter= 0

   		FinalSubCatCounter = CatCounter
%>

</table>

		</td>
		<td width = "5" align = "center"><img src = "images/underline.jpg" width = "1" height = "100%"> </td>
		<td width = "280"  height = "350" class = "body" valign = "top">
			<h2>Add Categories 
			<img src = "images/underline.jpg" width = "280" ></H2>

			<form action= 'AddCategoryhandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				<tr>
						<td width = "140" class = "body" align = "right">
							New Category:
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="CategoryType" type = "hidden" Value = "For Sale">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<input type=submit value = "Add Category" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
					</td>
			</tr>
			</table>
			</form>

<br><br>

<br>

	<h2>Delete Categories 
			<img src = "images/underline.jpg" width = "280" ></H2>
			<form action= 'DeleteCategoryHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body" align = "right">
							Category:
					</td>
					<td class = "body" >
							<select size="1" name="CategoryID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter +1) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= CategoryID(CatCounter) %>"><%= CategoryName(CatCounter) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
					</td>
			</tr>
			</table>
			</form>
   </td>
   </tr>
   <tr>
      <td>



			
		</td>
	</tr>
</table>