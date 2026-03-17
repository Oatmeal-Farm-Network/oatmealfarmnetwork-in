

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Add/Edit Product ColorsPage</title>
       


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white" >

<!--#Include virtual="/Membersistration/Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2>Add/Edit Product Colors<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, ProductColor.* from Animals, ProductColor where Animals.ID = ProductColor.ProductID and breed = 'product' order by animals.fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ProductID(40000)
	dim ColorID(40000)
	dim FullName(40000)
	dim Color(40000)

Recordcount = rs.RecordCount +1
%>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
 <tr>
		<td colspan = "9" align = "center">
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr>
		<th >Product</th>
		<th >Color</th>
	</tr>


	
<%
 While  Not rs.eof         
	 ProductID(rowcount) =   rs("ProductID")
	 ColorID(rowcount) =   rs("ColorID")
	 FullName(rowcount) =   rs("FullName")
	 color(rowcount) =   rs("Color")

	%>

	<form action= 'Colorsedithandleform.asp' method = "post">

	<tr >
		<td class = "body">
			<input type = "hidden" name="ProductID(<%=rowcount%>)" value= "<%=  ProductID( rowcount)%>" >
			<input type = "hidden" name="ColorID(<%=rowcount%>)" value= "<%= ColorID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
				<%=FullName(rowcount)%>
		</td>
		<td>
			<input name="Color(<%=rowcount%>)" value= "<%= Color(rowcount)%>" size = "46">
		</td>
	</tr>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
			</form>
		</td>

</tr>
</table>
 <br><br>
<%rowcount = 0%>

<%
dim aID(40000)
dim aName(40000)



	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ID, FullName from Animals where breed = 'product' order by fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	While Not rs.eof  
		aID(acounter) = rs("ID")
		aName(acounter) = rs("FullName")
	
		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>
 
 <form action= 'AddColorshandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Add a New Entry</H2>
		</td>
	</tr>
  <tr>
		<th >Name</th>
		<th >Color</th>
	</tr>

<tr onmouseover="this.AClassName='highlighted';this.style.cursor='hand';" onmouseout="this.AClassName='normal'">
		<td>
				<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			
					
				</td>

				<td  align = "center">
					<input name="color(<%=rowcount%>)" value= "<%= Color(rowcount)%>" size = "46">
				</td>

		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" >
			</form>
		</td>

</tr>
</table>



<%


Dim aColor(500)

	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "SELECT animals.*, Productcolor.* FROM Animals, Productcolor WHERE animals.id = Productcolor.productid and animals.breed = 'product' ORDER BY animals.fullname;"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	While Not rs.eof  
		ColorID(acounter) = rs("ColorID")
		aName(acounter) = rs("FullName")
		acolor(acounter) = rs("Productcolor.color")
	
		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>
 
 <form action= 'Removecolorshandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
 <tr>
		<td  align = "center">
					<H2>Remove a Product Color</H2>
		</td>
	</tr>

<tr onmouseover="this.AClassName='highlighted';this.style.cursor='hand';" onmouseout="this.AClassName='normal'">
		<td>
				<select size="1" name="ColorID">
					<option  value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option  value="<%=ColorID(count)%>">
							<%=aName(count)%> - <%=acolor(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			
					
				</td>
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" >
			</form>
		</td>

</tr>
</table>

<!--#Include virtual="/Membersistration/Footer.asp"--> </Body>
</HTML>