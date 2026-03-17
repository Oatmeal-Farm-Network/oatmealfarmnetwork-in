<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HTML>
<HEAD>
<!--#Include File="BlogAdminGlobalVariables.asp"--> 
	<link rel="stylesheet" type="text/css" href="/administration/style.css">
<script language="JavaScript" type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&BlogID=' + BlogID );">
<% end if %>


<!--#Include virtual="/Administration/AdminHeader.asp"-->
<br />
<% Current3 = "BlogHome" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
CustID = session("CustID")

BlogID = request.querystring("BlogID")
If Len(BlogID) > 0 Then
else
	BlogID = request.Form("BlogID")
End if
sql = "select * from Blog where BlogID = " & BlogID
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
 BlogDisplay = rs("BlogDisplay")
AuthorLink= rs("AuthorLink")
BlogUpload= rs("BlogUpload")
CatID= rs("BlogCatID")

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
For i = 1 To 10 
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

if len(PageTitle) > 1 then
	For loopi=1 to Len( PageTitle )
	    spec = Mid(PageTitle, loopi, 1)
	    specchar = ASC(spec)
	    if specchar < 32 or specchar > 126 then
			PageTitle= Replace(TempPageText,  spec, " ")
		end if
	Next
end if


%>

<a name="Top"></a>


<% if mobiledevice = False then %>
<!--#Include file="BlogAdminTabsInclude.asp"-->
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Blog Entry</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >
        <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td valign = "top">
			<form action= 'BlogAdminHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
		<table border = "0" bordercolor = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
  		<tr>
			<td  align = "right"   class = "body2">
						<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Text"  size = "60" value = "<%=PageTitle%>">
			</td>
	 </tr>
       		<tr>
			<td  align = "right"   class = "body2">
						<b>Category: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
<select size="1" name="CatID">
<% 
if len(CatID)> 0 then
sql2 = "select BlogCategoryName from BlogCategories where  Blogcatid = " &  CatID
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof  then
CurrentBlogCategoryName = rs2("BlogCategoryName")
CurrentCatID= catID %>
<option value="<%=CurrentCatID %>" selected><%=CurrentBlogCategoryName %></option>
<% end if
rs2.close
else %>
<option value="" selected> - </option>
<% end if

sql2= "select * from BlogCategories where  not (Blogcatid = 2 )  order by BlogCategoryOrder " 
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof  
BlogCatID = rs2("BlogCatID")
BlogCategoryName= rs2("BlogCategoryName")
if not(BlogcatID = CurrentBlogcatID) then%>
<option value="<%=BlogCatID %>"><%=BlogCategoryName %></option>
<% end if
rs2.movenext
Wend %>
</select>
<% rs2.close %>
</td></tr>
 <tr> <td  align = "right"   class = "body2">
<b>Date: </b>
</td>
<td>
		<select size="1" name="BlogMonth" align = "left">
				<div align = "left"><% if len(BlogMonth) > 0 then %>
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
</div>
  </td>
  </tr>
  <tr><td class = "body2" align = "right"><b>Display:</b></td>
  <td class = "body">
  <% if  BlogDisplay = "Yes" Or  BlogDisplay = True Then %>
Yes<input TYPE="RADIO" name="BlogDisplay" Value = "Yes" checked>
No<input TYPE="RADIO" name="BlogDisplay" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="BlogDisplay" Value = "Yes" >
No<input TYPE="RADIO" name="BlogDisplay" Value = "No" checked>
<% End If %>

</td></tr>
<tr>	<td  valign="middle" colspan = "2" align = "center">
			<input type=submit value = "Submit" class = "regsubmit2">
		</td>
		</tr>
</table>
</form>
<table width = "100%" cellpadding = "0" cellspacing = "0" border = "0">
<%

order = "even" 

For i = 1 To 10
	textblocknum = i
	TB = "TB" & i
	TempPageHeading = pageheadings(i)
	TempPageText =  PageTextArray(i)
	tempImage =   ImageArray(i) 
	TempBloguploadImageFile = "BlogAdminUploadImage" & i & ".asp"
	TempImageCaption =   ImageCaptionArray(i)
	TempImageOrientation =  ImageOrientationArray(i)
	TempTextBlock = "TextBlock" & i
   TempHeader = "Pageheading" & i
	if TempPageText ="0" then
	   TempPageText = " "
	end if
	   
	if len(TempPageText) > 1 then
		For loopi=1 to Len( TempPageText )
		    spec = Mid(TempPageText, loopi, 1)
		    specchar = ASC(spec)
		    if specchar < 32 or specchar > 126 then
				TempPageText= Replace(TempPageText,  spec, " ")
			end if
  		Next
	end if

   if len(TempPageHeading) > 1 then
		For loopi=1 to Len( TempPageHeading )
    		spec = Mid(TempPageHeading, loopi, 1)
    		specchar = ASC(spec)
    		if specchar < 32 or specchar > 126 then
				TempPageHeading= Replace(TempPageHeading,  spec, " ")
			end if
  
		Next
	end if

   if len(TempImageCaption) > 1 then
		For loopi=1 to Len( TempImageCaption )
		    spec = Mid(TempImageCaption, loopi, 1)
		    specchar = ASC(spec)
		    if specchar < 32 or specchar > 126 then
				TempImageCaption= Replace(TempImageCaption,  spec, " ")
			end if
  		Next
	end if
%>
 
 
<!-- #include virtual="/Administration/BlogAdmin/AdminBlogArticleMaintenanceInclude.asp" -->
<% next %>
</table>
         
 <% else %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=pagewidth %>"><tr><td align = "left">
		<H2><div align = "left">Edit Blog Entry</div></H2>
        </td></tr>
        <tr><td  align = "center" width = "100%"  valign = "top" > 
			<form action= 'BlogAdminHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
						<b>Heading: </b><br />
					<input name="Text"  size = "40" value = "<%=PageTitle%>" class = "rergsubmit2 body"><br />
						<b>Date: </b><br />
		<select size="1" name="BlogMonth" align = "left" class = "regsubmit2 body">
				<div align = "left"><% if len(BlogMonth) > 0 then %>
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
				/ <select size="1" name="BlogDay" class = "regsubmit2 body">
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
		<select size="1" name="BlogYear" class = "regsubmit2 body">
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
					</div>
					<BR />
					<center>
			<input type=submit value = "Submit" class = "regsubmit2 body"></center><br />
		</td>
		</tr>

</form>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<%

order = "even" 

For i = 1 To 10
	textblocknum = i
	TB = "TB" & i
	TempPageHeading = pageheadings(i)
	TempPageText =  PageTextArray(i)
	tempImage =   ImageArray(i) 
	TempBloguploadImageFile = "BlogAdminUploadImage" & i & ".asp"
	TempImageCaption =   ImageCaptionArray(i)
	TempImageOrientation =  ImageOrientationArray(i)
	TempTextBlock = "TextBlock" & i
   TempHeader = "Pageheading" & i
	if TempPageText ="0" then
	   TempPageText = " "
	end if
	   
	if len(TempPageText) > 1 then
		For loopi=1 to Len( TempPageText )
		    spec = Mid(TempPageText, loopi, 1)
		    specchar = ASC(spec)
		    if specchar < 32 or specchar > 126 then
				TempPageText= Replace(TempPageText,  spec, " ")
			end if
  		Next
	end if

   if len(TempPageHeading) > 1 then
		For loopi=1 to Len( TempPageHeading )
    		spec = Mid(TempPageHeading, loopi, 1)
    		specchar = ASC(spec)
    		if specchar < 32 or specchar > 126 then
				TempPageHeading= Replace(TempPageHeading,  spec, " ")
			end if
  
		Next
	end if

   if len(TempImageCaption) > 1 then
		For loopi=1 to Len( TempImageCaption )
		    spec = Mid(TempImageCaption, loopi, 1)
		    specchar = ASC(spec)
		    if specchar < 32 or specchar > 126 then
				TempImageCaption= Replace(TempImageCaption,  spec, " ")
			end if
  		Next
	end if
%>
 
 
<!-- #include virtual="/Administration/BlogAdmin/AdminBlogArticleMaintenanceInclude.asp" -->
<% next %>
</td></tr></table>
 <% end if %>



  

<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></div>
</td>
</tr>
</table><br>
<!-- #include virtual="/Administration/AdminFooter.asp" -->
 
 </Body>
</HTML>
