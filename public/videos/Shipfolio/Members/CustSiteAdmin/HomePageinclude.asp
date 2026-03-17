

<% 
	  
CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 


  sql = "select * from Pagelayout where PageName = 'Home Page'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
	 PageTitle = rs("PageTitle")
     PageHeading1= rs("PageHeading1")
     PageHeading2= rs("PageHeading2")
     PageHeading3= rs("PageHeading3")
     PageHeading4= rs("PageHeading4")
	 PageText1 = rs("PageText1")
	 PageText2 = rs("PageText2")
	 PageText3 = rs("PageText3")
	 PageText4 = rs("PageText4")
	 Image1= rs("Image1")
	 Image2= rs("Image2")
	 Image3= rs("Image3")
	 Image4= rs("Image4")
	 ImageCaption1= rs("ImageCaption1")
	 ImageCaption2= rs("ImageCaption2")
	 ImageCaption3= rs("ImageCaption3")
	 ImageCaption4= rs("ImageCaption4")
	 ImageOrientation1= rs("ImageOrientation1")
	 ImageOrientation2= rs("ImageOrientation2")
	 ImageOrientation3= rs("ImageOrientation3")
	 ImageOrientation4= rs("ImageOrientation4")
	FeaturedID= rs("FeaturedID")
	FeaturedStudID= rs("FeaturedStudID")

str1 = PageHeading1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, " ")
End If 

str1 = PageHeading1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, "'")
End If 

str1 = PageHeading2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, " ")
End If 

str1 = PageHeading21
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, "'")
End If 

str1 = PageHeading3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, " ")
End If 

str1 = PageHeading3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, "'")
End If 


str1 = PageHeading4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, " ")
End If 

str1 = PageHeading4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption1
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption2
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption3
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, "'")
End If 







str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 


str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText1
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, " ")
End If 

str1 = PageText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 

str1 = PageText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 = PageText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, " ")
End If 

str1 = PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, "'")
End If 

%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Home Page Page Content<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br><br>
		</td>
	</tr>
</table>





<a name="TextBlock1"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">


	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "100%" align = "center">
			<tr>
				<td >
					<h2>Home Page Image</h2>
				
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image1) > 2 Then %>
							<img src = "<%=Image1%>" width =  "366" align = "center">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="HomePageuploadPageImage.asp" >
								

								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>

						<tr>
					    <td class = "body">
							<form action= 'RemoveHomePageImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
  <td width  = "300" class = "body">

  <%
  conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
  If FeaturedID > 0 Then
  	sql2 = "select Animals.FullName from Animals where ID = " & FeaturedID 
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
FeaturedAlpaca = rs2("FullName")
	
Else
	FeaturedAlpaca = "Not Selected"

End if
%>
<%
Dim IDArray(20000)
Dim alpacaName(20000) 


	
	sql2 = "select Animals.ID, Animals.FullName from Animals where custID = " & session("custid") & " order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

%>
	<form  action="FeaturedAlpacaHandleForm.asp" method = "post">
  <h2>Featured Alpaca</h2>
	The current Featured Alpaca is: <br>
	<center><b><%=FeaturedAlpaca%></b></center><br>
	Select a new featured alpaca here:</br>

			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td class = "body">
					<select size="1" name="ID">
					<option name = "AID0" value= "<%=FeaturedID%>" selected><%=FeaturedAlpaca%></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<center><input type=submit value = "Select"  class = "menu" ></center>
				</td>
			  </tr>
		    </table>
		  </form>
<br>


<%
 
  If FeaturedStudID > 0 Then
  	sql2 = "select Animals.FullName from Animals where ID = " & FeaturedStudID 
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
StudFeaturedAlpaca = rs2("FullName")
	
Else
	StudFeaturedAlpaca = "Not Selected"

End if
%>
<%
Dim StudIDArray(20000)
Dim StudalpacaName(20000) 


	
	sql2 = "select Animals.ID, Animals.FullName from Animals where category = 'Experienced Male' and custID = " & session("custid") & " order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		StudIDArray(acounter) = rs2("ID")
		StudalpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

%>
	<form  action="FeaturedStudHandleForm.asp" method = "post">
  <h2>Featured Stud</h2>
	The current Featured Stud is: <br>
	<center><b><%=StudFeaturedAlpaca%></b></center><br>
	Select a new featured Stud here:</br>

			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td class = "body">
					<select size="1" name="ID">
					<option name = "AID0" value= "<%=FeaturedStudID%>" selected><%=StudFeaturedAlpaca%></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=StudIDArray(count)%>">
							<%=StudalpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<center><input type=submit value = "Select"  class = "menu" ></center>
				</td>
			  </tr>
		    </table>
		  </form>
<br>



	<h2>What's Happening</h2>
	The what's happening section shows some information on the next event. To enter events go to <a href = "CalendarMantainance.asp" class = "body">the events admin page.</a><br>
	<br>
<h2>What's an Alpaca</h2>
	The what's an alpaca section shows the start of the about alpacas text. To enter text go to <a href = "AboutAlpacasAdmin.asp" class = "body">the About Alpacas admin page.</a><br>
	<br>
  </td>
	 </tr>
</table>


</td>
</tr>
</table>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>

<% 		set conn = nothing %>