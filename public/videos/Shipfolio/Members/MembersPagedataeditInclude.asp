
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>

<%
x= 0

sql = "select PageLayoutID from RanchPageLayout where PageName = '" & Pagename & "' and PeopleID=" & PeopleID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
 PageLayoutID  = rs("PageLayoutID")
end if 
 If not rs.State = adStateClosed Then
  rs.close
End If  
	
 
sql = "select * from RanchPageLayout2 where PageLayoutID  = " & PageLayoutID & " and PeopleID=" & PeopleID & " order by BlockNum"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof
x = x + 1
PageLayoutID = rs("PageLayoutID")
	BlockNum = rs("BlockNum")

	PageLayout2IDArray(x) = rs("PageLayout2ID")

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
 x  = 1
 order = "even"
	 
	while x < (LastBlockNum + 1 ) 
   Block = x
	 ImageLink = ImageLinkArray(x)
	 Textblock =  x
	  TempPageLayout2ID = PageLayout2IDArray(x)
	  	
	 PageHeading = PageHeadingArray(x)
	 PageText = PageTextArray(x)
	 BlockImage = ImageArray(x)
	 ImageCaption = ImageCaptionArray(x)
	 ImageOrientation = ImageOrientationArray(x)
	 
	 Upload = UploadArray(x)
	 UploadText = UploadTextArray(x)
	 UploadFile = "MembersPageDatauploadImage.asp" ' changed from "PageDatauploadPageImage.asp" NEA 5/25/12
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
 %>
<a name = "<%=Textblock%>"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 90 %>"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">
		
<% if PageName = "Terms And Policies" and x = 1 then%>
<h2><a class="tooltip" href="#">Payment Terms<span class="custom info body"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><div align = "left"><em>Payment Terms:</em>Describe in what forms you will accept payment for your animals, products, and services - as applicable.</div></b></span></a></h2>

<% end if %>	
<% if PageName = "Terms And Policies" and x = 2 then%>
<h2><a class="tooltip" href="#">Shipping<span class="custom info body"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><div align = "left"><em>Shipping:</em>If applicable, describe how you handle shipping and handling of products, services, and animals.</div></b></span></a></h2>

<% end if %>

<% if PageName = "Terms And Policies" and x = 3 then%>
<h2><a class="tooltip" href="#">Return Policy<span class="custom info body"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><div align = "left"><em>Return Policy:</em>Describe you policies in regards to returns.</div></b></span></a></h2>

<% end if %>

<% if PageName = "About Us" then%>
<h2>About Us Text Block <%=x%></h2>

<% end if %>



<% if PageName = "Terms And Policies" and x > 3 then%>
<h2>Additional Information<span class="custom info body"></h2>

<% end if %>

  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -90%>" ><tr><td class = "body" align = "left">
<%
'*******************************************************************************************
'WYSIWYG Scripts
'*******************************************************************************************
%>   


<form action= 'MembersPageDataHandleForm2.asp?filename=<%=filename%>&PeopleID=<%=PeopleID%>' method = "post">
<input name="TextBlock"  size = "60" value = "<%=Textblock%>" type = "hidden">
<input name="TempPageLayout2ID"  size = "60" value = "<%=TempPageLayout2ID%>" type = "hidden">
<input name="PageLayoutID"  size = "60" value = "<%=PageLayoutID%>" type = "hidden">
<TEXTAREA NAME="Text" cols="65" rows="18" wrap="file" class = "body" id = "textarea1<%=Block%>"><%=PageText%></textarea><br>
<center><input type=submit value = "SUBMIT CHANGES"  size = "110" class = "regsubmit2" ></center>
	        </form>
	 
						
	         	<td valign="top" width = "380">
	 					<table cellpadding = "0" cellspacing = "0" width = "400">
	 					   <tr>
					     <td class = "body">
					     <h2>Image</h2>
					    <div align = "left"><b>Images must be in .JPG, .JPEG, .GIF, or .PNG format<br /> and less than 300KB in size.</b></div><br> 
					     	<% If Len(BlockImage) > 2 Then %>
							<img src = "<%=BlockImage%>" height = "100"><br>
							<% Else %>
							<h2>No Image</h2>
							<% End If %>
							<form  method="POST" enctype="multipart/form-data" action="MembersPageDatauploadImage.asp?PageLayout2ID=<%=TempPageLayout2ID%>&filename=<%=filename%>&PeopleID=<%=PeopleID%>&TextBlock=<%=TextBlock%>" >
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<center><input  type=submit value="Upload" class = "regsubmit2"></center>
							</form>
						<td>
						</tr>
						<tr>
							<td valign = "top" class = "body" >
								<center><form method="POST" action="MembersPageDataImageOrientation2.asp?filename=<%=filename%>&TextBlock=<%=TextBlock%>" >
								<b>Orientation: </b>
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation%>" selected><%=ImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
<input type = "hidden" name="TempPageLayout2ID?filename=<%=filename%>&PeopleID=<%=PeopleID%>" value= "<%=TempPageLayout2ID%>" >
<input name="TempPageLayout2ID"  size = "60" value = "<%=TempPageLayout2ID%>" type = "hidden">

	<input type = "hidden" name="OrientationImageID" value= "<%=Block %>" >
    <input type=submit value = "Submit"  size = "110" class = "regsubmit2"" ></center>
	
								</form>
							</td>
						</tr>
							<tr>
						   <td class = "body">
							
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
                        <% if len(BlockImage) > 3 then %>
                        <br />
							<form action= 'membersRemovePageDataImage2.asp?filename=<%=filename%>' method = "post">
								<input type = "hidden" name="PageLayout2ID" value= "<%=TempPageLayout2ID %>" >
								<input type=submit value="Remove This Image" class = "regsubmit2">
							</form>
                            <% end if %>
					</td>
				</tr>
	 </table>
	 			</td>
				</tr>
	 </table>
	 			</td>
				</tr>
	 </table>
	 <br />
   	 	
   	<% 
   	x = x +1
   	wend%> 	

