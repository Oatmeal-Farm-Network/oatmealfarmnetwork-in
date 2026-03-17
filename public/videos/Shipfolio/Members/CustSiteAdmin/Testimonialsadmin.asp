<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Add Testimonials</title>


<link rel="stylesheet" type="text/css" href="style.css">

</HEAD>
<body bgcolor = "#878554" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellpadding="0" >
<!--#Include virtual="/Administration/GlobalVariables.asp"--> 
<!--#Include virtual="/Administration/Header.asp"--> 

<form action= 'TestimonialsAdd.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">
	<tr>
		<td Class = "body">
			<H2><div align = "left">Add a Testimonial<br>
			<img src = "images/underline.jpg"></div></H2>
			Enter a testimonial and press the submit button.<br><br>
		</td>
	</tr>
	<TR><td class="body">
	<% Message=request.querystring("Message")
	if len(Message) > 3 then %>
	<font color = "brown"><%=Message%></font>
	<% end if %>
	</td></tr>
</table>


<%  
dim aID(40000)
dim aName(40000)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;"
						
'sql2 = "select Animals.ID, Animals.FullName from Animals where CustID = " & session("custid") & " order by Fullname "

sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname "
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

%>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">

	<tr>
		<td  class = "body" align = "right" valign = "top">Testimonial (Required):&nbsp;</td>
		<td class = "body">
				<textarea name="testimonial" cols="63" rows="8" wrap="VIRTUAL" ></textarea>
		</td>
	</tr>
		<tr ><td class = "body" align = "right">Author: &nbsp;<td><input name="Name" size = "70"></td></tr>
	<tr ><td class = "body" align = "right">Business Name: &nbsp;</td><td><input name="CustomerName" size = "70"></td></tr>
	<tr ><td class = "body" align = "right">Website Link: &nbsp;</td><td class="body">http://<input name="URL" size = "70"></td></tr>
	<Tr><td class = "body" align = "right">Testimonial Type: &nbsp;</td>
		<td class = "body"><select name="Testimonialtype" >
		 <option value="Business">Business Testimonial (About Your Ranch)</option>
 		 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
		 </select>
		</td></tr>
  <tr>
	<td class = "body" align = "right">Animal Name (If Applicable): &nbsp;</td>
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
</tr>
	<tr>
		<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px"  Class = "menu" >
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">
	<tr>
		<td Class = "body">
			<H2><div align = "left">Existing Testimonials<br>
			<img src = "images/underline.jpg"></div></H2><br>
		</td>
	</tr>
	<tr>	
		<td class= "body">
			<div align = "left"><b>To edit a testimonial click on the edit button under actions or any of the blue links below, or to delete a testimonial click on the X under actions.</b><br></div><br> 
		</td>
	</tr>
</table>
<%

sql = "select * from testimonials "
'response.write ("Testimonials sql = " & sql & "<br>" )

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
rowcount = 1
Dim TestimonialArray(1000)
Dim CustomerNameArray(1000)
Dim NameArray(1000)
Dim TestimonialsID(1000)
Dim URLArray(1000)
Dim TestimonialsTypeArray(1000)
Dim AnimalIDArray(1000)

Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no testimonials that are available to be edited.</b></font>
<% else %>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width="780" align = "center">
	<tr>
		<th class="body" width = "200" align = "center"><b>Author</b></th>
		<th class="body" width = "150" align = "center"><b>Business</b></th>
		<th class="body" width = "100" align = "center"><b>Type</b></th>
		<th class="body" width = "200" align = "center"><b>Animal Name</b></th>
		<th class="body" align = "center"><b>Actions</b></th>

	</tr>
<%
 While  Not rs.eof     
	 TestimonialsID(rowcount) =   rs("TestimonialsID")
	 CustomerNameArray(rowcount) =   rs("CustomerName")
	 NameArray(rowcount) 		 =   rs("Name")
	 TestimonialArray(rowcount)  =   rs("Testimonial")
	 URLArray(rowcount)			 =   rs("URL")
	 AnimalIDArray(rowcount) 	 =   rs("AnimalID")
	 TestimonialsTypeArray(rowcount) = rs("TestimonialsType") 
	 
	 'response.write(" AnimalIDArray(rowcount) = " & AnimalIDArray(rowcount) & "<br>")
	
	 if AnimalIDArray(rowcount) > 0  then
	 	sql2 = "select FullName from Animals where ID = " & AnimalIDArray(rowcount) 
	 	'response.write("sql2=" & sql2 & "!!!" )
	 	
		acounter = 1
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		rs2.Open sql2, conn, 3, 3 
		if not rs2.eof then
			Animalsname=rs2("FullName")
	 	end if 
	 	rs2.close
	 	
	 else
	 	   Animalsname = "N/A"
	 
	 end if
	 
	%>
	<tr >
		<td class = "body"><a href = "TestimonialsEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= NameArray(rowcount)%></a></td>
		<td class = "body"><a href = "TestimonialsEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= CustomerNameArray(rowcount)%></a></td>
		<td class = "body"><a href = "TestimonialsEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= TestimonialsTypeArray(rowcount)%></a></td>
		<td class = "body"><a href = "TestimonialsEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= Animalsname%></a></td>
		<td class = "body"> <a href = "TestimonialsEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>"><img src = "images/Edit.gif" width = "15" border = "0" alt = "Edit Class"></a>&nbsp;&nbsp;&nbsp; 
	      					<a href = "TestimonialsDelete.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>"><img src = "images/delete.jpg" width = "15" border = "0" alt = "Delete Class"></a>&nbsp;&nbsp;&nbsp;
 		</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

end if
%>
</table>
<br><br><br><br>

</td></tr></table>
<% 'set rs=nothing %>
<!--#Include virtual="/administration/Footer.asp"-->
</body>
</html>