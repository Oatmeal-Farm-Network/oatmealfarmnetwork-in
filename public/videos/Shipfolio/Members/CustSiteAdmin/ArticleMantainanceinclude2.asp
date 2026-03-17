<!--#Include file="ArticleHeader.asp"--> 

<% 
	  
CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

ArticleID = request.querystring("ArticleID")
If Len(ArticleID) > 0 Then

else
	ArticleID = request.Form("ArticleID")
End if
  sql = "select * from Articles where ArticleID = " & ArticleID
'response.write(sql)
Session("ArticleID")	 =	ArticleID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
Dim pageheadings(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
	
	 PageTitle = rs("ArticleHeadline")
	 AuthorLink= rs("AuthorLink")
	ArticleUpload= rs("ArticleUpload")
	ArticleArticleCatID= rs("ArticleCatID")

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
		 PageTextArray(i) = rs("ArticleText" & i )
		 ImageArray(i) = rs("ArticleImage" & i )
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
			<H2>Edit Article<br>
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
					<big><b><font color = "white">Basic Information</font></b></big> </b>
			</td>
		</tr>
   <tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'ArticleHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
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
			<td  align = "right"   class = "body">
						<b>Link to Author's Website: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					http://<input name="AuthorLink"  size = "60" value = "<%=AuthorLink%>">
			</td>
	 </tr>
	  <tr>
      <td class = "body" align = "right" ><b>Article Category:</b></td>
		<td class = "body" >
	

					<% 
Dim ArticleCatID(100,100)
Dim ArticleCategoryName(100,100)
ArticleIDFound = False

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

	 sql = "select * from ArticleCategories where ArticleCatID = " & ArticleArticleCatID
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 if Not rs.eof  then
	    ArticleIDFound = True
		ArticleArticleName = rs("ArticleCategoryName")
  End If
  

			 sql = "select * from ArticleCategories where not (ArticleCatID = 2) order by ArticleCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		ArticleCatID(CatCounter,0) = rs("ArticleCatID")
		ArticleCategoryName(CatCounter,0) = rs("ArticleCategoryName")
		'response.write(ArticleCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
 %>
   

<select size="1" name="ArticleCatID">
					<%If ArticleIDFound = True  then%>
					<option name = "ArticleArticleCatID" value="<%=	ArticleArticleCatID%>" selected>
							<%=ArticleArticleName %>
						</option>
					<% End If %>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1 %>
				
						<option name = "ArticleArticleCatID" value="<%=ArticleCatID(CatCounter,0)%>">
							<%=ArticleCategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

     </td>
  </tr>
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" ></form>
		</td>
		</tr>
		<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "burlywood" height = "24" width = "800">
					<big><b><font color = "white">Article PDF</font></b></big> </b>
			</td>
		</tr>
   <tr>
		 <tr>
		<td  valign = "middle" colspan = "2"  class = "body">
			<img src =  "images/Important_Triangle.png" width = "16"><b>Important:</b> If an article is uploaded then only that file will be available on your website - any text / images entered below will not show up.
		</td>
		</tr>
			
				 <tr>
					     <td class = "body" align = "right">
							<b>Current PDF: </b>
						</td>
						<td class = "body"> 
							<% If Len(ArticleUpload) > 4 Then %>
								<i><%=ArticleUpload%></b>
							<% Else %>
							<b>N/A</b>
							<% End If %></td>
					</tr>
				


							<form name="frmSend" method="POST" enctype="multipart/form-data" action="ArticleuploadPDF.asp" >
				 <tr>
					     <td class = "body" align = "right" ><b>Upload Article:</b></td>
						 <td class = "body">
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">	
						<td>
						</tr>
						 <tr>
					     <td class = "body" align = "right" ></td>
						 <td class = "body">
								<img src =  "images/Important_Triangle.png" width = "16"><b>Important:	PDF Format Only</b><br></form>
						<td>
						</tr>
							<% If Len(ArticleUpload) > 4 Then %>
	<tr>
					    <td class = "body" colspan = "2" align = "center">
							<form action= 'RemovearticlePDF.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<input type=submit value="Remove This Article">
							</form>
					</td>
				</tr>
				<% End If %>
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
   TempArticleuploadImageFile = "ArticleuploadImage" & i & ".asp"
   TempImageCaption =   ImageCaptionArray(i)
   TempImageOrientation =  ImageOrientationArray(i)
   TempTextBlock = "TextBlock" & i
   %>
   <a name= <%=TempTextBlock %> ></a>
   <!--#Include virtual="/Administration/ArticleBlockInclude.asp"--> 
<% next %>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>