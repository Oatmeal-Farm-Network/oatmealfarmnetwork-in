
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<!-- Begin
function NewWindow(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//  End -->
</script>

<script type="text/javascript"><!--//--><![CDATA[//><!--

sfHover = function() {
	var sfEls = document.getElementById("nav").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);

//--><!]]></script>

<% 
If  Hour(Now) > 19 Or Hour(Now) < 7 Then
		HeaderImage = "images/NightHeader.jpg"
Else If (Month(now)) >0 And (Month(now)) < 4 then  
				Season  = "Winter" 
				HeaderImage = "/images/HeaderWinter.jpg"
	   End if
	   If (Month(now)) >2 And (Month(now)) < 6 then  
				Season  = "Spring" 
				HeaderImage = "/images/HeaderSpring.jpg"
	   End if
	   If (Month(now)) >5 And (Month(now)) < 10 then  
				Season  = "Summer" 
				HeaderImage = "/images/SummerHeader.jpg"
	   End If
	    If (Month(now)) =10 then  
				Season  = "Fall" 
				HeaderImage = "/images/FallHeader.jpg"
	    End If
	   If (Month(now)) =11 then  
				Season  = "Fall" 
				HeaderImage = "/images/FallHeader.jpg"
	    End If
		 If (Month(now)) =12 then  
				Season  = "Fall" 
				HeaderImage = "/images/FallHeader.jpg"
	    End If
 End if
%>
</head>

<table width = "800" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
<tr>
	<td  height = "407"  width = "148"  valign = "top">
<table height = "195" width = "800"  border="0" cellpadding=0 cellspacing=0 valign = "top" >
	<tr>
		<td align="center" valign="top">
			<table width="800" border="0" bgcolor="#f2f0ec" cellpadding=0 cellspacing=0>
				<tr>
					<td>
						


<table height = "145" background = "<%=HeaderImage%>" width = "800" border="0" cellpadding=0 cellspacing=0  align = "center" >
<tr>
	<td  align = "right" valign = "bottom" height ="175" colspan = "6" nowrap>
			<a  href="Default.asp" class= "menu2" >Home&nbsp;&nbsp;&nbsp;</a>
			<a  href="ContactUs.asp" class= "menu2" >Contact Us&nbsp;&nbsp;&nbsp;</a>
		</td>
	</tr>
	<tr>
	<td>
		<table height = "20" width = "800"   border="0" cellpadding=0 cellspacing=0 id="NAV" align = "center" >



	<tr>
		<td width = "10">
			&nbsp;
		</td>
		<td nowrap  valign = "bottom"  >

<ul id="nav" >
	<li ><a href = '#' class= "menu2" >Alpacas For Sale&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><ul>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1">
						<a class = "menu" href = "/Females.asp">&nbsp;Females</a></li></td>
			</tr>
			</table>	
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Crias.asp">&nbsp;&nbsp;&nbsp;<%=Year(now)%> Crias</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Males.asp">&nbsp;Males</a></li></td>
			</tr>
			</table>	
					
			</li >


            <li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Blacks.asp">&nbsp;Blacks </a></li></td>
			</tr>
			</table>	
			</li >

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Greys.asp">&nbsp;Greys</a></li></td>
			</tr>
			</table>	
			</li >

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1" >
						<a class = "menu" href = "/Browns.asp">&nbsp;Browns</a></li></td>
			</tr>
			</table>	
			</li >
<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Fawns.asp">&nbsp;Fawns</a></li></td>
			</tr>
			</table>	
			</li >

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Whites.asp">&nbsp;Whites</a></li></td>
			</tr>
			</table>	
			</li >
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/AlpacaSale.asp">&nbsp;Complete Sales List</a></li></td>
			</tr>
			</table>	
			</li >

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/fs_EscrowReturnPolicy.asp">&nbsp;Our Guarantee</a></li></td>
			</tr>
			</table>	
			</li >

		</ul>
</td>






<td nowrap  valign = "bottom" >


<li ><a href = '#' class= "menu2"  >&nbsp;Herdsire Breeding&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
    <ul>
	<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1" >
						<a class = "menu" href = "/Herdsires.asp">&nbsp;Herdsires</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1" >
						<a class = "menu" href = "/Herdsires.asp#Jr.herdsires">&nbsp;Jr. Herdsires</a>
				</td>
			</tr>
			</table>	</li>
	<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/BreedingProtocol.asp">&nbsp;Breeding Protocol</a>
				</td>
			</tr>
			</table>	</li>
				
		</ul>
</td>
<td nowrap  valign = "bottom" >


		<li ><a href = '#' class= "menu2" >&nbsp;Special Offers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
    <ul>
	<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1">
						<a class = "menu" href = "/GodfatherSale.asp">&nbsp;GodFather Sale</a>
				</td>
			</tr>
			</table>	</li>
		
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Packages.asp">&nbsp;Package Deals</a>
				</td>
				</tr>
			</table></li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Auction.asp">&nbsp;Alpaca Auctions</a>
				</td>
				</tr>
			</table></li>
			<%'<li >
			'<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
			'	<tr>
			'		<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
			'			<a class = "menu" href = "/Specials.asp">&nbsp;GyuroStyle Auction</a>
			'	</td>
		'		</tr>
		'	</table></li>
%>
		</ul>
</td>




<td nowrap  valign = "bottom" >

		<li ><a href = '#' class= "menu2"  >&nbsp;&nbsp;The Dream</a>
    <ul>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1">
					<a class= "menu" href = "/AboutUs.asp" class = "menu">&nbsp;About Us</a>
					</td>
				</tr>
			</table>	
		</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/Goals.asp" class = "menu">&nbsp;Our Goals</a>
					</td>
				</tr>
			</table>	
		</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/Love.asp">&nbsp;For Love</a>
					</td>
			</tr>
			</table>	
			</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
				   <td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/Money.asp">&nbsp;For Money</a>
				   </td>
				</td>
			</tr>
			</table>
		</li>

		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/DollarsSense.asp">&nbsp;Dollars and Sense</a>
					</td>
				</tr>
			</table>	
		</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/TypicalInvestment.asp">&nbsp;Typical Investment</a>
					</td>
				</tr>
			</table>	
		</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/TaxBenefits.asp">&nbsp;Tax Benefits</a>
					</td>
				</tr>
			</table>	
		</li>
				<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/FamilyBusiness.asp">&nbsp;Family Business</a>
					</td>
				</tr>
			</table>	
		</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/AboutAlpacas.asp">&nbsp;About Alpacas</a>
					</td>
				</tr>
			</table>	
		</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/AlpacaFleece.asp">&nbsp;Alpaca Fleece</a>
					</td>
				</tr>
			</table>	
		</li>
		
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/Ranchtour.asp" >&nbsp;Ranch Tour</a>
					</td>
			</tr>
			</table>	
		</li>
	</ul>

</td>












<td nowrap  valign = "bottom" >
			<li ><a href = '#' class= "menu2"  >&nbsp;&nbsp;The Ranch</a>
    <ul>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1">
						<a class= "menu" href = "/Ranching.asp">&nbsp;Alpaca Ranching</a>
				</td>
			</tr>
			</table>	
			</li>
					<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Lifestyle.asp">&nbsp;The Lifestyle</a>
				</td>
			</tr>
			</table>	
			</li>
								<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/TypicalDay.asp">&nbsp;Typical Day</a>
				</td>
			</tr>
			</table>	
			</li>

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Feed.asp">&nbsp;Feeding & Nutrition</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/CleanUp.asp">&nbsp;Cleanup</a>
				</td>
			</tr>
			</table>	</li>


					<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Breeding.asp">&nbsp;Breeding</a>
				</td>
			</tr>
			</table>	</li>

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1" >
						<a class= "menu" href = "/Birthing.asp">&nbsp;Birthing</a>
				</td>
			</tr>
			</table>	</li>

			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Shearing.asp">&nbsp;Shearing</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Fleece.asp">&nbsp;Fleece</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Transportation.asp">&nbsp;Transporting</a>
				</td>
			</tr>
			</table>	</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Shows.asp">&nbsp;Shows</a>
				</td>
			</tr>
			</table>	</li>
				<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Vet.asp">&nbsp;Veterinary Care</a>	
				</td>
			</tr>
			</table>	</li>
				<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Marketing.asp">&nbsp;Marketing & Sales</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
					<a class= "menu" href = "/Links.asp">&nbsp;Links</a>
					</td>
			</tr>
			</table>	
		</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/Crias.asp">&nbsp;<%=Year(now)%> Crias</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class= "menu" href = "/News.asp">&nbsp;News</a>
				</td>
			</tr>
			</table>	</li>
</ul>
</td>


<td nowrap  valign = "bottom" >
<li ><a href = '#' class= "menu2"  >&nbsp;The Distinction</a>
    <ul>
	<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1">
						<a class = "menu" href = "/Startup.asp">&nbsp;Startup Assistance</a>
				</td>
			</tr>
			</table>	</li>
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/BeforeBuying.asp">&nbsp;Before Buying</a>
				</td>
			</tr>
			</table>	</li>

		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/RanchSetup.asp">&nbsp;Ranch Setup</a>
				</td>
			</tr>
			</table>	</li>

	
		<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1">
						<a class = "menu" href = "/Bloodlines.asp">&nbsp;Bloodlines</a>
				</td>
			</tr>
			</table>	</li>
			<li >
			<table border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0  >
				<tr>
					<td style="border-style: solid; border-color: #941500 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1" >
						<a class = "menu" href = "/SalesOps.asp">&nbsp;Sales</a>
				</td>
			</tr>
			</table>	</li>
</ul>
</td>
</tr>
</table>
</td>
</tr>
</table>



	</td>
</tr>
<tr>
	<td  valign = "top">