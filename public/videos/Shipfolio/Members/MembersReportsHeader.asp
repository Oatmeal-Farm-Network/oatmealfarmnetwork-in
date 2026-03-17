<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
			Response.Redirect("/Membersistration/Login.asp")
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

WebLink= "www.Andresenacres.com"
LongWeblink = "http://www.Andresenacres.com"
DatabasePath = "../../../DB/Andresenacres.mdb"
MembersistrationPath = "/Membersistration"
WebSiteName = "Andresen Acres Alpacas"
PhysicalPath = "E:\\Inetpub\\wwwroot\\starter\\alpacas2\\Andresenacres.com\\www"
UploadPath = "E:\\Inetpub\\wwwroot\\starter\\alpacas2\\Andresenacres.com\\www\\Uploads\\"
WebLink= "www.Andresenacres.com"

show=false


%>


<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "779" height = "120" background = "images/Reportsheaderbackground.jpg" align = "center" >
					<tr>
					  <td height = "90">&nbsp;
						
					  </td>
					 </tr>
					 <tr>
					   <td colspan ="2">
					     <table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "779"  align = "left" valign = "top" >
					<tr> 
						<td width = "113" align = "center">
									<a href = "/Membersistration/default.asp" class = "menu2">Website Members</a>
						</td>
							<td width = "113" align = "center">
								<a href = "/Membersistration/reports/default.asp" class = "menu2">Reports</a>
					</td>
						<td width = "113" align = "center">
								<a href = "/Membersistration/Transfers/default.asp" class = "menu2">Transfer Info
					</td>
							<td width = "113" align = "center">
								<a href = "/Membersistration/AI/default.asp" class = "menu2">Alpaca Infinity
					</td>
							<td width = "113" align = "center">
								
					</td>
					<td width= "214" align = "right">
							<a href = "/Default.asp" target = "blank" class = "Menu2" > Your Website</a>&nbsp;&nbsp;&nbsp;
							<a href = "/Membersistration/logout.asp"  class = "Menu2" > Logout</a>&nbsp;&nbsp;&nbsp;
					</td>
					</tr>
				</table>



						</td>
					</tr>
		
<% If Not(loginpage = True) Then %>

<tr>
<td nowrap cellpadding="10" valign = "bottom" height = "23">
<a href = "/Membersistration/reports/default.asp" class = "menu2">Reports Home</a>

<a href = "uploadLogo.asp" class = "menu2">Upload Logo</a>
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
<table width="779"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>