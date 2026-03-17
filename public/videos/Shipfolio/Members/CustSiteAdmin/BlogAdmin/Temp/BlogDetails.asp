<% SetLocale("en-us") %>
<html>
<head>
<%  PageName = "Blog" %>
<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= SEOTitle %> </title>
<META name="description" content="<%= SEODescription %> ">
<META name="keywords" content="<%= SEOKeyword1 %>, 
<%=SEOKeyword2%>, 
<%=SEOKeyword3 %>,
<%=SEOKeyword4 %>, 
<%=SEOKeyword5 %>, 
<%=SEOKeyword6 %>,  
<%=SEOKeyword7 %>, 
<%=SEOKeyword8 %>, 
<%=SEOKeyword9 %>, 
<%=SEOKeyword10 %>, 
<%=SEOKeyword11 %>, 
 <%=SEOKeyword12 %>, 
 <%=SEOKeyword13 %>, 
 <%=SEOKeyword14 %>, 
 <%=SEOKeyword15 %>, 
 <%=SEOKeyword16 %>, 
 <%=SEOKeyword17 %>, 
 <%=SEOKeyword18 %>, 
 <%=SEOKeyword19 %>, 
 <%=SEOKeyword20 %> ">


<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="<%=style%>">

</HEAD>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<!--#Include file="Header.asp"-->
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   width = "<%=TextWidth%>">
	<tr>
	    <td class = "body"  >
			<h1><%=PageTitle %></h1>
			</td>
	</tr>

		</table>
		
	
		
	<table border = "0" width = "<%=TextWidth%>" align = "center">
<tr>
  <td colspan = "2" class = "body">




				<%
				   dim aBlogID(40000)
					dim aBlogHeadline(40000)
					dim aBlog(40000)


					BlogID= Request.QueryString("BlogID") 
				
				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
					Set rs = Server.CreateObject("ADODB.Recordset")

				
				sql =  "select * from Blog where BlogID = " & BlogID
			'response.write(sql2)
			acounter = 1
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3 
	
			if Not rs.eof  then
				BlogHeadline = rs("BlogHeadline")
				Author = rs("Author")
				AuthorLink = rs("AuthorLink")
				CurrentCatID= rs("BlogCatID")
			end	if
	Dim pageheadings(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)

 For i = 1 To 20
	 'response.write("i=" & i)
		 pageheadings(i) = rs("PageHeading" & i  )
		 PageTextArray(i) = rs("BlogText" & i )
		 ImageArray(i) = rs("BlogImage" & i )
	
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
	<br>
		<h2><%=BlogHeadline %></h2>
		<% If Len(Author) > 1 Then%>
			by <%=Author %>
		<% End If %>
		<% If Len(AuthorLink) > 1 Then%>
				<a href = "http://<%=	AuthorLink %>" class = "body" target = "blank"><%=	AuthorLink %></a>
		<% end if %>
		<br>
	<%
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
			
			If Len(TempPageText ) > 2 then
			%>
			
<!--#Include file="CaptionedPageTextInclude.asp"-->
<br>	
<%  End If 

Next %>



		<% If Len(BlogImage) > 1 Then%>
				<img src = "/uploads/<%= BlogImage %>" align = "right" border = "2" width = "200">
		<% End If %>
			<%=	BlogText %>

</blockquote>
<br><br>


		</td>
	</tr>
</table>	


<%						conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
'Set rs = Server.CreateObject("ADODB.Recordset")
				'sql =  "select * from BlogCategories where not (BlogCatID = 2)"
				'rs.Open sql, conn, 3, 3 
				'While Not rs.eof 
				 '  CurrentCatID  = rs("BlogCatID")
				 '  BlogCategoryName   = rs("BlogCategoryName")
				   %>
				 
				 


			<%	

			 
				If CurrentCatID = 1 then
				sql2 =  "select * from Blog order by BlogID"
				Else
				  			sql2 =  "select * from Blog where BlogCatID= " & CurrentCatID & " order by BlogHeadline"

				End if
'response.write(sql2)
			acounter = 1

			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aBlogID(acounter) = rs2("BlogID")
				aBlogHeadline(acounter) = rs2("BlogHeadline")

				acounter = acounter +1
				rs2.movenext
			Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing

%>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=TextWidth%>" align = "center">
	<tr>
		<td valign = "top" class = "body">
	  <blockquote>
	  <h3>Related Blog:</h3>

		  <% count = 0 
		while count < acounter
		  count = count +1 %>
				 	 &nbsp;<a href = "BlogDetails.asp?BlogID=<%=aBlogID(count)%>&CatID=<%=CurrentCatID%>" class = "body"><%=aBlogHeadline(count)%></a><br>
		<% Wend %>

 &nbsp;<a href = "Library.asp" class = "body"><big>View the Complete List of Blog</big></a><br>
		 </blockquote>
		</td>
	</tr>
</table>

<% 'rs.movenext
				'Wend

				set conn = Nothing
				
				%>
		
	
<!--#Include file="Footer.asp"--> 
</body>
</html>

