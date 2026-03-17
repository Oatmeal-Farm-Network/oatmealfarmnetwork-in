<!--#Include file="LinksHeader.asp"--> 
<h1>Link Categories</h1>
<br>


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   >
	<tr>
		<td width = "300"  height = "300" class = "body" valign = "top">
		<H2>Link Categories<br>
			<img src = "images/underline.jpg" width = "280"></H2>

					<% 
Dim CatID(100,100)
Dim CategoryName(100,100)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from LinkCategories  order by CategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CatID(CatCounter,0) = rs("CatID")
		CategoryName(CatCounter,0) = rs("CategoryName")
		'response.write(CategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
			<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  ><tr><td> <form action= 'EditLinkCategory.asp' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			<input name="categoryname" value ="<%= CategoryName(CatCounter,0) %>"  size = "20">
			<input name="categorytype" value ="category"  type="hidden">
			
				<input name="CatID" value ="<%=CatID(CatCounter,0)%>"  type="hidden">
			<input type=submit value = "submit"  class = "small" ></div>
			</form>
		</td>
		</tr>
		</table>
		

	<% 
	
wend


%>



		</td>
		<td width = "5" align = "center"><img src = "images/underline.jpg" width = "1" height = "100%"> </td>
		<td width = "300"   class = "body" valign = "top">
			<h2>Add Categories
			<img src = "images/underline.jpg" width = "280" ></H2>

			<b>Add a New Category</b><br>
			<form action= 'AddLinkCathandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				<tr>
						<td width = "200" class = "body" align = "right">
							New Category:
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<input type=submit value = "Add Category" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
					</td>
			</tr>
			</table>
			</form>




<h1><center>Warning! </center></h1>
<b>When you delete a category  you will loose all Links with that category! Even if you create a new category with the same name, the old Links will not automatically be reassigned!</b><br><br>

			<b>Delete a Category</b>
<form action= 'DeleteLinkcatHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body" align = "right">
							Category:
					</td>
					<td class = "body" >
							<select size="1" name="CatID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter +1) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= CatID(CatCounter,0) %>"><%= CategoryName(CatCounter,0) %></option>
	
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