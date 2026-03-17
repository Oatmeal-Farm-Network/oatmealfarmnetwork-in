<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<!--#Include virtual="/FormatPrice.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Female Alpacas for Sale</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "New Arrivals in " & Year(now) %>
<!--#Include virtual="/CriaHeader.asp"-->

<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "Left" >
	<tr>		
		 <td  align = "center" valign ="top">

				<table width = "610"   border="0" cellspacing="0" cellpadding="0"  align = "center">
					<tr>
						<td  class = "body" valign = "top"  align = "center">
							<table width = "610"   border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class = "body" valign = "top" width = "300">
																		



<table valign = "top" border = "0" width = "<%=bodywidth%>"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >


<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "SELECT distinct Animals.*, Pricing.*, Photos.listpageimage FROM Animals, Pricing, Photos WHERE Animals.ID=Pricing.ID  And  Animals.ID=Photos.ID and not(category = 'Related Progeny') order by DOB DESC" 

	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 




 	if rs.eof then %>
		  <tr><td class = "body" ><blockquote>We currently do not have any dams for sale.  Please check back with us for updates!</blockquote>
		<br><br></td></tr>  
	<%end if%>



<% DetailType = "Other" %>
<!--#Include virtual="/CriasDetailIncludesmall.asp"--> 


		</td>
		</tr>
</table>








<% If Nobody = False Then %>

	<div><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>
<% End If %>
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

