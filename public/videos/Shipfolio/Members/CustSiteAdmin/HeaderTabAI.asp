<%
   if Session("access")= False And  Not (loginpage = True) then
		Response.Redirect("Login.asp")
	end if
%>

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
	var sfEls = document.getElementById("Nav").getElementsByTagName("LI");
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
<% 'Global Variables



BackgroundColor = "white"
WebLink= "www.flyingwalpacas.com"
LongWeblink = "http://www.flyingwalpacas.com"
DatabasePath = "../../DB/FlyingW.mdb"
AdministrationPath = "/Administration"
WebSiteName = "Flying W Alpacas"
PhysicalPath = "E:\\Inetpub\\wwwroot\\virtual\\dougandrenee\\flyingwalpacas.com\\www"
Slogan = ""

%>


<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "779"  height = "123" background = "images/headerbackground.jpg" align = "center" >
					<tr>
						<td class = "body" >
							
						</td>
						<td class = "menu" align = "right" valign = "bottom"><br>
						<% If Session("AIActive") = True Then %>
							<a href = "/Administration/Transfer.asp" class = "Menu" ><big><b>Transfer Animals-></b></big></a>
						<% End If %>
						<img src = "images/px.gif" width = "200" height = "0">
						<a href = "/Administration/Default.asp" class = "Menu" >Admin Home&nbsp;</a>
						&nbsp;&nbsp;&nbsp;<a href = "/Administration/Logout.asp" class = "Menu" >Logout&nbsp;</a>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
				</table>

						</td>
					</tr>
				</table>
	<%

	If Not(loginpage = True) Then %>
<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   <% If Session("AIActive") = True Then %>background = "images/menubackground.jpg"<%else%>background = "images/menubackground2.jpg"<% End If %> align = "center" valign = "bottom" height = "40"  width = "779">
	<tr>
		
		<td nowrap cellpadding="10" valign = "bottom" >
<ul id="NAV" >
	<li ><a href = '#' class= "menu" >Add & Edit Animal Listings</a><ul>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "/Administration/Default.asp" class= "menu" >Home Page / List of Animals</a></td>
			</tr>
			</table>	
			</li>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AddAnAlpaca.asp" class= "menu" >Add a Listing</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/EditAlpaca.asp" class = "menu"  >Edit a Listing</a></td>
			</tr>
			</table>	
			</li>
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/DeleteAnAlpaca.asp" class= "menu"  >Delete a Listing</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AdminPhotos.asp" class= "menu"  >Upload Photos</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/XStuds.asp" class= "menu"  >Other People's Studs</a></td></tr>
			</table>	
			</li >

			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/xAdminPhotos.asp" class= "menu"  >Pictures of Other People's Studs</a></td></tr>
			</table>	
			</li >
    	<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/Femaledata.asp" class= "menu"  >Breeding record</a></td></tr>
			</table>	
			</li >
	
		</ul>
<li ><a href = '#' class= "menu" >Site Maintenance</a><ul>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "/Administration/AccountMantainance.asp" class= "menu" >Contact Information</a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/ChangePassword.asp" class = "menu"  >Change Password</a></td>
			</tr>
			</table>	
			</li>
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/EditSEO.asp" class = "menu"  >Edit Page Meta Tags</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/EditPage.asp" class = "menu"  >Edit Pages</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/LinkMaintenance.asp" class = "menu"  >Link Maintenance</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AboutUsAdmin.asp" class = "menu"  >About Us Page</a></td>
			</tr>
			</table>	
			</li>
		</ul>
				<li ><a href = "PlaceClassifiedAd0.asp" class= "menu" >Add a Listing</a>
			</li>
			<li ><a href = "EditAd.asp" class = "menu"  >Edit a Listing</a>
			</li>
			
			<li >
			<a href = "UploadPhotos.asp" class= "menu"  >Upload Photos</a>
			</li >
			<li >
			<a href = "DeleteListing.asp" class= "menu"  >Delete a Listing</a>
			</li >
	
		</ul>

<% If Session("AIActive") = True Then %>

	<li ><a href = '#' class= "menu" >Add & Edit Animal Listings</a><ul>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/AddAnAlpaca.asp" class= "menu" >Add a Listing</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/EditAlpaca.asp" class = "menu"  >Edit a Listing</a></td>
			</tr>
			</table>	
			</li>
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/DeleteAnAlpaca.asp" class= "menu"  >Delete a Listing</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/AdminPhotos.asp" class= "menu"  >Upload Photos</a></td></tr>
			</table>	
			</li >
	
		</ul>
<li ><a href = '#' class= "menu" >Account Mantainance</a><ul>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/AccountMantainance.asp" class= "menu" >Account Information</a></td>
			</tr>
			</table>	
			</li>
				<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/UploadLogo.asp" class= "menu" >Upload Logo</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/ChangePassword.asp" class = "menu"  >Change Password</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AI/Addaservice.asp" class = "menu"  >Add Services</a></td>
			</tr>
			</table>	
			</li>
	
		</ul>
<% End If %>		
		</ul>
</td>

</tr>

</table>
</td>
</tr>
</table>
<% End If %>
<table width="779"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>