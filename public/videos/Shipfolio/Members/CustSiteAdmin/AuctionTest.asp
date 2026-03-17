<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Auction</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!--#Include virtual="/Header.asp"-->
<%conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsLookupTable where special = 'Auction'"
  Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If rs("Active")  = False Then
	   Active = False
	 Else
		Active = True
	End If 
	'response.write(Active)
%>

<table border="0" cellpadding="5" cellspacing="0" width="800"  background = "images/PageBackground.jpg">
    <tr>
      <td class = "body" colspan = "2">
       <br><h1 ><i>&nbsp;Alpaca Auctions at Lone Ranch</i><img src = "images/Line.jpg" width = "440" height = "2"></h1>
	</td>
</tr>
<tr>
	<td valign = "top">

	   <table width = "720" align = "center" border = "0">
			<tr>
				<td class = "body" valign = "top" >
					<!--#Include virtual="/AuctionIncludetest.asp"-->        
			</td>


			<%  If   currentauction = True then %>

			<td class = "body"  valign = "top" width = "230">
				
								
				<!--#Include virtual="/AuctionHeaderInclude.asp"-->

			
			</td>
			</tr>
			<tr>
				<td>
				
				<h1>Stud Breeding Auctions</h1>
					<!--#Include virtual="/BreedingAuctionInclude.asp"-->   
<% End If %>
				</td>
			</tr>
		</table>
		
</td>
</tr>
</table>
		


	




	
<!--#Include virtual="/Footer.asp"-->


	
<!--Alpacas at Lone Ranch, Oregon, offers exquisite Alpacas for sale, trade, and breeding including highly desired maroon, black and grey alpacas and herdires.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, ALPACAS, ALPACAS, Alpacas for sale, Peruvian Alpacas, Accoyo Alpacas, male alpacas, female alpacas, black, black alpacas, grey, grey alpacas, gray, gray alpacas, maroon, maroon alpacas, crias, color, ranch, alpaca ranching, ranching, farm, llama, llamas, Alpacas at Lone Ranch, Gold Beach, Oregon, breeding, sales, trading, stud service, family business, black herdsires, grey herdsires, maroon herdsires, breeder, investment -->
</body>
</html>