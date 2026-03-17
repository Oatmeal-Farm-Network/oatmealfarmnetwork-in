<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
	<!--#Include file="AdminSecurityInclude.asp"-->
	<!--#Include file="AdminGlobalvariables.asp"-->
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<%
Dim TotalCount
dim rowcount
dim CustomerName
dim Name
dim Testimonial
dim URL
dim Testimonialtype

CustomerName=Request.Form("CustomerName")
Name=Request.Form("Name")
Testimonial=Request.Form("Testimonial")
URL=Request.Form("URL")
Testimonialstype=Request.Form("Testimonialstype")
AnimalID= Request.Form("ID")

'response.write("AddTestimonials CompanyName = " & CompanyName & " Name = " & name & " testimoniaL = " & TESTIMONIAL & "<br>")
	
if len(Testimonial) < 2 then
	response.redirect("AdminTestimonialsadmin.asp?Message=Your changes could not be made. Please enter a Testimonial.")
else

	str1 = Testimonial
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		testimonial= Replace(str1, "'", "''")
	End If 

	str1 = Name
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Name= Replace(str1, "'", "''")
	End If

	str1 = CustomerName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		CustomerName= Replace(str1, "'", "''")
	End If

	str1 = URL
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		URL= Replace(str1, "'", "''")
	End If
	
	str1 = Ucase(URL)
	str2 = "HTTP://"
	If InStr(str1,str2) > 0 Then
		URL= Replace(str1, str2, "")
	End If

	if len(AnimalID) > 0 then
	else
		AnimalID = 0	
	end if
	
	Query =  "INSERT INTO Testimonials(Name, CustomerName, Testimonial, URL, AnimalID, TestimonialsType )" 
	Query =  Query & " Values ('" & Name & "' ,"
	Query =  Query &   " '" & CustomerName & "',"
	Query =  Query &   " '" & Testimonial & "',"
	Query =  Query &   " '" & URL & "',"	
	Query =  Query &   " " & AnimalID & ","
    Query =  Query &   " '" & Testimonialtype & "' )"
    response.write("AddTestimonial Query = " & Query & "<br>")
    
    Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 	
	DataConnection.Execute(Query) 
end if 

response.redirect("AdminTestimonialsadmin.asp?Message=Your Testimonial Has Been Added.")
%>

</BODY>
</HTML>
