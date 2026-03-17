

<% 
PageName = "I Love Alpacas"	  
 session("PageName") = PageName

CustID = session("CustID")

Redirect = "ILoveAlpacasAdmin.asp"
 Session("Redirect") = Redirect
 sql = "select * from Pagelayout where PageName = '" & PageName & "'"
set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
PageTitle = rs("PageTitle")
	 Order1 = rs("Order1")
	 Order2 = rs("Order2")
	 Order3 = rs("Order3")
	 Order4 = rs("Order4")
	 Order5 = rs("Order5")
	 Order6 = rs("Order6")
	 Order7 = rs("Order7")
	 Order8 = rs("Order8")
	 Order9 = rs("Order9")
	 Order10 = rs("Order10")
	 Order11 = rs("Order11")
	 Order12 = rs("Order12")
	 Order13 = rs("Order13")
	 Order14 = rs("Order14")
	 Order15 = rs("Order15")
	 Order16 = rs("Order16")
	 Order17 = rs("Order17")
	 Order18 = rs("Order18")
	 Order19 = rs("Order19")
	 Order20 = rs("Order20")
     PageHeading1= rs("PageHeading1")
     PageHeading2= rs("PageHeading2")
     PageHeading3= rs("PageHeading3")
     PageHeading4= rs("PageHeading4")
	 PageHeading5= rs("PageHeading5")
	 PageHeading6= rs("PageHeading6")
	 PageHeading7= rs("PageHeading7")
	 PageHeading8= rs("PageHeading8")
	 PageHeading9= rs("PageHeading9")
	 PageHeading10= rs("PageHeading10")
	 PageHeading11= rs("PageHeading11")
	 PageHeading12= rs("PageHeading12")
	 PageHeading13= rs("PageHeading13")
	 PageHeading14= rs("PageHeading14")
	 PageHeading15= rs("PageHeading15")
	 PageHeading16= rs("PageHeading16")
	 PageHeading17= rs("PageHeading17")
	 PageHeading18= rs("PageHeading18")
	 PageHeading19= rs("PageHeading19")
	 PageHeading20= rs("PageHeading20")
	 PageText1 = rs("PageText1")
	 PageText2 = rs("PageText2")
	 PageText3 = rs("PageText3")
	 PageText4 = rs("PageText4")
	 PageText5 = rs("PageText5")
	 PageText6 = rs("PageText6")
	 PageText7 = rs("PageText7")
	 PageText8 = rs("PageText8")
	 PageText9 = rs("PageText9")
	 PageText10 = rs("PageText10")
	 PageText11 = rs("PageText11")
	 PageText12 = rs("PageText12")
	 PageText13 = rs("PageText13")
	 PageText14 = rs("PageText14")
	 PageText15 = rs("PageText15")
	 PageText16 = rs("PageText16")
	 PageText17 = rs("PageText17")
	 PageText18 = rs("PageText18")
	 PageText19 = rs("PageText19")
	 PageText20 = rs("PageText20")
	 Image1= rs("Image1")
	 Image2= rs("Image2")
	 Image3= rs("Image3")
	 Image4= rs("Image4")
	 Image5= rs("Image5")
	 Image6= rs("Image6")
	 Image7= rs("Image7")
	 Image8= rs("Image8")
	 Image9= rs("Image9")
	 Image10= rs("Image10")
	 Image11= rs("Image11")
	 Image12= rs("Image12")
	 Image13= rs("Image13")
	 Image14= rs("Image14")
	 Image15=rs("Image15")
	 Image16= rs("Image16")
	 Image17= rs("Image17")
	 Image18= rs("Image18")
	 Image19= rs("Image19")
	 Image20= rs("Image20")
	 ImageCaption1= rs("ImageCaption1")
	 ImageCaption2= rs("ImageCaption2")
	 ImageCaption3= rs("ImageCaption3")
	 ImageCaption4= rs("ImageCaption4")
	 ImageCaption5= rs("ImageCaption5")
	 ImageCaption6= rs("ImageCaption6")
	 ImageCaption7= rs("ImageCaption7")
	 ImageCaption8= rs("ImageCaption8")
	 ImageCaption9= rs("ImageCaption9")
	 ImageCaption10= rs("ImageCaption10")
	 ImageCaption11= rs("ImageCaption11")
	 ImageCaption12= rs("ImageCaption12")
	 ImageCaption13= rs("ImageCaption13")
	 ImageCaption14= rs("ImageCaption14")
	 ImageCaption15= rs("ImageCaption15")
	 ImageCaption16= rs("ImageCaption16")
	 ImageCaption17= rs("ImageCaption17")
	 ImageCaption18= rs("ImageCaption18")
	 ImageCaption19= rs("ImageCaption19")
	 ImageCaption20= rs("ImageCaption20")
	 ImageOrientation1= rs("ImageOrientation1")
	 ImageOrientation2= rs("ImageOrientation2")
	 ImageOrientation3= rs("ImageOrientation3")
	 ImageOrientation4= rs("ImageOrientation4")
	 ImageOrientation5= rs("ImageOrientation5")
	 ImageOrientation6= rs("ImageOrientation6")
	 ImageOrientation7= rs("ImageOrientation7")
	 ImageOrientation8= rs("ImageOrientation8")
	 ImageOrientation9= rs("ImageOrientation9")
	 ImageOrientation10= rs("ImageOrientation10")
	 ImageOrientation11= rs("ImageOrientation11")
	 ImageOrientation12= rs("ImageOrientation12")
	 ImageOrientation13= rs("ImageOrientation13")
	 ImageOrientation14= rs("ImageOrientation14")
	 ImageOrientation15= rs("ImageOrientation15")
	 ImageOrientation16= rs("ImageOrientation16")
	 ImageOrientation17= rs("ImageOrientation17")
	 ImageOrientation18= rs("ImageOrientation18")
	 ImageOrientation19= rs("ImageOrientation19")
	 ImageOrientation20= rs("ImageOrientation20")
 PageHeading20= rs("PageHeading20")
	

For x = 1 To 20
	pageheadingname = "PageHeading" & x
	ImageCaptionName = "ImageCaption" & x
	PageTextName = "PageTextName" & x


	str1 = pageheadingname
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		pageheadingname= Replace(str1,  str2, " ")
	End If 

	str1 = pageheadingname
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		pageheadingname= Replace(str1,  str2, "'")
	End If 


	str1 =  ImageCaptionName
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		ImageCaptionName= Replace(str1,  str2, " ")
	End If 

	str1 =  ImageCaptionName
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionName= Replace(str1,  str2, "'")
	End If 


str1 = PageTextName
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageTextName= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageTextName
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTextName= Replace(str1,  str2, " ")
End If 

str1 = PageTextName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTextName= Replace(str1,  str2, "'")
End If 


next




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



%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td Class = "body">
			<H2>I Love Alpacas Page Content</H2>
			<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
	    <td class = "body">
             Your page is built from multiple "Text Blocks". Each Text Block is comprised of:
				<ul>
					<li>A Heading</li>
					<li>Text
					<li>An Image with a caption
				</ul>
              Select the links below to go directly to:
			      <ul>
					<li><a href = "#Heading" class ="body">The page heading</a>
				  <% For x = 1 To 20 %>
					
					<li><a href = "#TextBlock<%=x%>" class ="body">Text Block <%=x%></a>
				<% Next %>
				</ul><a name="Heading"></a>
				<br>
		</td>
		<td Class = "body">
			
			<img src = "images/TextBlocks.jpg" height = "250"></H2>
		</td>
	</tr>
</table>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14" width = "800">
					<big><b><font color = "white">Page Heading</font></b></big> </b>
			</td>
		</tr>
   <tr>
</table>
<% showheading = False 
If showheading = True then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td valign = "top">
			 <form action= 'ILoveAlpacasPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">

			<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "580">
  			<tr>
				<td  align = "right"   class = "body">
						<b>Page Heading: </b>
				</td>
				<td  align = "left" valign = "top" class = "body">
					<input name="Text"  size = "60" value = "<%=PageTitle%>">
				</td>
			</tr>
	<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
<% End If %>
 <% For x = 1 To 20 
    PageTextName = "pagetext" & x 
	session("ImageNumber" & x) = x
	If x = 1 Then'
		currentorder = order1
	    currentImage  = image1
		currentImageOrientation= ImageOrientation1
		currentPageHeading= PageHeading1
		currentPageText =  PageText1 
	End If 
	If x = 2 Then
			currentorder = order2
		currentImage  = image2
		currentImageOrientation= ImageOrientation2
		currentPageHeading= PageHeading2
		currentPageText =  PageText2 
	End If 
		If x = 3 Then
		currentorder = order3
		currentImage  = image3
		currentImageOrientation= ImageOrientation3
		currentPageHeading= PageHeading3
		currentPageText =  PageText3
	End If 
	If x =4 Then
		currentorder = order4
		currentImage  = image4
		currentImageOrientation= ImageOrientation4
		currentPageHeading= PageHeading4
		currentPageText =  PageText4 
	End If 
		If x = 5 Then
		currentorder = order5
		currentImage  = image5
		currentImageOrientation= ImageOrientation5
		currentPageHeading= PageHeading5
		currentPageText =  PageText5 
	End If 
		If x = 6 Then
		currentorder = order6
		currentImage  = image6
		currentImageOrientation= ImageOrientation6
		currentPageHeading= PageHeading6
		currentPageText =  PageText6 
	End If 
    If x = 7 Then
		currentorder = order7
		currentImage  = image7
		currentImageOrientation= ImageOrientation7
		currentPageHeading= PageHeading7
		currentPageText =  PageText7
	End If 
		If x = 8 Then
		currentorder = order8
		currentImage  = image8
		currentImageOrientation= ImageOrientation8
		currentPageHeading= PageHeading8
		currentPageText =  PageText8 
	End If 
    	If x = 9 Then
		currentorder = order9
		currentImage  = image9
		currentImageOrientation= ImageOrientation9
		currentPageHeading= PageHeading9
		currentPageText =  PageText9 
	End If 
		If x = 10 Then
		currentorder = order10
		currentImage  = image10
		currentImageOrientation= ImageOrientation10
		currentPageHeading= PageHeading10
		currentPageText =  PageText10 
	End If 
		If x = 11 Then
		currentorder = order11
		currentImage  = image11
		currentImageOrientation= ImageOrientation11
		currentPageHeading= PageHeading11
		currentPageText =  PageText11 
	End If 
		If x = 12 Then
		currentorder = order12
		currentImage  = image12
		currentImageOrientation= ImageOrientation12
		currentPageHeading= PageHeading12
		currentPageText =  PageText12 
	End If 
		If x = 13 Then
		currentorder = order13
		currentImage  = image13
		currentImageOrientation= ImageOrientation13
		currentPageHeading= PageHeading13
		currentPageText =  PageText13 
	End If 
		If x = 14 Then
		currentorder = order14
		currentImage  = image14
		currentImageOrientation= ImageOrientation14
		currentPageHeading= PageHeading14
		currentPageText =  PageText14 
	End If 
		If x = 15 Then
		currentorder = order15
		currentImage  = image15
		currentImageOrientation= ImageOrientation15
		currentPageHeading= PageHeading15
		currentPageText =  PageText15
	End If 
		If x = 16 Then
		currentorder = order16
		currentImage  = image16
		currentImageOrientation= ImageOrientation16
		currentPageHeading= PageHeading16
		currentPageText =  PageText16 
	End If 
			If x = 17 Then
		currentorder = order17
		currentImage  = image17
		currentImageOrientation= ImageOrientation17
		currentPageHeading= PageHeading17
		currentPageText =  PageText17
	End If 
			If x = 18 Then
		currentorder = order18
		currentImage  = image18
		currentImageOrientation= ImageOrientation18
		currentPageHeading= PageHeading18
		currentPageText =  PageText18
	End If 
			If x = 19 Then
		currentorder = order19
		currentImage  = image19
		currentImageOrientation= ImageOrientation19
		currentPageHeading= PageHeading19
		currentPageText =  PageText19 
	End If 
			If x = 20 Then
		currentorder = order20
		currentImage  = image20
		currentImageOrientation= ImageOrientation20
		currentPageHeading= PageHeading20
		currentPageText =  PageText20 
	End If 


str1 = CurrentPageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	CurrentPageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =CurrentPageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	CurrentPageText= Replace(str1,  str2, " ")
End If 

str1 = CurrentPageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	CurrentPageText= Replace(str1,  str2, "'")
End If 

	
	
	%>
<a name="TextBlock<%=x%>"></a>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14">
					<big><b><font color = "white">Text Block <%=x%></font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'ILoveAlpacasPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB" type = "hidden">
			<input type = "hidden" name="TBID" value= "<%=x%>" >
	<tr>
			<td  align = "left" class = "body" valign = "top">
					<b>Title: </b>
			</td>
		</tr>
		<tr>
			<td  align = "left" valign = "top" class = "body">

					<input NAME="Heading" size="44" value="<%=CurrentPageHeading%>">
					<% If currentorder > 0 Then
						 Else
							currentorder = x
						 End If 
					 showorder = False 
					If showorder = True then %>	 

					Order: 	<select size="1" name="Order">
					<option value="<%=currentorder%>" selected><%=currentorder%></option>
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
				</select>
				<% End If %>
			</td>
		</tr>
		<tr>
			<td  align = "left" class = "body" valign = "top">
					<b>Text: </b>
			</td>
		</tr>
		<tr>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="13" wrap="file"><%=CurrentPageText%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>


	  </td></form>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(currentImage) > 2 Then %>
							<img src = "<%=currentImage%>" height = "100">
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
						 <% uploadfilename = "UploadPageImage.asp?Pagenum=" & x %>
						 <form name="frmSend" method="POST" enctype="multipart/form-data" action="<%=uploadfilename%>"  >
								
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
					

						<tr>
					    <td class = "body">
							<form action= 'RemovePageImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=x%>" >
								<input type = "hidden" name="PageName" value= "<%=PageName%>" >
								<input type = "hidden" name="Redirect" value= "<%=Redirect%>" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>

<% next %>



</td>
</tr>
</table>
</td>
</tr>
</table>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>