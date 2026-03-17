<%
sql = "select PageLayout.PageName, PageLayout2.* from PageLayout, PageLayout2 where Pagelayout.PageLayoutID  = PageLayout2.PageLayoutID  and PageLayout.PageName = '" & Pagename & "' order by BlockNum"
'response.write(sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof

PageLayoutID = rs("PageLayoutID")
BlockNum = rs("BlockNum")
	
PageLayout2IDArray(BlockNum) = rs("PageLayout2ID")
PageHeadingArray(BlockNum) = rs("PageHeading")
	
str1 = PageHeadingArray(BlockNum)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
PageHeadingArray(BlockNum)= Replace(str1,  str2, " ")
End If 

str1 = PageHeadingArray(BlockNum)
str2 = "''"
If InStr(str1,str2) > 0 Then
PageHeadingArray(BlockNum) = replace(str1,  str2, "'")
End If 

EditImageArray(BlockNum) = rs("EditImage")
PageHeadingArray(BlockNum) = rs("PageHeading")
PageTextArray(BlockNum) = rs("PageText")
	
str1 = PageTextArray(BlockNum)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, " ")
End If 

str1 = PageTextArray(BlockNum)
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, "'")
End If 


str1 = PageTextArray(BlockNum)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1, str2 , vbCrLf)
End If  

ImageArray(BlockNum) = rs("Image")
ImageCaptionArray(BlockNum) = rs("ImageCaption")
	
if ImageCaptionArray(BlockNum) = "0" then
ImageCaptionArray(BlockNum)= ""
end if

str1 =  ImageCaptionArray(BlockNum)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
ImageCaptionArray(BlockNum)= Replace(str1,  str2, " ")
End If 

str1 = ImageCaptionArray(BlockNum)
str2 = "''"
If InStr(str1,str2) > 0 Then
ImageCaptionArray(BlockNum)= Replace(str1,  str2, "'")
End If
	
str1 =  Trim(ImageCaptionArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionArray(BlockNum)= Replace(str1,  str2, "")
	End If 
 

	ImageOrientationArray(BlockNum) = rs("ImageOrientation")
	ImageLinkArray(BlockNum) = rs("ImageLink")
	
	str1 =  Trim(ImageLinkArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageLinkArray(BlockNum)= Replace(str1,  str2, "")
	End If 



	UploadTextArray(BlockNum) = rs("UploadText")
	UploadArray(BlockNum) = rs("Upload")

rs.movenext
wend

LastBlockNum = BlockNum
'response.write("LastBlocknum = " & LastBlockNum )
x  = 1
 order = "even"
	 
	while x < (LastBlockNum + 1 ) 
	'response.write("x = " & x )%>

<%   Block = x
	 ImageLink = ImageLinkArray(x)
	 Textblock =  x
	  TempPageLayout2ID = PageLayout2IDArray(x)
	 PageHeading = PageHeadingArray(x)
	 PageText = PageTextArray(x)
	 BlockImage = ImageArray(x)
	' response.write("BlockImage=" & BlockImage )
	 ImageCaption = ImageCaptionArray(x)
	 ImageOrientation = ImageOrientationArray(x)
	 
	 Upload = UploadArray(x)
	 UploadText = UploadTextArray(x)
	 UploadFile = "AdminPageDataUploadPageImage.asp"
	 If BlockImageCaption= "0" Then
		BlockImageCaption = ""
	End If
	 
	
if len(PageText) > 1 then
For loopi=1 to Len( PageText )
    spec = Mid(PageText, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText= Replace(PageText,  spec, " ")

   end if
  
 Next
end if

 
	 	
if len(PageTitle) > 1 then
For loopi=1 to Len( PageTitle )
    spec = Mid(PageTitle, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageTitle= Replace(TempPageText,  spec, " ")

   end if
  
 Next
end if

if len(PageHeading) > 1 then
For loopi=1 to Len(  PageHeading )
    spec = Mid(PageHeading, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	 PageHeading= Replace( PageHeading,  spec, " ")

   end if
  
 Next
end if

if len(ImageCaption) > 1 then
For loopi=1 to Len(  ImageCaption )
    spec = Mid(ImageCaption, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	 ImageCaption= Replace( ImageCaption,  spec, " ")

   end if
  
 Next
end if

	 
	 
	   if order = "even" then
	  	order = "odd" %>
	  	 <table width = "970" bgcolor = "#CEAD7D">
	  	
	 <% else
	     order = "even" %>
	 	<table width = "970" bgcolor = "cccccc">    
	<% end if %>


	 <tr><td class = "body" width = "670">

 <a name = "<%=Textblock%>"></a>
    <script language="javascript1.2" type="text/javascript">
   // attach the editor to the textarea with the identifier 'textarea1'.
   WYSIWYG.attach("block<%=Block%>", mysettings);

 </script>

	 		<form action= 'AdminPageDataHandleForm2.asp?filename=<%=filename%>' method = "post">
			<input name="TextBlock"  size = "60" value = "<%=Textblock%>" type = "hidden">

<input name="TempPageLayout2ID"  size = "60" value = "<%=TempPageLayout2ID%>" type = "hidden">
<input name="PageLayoutID"  size = "60" value = "<%=PageLayoutID%>" type = "hidden">
			
			
	
			<TEXTAREA NAME="Text" cols="65" rows="18" wrap="file" class = "body" id="block<%=Block%>"><%=PageText%></textarea><br>
			<input type=submit value = "Submit Changes"  Class = "regsubmit2" >
	</form>
<td valign="top" class = "roundedtopandbottom">
<table>
					   <tr>
					     <td class = "body">
					     	<% If Len(BlockImage) > 2 Then %>
							<img src = "<%=BlockImage%>" height = "100"><br>
							<b><%=ImageCaption%></b>
							<% Else %>
							<h2>No Image</h2>
							<% End If %>
							<form  method="POST" enctype="multipart/form-data" action="AdminPageDataUploadImage.asp?PageLayout2ID=<%=TempPageLayout2ID%>&filename=<%=filename%>" >
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload" class = "regsubmit2">
							</form>
						<td>
						</tr>
						<tr>
							<td valign = "top" class = "body">
								<form method="POST" action="AdminPageDataImageOrientation2.asp?filename=<%=filename%>" >
								<b>Orientation: </b>
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation%>" selected><%=ImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Top">Top</option>
										<option  value="Right">Right</option>
										</select>
								
								<input type = "hidden" name="TempPageLayout2ID?filename=<%=filename%>" value= "<%=TempPageLayout2ID%>" >
		<input name="TempPageLayout2ID"  size = "60" value = "<%=TempPageLayout2ID%>" type = "hidden">

									<input type = "hidden" name="OrientationImageID" value= "<%=Block %>" >
									
									<br><b>Image Link: </b>http://<input type = "text" name="ImageLink" class = "body" size = "20" value= "<%=ImageLink %>" ><br>

									<b>Caption:</b> (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption%>"  size = "20" maxlength = "80">
									
									<input type=submit value = "Submit"  size = "110" Class = "regsubmit2" >
									
									
									
								</form>
							</td>
						</tr>
							<tr>
						   <td class = "body">
							
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage2.asp?filename=<%=filename%>' method = "post">
								<input type = "hidden" name="PageLayout2ID" value= "<%=TempPageLayout2ID %>" >
								<input type=submit value="Remove This Image" class = "regsubmit2">
							</form>
					</td>
				</tr>
				</table>
	 	
	 	
	 	</td>
	   </tr>
	   </table>
   	 	
   	<% 
   	x = x +1
   	wend%> 	
   	 

