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


<% TestimonialsID=request.querystring("TestimonialsID") 
	'response.write("TestimonialsID=" & TestimonialsID )
%>
<form action= 'TestimonialsUpdate.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">
	<tr>
		<td Class = "body">
			<H2><div align = "left">Edit Testimonial<br>
			<img src = "images/underline.jpg"></div></H2>
			make changes to your testimonial and press the submit button.<br><br>
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

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;"

 
dim aID(40000)
dim aName(40000)

'sql2 = "select Animals.ID, Animals.FullName from Animals where CustID = " & session("custid") & " order by Fullname "

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


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">

	<tr>
		<td  class = "body" align = "right" valign = "top">Testimonial (Required):&nbsp;</td>
		<td class = "body">
				<textarea name="testimonial" cols="63" rows="8" wrap="VIRTUAL" ><%=Testimonial%></textarea>
		</td>
	</tr>
		<tr ><td class = "body" align = "right">Author: &nbsp;<td><input name="Name" size = "70" value = "<%=Name%>"></td></tr>
	<tr ><td class = "body" align = "right">Business Name: &nbsp;</td><td><input name="CustomerName" size = "70" value="<%=CustomerName%>"></td></tr>
	<tr ><td class = "body" align = "right">Website Link: &nbsp;</td><td><input name="URL" size = "70" value = "<%=URL%>"></td></tr>
	<Tr><td class = "body" align = "right">Testimonial Type: &nbsp;</td>
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
	<td class = "body" align = "right">Animal Name (If Applicable): &nbsp;</td>
				 <td>
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
			&nbsp; <input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px"  Class = "menu" >
		</td>
	</tr>
<tr><td class = "body" colspan = "2" align = "center"><br><br><a href="testimonialsadmin.asp"  class="body">Return to the Add Testimonials page</a>
<br><br>
</td></tr>
</table>
</td></tr></table>
<% 'set rs=nothing %>
<!--#Include virtual="/administration/Footer.asp"-->
</body>
</html>