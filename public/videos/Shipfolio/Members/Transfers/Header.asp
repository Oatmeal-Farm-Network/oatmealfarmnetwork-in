<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
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
<% ' <!--#Include file="GlobalVariables.asp"--> %>
<% response.write("header " & "<br>")
'showonmenu=false %>

<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "800" height = "120" background = "/administration/images/headerbackground1.jpg" align = "center" >
<tr>
	<td height = "90">&nbsp;</td>
</tr>
<tr>
	<td colspan ="2">
		<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "800"  align = "left" valign = "top" >
		<tr> 
		<td width = "113" align = "center">

			<a href = "/administration/default.asp" class = "menu2">Website Admin</a>
		</td>
		<td width = "113" align = "center">
								<a href = "/administration/reports/default.asp" class = "menu2">Reports</a>
					</td>
						<td width = "113" align = "center">
								<a href = "/administration/Transfers/default.asp" class = "menu2">Transfer Info
					</td>
							<td width = "113" align = "center">
								<a href = "/administration/AI/default.asp" class = "menu2">Alpaca Infinity
					</td>
							<td width = "113" align = "center">
								
					</td>
					<td width= "214" align = "right">
							<a href = "/" target = "blank" class = "Menu2" >Go To Your Website</a>&nbsp;&nbsp;&nbsp;
							<a href = "/administration/logout.asp" class = "Menu2" >Logout</a>&nbsp;&nbsp;&nbsp;
					</td>
					</tr>
				</table>



						</td>
					</tr>
		
	<%

	If Not(loginpage = True) Then %>

	<tr>
		
		<td nowrap cellpadding="10" valign = "bottom" >
<ul id="NAV" >
	<li ><a href = '#' class= "menu2" >Your Animals</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/Default.asp" class= "menu" >Home Page / List of Animals</a></td>
			</tr>
			</table>	
			</li>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AddAnAlpaca.asp" class= "menu" >Add an Alpaca</a></td>
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

<li ><a href = '#' class= "menu2" >Your Information</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/AccountMantainance.asp" class= "menu" >Contact Information</a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/ChangePassword.asp" class = "menu"  >Change Password</a></td>
			</tr>
			</table>	
			</li>
			
			
		</ul>


	<% showonmenu = True
	
	
	If showonmenu=True Then %>
<li ><a href = '#' class= "menu2" >Your Pages</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/Administration/EditSEO.asp" class = "menu"  >Meta Tags</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/administration/EditPage.asp" class= "menu" >Edit Pages</a></td>
			</tr>
			</table>	
			</li>
				<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/administration/NewsEdit.asp" class= "menu" >News</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/administration/Packages.asp" class= "menu" >Packages</a></td>
			</tr>
			</table>	
			</li>

			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/administration/BlogAdmin/BlogAdminHome.asp" class= "menu" >Blog</a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "/administration/testimonials.asp" class= "menu" >Testimonials</a></td>
			</tr>
			</table>	
			</li>


		</ul>
<% End If %>
	<% showonmenu = True
	
	
	If showonmenu=True Then %>
		
		<li ><a href = '#' class= "menu2" >Store Maintenance </a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "PlaceClassifiedAd0.asp" class= "menu" >Add a Product </a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "EditAd.asp" class = "menu"  >Edit a Product</a></td>
			</tr>
			</table>	
			</li>
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "ProductsUploadPhotos.asp" class= "menu"  >Upload Product Photos </a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "DeleteListing.asp" class= "menu"  >Delete a Product </a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "setforsalecategories.asp" class= "menu" >Set Product Categories</a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "shippingrates.asp" class= "menu" >Shipping Rates</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "ProductsGeneralData.asp" class= "menu" >Products Overview</a></td>
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
</td>
</tr>
</table>
<% End If %>
<table width="800"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>