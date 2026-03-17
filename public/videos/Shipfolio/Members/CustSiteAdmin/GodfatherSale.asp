<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Breeding Protocol</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "GodFather Sale"  %>
<!--#Include virtual="/SpecialsHeader.asp"-->

<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "Left" >
	<tr>		
		 <td   valign ="top" class = "body">
	 
	<center><h1>Make Us an Offer that We Can't Refuse!<br>
25% off? 30% off? Don't be shy!</h1></center>


    In an effort to keep our herd balanced in terms of age, colors and gender, we offer a selection of our fine alpacas for your consideration.  And we invite you to participate in deciding the reduced price at which the alpaca would be an asset to your herd.  Please note that our usual reproductive and live birth guarantees are included.  And we offer a <a href = "fs_EscrowReturnPolicy.htm" class = "body">"no-question Escrow/Return policy"</a> on all Internet Purchases.<br><br>

<h2>It's as Easy as 1,2,3!</h2>

<ol>
	<li>SELECT</b> - any alpaca from the group listed below.  Click for additional details and photos!
  	<li>PRICE</b> - set the price at which the alpaca would be an asset to your herd, 20%, 30% or even try 50% off!
	<li>OFFER</b> - <a href="mailto:richard@alpacasontheweb.com?subject=Please contact me regarding an offer/clarification on your GodFather Sale!" class = "body">Click here!</a> - to make an offer or seek clarification.* 
</ol>
<i>* Subject to prior sale - alpacas available for this sale change periodically!</i>
 <br>
<br><h2>GodFather Sale Specials<br><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "<%=bodywidth%>" height = "2" ><h2>
	
<%conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsLookupTable where special = 'Godfather'"
  Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If rs("Active")  = False then
%>
	Sorry, we do not have an active Godfather sale. Please check back later.


<%
	else
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
    sql = "SELECT WebView.*, Godfather.* FROM WebView, Godfather where Animals.ID = Godfather.ID order by Godfather.ID, AValue DESC" 
' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
%>

	<!--#Include virtual="/GodFatherSaleInclude.asp"-->	  

 <% End If %>
		</td>
		</tr>
	</table>

	<!--#Include virtual="/Footer.asp"-->


	
<!--Alpacas at Lone Ranch, Oregon, offers exquisite Alpacas for sale, trade, and breeding including highly desired maroon, black and grey alpacas and herdires.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, ALPACAS, ALPACAS, Alpacas for sale, Peruvian Alpacas, Accoyo Alpacas, male alpacas, female alpacas, black, black alpacas, grey, grey alpacas, gray, gray alpacas, maroon, maroon alpacas, crias, color, ranch, alpaca ranching, ranching, farm, llama, llamas, Alpacas at Lone Ranch, Gold Beach, Oregon, breeding, sales, trading, stud service, family business, black herdsires, grey herdsires, maroon herdsires, breeder, investment -->
</body>
</html>