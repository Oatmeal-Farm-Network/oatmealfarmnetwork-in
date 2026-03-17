<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add or Delete a Product</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/Administration/Header.asp"--> 

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H2>Add a New Product<br>
			<img src = "images/underline.jpg"></H2>
			To add an animal, enter data in the boxes below then select the "Submit Changes" button at the bottom of the form.<br><br>
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		
	<form action= 'AddProductshandleform.asp' method = "post">
	<tr>
		<td width = "190">
			Name:
		</td>
		<td>
			<input name="Name" size = "30">
		</td>
	</tr>
	<tr>
		<td>
			Item ID:
		</td>
		<td>
			<input name="ARI">
		</td>
	</tr>
	
	<tr>
		<td>
			Category:
		</td>
		<td>
			<select size="1" name="Category">	
				<option name = "Category2" value= "" selected></option>
				<%
					conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
					"Data Source=" & server.mappath(databasepath) & ";" & _
					"User Id=;Password=;" 

					sql = "select * from ProductCategories ;"

			'response.write(sql)
					Set rs = Server.CreateObject("ADODB.Recordset")
					 rs.Open sql, conn, 3, 3 

					While not rs.eof %>
						<option  value="<%=rs("CategoryName")%>"><%=rs("CategoryName")%></option>

					<% rs.movenext
					Wend
				%>
			</select>
		</td>
	</tr>
		<input TYPE="hidden" name="Breed" Value = "product">

	<tr>
		<td Valign= "top">
			Sales Description:
		</td>
		<td>
			<textarea name="Comments" cols="63" rows="8" wrap="VIRTUAL" ></textarea>
		</td>
	</tr>
</table>	

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
 <table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <a name="Delete"></a> <H2>Delete an Product<br>
			<img src = "images/underline.jpg"></H2>
			To delete a product from the database simply select the product's name and push the delete button.<br> <b>But be careful. Once a product is deleted from your database, it's gone!</b>
		</td>
	</tr>
</table>

<%  
dim aID(400)
dim aName(400)
dim aARI(400)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select *  from Products order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ProductID")
		aName(acounter) = rs2("FullName")
		aARI(acounter) = rs2("ARI")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
<br>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td>
			<form action= 'DeleteProducthandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Product's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aARI(count)%> - <%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>