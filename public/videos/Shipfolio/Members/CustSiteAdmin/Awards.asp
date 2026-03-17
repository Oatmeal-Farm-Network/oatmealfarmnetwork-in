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
		<td Class = "body">
			<H2>Edit Award Information<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Awards.* from Animals, Awards where Animals.ID = Awards.ID order by fullname"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(300)
	dim AwardsID(300)
	dim FullName(300)
	dim Show(300)
	dim Placing(300)
	dim AClass(300)
	dim Judge(300)
	dim ClassSize(300)
	dim ShowLevel(300)
	dim ShowYear(300)
	dim AwardType(300)

Recordcount = rs.RecordCount +1
%>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr>
		<th >Animal</th>
		<th >Show</th>
		<th >Placing</th>
			<th >Class</th>
		<th >Class<br>Size</th>		
		<th >Judge</th>
	</tr>


	
<%
 While  Not rs.eof         
	 ID(rowcount) =   rs("ID")
	 FullName(rowcount) =   rs("FullName")
	 AwardsID(rowcount) =   rs("AwardsID")
	 Show(rowcount) =   rs("Show")
	 Placing(rowcount) =   rs("Placing")
	 AClass(rowcount) =   rs("Class")
	 Judge(rowcount) =  rs("Judge")
	 ClassSize(rowcount) =  rs("ClassSize")
	%>

	<form action= 'Awardsedithandleform.asp' method = "post">

	<tr >
		<td>
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%= AwardsID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
			<%=FullName(rowcount)%>
		</td>
		<td>
			<input name="Show(<%=rowcount%>)" value= "<%= Show(rowcount)%>" >
		</td>
		<td >
			<input name="Placing(<%=rowcount%>)" value= "<%= Placing(rowcount)%>" size = "6">
		</td>
		<td >
			<input name="AClass(<%=rowcount%>)" value="<%= AClass( rowcount)%>" >
		</td>
		<td >
			<input name="ClassSize(<%=rowcount%>)" value="<%=  ClassSize( rowcount)%>" size = "5">
		</td>
		<td >
			<input name="Judge(<%=rowcount%>)" value="<%= Judge( rowcount)%>" size = "15">
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
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" ></div>
			</form>
		</td>

</tr>
</table>
 
<%rowcount = 0%>

<%
dim aID(300)
dim aName(300)



	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ID, FullName from Animals order by fullname"

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
 <form action= 'AddAwardshandleform.asp' method = "post">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Add a New Entry</H2>
		</td>
	</tr>
  <tr>
		<th >Name</th>
		<th >Show</th>
		<th >Placing</th>
		<th >Class</th>
		<th >Class<br>Size</th>		
		<th >Judge</th>
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
				<td  align = "center" >
					<input name="Show(<%=rowcount%>)" value= "<%= Show(rowcount)%>" >
				</td>
				<td  align = "center">
					<input name="Placing(<%=rowcount%>)" value= "<%= Placing(rowcount)%>" size = "6">
				</td>
				<td  align = "center">
					<input name="AClass(<%=rowcount%>)" value="<%= AClass( rowcount)%>" size = "12">
				</td>
				<td  align = "center">
					<input name="ClassSize(<%=rowcount%>)" value="<%= ClassSize( rowcount)%>" size = "5">
				</td>

				<td  align = "center">
					<input name="Judge(<%=rowcount%>)" value="<%= Judge( rowcount)%>" size = "15">
				</td>
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" ></div>
			</form>
		</td>

</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>