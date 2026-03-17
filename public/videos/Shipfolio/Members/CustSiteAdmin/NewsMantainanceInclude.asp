

<!--#Include file="NewsHeader.asp"--> 


<table border = "0">
<tr>
  <td colspan = "2">




				<%  
				dim aID(4000)
				dim aNewsHeadline(4000)
				dim aNews(4000)
				Dim NewsCategoryName(4000)
				Dim NewsCatID(4000) 

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sqlx =  "select * from NewsCategories where not (NewsCatID =2)"

			
			Set rsx = Server.CreateObject("ADODB.Recordset")
			rsx.Open sqlx, conn, 3, 3 
			catcounter = 0
			While Not rsx.eof  
				NewsCategoryName(CatCounter) = rsx("NewsCategoryName")
				NewsCatID(CatCounter) = rsx("NewsCatID")	
		


				catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			FinalCatCounter = catcounter 



			rsx.close

				sql2 =  "select * from News"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("NewsID")
				aNewsHeadline(acounter) = rs2("NewsHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
	



%>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<H2>Edit a Different News<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
			<form action= 'NewsMantainance.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top" class = "body">
				 
					News's Name: <select size="1" name="NewsID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
						If Len(aNewsHeadline(count))> 2 then
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aNewsHeadline(count)%>
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

TempNewsID=Request.Form("NewsID" ) 


 sql = "select * from News"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	

	
Recordcount = rs.RecordCount +1
%>


   
	
 
<%    If Len(TempNewsID) > 0 then
Dim NewsCatName 
Dim 	 NewsID
Dim 	 NewsPageNumber 
Dim 	 NewsHeadline
Dim 	 NewsImage 
Dim 	 NewsText 
Dim  Author
Dim 	 AuthorLink 


%>
<table border = "0">
</tr>
  <tr>
		<td class = "body" colspan = "4">
		<H2>Edit News Information<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>

<%

 sql = "select * from News, Newscategories where News.NewsCatID = NewsCategories.NewsCatID  and  NewsID = " & TempNewsID

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
		<th  >News</th>
	</tr>



	
<%
if Not rs.eof  then
	NewsImage = ""	
	 NewsID =   rs("NewsID")
	 NewsPageNumber =   rs("NewsPageNumber")
	 NewsHeadline =   rs("NewsHeadline")
	 NewsImage=   rs("NewsImage")
	 NewsText =   rs("NewsText")
     Author =   rs("Author")	
	 AuthorLink =   rs("AuthorLink")
	CurrentNewsCatID =  rs("News.NewsCatID")
	CurrentNewsCategoryName =  rs("NewsCategoryName")
'response.write(CurrentNewsCatID)
%>

	
	<tr >
	 <td class = "body" valign = "top">
			<%		
			If Len(Trim(NewsImage)) < 2 Then
					 NewsImage = "ImageNotAvailable.jpg"
				   End If %>

			<img src = "../uploads/<%= NewsImage%>" width = "65"><br>
		   <a href = "AdminNewsPhotos.asp?NewsID=<%= NewsID%>" class = "body" >Edit Photo</a>

		<form action= 'Newshandleform.asp' method = "post">
		<input type = "hidden" name="NewsID" value= "<%= NewsID%>" >
		 </td>
		 <td nowrap valign = "top">
		 <table>
		 <tr>
				    <td  class= "body">Title: </td>
					<td><input type = "Text" name="NewsHeadline" value= "<%=NewsHeadline%>" size = "80">
					</td>
				</tr>
		   <tr>
		      <td  class= "body">
					Category:
			  </td>
			   <td>
		 <% 		CatCounter= 0
					 %>
		          <select size="1" name="NewsCatID">
					<option name = "NewsID0" value= "<%=CurrentNewsCatID%>" selected><%=CurrentNewsCategoryName%></option>
					<% 
						While CatCounter < FinalCatCounter
						
					%>
						<option value="<%=NewsCatID(CatCounter)%>">
							<%=NewsCategoryName(CatCounter)%>
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
						<textarea name="NewsText"  cols="85" rows="20"   class = "body"  ><%= Newstext%></textarea>
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