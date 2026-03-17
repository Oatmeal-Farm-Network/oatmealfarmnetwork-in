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


<% 

TestimonialsID=request.querystring("TestimonialsID") 
	'response.write("TestimonialsID=" & TestimonialsID )
	
	
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;"

%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="780" align = "center">
	<tr>
		<td Class = "body">
			<H2><div align = "left">Delete Testimonial<br>
			<img src = "images/underline.jpg"></div></H2>
			Are You Sure that You Want to delete this testimonial? Once it is deleted it is gone forever!<br><br>
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
		<td  class = "body" align = "right" valign = "top" width = "200">Testimonial:&nbsp;</td>
		<td class = "body" width="580">
			<%=Testimonial%>
		</td>
	</tr>
		<tr ><td class = "body" align = "right" height = "20">Author: &nbsp;<td class = "body"><%=Name%></td></tr>
	<tr ><td class = "body" align = "right" height = "20" >Business Name: &nbsp;</td><td class = "body"><%=CustomerName%></td></tr>
	<tr ><td class = "body" align = "right" height = "20">Website Link: &nbsp;</td><td class = "body"><%=URL%></td></tr>
	<Tr><td class = "body" align = "right" height = "20">Testimonial Type: &nbsp;</td>
		<td class = "body"><%=TestimonialsType%>
		</td></tr>
  <tr>
	<td class = "body" align = "right" height = "20">Animal Name (If Applicable): &nbsp;</td>
				 <td class = "body">
					<%=Animalsname%>
				</td>
</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="300" align = "center">

	<tr>
	<td  class = "body" align = "right" valign = "top">

	<form  name=form method="post" action="testimonialsadmin.asp">
               
		<input type="Submit" value="Cancel" >

	</form>

</td>
<td width = "5">&nbsp;</td>
<td  class = "body" align = "left" valign = "top">

<form  name=form method="post" action="TestimonialsDelete2.asp?TestimonialsID=<%=TestimonialsID%>">
               
		<input type="Submit" value="Delete">

	</form>

</td></tr></table>
<% 'set rs=nothing %>
<!--#Include virtual="/administration/Footer.asp"-->
</body>
</html>