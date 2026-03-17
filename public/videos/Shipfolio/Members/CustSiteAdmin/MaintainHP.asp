<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Maintain Home Page Content</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">



<!--#Include virtual="/Administration/Header.asp"--> 




<%



			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Pages where PageId='Home'" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	



			%>

	<a name="News"></a>		
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Edit Your Latest News Text<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td valign = "top">
			 <form action= 'EditHPHandleForm.asp' method = "post">
			<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
				<tr>
				<td   valign = "top">
					 <input type = "hidden" name="Page"   value = "Home">
					<textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ><%=rs("HPText")%></textarea>
				</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "3" align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>











		<%



			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Pages where PageId='FA'" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
			currentID  = rs("AID")


			%>

			<%  
dim aID(40000)
dim aName(40000)

	
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

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
	

		
		

		sql2 = "select FullName from animals where ID = " & currentID

	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
		
		CurrentName = rs2("FullName")

		rs2.close
		set rs2=Nothing
		
		set conn = nothing



%>
			

		<a name="FA"></a>			
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Edit Your <b>Featured Alpaca</b><br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>
<form action= 'EditHPHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td>
					<b>Featured Alpaca:</b>
					<select size="1" name="ID">
					<option name = "AID0" value= "<%=CurrentID%>" selected><%=CurrentName%></option>
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
			  </tr>
		    </table>
<table>
	<tr>
		<td valign = "top">
			 
			<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
				<tr>
				<td   valign = "top">
							 <input type = "Hidden" name="Page"   value = "FA">
					<textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ><%=rs("HPText")%></textarea>
				</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "3" align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>



		<%



			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Pages where PageId='FP'" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	



			%>
<a name="FP"></a>		
			
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Edit Your <b>Featured Product</b> Text<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td valign = "top">
			 <form action= 'EditHPHandleForm.asp' method = "post">
			<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
				<tr>
				<td   valign = "top">
							 <input type = "Hidden" name="Page"   value = "FP">
					<textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ><%=rs("HPText")%></textarea>
				</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "3" align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>

</Body>
</HTML>