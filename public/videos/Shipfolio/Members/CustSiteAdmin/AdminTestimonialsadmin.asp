<!DOCTYPE html>
<%@ Language=VBScript %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/administration/adminHeader.asp"--> 

<%
dim aID(40000)
dim aName(40000)
Dim TestimonialArray(1000)
Dim CustomerNameArray(1000)
Dim NameArray(1000)
Dim TestimonialsID(1000)
Dim URLArray(1000)
Dim TestimonialsTypeArray(1000)
Dim AnimalIDArray(1000)

 if mobiledevice = False then %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width =<%=screenwidth - 35 %>><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Testimonial</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%" valign = "top" >   
	<% Message=request.querystring("Message")
	if len(Message) > 3 then %>
	<font color = "brown"><%=Message%></font>
	<% end if %>



<%  
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

<form action= 'AdminTestimonialAdd.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="100%" align = "center">

	<tr>
		<td  class = "body2" align = "right" valign = "top"><b>Testimonial (Required):</b>&nbsp;</td>
		<td class = "body">
	<%
if screenwidth > 987 then
    fieldlength = 80
end if 
if screenwidth < 987 then
    fieldlength = 70
end if
if screenwidth < 769 then
    fieldlength = 60
end if
 if screenwidth < 601 then
    fieldlength = 50
end if

%>
				<textarea name="testimonial" cols="<%=fieldlength %>" rows="8" wrap="VIRTUAL" ></textarea>
		</td>
	</tr>
		<tr ><td class = "body2" align = "right"><b>Author:</b> &nbsp;<td><input name="Name" size = "<%=fieldlength %>"></td></tr>
	<tr ><td class = "body2" align = "right"><b>Business Name:</b> &nbsp;</td><td><input name="CustomerName" size = "<%=fieldlength %>"></td></tr>
	<tr ><td class = "body2" align = "right"><b>Website Link:</b> &nbsp;</td><td class="body">http://<input name="URL" size = "<%=fieldlength %>"></td></tr>
	<Tr><td class = "body2" align = "right"><b>Testimonial Type:</b> &nbsp;</td>
		<td class = "body2"><select name="Testimonialtype" >
		 <option value="Business">Business Testimonial (About Your Ranch):</option>
 		 <option value="Animal">Animal Testimonial (About One of Your Animals):</option>
		 </select>
		</td></tr>
  <tr>
	<td class = "body2" align = "right"><b>Animal Name (If Applicable):</b> &nbsp;</td>
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
			&nbsp; <input type=submit value="Submit"  Class= "regsubmit2 body" >
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width =<%=screenwidth - 35 %>><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">List of Existing Testimonials</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%" valign = "top" >   
<%

sql = "select * from testimonials "
'response.write ("Testimonials sql = " & sql & "<br>" )

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
rowcount = 1


Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no testimonials that are available to be edited.</b></font>
<% else %>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width="100%" align = "center">
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
		<td class = "body"><a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= NameArray(rowcount)%></a></td>
		<td class = "body"><a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= CustomerNameArray(rowcount)%></a></td>
		<td class = "body"><a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= TestimonialsTypeArray(rowcount)%></a></td>
		<td class = "body"><a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= Animalsname%></a></td>
		<td class = "body"> <a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>"><img src = "images/Edit.gif" width = "15" border = "0" alt = "Edit Class"></a>&nbsp;&nbsp;&nbsp; 
	      					<a href = "AdminTestimonialDelete.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>"><img src = "images/delete.jpg" width = "15" border = "0" alt = "Delete Class"></a>&nbsp;&nbsp;&nbsp;
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
<% else %>


<form action= 'AdminTestimonialAdd.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="<%=pagewidth %>" align = "center">
	<tr>
		<td Class = "body">
			<H2><div align = "left">Add a Testimonial</H2>

	<% Message=request.querystring("Message")
	if len(Message) > 3 then %>
	<font color = "brown"><%=Message%></font>
	<% end if %>



<%  


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

Testimonial (Required):<br />
	<textarea name="testimonial" cols="32" rows="8" wrap="VIRTUAL" ></textarea><br />
    <b>Author: </b><br />
    <input name="Name" size = "40"><br />
	 <b>Business Name: </b><br />
	<input name="CustomerName" size = "40"><br />
	 <b>Website Link: </b><br />
	http://<input name="URL" size = "30"><br />
	 <b>Testimonial Type: </b> <br />
    <select name="Testimonialtype" class = "regsubmit2 body">
		 <option value="Business">Business Testimonial (About Your Ranch)</option>
 		 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
		 </select><br />
		  <b>Animal Name (If Applicable):  </b><br />
			<select size="1" name="ID" class = "regsubmit2 body">
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

		<center><input type=submit value="Submit"  class = "regsubmit2 body" ></center>
		<br /><br />
		
			<H2><div align = "left">Existing Testimonials</H2>
			
<%

sql = "select * from testimonials "

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no testimonials that are available to be edited.</b></font>
<% else 
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
	<a href = "AdminTestimonialEdit.asp?TestimonialsID=<%=TestimonialsID(rowcount)%>" class="body"><%= NameArray(rowcount)%></a><br />
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

end if
%>

</td></tr></table>
<br /><br /><br />

<% end if %>
<br /><br />
  <!-- #include virtual="/administration/adminFooter.asp" -->
 </Body>
</HTML>