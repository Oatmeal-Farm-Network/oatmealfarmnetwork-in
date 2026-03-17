<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Product Description Edit Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">



</HEAD>

<BODY  border = "0" leftmargin="10" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white">
	<tr>
		<td class = "body">
			 <H2>Edit Product Descriptions <br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your descriptions, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ProductID, FullName, Description from Products order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ProductID(400)
	dim FullName(400)
	dim Comments(400)
		dim CriaText(400)
	
Recordcount = rs.RecordCount +1
%>
<form action= 'ProductsDescriptionhandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "750">
	<tr>
		<th align = "center">&nbsp;Name&nbsp;</th>
		<th >Description</th>
	</tr>



	
<%
 While  Not rs.eof         
	 ProductID(rowcount) =   rs("ProductID")
	 FullName(rowcount) =   rs("FullName")
	 Comments(rowcount) =   rs("Description")

%>

	
	<tr>
		<td valign = "top"  align = "left" class = "body">
			<input type = Hidden name="ProductID(<%=rowcount%>)" value= "<%=  ProductID( rowcount)%>" >
			<input type = Hidden name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
			<%=  FullName( rowcount)%>
		</td>
		<td class = "body" width = "300"><textarea name="Comments(<%=rowcount%>)" cols="85" rows="12" wrap="VIRTUAL" class = "body"><%= Comments(rowcount)%></textarea></td>
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
		<td colspan = "2" align = "center" valign = "middle" class = "body">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px"  class = "menu" >
			</form>
		</td>
</tr>
</table>
 
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>