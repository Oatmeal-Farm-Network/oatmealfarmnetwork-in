<%@ Language="VBScript" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">

<title>Classes /  Workshops at Andresen Events - Event Registration</title>
<meta name="Title" content="<%= EventName %> at Andresen Events - Event Registration">
<meta name="description" content="<%= EventDescription %> " >
<meta name="keywords" content="Event Registration">
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subjects" content="Event Registration, Alpacas Shows" >
<link rel="shortcut icon" href="file:///infinityknot.ico" > 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" > 
<meta name="author" content="The Andresen Goup" >
<link rel="stylesheet" type="text/css" href="Style.css">
<%  PageName = "Event Classes" %>
<!--#Include virtual="GlobalVariablesNotLoggedIn.asp"-->

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<!--#Include file="EventHeader.asp"-->


<% 
ClassInfoID = request.querystring("ClassInfoID") 
	sql = "select * from Classinfo where EventID = " & EventID & " and ClassInfoID=" & ClassInfoID 
    'response.write("sql 1 = " & sql & "<br>")
  	'sql = "select * from Classinfo where ClassInfoID = " & ClassInfoID & "" 
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conn, 3, 3   
	if not rs.eof then 
		'publish= rs("publish")
		ClassInfoID = rs("ClassInfoID")
		ClassInfoTitle = rs("ClassInfoTitle")
		InstructorsName= rs("InstructorsName")
		InstructorsWebsite= rs("InstructorsWebsite")
	    InstructorsBio= rs("InstructorsBio")
	    InstructorsImage= rs("InstructorsImage")
		ClassInfoDescription = rs("ClassInfoDescription")
		ClassHomework= rs("ClassHomework")
		ClassInforoomRequirements= rs("ClassInforoomRequirements")
		ClassInfoMaterialsSupplied= rs("ClassInfoMaterialsSupplied")
		ClassInfoTeacherFee= rs("ClassInfoTeacherFee")
		ClassInfoMaterialFee= rs("ClassInfoMaterialFee")
		ClassInfoStudentFee= rs("ClassInfoStudentFee")
		ClassInfoMaterialFee= rs("ClassInfoMaterialFee")
		ClassInfoOrganizationFee= rs("ClassInfoOrganizationFee")
		ClassInfoMinimumStudents= rs("ClassInfoMinimumStudents")
		ClassInfoRoomDesignation= rs("ClassInfoRoomDesignation")
		ClassInfoAdditionalSession= rs("ClassInfoAdditionalSession")
	
	
	dim buttonimages(20)
dim buttontitle(20)

		
	PhotoCount = 0
	If Len(rs("ClassImage1")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 
	
 	If Len(rs("ClassImage2")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 

		If Len(rs("ClassImage3")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 
	If Len(rs("ClassImage4")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 
	If Len(rs("ClassImage5")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 

		If Len(rs("ClassImage6")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 
		If Len(rs("ClassImage7")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 
	If Len(rs("ClassImage8")) > 2 then
	   PhotoCount = PhotoCount + 1
	end if 

	

	           If Len(1) < 2 And Len(ClassImage2)< 2  And Len(ClassImage3) < 2  And Len(ClassImage4) < 2  And Len(ClassImage5) < 2 And Len(ClassImage6) < 2  And Len(ClassImage7) < 2  And Len(ClassImage8) < 2 then 
				click = "<img width=""260"" src=""/Uploads/ImageNotAvailable.jpg""> "
				noimage = True
				  ' response.write("found")
				Else 
						noimage = false

		End If
	
		
	

	pcounter = 0
	counter = 0
	counttotal = 8
	While counter < counttotal
		'response.write("counter=")
		'response.write(counter)

		counter = counter +1

		Photonum = "ClassImage" & counter
		Captionnum = "ClassImageCaption" & counter
		image = rs(Photonum)
		Caption = rs(Captionnum)
		If Len(image)> 2 Then
		pcounter = pcounter +1
		buttonimages(pcounter) =   image
		buttontitle(pcounter) = Caption
		'response.write(buttonimages(counter))
%>
<script language="JavaScript">
               if (document.images) version = "n3";
               else version = "n2";
               if (version == "n3") {
				but<%=pcounter%>on = new Image(85, 115);
				but<%=pcounter%>on.src = "<%=image%>";
			   }
	

       function img<%=pcounter%>(imgName) {
               if (version == "n3") {
               imgOn = eval("but<%=pcounter%>on.src");
               document [imgName].src = imgOn;               }       }
      
      
</script>

<% end if
	wend


		str1 = ClassInfoTitle
		str2 = "''"
		If InStr(str1,str2) > 0 Then
			ClassInfoTitle= Replace(str1,  str2, "'")
		End If 
	end if 


	row = "odd"
	rowcount = 1
 	sql = "select * from ClassInfo  where ClassInfoID = " & ClassInfoID
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	if not rs.eof then 
	
	leftwidth = cint(textwidth) - 300
%>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=DescriptionWidth%>"><tr><td class = "roundedtop" align = "left" >
		<h1><%=ClassInfoTitle%></h1>
        </td></tr>
        <tr><td class = "roundedBottom">
<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=textwidth %>" align = "center" >

	<tr><td class = "body" width = "<%=leftwidth %>">
<% 	
	if Not rs.eof  then
		ClassInfoTitle = rs("ClassInfoTitle")
		ClassInfoStudentFee = rs("ClassInfoStudentFee")
		ClassDateMonth = rs("ClassDateMonth")
		ClassDateDay = rs("ClassDateDay")
		ClassDateYear = rs("ClassDateYear")
		ClassStartTime = rs("ClassStartTime")
		ClassEndTime = rs("ClassEndTime")
		ClassInfoRoomDesignation = rs("ClassInfoRoomDesignation")
		ClassInfoMaximumStudents = rs("ClassInfoMaximumStudents")
		ClassInfoMinimumStudents = rs("ClassInfoMinimumStudents")
		ClassInfoDescription = rs("ClassInfoDescription")
		ClassHomework = rs("ClassHomework")
		ClassInfoID = rs("ClassInfoID")
		
%>

<table cellpadding = "0" cellspacing = "0" width = "<%=cint(textwidth) - 300 %>">
		<tr>

			<td>
				<table border = "0" bordercolor = "#DBF5F3"  align = "center">
				<tr>
			 		<td class = "body" align = "left" ><b>Price: </b><%=formatcurrency(ClassInfoStudentFee,2) %></td>
				</tr>
			
				<tr>
					<td class = "body" align = "left"><b>Date: </b><%=ClassDateMonth%>/<%=ClassDateDay%>/<%=ClassDateYear%></td>
				</tr>
			
				<tr>
					<td class = "body"  align = "left"><b>Time: </b><%=ClassStartTime%> - <%=ClassEndTime%></td>
				</tr>
			
				<tr>
					<td class = "body" align = "left"><b>Min. # students: </b><%=ClassInfoMinimumStudents%><br /><b> Max. # students: </b><%=ClassInfoMaximumStudents%></td>
				</tr>
			
				<tr>
					<td class = "body"  align = "left"><br><b>Description: </b><%=ClassInfoDescription%><br></td>	
				</tr>
			
				<tr>
					<td class = "body"  align = "left"><br><b>Homework: </b><%=ClassHomework%></td>	
				</tr>
			</table>
</td>	
				</tr>
			</table>
	
<% end if %>
</td>
<td width = "5"><img src ="images/px.gif" width = "1" height = "1" alt = "<%=EventName %> Classes"</td>
<td align = "center" width = "295">
<!--#Include file="DetailImageInclude.asp"-->
</td>
</tr>
</table>

<table width = "<%=textwidth %>" ><tr>
<td class="body"  width = "210" valign="top" >
		    	<% if len(InstructorsImage) > 3 then %>
		      		<img src = "<%=InstructorsImage%>" width = "200" >
		     	<% end if %>
		     	
			</td>
			<td class="body"   valign="top" >

		     	<% if len(InstructorsName) > 0  then%>
		     	<b>Instructor: </b><%=InstructorsName%>&nbsp;<br /> 
		     	<% if len(Instructorswebsite)> 2 then %><a href = "http://<%=Instructorswebsite%>" class = "body" target = "blank"><%=Instructorswebsite%></a><br /><% end if %>
		     		<% if len(InstructorsBio)> 2 then %><%=InstructorsBio%><br /><% end if %>
		     <% end if %>
			</td>
			</tr>
	</table>
		
<% end if %>
<br /><br />
	</td>
			</tr>
	</table>
  <!--#Include file="EventFooter.asp"--> 


</Body>
</HTML>