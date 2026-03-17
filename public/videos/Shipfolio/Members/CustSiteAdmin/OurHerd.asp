<% SetLocale("en-us") %>
<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<!--#Include virtual="/FormatPrice.asp"--> 
<title><%= WebSiteName %> - <%= Breed %> Our Alpaca Herd</title>
<meta name="description" content="<%= Breed %> Our Alpaca Herd">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">


</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   bgcolor = "#D7E3D7">

<!--#Include virtual="/Header.asp"-->
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top">
	<tr>
		<td><img src = "images/HeadingAlpacaHerd.jpg">
		<center><a href = "#Females" class ="body">&nbsp; Females |</a> 
						 <a href = "#Males" class ="body">&nbsp; Males  </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></td>
	</tr>
</table>


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "right"  width = "610"  height = "350" valign ="top">
	<tr>		
		 <td  align = "center" valign ="top">

				<table width = "610"   border="0" cellspacing="0" cellpadding="0"  align = "center">
					<tr>
						<td  class = "body" valign = "top"  align = "center">
							<table width = "610"   border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class = "body" valign = "top" width = "300">
											<br>
				
											

<a name="Females"></a>
<table border = "0" width = "610"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
	<td colspan = "2"  valign = "top" height = "20" valign = "bottom" >
			<H2>Female Alpacas</H2></td>
		</tr>
		<tr>
		<td colspan = "2"  valign = "top" height = "2" valign = "top" background = "images/Ledge.jpg">
			<img src = "images/px.gif" height = "2" border = "0"></td>
		</tr>		
	<tr>
				<td colspan = "2" height = "9" valign = "top">&nbsp;</td>
</tr>

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select * from WebView where (Category = 'Dam' ) or (Category = 'Maiden' ) order by FullName " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" ><blockquote>We currently do not have any of our female Alpacas for sale.  Please check back with us for updates!</blockquote>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Dam" %>
<!--#Include virtual="/GlobalVariables.asp"-->DetailInclude.asp"--> 









	<a name="Males"></a>
<table border = "0" width = "610"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
	<td colspan = "2"  valign = "top" height = "20" valign = "bottom" >
			<H2>Male Alpacas</H2></td>
		</tr>
			<tr>
		<td colspan = "2"  valign = "top" height = "2" valign = "top" background = "images/Ledge.jpg">
			<img src = "images/px.gif" height = "2" border = "0"></td>
		</tr>		
	<tr>
				<td colspan = "2" height = "9" valign = "top">&nbsp;</td>
</tr>

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select * from WebView where Category = 'Herdsire' or Category = 'Jr. Herdsire' or Category = 'Juvenile Male'  order by FullName " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" ><blockquote>We currently do not have any of our Male Alpacas for sale.  Please check back with us for updates!</blockquote>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Sire" %>
<!--#Include virtual="/GlobalVariables.asp"-->DetailInclude.asp"--> 
<br>


<br>


<br>

</td>
		</tr>
</table>
			</td>
		</tr>
</table>
			</td>
		</tr>
</table>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

