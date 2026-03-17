<html>

<head>
 <!--#Include virtual="/GlobalVariables.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Alpaca Fleece</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">



<% 	
   
			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			
				sql = "select * from FleecePhotos order by PhotoOrder"
				rs.Open sql, conn, 3, 3
				'response.write(sql)
				
	
		if not rs.eof then 
			photoID = "nophoto"
			imagelength = len(rs("Image"))
			'response.write("imagelength=")
			'response.write(imagelength)
			if  imagelength > 5 then
				photoID = rs("Image")
			end if

           If photoID = "nophoto" then 
				click = "<img width=""285"" src=""/Uploads/FleecePage/NotAvailableD.jpg""> "
			Else
				click = "<img  width=""285"" src=""/Uploads/FleecePage/" & photoID & """>" 
			End If
		
   End If


dim buttonimages(20)
dim buttontitle(20)

		
	imageone = "/Uploads/FleecePage/" + rs("Image")
	counter = 0
	counttotal = rs.recordcount
	While counter < counttotal
		
		counter = counter +1
		buttonimages(counter) = "/Uploads/FleecePage/" & rs("Image")
		buttontitle(counter) = rs("ImageTitle")
		'response.write(rs("Image"))
%>
<script language="JavaScript">
               if (document.images) version = "n3";
               else version = "n2";
               if (version == "n3") {
				but<%=counter%>on = new Image(85, 115);
				but<%=counter%>on.src = "/Uploads/FleecePage/<%=rs("Image")%>";
			   }
	

       function img<%=counter%>(imgName) {
               if (version == "n3") {
               imgOn = eval("but<%=counter%>on.src");
               document [imgName].src = imgOn;               }       }
      
      
</script>

<% 
		if counter< counttotal then
			rs.movenext
		end if
	wend
%>






</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "Alpaca Fleece is processed into a Variety of Products " %>
<!--#Include virtual="/RanchHeader.asp"-->

<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "Left" >
       <tr> 
		<td class = "body" valign = "top" >
        
			<blockquote>
			
			At Alpacas at Lone Ranch, our Alpacas are shorn once a year.  There are three shearing areas: blanket, neck, leg and belly, and 6 grades of fineness.  It is important to know the grade of the fiber to determine its end use.<br><br>
<ul>
	<li><b>Grade 1    -    Ultrafine         <20 microns    </b>           (this is what you want to wear next to your skin)
	<li><b>Grade 2    -    Superfine        20 - 22.9 microns  </b>    (yarn, wear next to your skin)<br>
	<li><b>Grade 3    -    Fine                 23 - 25.9 microns </b>     (most versatile grade, yarn, textiles)<br>
	<li><b>Grade 4    -    Medium            26 - 28.9 microns </b>     (socks, throws)<br>
	<li><b>Grade 5    -    Intermediate    29 - 32.0 microns </b>     (mattress pads, comforters. quilt batting)  <br> 
	<li><b>Grade 6    -    Robust             32.1 - 35 microns  </b>    (rugs, stadium seat mats, car seats, stuffing for pet bedding, even insulation: R-95)</ul>
 </blockquote>
 
		</td>
		<td width = "300" valign = "top" align = "right"><!--#Include virtual="/FleeceImageInclude.asp"-->
		</td>
		</tr>
<tr>
	<td colspan = "2" class = "body">
	<blockquote>
Alpaca fiber is one of the less flammable and difficult to ignite fibers, with a slow spreading flame which is easy to extinguish.<br>
		<br>
We are members of the <a href = "http://www.americasalpaca.com/" class = "body" target = "_blank">Alpaca Fiber Cooperative of North America</a>, and send a portion of our annual clip to them to be converted into finished products for sale to its members at whole sale prices.  Another fiber coop is the  <a href ="http://www.neafp.com/" class = "body" target = "_blank">New England Alpaca Fiber Pool</a>.  They carry an inventory of products made in the US from US alpaca fleece. Each product requires us to send a certain amount of fleece and pay a reasonable wholesale price for socks, hats, blankets, etc. 
<br><br>

We ship our finest fleeces to a local mill to be processed into heavenly yarn, usually in skeins of 110 or 220 yards. Different colors of similar micron counts can be combined to produce various shades of natural colors. For instance, several of our white and one black fleece were spun into beautiful silver grey yarn, and we are adding silk and bamboo to create delicious blends. The yarn is available in our ranch store and we sell it at local events and alpaca shows.  We are over-dying some of the lighter yarns and are delighted with the results.  Rovings are also available, as is a small amount of raw fleece if you want to spin your own.  
 <br><br>

If you knit or crochet and have never used Alpaca yarn, you owe it to yourself to order some today!<br>  <a href = "mailto:Richard@AlpacasOnTheWeb.com" class = "body"> E-mail us</a> for colors and weight.  The average price per ounce of yarn is $4-5.   

<ul>
<li>The coarsest fiber is made into hand-woven rugs by a company in Texas.  We carry 2x3’, 3x5’ and 4x6’ rugs, and can special order any other size.  The entire 2006 clip has been processed and we won’t be able to accept special orders until shearing our herd again in May.

<li>We also carry a large assortment of finished product: scarves and hats hand knitted locally, the warmest socks imaginable made in Georgia, and cardigans and vests imported from  Peru. 

<li>We ship USPS and accept VISA and MasterCard.
</ul>  <br>
</blockquote>

	</td>
</tr>


	</table>

	<!--#Include virtual="/Footer.asp"-->


	
<!--Alpacas at Lone Ranch, Oregon, offers exquisite Alpacas for sale, trade, and breeding including highly desired maroon, black and grey alpacas and herdires.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, ALPACAS, ALPACAS, Alpacas for sale, Peruvian Alpacas, Accoyo Alpacas, male alpacas, female alpacas, black, black alpacas, grey, grey alpacas, gray, gray alpacas, maroon, maroon alpacas, crias, color, ranch, alpaca ranching, ranching, farm, llama, llamas, Alpacas at Lone Ranch, Gold Beach, Oregon, breeding, sales, trading, stud service, family business, black herdsires, grey herdsires, maroon herdsires, breeder, investment -->
</body>
</html>