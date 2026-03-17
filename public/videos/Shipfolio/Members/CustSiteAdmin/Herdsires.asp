<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<!--#Include virtual="/FormatPrice.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Stud Services</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "Stud Services" %>
<!--#Include virtual="/HerdsiresHeader.asp"-->



<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
    <tr>
		<td class = "body" valign = "top" height = "200">
        By careful design, Alpacas at Lone Ranch has assembled an exceptional group of ribbon-winning Champion Herdsires in a range of genetically diverse colors including desired black. They meet strict criterion for being:

<ul>
	<li>Accoyo/Peruvian or U.S. born of Peruvian / Chilean descent. 
<li>Genetically diverse colors - fawn, maroon, black, white and grey. 
<li>Conformationally correct. 

<li>Fine fleeced. 

<li>Ribbon-winning Champions having excelled in the Show Ring. 

</ul>
<br>
In addition our breeding practices meet carefully organized professional standards: 

<ul>
	<li>Hand breeding. 

<li>Biologically-directed guidelines. 

<li>BVDV-free facility. 

<li>Meticulous records. 

<li>Superb care of females & crias. 

<li>Weekly breeding report sent to clients. 

<li>Multiple breeding discount. 

<li>Live birth guarantee. 
</ul>
Select from this outstanding group of colored Ribbon-Winning Champion Herdsires! 
<br><br>
						<div align = "center"><a href = "#Herdsires" class ="body">Herdsires |</a>
					   <a href = "#Jr.Herdsires" class ="body">Jr. Herdsires</a>&nbsp;&nbsp;&nbsp;</div>
		</td>
	</tr>
						<tr>
						<td >
						<h1>Herdsires<br><img src = "images/Line.jpg" width = "<%=bodywidth%>" height = "2" ></h1>
							</td>
					</tr>
	<tr>		
		 <td  align = "center" valign = "top">
				<table width = "610"    border="0" cellspacing="0" cellpadding="0" >

					<tr>
						<td  class = "body" valign = "top" align = "left">
							<table width = "610"    border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class = "body" valign = "top" width = "300">
											<br>
											
											<a name="Herdsires"></a>
<table border = "0" width = "610"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >



<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select distinct * from MaleWebView where (Category = 'Herdsire' or Animals.Category = 'Herdsire' ) order by colorcategoryID, Studfee DESC " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center" ><b>Currently we do not have any Herdsires available.</b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Sire" %>
<% StudType = "Herdsires" %>
<!--#Include virtual="/StudDetailInclude.asp"--> 
	


</td>
		</tr>
</table>
</td>
		</tr>
</table>
			</td>
		</tr>
		<tr>
			<td ><a name="Jr.Herdsires"></a>
				<h1>Jr. Herdsires<br><img src = "images/Line.jpg" width = "<%=bodywidth%>" height = "2" ></h1>
			</td>
		</tr>
		<tr>
			<td>


<table border = "0" width = "610"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
	

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select distinct * from MaleWebView where ( Animals.Category = 'Jr. Herdsire' ) order by colorcategoryID, Studfee DESC " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center" ><b>Currently we do not have any Jr. Herdsires available.</b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Sire" %>
<% StudType = "Jr. Herdsires" %>
<!--#Include virtual="/StudDetailInclude.asp"--> 
	




 <div><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>
			</td>
		</tr>
</table>
			
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

