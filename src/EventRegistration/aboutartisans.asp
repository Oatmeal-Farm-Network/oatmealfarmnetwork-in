
<html>
<head>

<%  PageName = "About Artisans" %>
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

<!--#Include virtual="Header.asp"-->
<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" height = "230" width = "100%">
	<tr>
	

	<td class = "body" valign = "top">
		<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" valign = "top" width = "720">
		<tr>
				<td class = "body" align ="left">
					<br><h1><%=PageTitle %></h1>
				</td>
			</tr>
		<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1"><img src = "images/px.gif" height = "1"></td>
			</tr>
		

			<tr>
			   <td class = "body">
						<blockquote>
							<br><% If Len(Image1) > 1 Then %> 
									<img src = "<%=Image1 %>" align = "right" valign = "top" width = "290">
							<% end if %>
							<%=PageText %></blockquote>
	
				
</td>
		
	</tr>
</table>

		</td>
	</tr>
</table>

 <!--#Include virtual="Footer.asp"--> 
</body>
</html>
