<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Packages Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 


<form action= 'AddaPackage.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Add a Package<br>
			<img src = "images/underline.jpg"></div></H2>
			Enter a name of the package and press the submit button.<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr >
		<th>New Package Name</th>
		<th>Price</th>
		<th>Order</th>
	</tr>
	<tr>
		<td >
			<input name="PackageName" size = "70">
		</td>
		<td >
			&nbsp; <input name="Price" size = "6">&nbsp; 
		</td>
		<td >
			   <select size="1" name="PackageOrder">
					<option  value= "1" selected>1</option>
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
		</tr>
			<td colspan = "3">
				<textarea name="Description" cols="73" rows="8" wrap="VIRTUAL" ></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px"  Class = "menu" >
		</td>
	</tr>
</table>
</form>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Edit an Existing Package<br>
			<img src = "images/underline.jpg"></div></H2>
			To make changes edit your data and press the submit button.<br><br>
		</td>
	</tr>
</table>
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim PackageID(200)
	dim PackageName(200)
	Dim PackageOrder(200)
	dim PackagePrice(200)
	dim Description(200)

Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be edited.</b></font>
<% else %>

<form action= 'Packagesedithandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<th>Package Name</th>
		<th>Price</th>
		<th></th>
	</tr>
<%
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	  PackageOrder(rowcount) =   rs("PackageOrder")
	 PackagePrice(rowcount) =   rs("Price")
	 Description(rowcount) =   rs("Description")
%>
	<tr >
		<td>
			<input type = "hidden" name="PackageID(<%=rowcount%>)" value= "<%=PackageID(rowcount)%>" >
			<input name="PackageName(<%=rowcount%>)" value= "<%= PackageName(rowcount)%>" size = "70">&nbsp;
		</td>
		<td >
			&nbsp;<input name="PackagePrice(<%=rowcount%>)" value= "<%= PackagePrice(rowcount)%>" size = "6">&nbsp;
		</td>
		<td >
			   <select size="1" name="PackageOrder(<%=rowcount%>)">
					<option  value= "<%= PackageOrder(rowcount)%>" selected><%= PackageOrder(rowcount)%></option>
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
		</tr>
		</tr>
			<td colspan = "3">
				<textarea name="Description(<%=rowcount%>)" cols="73" rows="8" wrap="VIRTUAL" ><%= Description(rowcount)%></textarea>
			</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
%>
</tr>
			<td colspan = "2">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
	</tr>
</table>
<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
</form>
<% end if%>

<br>
<%
dim pID(200)
dim pName(200)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	While Not rs.eof  
		pID(pcounter) = rs("PackageID")
		pName(pcounter) = rs("PackageName")
		'response.write (SSName(studcounter))

		pcounter = pcounter +1
		rs.movenext
	Wend		
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Delete a Package<br>
			<img src = "images/underline.jpg"></div></H2>
			To delete a package select the package and press the submit button.<br><br>
		</td>
	</tr>
</table>
<% if pcounter = 1  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be deleted.</b></font>
<% else %>

<form action= 'DeletePackages.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<td class = "body">
		  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td class = "body">Package Name</td>
					<th></th>
			   </tr>
			    <tr>
				 <td>
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < pcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
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

<% end if 
	   rs.close
	   set rs=nothing
	   set conn = nothing%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Adding Animals to a Package<br>
			<img src = "images/underline.jpg"></div></H2>
			To add animals to a package use the <a href = "GeneralData.asp" class = "target">General Information Page</a>.<br><br>
		</td>
	</tr>
</table>

 


</BODY>
</HTML>