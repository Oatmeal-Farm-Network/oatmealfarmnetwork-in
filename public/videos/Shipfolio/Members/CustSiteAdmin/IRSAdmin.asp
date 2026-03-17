<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit IRS Sale Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/Administration/globalvariables.asp"--> 
<%	
dim dID(1400)
dim dName(1400)
dim dPhotoID(1400)
Dim dImage(1400)
Dim dImageOrder(1400)
Dim dImageTitle(1400)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" 
	sqld = "select Animals.ID, Animals.FullName, AdditionalPhotos.* from Animals, AdditionalPhotos where Animals.ID = AdditionalPhotos.ID ORDER by Animals.FullName ASC"

	dcounter = 1
	Set rsd = Server.CreateObject("ADODB.Recordset")
	rsd.Open sqld, conn, 3, 3 
	While Not rsd.eof  
		dID(dcounter) = rsd("AdditionalPhotos.ID")
		dName(dcounter) = rsd("FullName")
		dPhotoID(dcounter) = rsd("PhotoID")
		dImage(dcounter) = rsd("Image")
		dImageOrder(dcounter) = rsd("PhotoOrder")
		dImageTitle(dcounter) = rsd("ImageTitle")
		'response.write (rsd("AdditionalPhotos.ID"))

		dcounter = dcounter +1
		rsd.movenext
	Wend		
	
		rsd.close
		set rsd=nothing
		set conn = nothing



%>

<%rowcount = 0%>

<%
dim aID(200)
dim aName(200)



	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ID, FullName from Animals order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	While Not rs.eof  
		aID(acounter) = rs("ID")
		aName(acounter) = rs("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2>Edit I.R.S Sale Information<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<form action= 'ActiveSaleHandleForm.asp' method = "post">
			<input type = "hidden" name="Special" value= "IRS" >
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsLookupTable where special = 'IRS'"
  Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 

%>
<b>There currently is a sale :
<%if rs("Active") = True then %>
		True<input TYPE="RADIO" name="Active" Value = "True" checked>
		False<input TYPE="RADIO" name="Active" Value = "False" >
	<% else %>
		True<input TYPE="RADIO" name="Active" Value = "True" >
		False<input TYPE="RADIO" name="Active" Value = "False" checked>
	<%end if%>
</b>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
		
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>

<table>
<%
	dim DFileName(1400)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from IRSHeader where FieldID = 1"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Title = rs("FieldContent")
%>
			<form action= 'AddIRSContent.asp' method = "post">
<%
 sql = "select * from IRSHeader where FieldID = 2"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text2 = rs("FieldContent")
%>

	<tr>
		<td>
		 <h2>Heading</h2>
		 	<img src = "images/underline.jpg">
            <textarea name="Text2" cols="90" rows="8" wrap="VIRTUAL" ><%=Text2%></textarea>

		</td>
	</tr>
	

<%
 sql = "select * from IRSHeader where FieldID = 0"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text = rs("FieldContent")
%>

	

	
<tr>
		<td>

					<center><input type=Submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></center>
				</td>
			  </tr>
		    </table>
			<br><br>
		  </form>






 <form action= 'AddIRShandleform.asp' method = "post">
  <table>
 <tr>
		<td colspan = "6" align = "center">
					<H2>Add a New Animal</H2>	<img src = "images/underline.jpg">
		</td>
	</tr>
  <tr>
		<th >&nbsp;Alpaca's Name&nbsp;</th>
	
							
	</tr>
	<tr >
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
				<td width = "110" align = "center" >

		</td>
		<td width = "110" align = "center">

		</td>
	<td >

		</td>
		<td >

		</td>
		<td >

		</td>
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">

			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>






<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
		<td   class = "body">
<h2>Animals Currently Selected</h2><img src = "images/underline.jpg"><br>	

<%
	dim bID(200)
dim bName(200)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select distinct IRS.animalID, animals.FullName from Animals, IRS where Animals.ID = IRS.animalID order by Animals.FullName "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	bcounter = 1
	While Not rs.eof  
		bID(bcounter) = rs("animalID")
		bName(bcounter) = rs("FullName")%>
&nbsp; <%=bName(bcounter)%><br>
<%		'response.write (SSName(studcounter))

		bcounter = bcounter +1
		rs.movenext
	Wend		
	
	
	rs.close
		set rs=nothing
		set conn = nothing%>
</td>
</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	 <tr>
		<td colspan = "6" align = "center">
				<br><br>	<H2>Remove an Entry<br><img src = "images/underline.jpg"></H2>	
		</td>
	</tr><tr>
		<td>
			
			<form action= 'RemoveIRShandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < bcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=bID(count)%>">
							<%=bName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Remove" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br><br>
<!--#Include virtual="/Administration/Footer.asp"-->
</BODY>
</HTML>