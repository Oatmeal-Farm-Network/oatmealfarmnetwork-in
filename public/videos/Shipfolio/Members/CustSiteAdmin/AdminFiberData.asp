<!DOCTYPE HTML>
<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<!--#Include File="Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Edit Fiber Data<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H1>Add a New Animal Wizard</H1>
			Enter up to 10 years worth of fiber results.
			<img src = "images/line.jpg">
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
	<tr>
		<td class = "body">
			<h2><font color = "brown">Step 3: Fiber</font> <small></small></h2><br>
		</td>
	</tr>
	</table>
<form action= 'AddFiberhandleForm.asp' method = "post">
<input type = "hidden" name="ID" value= "<%= ID%>" >
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
 <tr>
	</tr>
  <tr>
<th>Sample<br>Date</th>
		<th >AFD</th>
		<th >SD</th>
		<th>COV</th>
		<th >Fiber > 30</th>
		<th >Blanket<br>Weight</th>
		<th >Shear<br> Weight</th>
	</tr>

	<% For count = 1 To 10 %>
	<tr  >
		<td  align = "center" >
			<input name="SampleDate(<%=count%>)"   size = "10">
		</td>
		<td align = "center">
			<input name="Average(<%=count%>)"  size = "5">
		</td>
		<td  align = "center">
			<input name="StandardDev(<%=count%>)"  size = "5" >
		</td>
		<td  align = "center">
			<input name="COV(<%=count%>)" value=""  size = "5">
		</td>
		<td  align = "center">
			<input name="GreaterThan30(<%=count%>)"  size = "5">
		</td>
		<td  align = "center">
			<input name="BlanketWeight(<%=count%>)" value=""   size = "5">
		</td>
		<td  align = "center">
			<input name="ShearWeight(<%=count%>)" value=""  size = "5">
		</td>
			</tr>
	<% Next %>
		</table>
		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			<tr>
				<td  valign = "middle">
					<img src = "images/underline.jpg">
					<div align = "center">
					<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<input type=submit value = "Submit Changes" size = "110" class = "Submit" >
			</form>
		</td>
</tr>
</table>
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(40000)
	dim FiberID(40000)
	dim FullName(40000)
	dim SampleAge(40000)
	dim SampleDate(40000)
	dim Average(40000)
	dim StandardDev(40000)
	dim COV(40000)
	dim GreaterThan30(40000)
	dim CF(40000)
	dim Curve(40000)
	dim ShearWeight(40000)
	dim BlanketWeight(40000)
	dim Length(40000)
	dim CrimpPerInch(40000)

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
		
		<th>Sample<br>Year</th>
		<th>Age </th>
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

	 FiberID(rowcount) =   rs("FiberID")
	 FullName(rowcount) =   rs("FullName")
	 SampleDate(rowcount) =   rs("SampleDate")


	 SampleAge(rowcount) =   rs("SampleAge")
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
			<input name="SampleDate(<%=rowcount%>)"   size = "10" value="<%=SampleDate(rowcount)%>">
		</td>
		<td  align = "center" >
			<input name="SampleAge(<%=rowcount%>)"   size = "10" value="<%=SampleAge(rowcount)%>">
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
			
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<div align = "center"><input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></div>
			</form>
		</td>

</tr>
</table>
 
<%rowcount = 0%>

<%
dim aID(40000)
dim aName(40000)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals "

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
		<th>Age </th>
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
	<tr  >
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
		<td  align = "center" >
			<input name="SampleAge(<%=rowcount%>)"   size = "10">
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
					<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
<!--#Include File="Footer.asp"--> </Body>
</HTML>