<!--#Include file="ArticleHeader.asp"--> 

<% 
	  
CustID = session("CustID")


%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Add an Article<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br><br>
		</td>
	</tr>
</table>

<table border= "0">
<tr>
			<td  align = "center" class = "body" colspan= "2"  height = "24" width = "800">
					<big><b>Step 1: Enter Basic Information</b></big> </b>
			</td>
		</tr>
   <tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'ArticleAddHeader.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780">
  		<tr>
			<td  align = "right"   class = "body">
						<b>Page Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageTitle%>">
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
		
	</table>

<br><br>

