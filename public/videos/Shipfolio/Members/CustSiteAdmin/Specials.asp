<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit GyuroStyle Auctions Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

<%	

dim dID(1400)
dim dName(1400)
dim dPhotoID(1400)
dim	dImage(1400)
dim	dImageOrder(1400)
dim	dImageTitle(1400)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
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
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
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

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2>Edit GyuroStyle Auction Information<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<form action= 'ActiveSaleHandleForm.asp' method = "post">
			<input type = "hidden" name="Special" value= "GyroStyle" >
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsLookupTable where special = 'GyroStyle'"
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
</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
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
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsHeader where FieldID = 1"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Title = rs("FieldContent")
%>
			<form action= 'AddSpecialsContent.asp' method = "post">
	<tr>
		<td>
            <h2>Title:</h2>
			<textarea name="Title" cols="90" rows="2" wrap="VIRTUAL" ><%=Title%></textarea>

		</td>
	</tr>
<%
 sql = "select * from SpecialsHeader where FieldID = 0"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text = rs("FieldContent")
%>

	<tr>
		<td>
		 <h2>Text:</h2>
            <textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ><%=Text%></textarea>

		</td>
	</tr>

<%
 sql = "select * from SpecialsHeader where FieldID = 3"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

ContestAnimalID = rs("FieldContent")
%>
<%
If Len(ContestAnimalID) =0 Then
	sql = "select * from SpecialsHeader where FieldID = 4"
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
	
	If Not rs.eof Then
		ContestAnimalname = rs("FieldContent")	
	sql = "select ID from animals where Fullname='" & ContestAnimalname & "';"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
		 sql = "select ID from animals where FullName='" & ContestAnimalname & "';"
	    Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3   
		ContestAnimalID = rs("ID")
	End if
End if
 sql = "select Fullname from animals where ID=" & ContestAnimalID & ";"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

ContestAnimalname = rs("Fullname")
%>
	
<tr>
		<td><h2>Contest Animal:</h2>
<select size="1" name="ContestAnimalID">
					<option name = "AID0" value= "<%=ContestAnimalID%>" selected><%=ContestAnimalname%></option>
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

					<br><br>
					<center><input type=Submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></center>
				</td>
			  </tr>
		    </table>
			<br><br>
		  </form>
		</td>
	</tr>
	




</table>




<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Specials.* from Animals, Specials where Animals.ID = Specials.ID order by Animals.FullName, Week"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(200)
	dim SpecialID(200)
	dim FullName(200)
	dim Price(200)
	dim Week(200)
	dim Pending(200)
	

Recordcount = rs.RecordCount +1
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
 <tr>
		<td colspan = "5" align = "center">
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr>
		<th width = "190">&nbsp;Alpaca's Name&nbsp;</th>
		
		<th >&nbsp;Week&nbsp;</th>
			
		<th >&nbsp;Price&nbsp;</th>
			
		<th >&nbsp;Sale Pending&nbsp;</th>
			
	
	</tr>


	
<%

 While  Not rs.eof         
	 ID(rowcount) =   rs("ID")
	 SpecialID(rowcount) =   rs("SpecialID")
	 FullName(rowcount) =   rs("FullName")
	 Price(rowcount) =   rs("Price")
	 Week(rowcount) =   rs("Week")
	 Pending(rowcount) =   rs("SalePending")
%>


	<form action= 'Specialsedithandleform.asp' method = "post">
	
	
	<tr >
		<td>
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="SpecialsID(<%=rowcount%>)" value= "<%= SpecialID( rowcount)%>" >
			
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
			<%=FullName(rowcount)%>
					
		</td>
		<td   >
			<input name="Week(<%=rowcount%>)" value= "<%= Week(rowcount)%>" >
		</td>
		<td >
			<input name="Price(<%=rowcount%>)" value= "<%= Price(rowcount)%>" >
		</td>
		<td>
		<table>
		<tr>
		<td >
			<%if Pending(rowcount) = "True" then %>
		<td nowrap>True<input TYPE="RADIO" name="Pending(<%=rowcount%>)" Value = "True" checked>
		False<input TYPE="RADIO" name="Pending(<%=rowcount%>)" Value = "False" ></td>
	<% else %>
		<td nowrap>True<input TYPE="RADIO" name="Pending(<%=rowcount%>)" Value = "True" >
		False<input TYPE="RADIO" name="Pending(<%=rowcount%>)" Value = "False" checked></td>
	<%end if%>
			
		
		</td>
		</tr>
		</table>
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
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>
 

 <form action= 'AddSpecialshandleform.asp' method = "post">
  <table>
 <tr>
		<td colspan = "6" align = "center">
					<H2>Add a New Animal/Week</H2>
		</td>
	</tr>
  <tr>
		<th nowrap id="F1">&nbsp;Alpaca's Name&nbsp;</th>
		
		<th nowrap id="F1">&nbsp;Week&nbsp;</th>
			
		<th nowrap id="F2">&nbsp;Price&nbsp;</th>
			
		
							
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
				<td width = "90" align = "center" >
			<input name="Week" value= "" >
		</td>
		<td width = "90" align = "center">
			<input name="Price" value= ""   >
		</td>
	
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>

<%
	dim bID(200)
dim bName(200)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select distinct Specials.ID, FullName from Animals, Specials where Animals.ID = Specials.ID order by Animals.FullName "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	bcounter = 1
	While Not rs.eof  
		bID(bcounter) = rs("ID")
		bName(bcounter) = rs("FullName")
		'response.write (SSName(studcounter))

		bcounter = bcounter +1
		rs.movenext
	Wend		
	
	
	rs.close
		set rs=nothing
		set conn = nothing%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	 <tr>
		<td colspan = "6" align = "center">
					<H2>Delete an Entry</H2>
		</td>
	</tr><tr>
		<td>
			
			<form action= 'DeleteSpecialshandleform.asp' method = "post">
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
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
</BODY>
</HTML>