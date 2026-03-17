<html>
 <head>

 <!--#Include virtual="/GlobalVariables.asp"-->
 <!--#Include virtual="/StudsDetailDBInclude.asp"--> 
<title><%= WebSiteName %> Stud - <%=rs("FullName")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META name="description" content="<%= WebSiteName %> - <%= Slogan %>">
<META name="keywords" content="<%= WebSiteName %>, <%= Slogan %>, Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" href="style.css" type="text/css">


</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = rs("FullName") %>
<!--#Include virtual="/HerdsiresHeader.asp"-->



<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
    <tr>
		<td class = "body" valign = "top" height = "200">
				<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "620"  >
				<tr>
				<td   valign="top">
						<!--#Include virtual="/StudGeneralStatsInclude.asp"--> 
						
					</td>
					<td class = "body" valign = "top" align = "center" width = "320">
						<table valign = "top" border = "0">
							<tr>
								<td valign = "top"><!--#Include virtual="/DetailImageInclude.asp"--></td></tr> 
								<tr><td><!--#Include virtual="/ServiceSireInclude.asp"--> </td></tr>
								<tr><td colspan = "2"><!--#Include virtual="/AwardsInclude.asp"--></td></tr>
							</tr>
						</table>
					</td>
					
				</tr>
				</table>

		<br><br>
	</td>
				</tr>
				</table>		 
				<!--#Include virtual="/FiberInclude.asp"--> 
				<center><!--#Include virtual="/ProgenyInclude.asp"--> </center>
				<!--#Include virtual="/AncestryInclude.asp"--> 

				</td>
				</tr>
				</table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>