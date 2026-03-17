<HTML>
<HEAD>
 <title>Add Testimonial Name Results Page</title>
     <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<!--#Include virtual="/Administration/Globalvariables.asp"-->

<%
TestimonialsID= Request.Querystring("TestimonialsID")

response.write("AddTestimonials CompanyName = " & CompanyName & " Name = " & name & " testimoniaL = " & TESTIMONIAL & "<br>")
	
	
Query =  "Delete * From Testimonials where TestimonialsID = " & TestimonialsID


response.write("AddTestimonial Query = " & Query & "<br>")	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 



response.redirect("Testimonialsadmin.asp?Message=Your Testimonial Has Been Deleted.")
%>

</BODY>
</HTML>
