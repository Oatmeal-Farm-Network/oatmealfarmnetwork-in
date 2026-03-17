

<SCRIPT type=text/javascript><!--//--><![CDATA[//><!--

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

//--><!]]></SCRIPT>



			<table border="0" cellpadding=0 cellspacing=0 >
				<tr>
						<td nowrap  valign = "bottom" width = "43" >
						<center><a  href="Default.asp" class= "menu2" >Home</a></center>
					</td>
					<td>

<table height="50"  border="0" cellpadding=0 cellspacing=0 id="NAV" align = "center" >
	<tr>
<ul id="nav" >	
	<td nowrap  valign = "bottom" width = "130" >
		<li ><a href = "aboutartisans.asp" class= "menu2"  ><center>Artisans at the Barn</center></a>
    <ul>
		<li ><a href="AboutArtisans.asp" class = "menu">About Artisans</a></li>
		<li ><a href="FeaturedArtisan.asp" class = "menu">Featured Artisan</a></li>
		<li ><a href="Artists.asp" class = "menu">Resident Artisans</a></li>

</ul>
</td>
	<td nowrap  valign = "bottom" width = "130" >


	<li ><a class = "menu2"  href="#"><center>The Shop at the Barn</center></a><ul>
		<li ><a  href="Barnstore.asp#Store" class= "menu" >About the Store</a></li>	
		<li ><a  href="Barnstore.asp#Products" class= "menu" >Products for Sale</a></li >
		<li ><a  href="Registryhome.asp" class= "menu" >Gift Registry</a></li >

</ul>
</td>


	<td nowrap  valign = "bottom" width = "130" >
		<li ><a href = '#' class= "menu2"  ><center>Calendar of Events</center></a>
    <ul>
	<li ><a href="News.asp" class = "menu">Latest News</a></li>
		<li ><a href="Calendar.asp" class = "menu">Calendar</a></li>
		<li ><a href="PastEvents.asp" class = "menu">Past Events</a></li>
</ul>
</td>
			<td nowrap  valign = "bottom" width = "90" >
<li ><a class = "menu2"  href="#"><center>About the Barn</center></a>
    <ul>
	<li ><a href="Story.asp" class = "menu" >Story of the Barn</a></li>
	<li ><a href="Opportunities.asp" class = "menu" >Artist Opportunities</a></li>
	<li ><a href="RentingSpace.asp" class = "menu" >Renting Space</a></li>
	<li ><a href="ContactUs.asp" class = "menu" >Contact Us</a></li>
</li>

</ul>
</td>
			<td nowrap  valign = "bottom" width = "125" >
			<li ><a class = "menu2"  href="#"><center>Sustaining the Barn</center></a><ul>
			<%	sql2 = "select * from Pagelayout where PageType = 'Sustaining the Barn' and publish=true"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
	
		currentPageName = rs2("PageName")
		

		'response.write (SSName(studcounter)) %>
<li ><a href="SustainingPage.asp?pagename=<%=currentPageName%>" class = "menu" ><%=currentPageName%></a></li>

<%
		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		
showpages = False
If showpages = True then
%>




<li ><a href="FriendsoftheBarn.asp" class = "menu" >Friends of the Barn</a></li>
	<li ><a href="AdoptaWheel.asp" class = "menu" >Adopt-a-Wheel</a></li>
	<li ><a href="ArtisanCookbook.asp" class = "menu" >Artisan Cookbook</a></li>
		<li ><a href="DVD.asp" class = "menu" >Artisan DVD</a></li>
	<li ><a href="Gifts.asp" class = "menu" >Planned Gifts</a></li>
<% End If %>

</li>


</ul>

</td>
		<td nowrap  valign = "bottom" width = "110" >
<li ><a class = "menu2"  href="#"><center>Resources</center></a><ul>
<% 	' Get marketing text for the top of the page:
     
	sql = "SELECT  * FROM LinkPages order by PageName" 
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
	While Not rs.eof 

%>
<li ><a href="links.asp?PageID=<%=rs("LinkPageID")%>" class = "menu" ><%=rs("PageName")%></a></li>
	<% rs.movenext 
	Wend %>


</li>


</ul>

</td>
	</tr>
   </table>
</td>
</tr> <tr><td height = "3" colspan = "2"><img src = "images/px.gif" height = "3"></td></tr>
</table>





