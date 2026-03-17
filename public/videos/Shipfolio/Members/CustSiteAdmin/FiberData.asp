<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Fiber Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white" >

<!--#Include virtual="/administration/Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Edit Fiber Data<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(300)
	dim FiberID(300)
	dim FiberOrder(300)
	dim FullName(300)
	dim SampleAge(300)
	dim SampleDate(300)
	dim Average(300)
	dim StandardDev(300)
	dim COV(300)
	dim GreaterThan30(300)
	dim CF(300)
	dim Curve(300)
	dim ShearWeight(300)
	dim BlanketWeight(300)
	dim Length(300)
	dim CrimpPerInch(300)

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
 <tr>
		<td colspan = "13" align = "center">
					<H2>Edit an Existing Entry (if any exist)</H2>
		</td>
	</tr>
	<tr>
		<th  width = "100">&nbsp; Name&nbsp;</th>
		<th>Order</th>
		<th>Sample<br>Date</th>
		<th >AFD</th>
		<th >SD</th>
		<th>COV</th>
		<th >Fiber > 30</th>
		<th >CF</th>
		<th >Curve</th>
		<th >Blanket<br>Weight</th>
		<th >Total<br> Weight</th>
		<th >Length</th>
		<th >Crimp/<br>Inch</th>
			
	</tr>

	
<%
 While  Not rs.eof         
	 ID(rowcount) =   rs("ID")
	 FiberOrder(rowcount) =   rs("FiberOrder")
	 FiberID(rowcount) =   rs("FiberID")
	 FullName(rowcount) =   rs("FullName")
	 SampleDate(rowcount) =   rs("SampleDate")
	 Average(rowcount) =   rs("Average")
	 StandardDev(rowcount) =   rs("StandardDev")
	 COV(rowcount) =  rs("COV")
	 GreaterThan30(rowcount) =   rs("GreaterThan30")
	 CF(rowcount) =  rs("CF")
	 Curve(rowcount) =   rs("Curve")
	 ShearWeight(rowcount) =   rs("ShearWeight")
	 BlanketWeight(rowcount) =   rs("BlanketWeight")
	 Length(rowcount) =   rs("Length")
	 CrimpPerInch(rowcount) =   rs("CrimpPerInch")
%>

	<form action= 'Fiberhandleform.asp' method = "post">
	<tr >
		<td width = "100">
			<input type = "hidden" name="ID(<%=rowcount%>)"  value="<%=ID(rowcount)%>" >
			<input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" >
			
			<input type = "hidden" name="FullName(<%=rowcount%>)"  >
			<%=FullName(rowcount)%>
		</td>
		<td  align = "center" >
		<%
		If fiberorder(rowcount) < 2 Or fiberorder(rowcount)  = Null Then
			fiberorder(rowcount) = 1
		End if
		%>
			  <select size="1" name="fiberOrder(<%=rowcount%>)">
					<option  value= "<%=FiberOrder(rowcount)%>" selected><%=FiberOrder(rowcount)%></option>
					<option  value= "1" >1</option>
					<option  value= "2" >2</option>
					<option  value= "3" >3</option>
					<option  value= "4" >4</option>
					<option  value= "5" >5</option>
					<option  value= "6" >6</option>
					<option  value= "7" >7</option>
					<option  value= "8" >8</option>
					<option  value= "9" >9</option>
				</select>
		</td>
		<td  align = "center" >
			<input name="SampleDate(<%=rowcount%>)"   size = "10" value="<%=SampleDate(rowcount)%>">
		</td>
		<td align = "center">
			<input name="Average(<%=rowcount%>)"  size = "5" value="<%=Average(rowcount)%>">
		</td>
		<td  align = "center">
			<input name="StandardDev(<%=rowcount%>)"  size = "5" value="<%=StandardDev(rowcount)%>" >
		</td>
		<td  align = "center">
			<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="GreaterThan30(<%=rowcount%>)"  size = "5" value="<%=GreaterThan30(rowcount)%>" >
		</td>
		<td  align = "center">
			<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5">
		</td>
		<td  align = "center">
			<input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5">
		</td>
		<td  align = "center">
			<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5">
		</td>
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
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></div>
			</form>
		</td>

</tr>
</table>
 
<%rowcount = 0%>

<%
dim aID(300)
dim aName(300)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing%>
 <form action= 'AddFiberhandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
 <tr>
		<td colspan = "13" align = "center">
					<H2>Add a New Entry</H2>
		</td>
	</tr>
  <tr>
		<th  width = "100">&nbsp; Name&nbsp;</th>
		
		<th>Sample<br>Date</th>
		<th >AFD</th>
		<th >SD</th>
		<th>COV</th>
		<th >Fiber > 30</th>
		<th >CF</th>
		<th >Curve</th>
		<th >Blanket<br>Weight</th>
		<th >Total<br> Weight</th>
		<th >Length</th>
		<th >Crimp/<br>Inch</th>
	</tr>
	<tr onmouseover="this.className='highlighted';this.style.cursor='hand';" onmouseout="this.className='normal'">
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
				<td  align = "center" >
			<input name="SampleDate(<%=rowcount%>)"   size = "10">
		</td>
		<td align = "center">
			<input name="Average(<%=rowcount%>)"  size = "5">
		</td>
		<td  align = "center">
			<input name="StandardDev(<%=rowcount%>)"  size = "5" >
		</td>
		<td  align = "center">
			<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="GreaterThan30(<%=rowcount%>)"  size = "5">
		</td>
		<td  align = "center">
			<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5">
		</td>
		<td  align = "center">
			<input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5">
		</td>
		<td  align = "center">
			<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5">
		</td>
		<td  align = "center">
			<input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5">
		</td>
			</tr>
		</table>
		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			<tr>
				<td  valign = "middle">
					<img src = "images/underline.jpg">
					<div align = "center">
					<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></div>
			</form>
		</td>
</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>