<!--#Include file="NewsHeader.asp"--> 

<% 
	  
CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

NewsID = request.querystring("NewsID")
If Len(NewsID) > 0 Then

else
	NewsID = request.Form("NewsID")
End if
  sql = "select * from News where NewsID = " & NewsID
'response.write(sql)
Session("NewsID")	 =	NewsID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
Dim pageheadings(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
	
	 PageTitle = rs("HeadlineOne")


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
		 PageTextArray(i) = rs("PageText" & i )
		 ImageArray(i) = rs("PageImage" & i )
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



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Edit News<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
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
					<li><a href = "#Heading" class ="body">Basic Information</a>
				<% 	For i = 1 To 20 
							TempBlockLink = "#TextBlock" & i
							TempBlockName = "Text Block " & i
							%>
				  	<li><a href = "<%=TempBlockLink%>" class ="body"><%=TempBlockName%></a>
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
			<td  align = "center" class = "body" colspan= "2" bgcolor = "burlywood" height = "24" width = "800">
					<big><b><font color = "white">Heading</font></b></big> </b>
			</td>
		</tr>
   <tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'NewsHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="NewsID"  size = "60" value = "<%=NewsID%>" type = "hidden">
		<table border = "0" bordercolor = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780">
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
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" ></form>
		</td>
		</tr>

	
	</table>
</td>
				</tr>
				</table>
<br><br>






<%


For i = 1 To 20


textblocknum = i
   TB = "TB" & i
   TempPageHeading = pageheadings(i)
   TempPageText =  PageTextArray(i)
   tempImage =   ImageArray(i) 
   TempNewsuploadImageFile = "NewsuploadImage" & i & ".asp"
   TempImageCaption =   ImageCaptionArray(i)
   TempImageOrientation =  ImageOrientationArray(i)
   TempTextBlock = "TextBlock" & i
   %>
   <a name= <%=TempTextBlock %> ></a>
   <!--#Include virtual="/Administration/NewsBlockInclude.asp"--> 
<% next %>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>