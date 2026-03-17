<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include File="AdminSecurityInclude.asp"--> 
<!--#Include File="AdminGlobalVariables.asp"--> 
<!--#Include File="AdminHeader.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td Class = "body roundedtopandbottom">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td align = "left">
	<tr>
		<td Class = "body"colspan = "2">
			<H1>Edit Godfather Sale Information</H1>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
<%

 sql = "select Animals.FullName, Godfather.* from Animals, Godfather where Animals.ID = Godfather.ID order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(400)
	dim SpecialID(400)
	dim FullName(400)
	dim EndDate(400)
	dim Pending(400)
	dim SalesText(400)
	

Recordcount = rs.RecordCount +1
%>
 <tr>
		<td colspan = "5" align = "center">
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr>
		<th width = "190">&nbsp;Alpaca's Name&nbsp;</th>
		
		<th >&nbsp;End Date&nbsp;</th>
			
					
		<th >&nbsp;Sale Pending&nbsp;</th>
			
	
	</tr>


	
<%

 While  Not rs.eof         
	 ID(rowcount) =   rs("ID")
	 SpecialID(rowcount) =   rs("SpecialID")
	 FullName(rowcount) =   rs("FullName")
	 EndDate(rowcount) =   rs("EndDate")
	 Pending(rowcount) =   rs("SalePending")
	 SalesText(rowcount) =   rs("SalesText")
	
%>


	<form action= 'Godfatheredithandleform.asp' method = "post">
	
	
	<tr >
		<td>
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="GodfatherID(<%=rowcount%>)" value= "<%= SpecialID( rowcount)%>" >
			
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" AClass="InputBlur" >
			<%=FullName(rowcount)%>
					
		</td>
		<td   >
			<input name="EndDate(<%=rowcount%>)" value= "<%= EndDate(rowcount)%>" >
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
		<td>
				<textarea name="SalesText(<%=rowcount%>)" cols="53" rows="8" wrap="VIRTUAL" ><%= SalesText(rowcount)%></textarea>
		</td>
		
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
		<td  valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes"  Class = "Regsubmit2" ></center>
			</form>
		</td>

</tr>
</table>
 
<%rowcount = 0%>

<%
dim aID(400)
dim aName(400)



	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
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
 <form action= 'AddGodfatherhandleform.asp' method = "post">
  <table>
 <tr>
		<td colspan = "6" align = "center">
					<H2>Add a New Entry</H2>
		</td>
	</tr>
  <tr>
		<th nowrap id="F1">&nbsp;Alpaca's Name&nbsp;</th>
		
		<th nowrap id="F1">&nbsp;EndDate&nbsp;</th>
			
			
		
							
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
				<td width = "90" align = "center" >
			<input name="EndDate(<%=rowcount%>)" value= "<%= EndDate(rowcount)%>" >
		</td>
			
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes"  Class = "Regsubmit2" ></center>
			</form>
		</td>

</tr>
</table>

<%
	dim bID(400)
dim bName(400)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select distinct Godfather.ID, FullName from Animals, Godfather where Animals.ID = Godfather.ID order by Animals.FullName "

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
			
			<form action= 'DeleteGodfatherhandleform.asp' method = "post">
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
			<center><input type=submit value = "Submit Changes"  Class = "Regsubmit2" ></center>
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
  <!--#Include File="AdminFooter.asp"--></Body>
</HTML>