
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<% 'Clean Directory NEA 4/2012 %>
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

<!--#Include file="AdminSecurityInclude.asp"--> 

<table width = "100%" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" >
<tr><td><table width = "980" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" height = "80">
<img src =  "/administration/images/CMSLogo.jpg" alt = "Content Management System" height = "60">
<td>
<td width= "214" align = "right">
	<a href = "/" target = "blank" class = "Menu2" >Go To Your Website</a>&nbsp;&nbsp;&nbsp;
	<a href = "AdminLogout.asp" class = "Menu2" >Logout</a>&nbsp;&nbsp;&nbsp;
</td>
</tr>
</table>
</td></tr>
<tr><td bgcolor = "#abacab" height = "1"><img src = "images/px.gif" height = "1" alt = "content Management System"></td></tr></table>
<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "980" height = "20"  align = "center" bgcolor = "white">
<tr><td>
   <% Current = "Dashboard" %>



</td></tr>
<tr><td>

<!--#Include file="AdminHeaderTabsInclude.asp"--> 

	<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "980" height = "30"  align = "center"  background = "images/SelectedHeader.jpg">
	
<%

	If Not(loginpage = True) Then %>

	<tr >
		<td bgcolor = "#ABACAB" width = "1"><img src = "images/px.gif" width = "1"></td>
		<td  width = "10"><img src = "images/px.gif" width = "10"></td>
		<td nowrap cellpadding="10"  ><ul id="NAV" >
			<li ><a href = '#' class= "menu2" >Animals</a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "Default.asp" class= "menu" >Dashboard</a></td>
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
					<td><a href = "AdminAnimalEdit.asp" class = "menu"  >Edit an Animal</a></td>
			</tr>
			</table>	
			</li>
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminAnimalDelete.asp" class= "menu"  >Delete an Animal</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminPhoto.asp" class= "menu"  >Upload Photos</a></td></tr>
			</table>	
			</li >
			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminOutsideStud.asp" class= "menu"  >Other People's Studs</a></td></tr>
			</table>	
			</li >

			<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminOutsidePhoto.asp" class= "menu"  >Pics of Other People's Studs</a></td></tr>
			</table>	
			</li >
    	<li >
			<table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 0; border-bottom-width: 1"  bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminFemaleData.asp" class= "menu"  >Breeding Record</a></td></tr>
			</table>	
			</li >
	
		</ul>

	<% showonmenu = True
	If showonmenu=True Then %>
	
<li ><a href = '#' class= "menu2" >Your Pages</a><ul>

<%  sql2 = "select * from Pagelayout where PageAvailable = True and not (PageName='Farm Store (Header)')  and not (PageName='Photo Galleries') order by Pagename"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
  
	While Not rs2.eof 
%> 

<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
<tr>
<td><a href = "<%=rs2("EditLink")%>" class= "menu" ><%=rs2("PageName")%></a></td>

</tr>
</table>	
</li>
		
 <% 
	rs2.movenext
 Wend %>

 <li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150" height = "1">
<tr><td></td></tr></table></li></ul>
<% End If %>

<li ><a href = '#' class= "menu2" >Store Maintenance </a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminClassifiedAdPlace.asp" class= "menu" >Add a Product </a></td>
			</tr>
			</table>	
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminAdEdit.asp" class = "menu"  >Edit a Product</a></td>
			</tr>
			</table>	
			</li>
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminProductPhotos.asp" class= "menu"  >Upload Product Photos </a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminListingDelete.asp" class= "menu"  >Delete Products</a></td>
			</tr>
			</table>	
			</li>
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminSetSaleCategories.asp" class= "menu" >Set Product Categories</a></td>
			</tr>
			</table>	
			</li>
		
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminStoreShippingRates.asp" class= "menu" >Shipping Rates</a></td>
			</tr>
			</table>	
			</li>
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "100">
				<tr>
					<td><a href = "AdminStoreMaintenance.asp" class= "menu" >Store Settings</a></td>
			</tr>
			</table>	
			</li>
		</ul>




     
<li ><a href = '#' class= "menu2" ><div align = "center">Photo Gallery</div></a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminGalleryAddImage1.asp" class = "menu">Add Images</a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminGalleryEditImages.asp" class = "Menu" >Edit Images</a></td>
			</tr>
			</table>	
			</li>
			
						<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td> <a href = "AdminGallerySetCategories.asp" class = "Menu" >Gallery Categories</b></a></td>
			</tr>
			</table>	
			</li>
			
			
		</ul>
		 
        
<li ><a href = '#' class= "menu2" ><div align = "center">Your User Information</div></a><ul>
					
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 0"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminAccountMaintenance.asp" class= "menu" >Contact Information</a></td>
			</tr>
			</table>	
			
			<li ><table border="0" style="border-style: solid; border-color: #544644 ; border-right-width: 1; border-left-width: 1; border-top-width: 1; border-bottom-width: 1"  background = "images/HomeMenuBackground.jpg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 width = "150">
				<tr>
					<td><a href = "AdminPasswordChange.asp" class = "menu"  >Change Password</a></td>
			</tr>
			</table>	
			</li>
		</ul>
		






		</ul>
</td>
	<td bgcolor = "#898989" width = "1"><img src = "images/px.gif" width = "1"></td>
</tr>

</table>

				</td>
				</tr>
				</table>
<% End If %>

<table width="980"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>