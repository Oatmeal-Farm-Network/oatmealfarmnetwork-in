<HTML>
<HEAD>
 <title>Add Testimonial Name Results Page</title>
     <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<!--#Include virtual="/Administration/Globalvariables.asp"-->

<%
Dim TotalCount
dim rowcount
dim RanchName
dim Name
dim Testimonial

CustomerName=Request.Form("CustomerName")
Name=Request.Form("Name")
Testimonial=Request.Form("Testimonial")
URL=Request.Form("URL")
TestimonialsType=Request.Form("TestimonialsType")
AnimalID= Request.Form("ID")
TestimonialsID= Request.Form("TestimonialsID")

response.write("AddTestimonials CompanyName = " & CompanyName & " Name = " & name & " testimoniaL = " & TESTIMONIAL & "<br>")
	
if len(Testimonial) < 2 then
	response.write("<center>Your changes could not be made. Please enter a Testimonial</center>")	
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
	
	Query =  " UPDATE Testimonials Set Name = '" &  Name & "', " 
    Query =  Query & "  CustomerName = '" &  CustomerName & "'," 
	Query =  Query & "  Testimonial = '" &  Testimonial & "'," 
	Query =  Query & "  URL = '" &  URL & "'," 
	Query =  Query & "  AnimalID = '" &  AnimalID & "'," 
	Query =  Query & "  TestimonialsType = '" &  TestimonialsType & "'" 
    Query =  Query & " where TestimonialsID = " & TestimonialsID & ";" 
	'response.write("UpdateTestimonial Query = " & Query & "<br>")	
	
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 
	
end if 

response.redirect("TestimonialsEdit.asp?TestimonialsID=" & TestimonialsID & "&Message=Your Testimonial Has Been Updated.")
%>

</BODY>
</HTML>
