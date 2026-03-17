<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>ProductsPricing Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td class = "body">
			 <H2>Edit Product Pricing<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
	</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select products.* from Products  order by products.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ProductID(400)
	dim FullName(400)
	dim ForSale(960)
	dim Price(400)
	dim PriceComments(400)
	dim Foundation(400)

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<th width = "300" valign = "bottom">Name</th>
		<th  valign = "bottom" width = "110">ForSale?</th>
		<th  valign = "bottom" align = "left" >Price (Must be a number )</th>

	</tr>

	
<%
 While  Not rs.eof         
	 ProductID(rowcount) =   rs("ProductID")
	 FullName(rowcount) =   rs("FullName")
	 Price(rowcount) =   rs("Price")
	 ForSale(rowcount) =   rs("Forsale")

if Price(rowcount)  = "0" then
	Price(rowcount) = ""
end if 
%>

	<form action= 'ProductsPricehandleform.asp' method = "post">
	<tr >
		<td class = "body"><input type = "hidden" name="ProductID(<%=rowcount%>)" Value = "<%=  ProductID( rowcount)%>"><input type = "hidden" name="FullName(<%=rowcount%>)" Value = "<%=  FullName( rowcount)%>" class = "body"><%= FullName( rowcount)%></td>

	
	<%if ForSale(rowcount) = "True" then %>
		<td class = "body">True<input TYPE="RADIO" name="ForSale(<%=rowcount%>)" Value = "Yes" checked>
		False<input TYPE="RADIO" name="ForSale(<%=rowcount%>)" Value = "No" ></td>
	<% else %>
		<td class = "body">True<input TYPE="RADIO" name="ForSale(<%=rowcount%>)" Value = "Yes" >
		False<input TYPE="RADIO" name="ForSale(<%=rowcount%>)" Value = "No" checked></td>
	<%end if%>
	
	<td class = "body">$<input name="Price(<%=rowcount%>)" Value= "<%= Price(rowcount)%>"  size = "10" class = "body"></td>
</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "10" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<input type=submit Value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>