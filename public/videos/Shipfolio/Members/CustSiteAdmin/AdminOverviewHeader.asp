   <% Current = "Website" %>
   <!--#Include file="AdminSecurityInclude.asp"--> 
   <!--#Include file="AdminHeaderTabsInclude.asp"--> 
    
  
<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
		Response.Redirect("AdminLogin.asp")
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


<table   border="1"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "980" height = "120"  align = "center"   >
<tr><td >
	<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "800" height = "20"  align = "center"  bgcolor = "orange" background = "images/SelectedHeader.jpg">
<tr>
	<td colspan ="2">
</td>
</tr>
		
	<%

	If Not(loginpage = True) Then %>

<tr >
<td nowrap cellpadding="10" valign = "bottom"  bgcolor = "blue">
<ul id="NAV" >
	<li ><a href = '#' class= "menu2" >Your Animals111</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "Default.asp" class= "menu" >Home Page / List of Animals</a></td>
			</tr>
			</table>	
			</li>
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminAnimalAdd1.asp" class= "menu" >Add an Animal</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminAnimalEdit.asp" class = "menu"  >Edit a Listing</a></td>
			</tr>
			</table>	
			</li>
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "/AdminAnimalDelete.asp" class= "menu"  >Delete a Listing</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminPhotos.asp" class= "menu"  >Upload Photos</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminOutsideStuds.asp" class= "menu"  >Other People's Studs</a></td></tr>
			</table>	
			</li >

			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminOutsidePhotos.asp" class= "menu"  >Pics of Other People's Studs</a></td></tr>
			</table>	
			</li >
    	<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminFemaleData.asp" class= "menu"  >Breeding Record</a></td></tr>
			</table>	
			</li >
	
		</ul>




<li ><a href = '#' class= "menu2" >Your Information</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminAccountMantainance.asp" class= "menu" >Contact Information</a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminChangePassword.asp" class = "menu"  >Change Password</a></td>
			</tr>
			</table>	
			</li>
			
			
		</ul>


	<% showonmenu = True
	
	
	If showonmenu=True Then %>
<li ><a href = '#' class= "menu2" >Your Pages</a><ul>
		
<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	
sql2 = "select * from Pagelayout where PageAvailable = True order by Pagename"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof %> 

<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
<tr>
<td><a href = "<%=rs2("EditLink")%>" class= "menu" ><%=rs2("PageName")%></a></td>
</tr>
</table>	
</li>
		
 <% 
	rs2.movenext
 Wend %></ul>
<% End If %>




<li ><a href = '#' class= "menu2" >Store Maintenance </a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminPlaceClassifiedAd0.asp" class= "menu" >Add a Product </a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminEditAd.asp" class = "menu"  >Edit a Product</a></td>
			</tr>
			</table>	
			</li>
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminProductsUploadPhotos.asp" class= "menu"  >Upload Product Photos </a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminListingDelete.asp" class= "menu"  >Delete a Product </a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminSetSaleCategories.asp" class= "menu" >Set Product Categories</a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminShippingRates.asp" class= "menu" >Shipping Rates</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "ProductsGeneralData.asp" class= "menu" >Products Overview</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "StoreMaintenance.asp" class= "menu" >Store Settings</a></td>
			</tr>
			</table>	
			</li>


			
		</ul>





	<li ><a href = '#' class= "menu2" >Site Design&nbsp;&nbsp;</a><ul>
	<% showLayoutstyle = true 
	if showLayoutstyle = true then %>
				<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "StandardStylesMaster.asp" class= "menu" >Layout Styles</a></td>
			</tr>
			</table>	
			</li>

	<% end if %>	
		<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td> <a href = "StandardStylesmaster.asp#images" class = "menu">Upload Layout Images</a>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "LayoutEdit.asp" class= "menu" >Font Styles</a></td>
			</tr>
			</table>	
			</li>
</ul>

		
		</ul>
</td>

</tr>

</table>

				</td>
				</tr>
				</table>
<% End If %>

