<html>
<head>

<% PageName = "Testimonials" %>
<!--#Include file = "GlobalVariables.asp"-->
<%'Start meta tags%>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Oregon Alpacas - Alpacas for Sale at Andresen Acres in Southern Oregon</title>
<META name="Title" content="Oregon Alpacas - Alpacas for Sale at Andresen Acres in Southern Oregon">
<META name="keywords" content="Alpacas for Sale,
Friendly Alpacas,
Quality Fleece, 
Oregon Alpacas,
Certified Fleece Sorter,
Fleece Sorting,
Alpaca Fleece Sorting, 
Southern oregon Alpacas
Raising Alpacas, 
Quality Herdsires, 
Quality Alpacas,
Quality Production Females, 
Southern Oregon Alpacas, 
Northwest Alpacas,  
Alpaka, 
Alpacka, 
Livestock for Sale, 
Alpaca Breeders">
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="Alpacas for Sale, Raising Alpacas, Oregon Livestock" />
<meta name="author" content="WebArtists.biz">
<%'End meta tags%>

<link rel="stylesheet" type="text/css" href="style.css">

</HEAD>
<body bgcolor = "#878554" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellpadding="0" >

<!--#Include file="Header.asp"-->
<table width = "740" align="center" cellspacing="0" cellpadding="0"> 
<tr>
	<td class = "body">
		<table align = "center" width = "740" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td  align = "center" ><H1><br>Testimonials</H1><br></td>
		</tr>
		</table>
<%
testimonialsID=request.form("AGTestimonialsID") 
sql = "select * from Testimonials order by AGTestimonialsID desc" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
%>

<table  width = "700"  align = "center" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellspacing=0 >
<tr>
	<td class = 'body' align = "center" colspan = "5" align = "center">								
		 <div align ="right">
		 <form action= 'Testimonials.asp' method = "post">
		 	<b>Select a Testimonial:</b>
			<select  name="testimonialsID">
				<% While Not rs.eof %>
					<small><option name = "testimonialsID" value= "<%= rs("AGTestimonialsID")%>" size = "30"></option></small>
				<%  rs.movenext
					Wend
				rs.movefirst %>
			</select>
			<input type=submit value = "View" style="background-image: url('/images/ButtonBackground.jpg'); border-style: solid; border-color: #404040; border-width: 1; height = '22' "  class = "Menu" >
		</form>
		</div>
	</td>
</tr>
</table>

<%
rs.close

TestimonialsID = request.form("TestimonialsID")

if TestimonialsID = "" then
	sql = "select * from Testimonials order by AGTestimonialsID desc" 
else
	sql = "select * from Testimonials where AGTestimonialsID = " & TestimonialsID
End If
'response.write("sql = "  & sql & "<br>")

 	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

%>

<table border = "0">

<%
if Not rs.eof  then
	TestimonialsID = rs("AGTestimonialsID")
	CustomerName = rs("CustomerName")
	Testimonial= rs("Testimonial")
end	if

Dim TestimonialArray(1000)
Dim CustomerNameArray(1000)
Dim NameArray(1000)

i=0
while not rs.eof
	i = i + 1
	response.write("i = " & i & "<br>")
	TestimonialArray(i) = rs("Testimonial")
	CustomerNameArray(i) = rs("CustomerName")
	NameArray(i) = rs("Name")
	str1 = TestimonialArray(i)
	str2 = vblf
	If InStr(str1,str2) > 0 Then
		TestimonialArray(i)= Replace(str1, str2 , "</br>")
	End If  

	str1 = CustomerNameArray(i)
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		CustomerNameArray(i)= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 
		 
	str1 = NameArray(i)
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		NameArray(i)= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If
	blank = " "	
%> 		
	
<tr>
	<td><small><%=i%><%=blank%><%=TestimonialArray(i)%></small></td>
</tr>
<tr>
	<td class = "body" align = "right" width = "100%"><%=CustomerNameArray(i)%> </td>
</tr>
<tr>
	<td><td class = "body" align = "right" width = "100%"><%=NameArray(i)%> </td>
</tr>
<%
'response.write("TestimonialArray(i) = " & TestimonialArray(i) & "<br>") 
'response.write("CustomerNameArray(i) = " & CustomerNameArray(i) & "<br>") 
'response.write(" NameArray(i) = " & NameArray(i) & "<br>") 
TestimonialsID = TestimonialsID -1
rs.moveprevious
wend

rs.close
set rs=nothing
'response.write("TestimonialsID = "  & TestimonialsID & "<br>")
%>
</table>

<% set rs=nothing %>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>