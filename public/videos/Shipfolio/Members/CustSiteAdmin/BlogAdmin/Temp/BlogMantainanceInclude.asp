

<!--#Include file="BlogHeader.asp"--> 


<table border = "0">
<tr>
  <td colspan = "2">




				<%  
				dim aID(4000)
				dim aBlogHeadline(4000)
				dim aBlog(4000)
				Dim BlogCategoryName(4000)
				Dim BlogCatID(4000) 

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sqlx =  "select * from BlogCategories where not (BlogCatID =2)"

			
			Set rsx = Server.CreateObject("ADODB.Recordset")
			rsx.Open sqlx, conn, 3, 3 
			catcounter = 0
			While Not rsx.eof  
				BlogCategoryName(CatCounter) = rsx("BlogCategoryName")
				BlogCatID(CatCounter) = rsx("BlogCatID")	
		


				catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			FinalCatCounter = catcounter 



			rsx.close

				sql2 =  "select * from Blog"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("BlogID")
				aBlogHeadline(acounter) = rs2("BlogHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
	



%>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<H2>Edit a Different Blog<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
			<form action= 'BlogMantainance.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top" class = "body">
				 
					Blog's Name: <select size="1" name="BlogID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
						If Len(aBlogHeadline(count))> 2 then
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aBlogHeadline(count)%>
						</option>
					<%  End if
					
					count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>


<%

TempBlogID=Request.Form("BlogID" ) 


 sql = "select * from Blog"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	

	
Recordcount = rs.RecordCount +1
%>


   
	
 
<%    If Len(TempBlogID) > 0 then
Dim BlogCatName 
Dim 	 BlogID
Dim 	 BlogPageNumber 
Dim 	 BlogHeadline
Dim 	 BlogImage 
Dim 	 BlogText 
Dim  Author
Dim 	 AuthorLink 


%>
<table border = "0">
</tr>
  <tr>
		<td class = "body" colspan = "4">
		<H2>Edit Blog Information<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>

<%

 sql = "select * from Blog, Blogcategories where Blog.BlogCatID = BlogCategories.BlogCatID  and  BlogID = " & TempBlogID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>

<table border = "0">
 
<tr>
  <td colspan = "2">

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	
	<tr>
		<th >Image</th>
		<th  >Blog</th>
	</tr>



	
<%
if Not rs.eof  then
	BlogImage = ""	
	 BlogID =   rs("BlogID")
	 BlogPageNumber =   rs("BlogPageNumber")
	 BlogHeadline =   rs("BlogHeadline")
	 BlogImage=   rs("BlogImage1")
	 BlogText =   rs("BlogText")
     Author =   rs("Author")	
	 AuthorLink =   rs("AuthorLink")
	CurrentBlogCatID =  rs("Blog.BlogCatID")
	CurrentBlogCategoryName =  rs("BlogCategoryName")
'response.write(CurrentBlogCatID)
%>

	
	<tr >
	 <td class = "body" valign = "top">
			<%		
			If Len(Trim(BlogImage)) < 2 Then
					 BlogImage = "ImageNotAvailable.jpg"
				   End If %>

			<img src = "../uploads/<%= BlogImage%>" width = "65"><br>
		   <a href = "AdminBlogPhotos.asp?BlogID=<%= BlogID%>" class = "body" >Edit Photo</a>

		<form action= 'Bloghandleform.asp' method = "post">
		<input type = "hidden" name="BlogID" value= "<%= BlogID%>" >
		 </td>
		 <td nowrap valign = "top">
		 <table>
		 <tr>
				    <td  class= "body">Title: </td>
					<td><input type = "Text" name="BlogHeadline" value= "<%=BlogHeadline%>" size = "80">
					</td>
				</tr>
		   <tr>
		      <td  class= "body">
					Category:
			  </td>
			   <td>
		 <% 		CatCounter= 0
					 %>
		          <select size="1" name="BlogCatID">
					<option name = "BlogID0" value= "<%=CurrentBlogCatID%>" selected><%=CurrentBlogCategoryName%></option>
					<% 
						While CatCounter < FinalCatCounter
						
					%>
						<option value="<%=BlogCatID(CatCounter)%>">
							<%=BlogCategoryName(CatCounter)%>
						</option>
					<% 	CatCounter= CatCounter +1
					wend 
					%>
					

					</select>
						</td>
					</tr>
		    
			    
				<tr>
					<td  valign = "top" class = "body">
						Author: 
						</td>
			   <td><input type = "Text" name="Author" value= "<%= Author%>" size = "80">
					</td>
				<tr>
					<td  valign = "top" class = "body">
						Link: </td>
			   <td>
			   <small>http://</small><input type = "Text" name="AuthorLink" value= "<%= AuthorLink%>" >
					</td>
				</tr>
				<tr>
					<td  class= "body" valign = "top">Text: </td>
			   <td>
						<textarea name="BlogText"  cols="85" rows="20"   class = "body"  ><%= Blogtext%></textarea>
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
	

<%

	End if
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "8" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 

<% End If %>



<br><br><br><br>
<br><br><br><br>