<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
	<!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalvariables.asp"-->
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
    
<%
TestimonialsID= Request.Querystring("TestimonialsID")

response.write("AddTestimonials CompanyName = " & CompanyName & " Name = " & name & " testimoniaL = " & TESTIMONIAL & "<br>")
	
	
Query =  "Delete * From Testimonials where TestimonialsID = " & TestimonialsID


response.write("AddTestimonial Query = " & Query & "<br>")	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 



response.redirect("AdminTestimonialsadmin.asp?Message=Your Testimonial Has Been Deleted.")
%>

</BODY>
</HTML>
