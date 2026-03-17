

<!--#Include file="ArticleHeader.asp"--> 


<table border = "0">
<tr>
  <td colspan = "2">




				<%  
				dim aID(4000)
				dim aArticleHeadline(4000)
				dim aArticle(4000)
				Dim ArticleCategoryName(4000)
				Dim ArticleCatID(4000) 

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sqlx =  "select * from ArticleCategories where not (ArticleCatID =2)"

			
			Set rsx = Server.CreateObject("ADODB.Recordset")
			rsx.Open sqlx, conn, 3, 3 
			catcounter = 0
			While Not rsx.eof  
				ArticleCategoryName(CatCounter) = rsx("ArticleCategoryName")
				ArticleCatID(CatCounter) = rsx("ArticleCatID")	
		


				catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			FinalCatCounter = catcounter 



			rsx.close

				sql2 =  "select * from Articles"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ArticleID")
				aArticleHeadline(acounter) = rs2("ArticleHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
	



%>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<H2>Edit a Different Article<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
			<form action= 'ArticleMantainance.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top" class = "body">
				 
					Article's Name: <select size="1" name="ArticleID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
						If Len(aArticleHeadline(count))> 2 then
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aArticleHeadline(count)%>
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

TempArticleID=Request.Form("ArticleID" ) 


 sql = "select * from Articles"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	

	
Recordcount = rs.RecordCount +1
%>


   
	
 
<%    If Len(TempArticleID) > 0 then
Dim ArticleCatName 
Dim 	 ArticleID
Dim 	 ArticlePageNumber 
Dim 	 ArticleHeadline
Dim 	 ArticleImage 
Dim 	 ArticleText 
Dim  Author
Dim 	 AuthorLink 


%>
<table border = "0">
</tr>
  <tr>
		<td class = "body" colspan = "4">
		<H2>Edit Article Information<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>

<%

 sql = "select * from Articles, Articlecategories where Articles.ArticleCatID = ArticleCategories.ArticleCatID  and  articleID = " & TempArticleID

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
		<th  >Article</th>
	</tr>



	
<%
if Not rs.eof  then
	ArticleImage = ""	
	 ArticleID =   rs("ArticleID")
	 ArticlePageNumber =   rs("ArticlePageNumber")
	 ArticleHeadline =   rs("ArticleHeadline")
	 ArticleImage=   rs("ArticleImage")
	 ArticleText =   rs("ArticleText")
     Author =   rs("Author")	
	 AuthorLink =   rs("AuthorLink")
	CurrentArticleCatID =  rs("Articles.ArticleCatID")
	CurrentArticleCategoryName =  rs("ArticleCategoryName")
'response.write(CurrentArticleCatID)
%>

	
	<tr >
	 <td class = "body" valign = "top">
			<%		
			If Len(Trim(ArticleImage)) < 2 Then
					 ArticleImage = "ImageNotAvailable.jpg"
				   End If %>

			<img src = "../uploads/<%= ArticleImage%>" width = "65"><br>
		   <a href = "AdminArticlePhotos.asp?ArticleID=<%= ArticleID%>" class = "body" >Edit Photo</a>

		<form action= 'Articlehandleform.asp' method = "post">
		<input type = "hidden" name="ArticleID" value= "<%= ArticleID%>" >
		 </td>
		 <td nowrap valign = "top">
		 <table>
		 <tr>
				    <td  class= "body">Title: </td>
					<td><input type = "Text" name="ArticleHeadline" value= "<%=ArticleHeadline%>" size = "80">
					</td>
				</tr>
		   <tr>
		      <td  class= "body">
					Category:
			  </td>
			   <td>
		 <% 		CatCounter= 0
					 %>
		          <select size="1" name="ArticleCatID">
					<option name = "ArticleID0" value= "<%=CurrentArticleCatID%>" selected><%=CurrentArticleCategoryName%></option>
					<% 
						While CatCounter < FinalCatCounter
						
					%>
						<option value="<%=ArticleCatID(CatCounter)%>">
							<%=ArticleCategoryName(CatCounter)%>
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
						<textarea name="ArticleText"  cols="85" rows="20"   class = "body"  ><%= Articletext%></textarea>
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