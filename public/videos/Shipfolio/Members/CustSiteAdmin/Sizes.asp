<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add/Edit Product Sizes Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white" >

<!--#Include virtual="/Administration/Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2>Add/Edit Sizes<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Products.FullName, ProductSizes.* from Products, ProductSizes where Products.ProductID = ProductSizes.ProductID order by Products.fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ProductID(400)
	dim SizeID(400)
	dim FullName(400)
	dim Size(400)
	dim ExtraCost(400)

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
		<th >Size</th>
	</tr>


	
<%
 While  Not rs.eof         
	 ProductID(rowcount) =   rs("ProductID")
	 SizeID(rowcount) =   rs("SizeID")
	 FullName(rowcount) =   rs("FullName")
	 Size(rowcount) =   rs("Size")
	%>

	<form action= 'Sizesedithandleform.asp' method = "post">

	<tr >
		<td class = "body">
			<input type = "hidden" name="ProductID(<%=rowcount%>)" value= "<%=  ProductID( rowcount)%>" >
			<input type = "hidden" name="SizeID(<%=rowcount%>)" value= "<%= SizeID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
				<%=FullName(rowcount)%>
		</td>
		<td>
			<input name="Size(<%=rowcount%>)" value= "<%= Size(rowcount)%>" size = "10">
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
dim aID(400)
dim aName(400)


	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ProductID, FullName from Products where breed = 'product' order by fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	While Not rs.eof  
		aID(acounter) = rs("ProductID")
		aName(acounter) = rs("FullName")
	
		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>
 
 <form action= 'AddSizeshandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Add a New Entry</H2>
		</td>
	</tr>
  <tr>
		<th >Name</th>
		<th >Size</th>
	</tr>

<tr >
		<td>
				<select size="1" name="ProductID">
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
					<input name="Size(<%=rowcount%>)" value= "<%= Size(rowcount)%>" size = "10">
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


<%rowcount = 0%>

<%


Dim asize(500)

	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Products.*, Productsizes.* from Products, Productsizes where Products.ProductID = Productsizes.productid and Products.breed = 'product' order by Products.fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	While Not rs.eof  
		Sizeid(acounter) = rs("Sizeid")
		aName(acounter) = rs("FullName")
		asize(acounter) = rs("size")
	
		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>
 
 <form action= 'RemoveSizeshandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
 <tr>
		<td  align = "center">
					<H2>Remove a Size</H2>
		</td>
	</tr>

<tr onmouseover="this.AClassName='highlighted';this.style.cursor='hand';" onmouseout="this.AClassName='normal'">
		<td>
				<select size="1" name="Sizeid">
					<option  value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option  value="<%=Sizeid(count)%>">
							<%=aName(count)%> - <%=asize(count)%>
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




<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>