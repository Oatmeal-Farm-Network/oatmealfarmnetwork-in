
<html>
<head>

<%  PageName = "About The Shop" %>
<!--#Include virtual="GlobalVariables.asp"-->

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
<link rel="shortcut icon" href="<%=ShortIcon%>" /> 
<link rel="icon" href="<%=LongIcon%>" /> 
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="BarnStyle.css">


</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<!--#Include file="Header.asp"-->

	<a name = "Store">		
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   height = "250" width = " 780" >
	<tr>
	<td >
    <Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" valign = "top" width = "100%">
			<tr>
				<td class = "body" align ="left">
					<br><h1><%=PageTitle %></h1>
				</td>
			</tr>
		<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1"><img src = "images/px.gif" height = "1"></td>
			</tr>
		
			<tr>
			   <td class = "body"><br>
						<blockquote>
							<% If Len(Image1) > 1 Then %> 
									<img src = "<%=Image1 %>"  valign = "top" width = "250" align = "right"><br>
							<% end if %>
							<%=PageText %></blockquote>
	
				
</td>
		
	</tr>
</table>
</td>
</tr>	
	
	
	<%  PageName = "About the Products" %>
<% rs.close
'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************

	sql = "select * from pageLayout where PageName = '" & PageName & "';"
	'response.write(sql)
	rs.Open sql, conn, 3, 3
If Not rs.eof then
	'**************************************************************
	 ' Gather Page Content
	'**************************************************************
	'HeaderImage = rs("HeaderImage")
	'FooterImage = rs("FooterImage")
	Image1 = rs("Image1")
	Image2 = rs("Image2")
	PageTitle = rs("PageTitle")
	PageText = rs("PageText")

					PageHeading1= rs("PageHeading1")
					PageHeading2= rs("PageHeading2")
					PageHeading3= rs("PageHeading3")
					PageHeading4= rs("PageHeading4")
					PageText = rs("PageText")
					PageText2 = rs("PageText2")
					PageText3 = rs("PageText3")
					PageText4 = rs("PageText4")
					Image1= rs("Image1")
					Image2= rs("Image2")
					Image3= rs("Image3")
					Image4= rs("Image4")
					ImageCaption1= rs("ImageCaption1")
					ImageCaption2= rs("ImageCaption2")
					ImageCaption3= rs("ImageCaption3")
					ImageCaption4= rs("ImageCaption4")
					ImageOrientation1= rs("ImageOrientation1")
					ImageOrientation2= rs("ImageOrientation2")
					ImageOrientation3= rs("ImageOrientation3")
					ImageOrientation4= rs("ImageOrientation4")




End if
'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close
%>
	<tr>
	<a name = "Products"></a>	
		<td class = "body" valign = "top"   >			
		<h1><%=PageTitle %></h1>
		</td>
		</tr>
			<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1"><img src = "images/px.gif" height = "1"></td>
			</tr>
		<tr>
		   <td class = "body">
			<blockquote><% If Len(Image1) > 1 Then %> 
									<img src = "<%=Image1 %>"  valign = "top" width = "250" align = "right"><br>
							<% end if %>
							<%=PageText %><br><br>



				<%
				Dim CategoryIDList(100)
				Dim CategoryNameList(100)
				subject = "For Sale"

				SCounter = 0
					conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
					"Data Source=" & server.mappath(databasepath) & ";" & _
					"User Id=;Password=;" 

					sql = "select * from SFCategories  order by CatName  ;"

			'response.write(sql)
					Set rs = Server.CreateObject("ADODB.Recordset")
					 rs.Open sql, conn, 3, 3 

					While not rs.eof 
						SCounter = SCounter +1 
						
						CategoryIDList(SCounter) = rs("CatID")
						CategoryNameList(SCounter) = rs("CatName")
						'RESPONSE.WRITE(CategoryNameList(SCounter) )
					 rs.movenext
					Wend
					FinalCount = SCounter
				
				rs.Close


		SCounter = 0
		While Scounter < FinalCount
							SCounter = SCounter +1  
							
						
							sql = "select * from sfProducts where prodCategoryId = " & CategoryIDList(SCounter) & ";"
							'response.write(sql)
							Set rs = Server.CreateObject("ADODB.Recordset")
							rs.Open sql, conn, 3, 3 
							
						
						%>
					
				&nbsp;<a href = "SearchResults.asp?CatID=<%=CategoryIDList(SCounter)%>" class = "body"><%=CategoryNameList(SCounter)%></a> <br>


		
		<% Wend
		SCounter = 0
%>



</blockquote>



</td>

</tr>
</table>
<!--#Include file="Footer.asp"-->



</body>
</html>