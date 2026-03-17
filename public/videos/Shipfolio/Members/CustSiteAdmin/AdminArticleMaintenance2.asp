<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body >

    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include File="AdminHeader.asp"--> 
<% Current3 = "EditArticles" %>

<% if mobiledevice = True  then %> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
        <tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Articles" class = "body">List of Articles</a><br />
<a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Article</a><br />
<a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Articles</a><br />
<a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Article Categories</a><br />
<H1><div align = "left">Edit Article</div></H1>
<% else %> 
<!--#Include file="AdminArticlesTabsInclude.asp"-->
<% if screenwidth > 768 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Article</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">  
        <% end if %>
  <% end if %> 
  
  


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

Session("ArticleID")=	ArticleID

    sql = "select * from Articles where ArticleID = " & ArticleID
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
<% if mobiledevice = True   then %> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%" >
        <tr><td  align = "center" width = "100%">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Basic Information</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">

<% end if %>

	<tr>
		<td valign = "top">
			 <form action= 'AdminArticleHandleForm2.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
		<table border = "0" bordercolor = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
  		<tr>
			<td  align = "right"   class = "body">
						<b>Heading: </b>
<% if mobiledevice = True  then %> 
<br />
<% end if %>
					<input name="Text"  size = "40" value = "<%=PageTitle%>">
			</td>
	 </tr>
	 <tr>
			<td  align = "right"   class = "body">
						<b>Author's Website: </b>
<% if mobiledevice = True  then %> 
<br />
<% end if %>
					http://<input name="AuthorLink"  size = "40" value = "<%=AuthorLink%>">
			</td>
	 </tr>
	  <tr>
      <td class = "body" align = "right" ><b>Category:</b>
<% if mobiledevice = True  then %> 
<br />
<% end if %>
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
   

<select size="1" name="ArticleCatID" class = "regsubmit2 body">
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
			<input type=submit value = "Submit Changes"  Class = "regsubmit2 body" >
			</form>
		</td>
		</tr>
		<% if mobiledevice = False then%>
		<tr>
			<td  align = "center" class = "body" colspan= "2"  height = "24" width = "100%">
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
					     <td class = "body" colspan = "2">
							<b>Current PDF: </b>
							<% If Len(ArticleUpload) > 4 Then %>
								<i><%=ArticleUpload%></b>
							<% Else %>
							<b>N/A</b>
							<% End If %></td>
					</tr>
				


							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminArticleUploadPDF.asp" >
				 <tr>
					     <td class = "body"  colspan = "2"><b>Upload Article:</b>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload" class="regsubmit2 body">	
						<td>
						</tr>
						 <tr>
					     <td class = "body" colspan = "2">
								<img src =  "images/Important_Triangle.png" width = "16"><b>Important:	PDF Format Only</b><br></form>
						<td>
						</tr>
							<% If Len(ArticleUpload) > 4 Then %>
	<tr>
					    <td class = "body" colspan = "2" align = "center">
							<form action= 'AdminArticleRemovePDF.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<center><input type=submit value="Remove This Article" class = "regsubmit2 body"></center>
							</form>
					</td>
				</tr>
				<% End If %>
				<% end if  %>
	</table>
</td>
</tr>
</table>
<br><br>
</td>
</tr>
</table>
<br>


<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>

<%


For i = 1 To 20


textblocknum = i
   TB = "TB" & i
   TempPageHeading = pageheadings(i)
   TempPageText =  PageTextArray(i)
   tempImage =   ImageArray(i) 
   TempArticleuploadImageFile = "AdminArticleUploadImage" & i & ".asp"
   TempImageCaption =   ImageCaptionArray(i)
   TempImageOrientation =  ImageOrientationArray(i)
   TempTextBlock = "TextBlock" & i
   %>
   <a name= <%=TempTextBlock %> ></a>
   <!--#Include File="AdminArticleBlockInclude.asp"--> 
<% next %>
<% if screenwidth > 768 then %>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>

</td>
</tr>
</table>
<% end if %>
<br />
<!-- #include File="AdminFooter.asp" -->
 </Body>
</HTML>
