<!--#Include file="BlogHeader.asp"--> 

<% 
	  
CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

BlogID = request.querystring("BlogID")
If Len(BlogID) > 0 Then

else
	BlogID = request.Form("BlogID")
End if
  sql = "select * from Blog where BlogID = " & BlogID
'response.write(sql)
Session("BlogID")	 =	BlogID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
Dim pageheadings(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
	
	 PageTitle = rs("BlogHeadline")
	 	
	 Blogday = rs("Blogday")
	 BlogMonth = rs("BlogMonth")
	 BlogYear= rs("BlogYear")

	 
	 AuthorLink= rs("AuthorLink")
	BlogUpload= rs("BlogUpload")
	BlogBlogCatID= rs("BlogCatID")

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

     
	 Dim num

	 For i = 1 To 20
	 'response.write("i=" & i)
		 pageheadings(i) = rs("PageHeading" & i  )
		 PageTextArray(i) = rs("BlogText" & i )
		 ImageArray(i) = rs("BlogImage" & i )
		 ImageCaptionArray(i) = rs("ImageCaption" & i )
		 ImageOrientationArray(i) = rs("ImageOrientation" & i )

if pageheadings(i) = "0" then
	pageheadings(i) = ""
End if
		str1 = pageheadings(i)
		str2 = "&nbsp;"
		If InStr(str1,str2) > 0 Then
			pageheadings(i)= Replace(str1,  str2, " ")
		End If 

		str1 = pageheadings(i)
		str2 = "''"
		If InStr(str1,str2) > 0 Then
			pageheadings(i)= Replace(str1,  str2, "'")
		End If 

		str1 = ImageCaptionArray(i) 
		str2 = "''"
		If InStr(str1,str2) > 0 Then
			ImageCaptionArray(i)  = Replace(str1,  str2, "'")
		End If 

		str1 =  ImageCaptionArray(i) 
		str2 = "&nbsp;"
		If InStr(str1,str2) > 0 Then
			 ImageCaptionArray(i) = Replace(str1,  str2, " ")
		End If 

		
		str1 = PageTextArray(i)
		str2 = "</br>"
		If InStr(str1,str2) > 0 Then
			PageTextArray(i)= Replace(str1, str2 , vbCrLf)
		End If  

		str1 =PageTextArray(i)
		str2 = "&nbsp;"
		If InStr(str1,str2) > 0 Then
			PageTextArray(i)= Replace(str1,  str2, " ")
		End If 

		str1 = PageTextArray(i)
		str2 = "''"
		If InStr(str1,str2) > 0 Then
			PageTextArray(i)= Replace(str1,  str2, "'")
		End If 



	 Next


	


%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<tr>
		<td Class = "body">
			<H2>Edit Blog Entry<br>
			<img src = "images/underline.jpg" width = "800"></H2>
			<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<tr>
		<td valign = "top">
			 <form action= 'BlogHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
		<table border = "0" bordercolor = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780">
  		<tr>
			<td  align = "right"   class = "body">
						<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Text"  size = "60" value = "<%=PageTitle%>">
			</td>
	 </tr>
	 <tr>
	 <td  align = "right"   class = "body">
						<b>Date: </b>
			</td>

	 <td>
		<select size="1" name="BlogMonth">
				<% if len(BlogMonth) > 0 then %>
					<option value="<%=BlogMonth%>" selected><%=BlogMonth%></option>
				<% else %>
					<option value="" selected>------</option>
				<% end if %>
					<option value="1">Jan.(1)</option>
					<option  value="2">Feb.(2)</option>
					<option  value="3">March (3)</option>
					<option  value="4">April (4)</option>
					<option  value="5">May (5)</option>
					<option  value="6">June (6)</option>
					<option  value="7">July (7)</option>
					<option  value="8">Aug. (8)</option>
					<option  value="9">Sept. (9)</option>
					<option  value="10">Oct. (10)</option>
					<option  value="11">Nov. (11)</option>
					<option  value="12">Dec. (12)</option>
				</select>
				/ <select size="1" name="BlogDay">
				<% if len(BlogDay) > 0 then %>
					<option value="<%=BlogDay%>" selected><%=BlogDay%></option>
				<% else %>
					<option value="" selected>------</option>
				<% end if %>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="BlogYear">
					<% if len(BlogYear) > 0 then %>
					<option value="<%=BlogYear%>" selected><%=BlogYear%></option>
				<% else %>
					<option value="<%=year(now)%>" selected><%=year(now)%></option>
				<% end if %>

					
					
				
			<% currentyear = year(date) 
						'response.write(currentyear)
					For yearv=currentyear-3 To currentyear + 5%>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
  </td>
  </tr>
      
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit" class = "regsubmit2" ></form>
		</td>
		</tr>
		
   <tr>
				</table>

<%


For i = 1 To 20


textblocknum = i
   TB = "TB" & i
   TempPageHeading = pageheadings(i)
   TempPageText =  PageTextArray(i)
   tempImage =   ImageArray(i) 
   TempBloguploadImageFile = "BloguploadImage" & i & ".asp"
   TempImageCaption =   ImageCaptionArray(i)
   TempImageOrientation =  ImageOrientationArray(i)
   TempTextBlock = "TextBlock" & i
   %>
   <a name= <%=TempTextBlock %> ></a>
   <!--#Include virtual="/Administration/BlogBlockInclude.asp"--> 
<% next %>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>