<!DOCTYPE HTML>
<html>
<head>
<%  PageName = "Articles" %>
<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<% ArticleID= Request.QueryString("ArticleID") 
CatId= Request.querystring("CatID") %>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ArticleID=' + ArticleID + '&CatId=' + CatId);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="Header.asp"-->   

<%
dim aArticleID(40000)
dim aArticleHeadline(40000)
dim aArticle(40000)
sql =  "select * from Articles where ArticleID = " & ArticleID
'response.write(sql2)
acounter = 1
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if Not rs.eof  then
ArticleHeadline = rs("ArticleHeadline")
Author = rs("Author")
AuthorLink = rs("AuthorLink")
CurrentCatID= rs("ArticleCatID")
end	if
Dim pageheadings(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
For i = 1 To 20
'response.write("i=" & i)
pageheadings(i) = rs("PageHeading" & i  )
PageTextArray(i) = rs("ArticleText" & i )
ImageArray(i) = rs("ArticleImage" & i )
ImageCaptionArray(i) = rs("ImageCaption" & i )
ImageOrientationArray(i) = rs("ImageOrientation" & i )
str1 = PageTextArray(i)
str2 = vblf
If InStr(str1,str2) > 0 Then
PageTextArray(i)= Replace(str1, str2 , "</br>")
End If  
str1 = PageTextArray(i)
str2 = vbtab
If InStr(str1,str2) > 0 Then
PageTextArray(i)= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
Next
rs.close
set rs=nothing
%>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   width = "<%=screenWidth-35%>">
	<tr>
	    <td class = "body"  >
	<h1><%=ArticleHeadline %></h1>
	</td>
	</tr>
<tr>
  <td colspan = "2" class = "body">
  <center>
<% If Len(Author) > 1 Then%>
	by <%=Author %>
<% End If %>
<% If Len(AuthorLink) > 1 Then%>
<a href = "http://<%=	AuthorLink %>" class = "body" target = "blank"><%=	AuthorLink %></a>
<% end if %>
<br></center>
<% 
Screenwidth = screenwidth - 50
 textwidth = screenwidth - 50
 For i = 1 To 20
           If Len(ImageOrientationArray(i) ) > 1 then
	TempOrientation = ImageOrientationArray(i) 
Else
TempOrientation = "Right"
End If 

	TempImage = ImageArray(i) 
	TempImageCaption =  ImageCaptionArray(i) 
	TempHeading = pageheadings(i)
	TempPageText = PageTextArray(i)  
	
If Len(TempPageText ) > 2 or len(TempImage) >4 then
	
If Len(TempPageText ) > 2  then
For loopi=1 to Len(TempPageText)
   spec = Mid(TempPageText, loopi, 1)
   specchar = ASC(spec)
   if specchar < 32 or specchar > 126 then
TempPageText= Replace(TempPageText,  spec, " ")
	end if
   next
end if   
	%>
<!--#Include file="CaptionedPageTextInclude.asp"-->
<%  End If 
Next %>
<% If Len(ArticleImage) > 1 Then%>
<img src = "/uploads/<%= ArticleImage %>" align = "right" border = "2" width = "200">
<% End If %>
<%= ArticleText %>
</blockquote>
</td>
	</tr>
</table>	
<%
If CurrentCatID = 1 then
sql2 =  "select * from Articles order by ArticleID"
Else
 	sql2 =  "select * from Articles where ArticleCatID= " & CurrentCatID & " order by ArticleHeadline"

End if
'response.write(sql2)
	acounter = 1

	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
aArticleID(acounter) = rs2("ArticleID")
aArticleHeadline(acounter) = rs2("ArticleHeadline")

acounter = acounter +1
rs2.movenext
	Wend
	
rs2.close
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenWidth-35%>" align = "center">
	<tr>
<td valign = "top" class = "body">
	  <blockquote>
	  <h3>Related Articles:</h3>

 <% count = 0 
while count < acounter
 count = count +1 %>
	 &nbsp;<a href = "ArticleDetails.asp?ArticleID=<%=aArticleID(count)%>&CatID=<%=CurrentCatID%>" class = "body"><%=aArticleHeadline(count)%></a><br>
<% Wend %>

 &nbsp;<a href = "Articles.asp" class = "body"><big>View the Complete List of Articles</big></a><br>
</blockquote>
<br /><br />
</td></tr></table>
</td></tr></table>
<% Screenwidth = screenwidth + 50 %>
<!--#Include file="Footer.asp"--> 
</body>
</html>

