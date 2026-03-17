<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
					Response.Redirect("/administration/Login.asp")
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

DatabasePath = "../../../DB/AlpacaDB.mdb"
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 

 sql2 = "select * from SiteDesign where custid = 66;" 
			'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

WebSiteName = rs2("custCompany")
PhysicalPath = rs2("PhysicalPath")
UploadPath = rs2("UploadPath")
Slogan = rs2("Slogan")
WebLink= rs2("URL")
LongWeblink =  rs2("URL")

CustEmail =  rs2("CustEmail")

End If 


sql2 = "select * from Users where custid = 11;" 
			'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

AIEmail = rs2("AIEmail")
AIPassword = rs2("AIPassword")
AIID = rs2("AIID")
session("AIID")  = AIID
PNAAID = rs2("PNAAID")
session("PNAAID")  = PNAAID
PNAAEmail = rs2("PNAAEmail")
PNAAPassword = rs2("PNAAPassword")
End If


show=false


%>


<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<% 'Cleaan Directory NEA 4/2012 %>
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
<script type="text/javascript"><!--    //--><![CDATA[//><!--

    sfHover = function() {
        var sfEls = document.getElementById("Nav").getElementsByTagName("LI");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function() {
                this.className += " sfhover";
            }
            sfEls[i].onmouseout = function() {
                this.className = this.className.replace(new RegExp(" sfhover\\b"), "");
            }
        }
    }
    if (window.attachEvent) window.attachEvent("onload", sfHover);

    //--><!]]></script>



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
   <% Current = "PNAA"  %>



</td></tr>
<tr><td>
<!--#Include file="AdminPNAAHeaderTabsInclude.asp"--> 
	<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "980" height = "30"  align = "center"  background = "images/SelectedHeader.jpg">
	<tr >
		<td bgcolor = "#eeeeee" width = "1"><img src = "images/px.gif" width = "1"></td>
</tr>

</table>

				</td>
				</tr>	<tr >
		<td bgcolor = "#abacab" height = "1"><img src = "images/px.gif" width = "1"></td>
</tr>
				</table>

<table width="980"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>