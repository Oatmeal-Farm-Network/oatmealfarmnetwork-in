<% 
If  Hour(Now) > 19 Or Hour(Now) < 7 Then
		HeaderImage = "images/NightHeader.jpg"
Else If (Month(now)) >0 And (Month(now)) < 4 then  
				Season  = "Winter" 
				HeaderImage = "images/HeaderWinter.jpg"
	   End if
	   If (Month(now)) >2 And (Month(now)) < 5 then  
				Season  = "Spring" 
				HeaderImage = "images/HeaderSpring.jpg"
	   End if
	   If (Month(now)) >4 And (Month(now)) < 10 then  
				Season  = "Summer" 
				HeaderImage = "images/SummerHeader.jpg"
	   End If
	    If (Month(now)) =10 then  
				Season  = "Fall" 
				HeaderImage = "images/FallHeader.jpg"
	    End If
	   If (Month(now)) =11 then  
				Season  = "Fall" 
				HeaderImage = "images/FallHeader.jpg"
	    End If
		 If (Month(now)) =12 then  
				Season  = "Fall" 
				HeaderImage = "images/FallHeader.jpg"
	    End If
 End if
%>
</head>

<table width = "800" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
<tr>
	<td  height = "407"   valign = "top">
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
		<table height = "20" width = "800"   border="0" cellpadding=0 cellspacing=0 align = "center" >
		<tr>
			<td nowrap  valign = "bottom" align = "center">
			
				<a href = "AlpacaSale.asp" class= "menu2" >Alpacas For Sale</a>&nbsp;&nbsp;
				<a href = "Herdsires.asp" class= "menu2"  >Herdsire Breeding</a>&nbsp;&nbsp;
				<a href = "specialshome.asp" class= "menu2" >Special Offers</a>&nbsp;&nbsp;
				<a href = "Store.asp" class= "menu2" >Alpaca Products</a>&nbsp;&nbsp;
						<a href = "News.asp"  class= "menu2">News</a>&nbsp;&nbsp;
				<a href = "AboutUs.asp"  class= "menu2">The Dream</a>&nbsp;&nbsp;
				<a href = "Ranching.asp" class= "menu2"  >The Ranch</a>&nbsp;&nbsp;
				<a href = "Startup.asp" class= "menu2" >&nbsp;The Distinction</a>
			</td>
			</tr>
		</table>
</td>
</tr>
</table>
</td>
</tr>
</table>


		
	</td>
</tr>
<tr>
	<td  valign = "top" background = "images/PageBackground.jpg">
		<table width = "770" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "left" valign = "top" >
		<tr>
		<td width = "5" rowspan = "2">&nbsp;</td>
			<td colspan ="3">
			<br><h1 ><i>&nbsp;<%=PageTitle%></i><br><img src = "images/Line.jpg" width = "750" height = "2"></h1>
			</td>
		</tr>
		<tr>
		
			<td class = "body" valign = "top" width = "120">