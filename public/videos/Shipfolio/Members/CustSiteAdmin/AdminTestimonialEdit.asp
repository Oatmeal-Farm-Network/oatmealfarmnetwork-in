<!DOCTYPE html>
<%@ Language=VBScript %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<body >
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include virtual="/administration/adminHeader.asp"--> 


<% TestimonialsID=request.querystring("TestimonialsID") 

dim aID(40000)
dim aName(40000)

if mobiledevice = False then
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width =<%=screenwidth - 35 %>><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Testimonial</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%" valign = "top" >   
<% Message=request.querystring("Message")
	if len(Message) > 3 then %>
	<font color = "brown"><%=Message%></font>
	<% end if %>

<form action= 'AdminTestimonialUpdate.asp' method = "post">


<%  
sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname "
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (aName(acounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
Totalanimals= acounter- 1



sql = "select * from testimonials where TestimonialsID= " & TestimonialsID
'response.write ("sql = " & sql & "<br>" )

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
 if not rs.eof  then     
	 TestimonialsID =   rs("TestimonialsID")
	 CustomerName =   rs("CustomerName")
	 Name =   rs("Name")
	 Testimonial =   rs("Testimonial")
	 URL =   rs("URL")
	 AnimalID =   rs("AnimalID")
	 TestimonialsType = rs("TestimonialsType")
end if
rs.close

if AnimalID > 0 then
	 
	 	sql2 = "select FullName from Animals where ID = " & AnimalID
		acounter = 1
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		rs2.Open sql2, conn, 3, 3 
		if not rs2.eof then
			Animalsname=rs2("FullName")
	 	end if 
	 	rs2.close
	 	
	 end if

if screenwidth > 987 then
    fieldlength = 80
     fieldlength2 = 60
end if 
if screenwidth < 987 then
    fieldlength = 70
      fieldlength2 = 60
end if
if screenwidth < 769 then
    fieldlength = 60
      fieldlength2 = 50
end if
 if screenwidth < 601 then
    fieldlength = 50
      fieldlength2 = 40
end if

%>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="100%" align = "center">

	<tr>
		<td  class = "body2" align = "right" valign = "top"><b>Testimonial (Required):</b></b>&nbsp;</td>
		<td class = "body">
				<textarea name="testimonial" cols="<%=fieldlength2 %>" rows="8" wrap="VIRTUAL" ><%=Testimonial%></textarea>
		</td>
	</tr>
		<tr ><td class = "body2" align = "right"><b>Author:</b> &nbsp;<td><input name="Name" size = "<%=fieldlength %>" value = "<%=Name%>"></td></tr>
	<tr ><td class = "body2" align = "right"><b>Business Name:</b> &nbsp;</td><td><input name="CustomerName" size = "<%=fieldlength %>" value="<%=CustomerName%>"></td></tr>
	<tr ><td class = "body2" align = "right"><b>Website Link:</b> &nbsp;</td><td><input name="URL" size = "<%=fieldlength %>" value = "<%=URL%>"></td></tr>
	<Tr><td class = "body2" align = "right"><b>Testimonial Type: </b>&nbsp;</td>
		<td class = "body"><select name="TestimonialsType" >
		 <%if TestimonialsType = "Animal" then%>
		 	 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
		 	 <option value="Business">Business Testimonial (About Your Ranch)</option>
         <%else %>
		 	 <option value="Business">Business Testimonial (About Your Ranch)</option>
		 	 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
         <%end if%>
		 </select>
		</td></tr>
  <tr>
	<td class = "body2" align = "right"><b>Animal Name (If Applicable):</b> &nbsp;</td>
				 <td class = "body">
					<select size="1" name="ID">
					<option name = "AID0" value= "<%=AnimalID %>" selected><%=Animalsname%></option>
					<% count = 1	
						while count < Totalanimals						
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
		<input name="TestimonialsID" type = "hidden" value="<%=TestimonialsID%>">
			&nbsp; <input type=submit value = "Submit Changes" Class = "regsubmit2 body" >
		</td>
	</tr>
<tr><td class = "body" colspan = "2" align = "center"><br><br><a href="AdminTestimonialsadmin.asp"  class="body">Return to the Add Testimonials page</a>
<br><br>
</td></tr>
</table>
</form>
</td></tr></table>
<% else %>


<table width = "<%=pagewidth %>" cellpadding = "0" cellspacing = "0">
<tr><td class = "body">
<form action= 'AdminTestimonialUpdate.asp' method = "post">
<H1><div align = "left">Edit Testimonial</H1>

	<% Message=request.querystring("Message")
	if len(Message) > 3 then %>
	<font color = "brown"><%=Message%></font><br />
	<% end if 
	
sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname "
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (aName(acounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
Totalanimals= acounter- 1

sql = "select * from testimonials where TestimonialsID= " & TestimonialsID
'response.write ("sql = " & sql & "<br>" )

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
 if not rs.eof  then     
	 TestimonialsID =   rs("TestimonialsID")
	 CustomerName =   rs("CustomerName")
	 Name =   rs("Name")
	 Testimonial =   rs("Testimonial")
	 URL =   rs("URL")
	 AnimalID =   rs("AnimalID")
	 TestimonialsType = rs("TestimonialsType")
end if
rs.close

if AnimalID > 0 then
	 
	 	sql2 = "select FullName from Animals where ID = " & AnimalID
		acounter = 1
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		rs2.Open sql2, conn, 3, 3 
		if not rs2.eof then
			Animalsname=rs2("FullName")
	 	end if 
	 	rs2.close
	 	
	 end if

'response.write("sql2=" & sql2 )

%>

<b>Testimonial (Required):</b><br />
<textarea name="testimonial" cols="40" rows="8" wrap="VIRTUAL" class="body"><%=Testimonial%></textarea><br />
Author: <br />
<input name="Name" size = "40" value = "<%=Name%>" class="regsubmit2 body"><br />
Business Name: <br />
<input name="CustomerName" size = "40" value="<%=CustomerName%>" class="regsubmit2 body"><br />
Website Link:<br />
	<input name="URL" size = "40" value = "<%=URL%>" class="regsubmit2 body"><br />
Testimonial Type: <br />
<select name="TestimonialsType" class="regsubmit2 body">
		 <%if TestimonialsType = "Animal" then%>
		 	 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
		 	 <option value="Business">Business Testimonial (About Your Ranch)</option>
         <%else %>
		 	 <option value="Business">Business Testimonial (About Your Ranch)</option>
		 	 <option value="Animal">Animal Testimonial(About One of Your Animals)</option>
         <%end if%>
		 </select>
		<br />
		Animal Name (If Applicable): <br />
					<select size="1" name="ID" class="regsubmit2 body">
					<option name = "AID0" value= "<%=AnimalID %>" selected><%=Animalsname%></option>
					<% count = 1	
						while count < Totalanimals						
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<br />
		<input name="TestimonialsID" type = "hidden" value="<%=TestimonialsID%>">
<center><input type=submit value = "Submit Changes" Class = "regsubmit2 body" ></center>
<br><br><a href="AdminTestimonialsadmin.asp"  class="body">Return to the Add Testimonials Page</a>

</td></tr></table>


<% end if %>
<br /><br />
<!--#Include file="adminFooter.asp"-->
</body>
</html>