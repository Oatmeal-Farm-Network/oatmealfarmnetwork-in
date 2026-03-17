<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<title>Make an OBO Offer</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="robots" content="none"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/Style.css" />
<% 
CurrentPeopleID= Request.form("CurrentPeopleID")
OBOOffer= Request.form("OBOOffer") 
PackageID = Request.querystring("PackageID") 
PackageName = Request.querystring("PackageName") 

sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
	If not rs.eof Then

		MenuBackgroundColor = rs("MenuBackgroundColor")
		MenuColor = rs("MenuColor")
		MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
		TitleColor = rs("TitleColor")
		PageBackgroundColor = rs("PageBackgroundColor")
		PageTextColor = rs("PageTextColor")
		LayoutStyle = rs("LayoutStyle")
		PageTextMouseOverColor = rs("PageTextMouseOverColor")
End If
rs.close 

if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
%>

<style>
		H1 {font: 24pt arial; color: <%=TitleColor %>}
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 18pt arial; color: <%=TitleColor %>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuColor %>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%	Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
 PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName	= rs("PeopleLastName")
rs.close
End If 
%>
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.FirstName.value=="") {
themessage = themessage + " -First Name \r";
}
if (document.form.FirstName.value == "") {
    themessage = themessage + " -Last Name \r";
}

if (document.form.Fieldname2.value == "") {
    themessage = themessage + " -Email \r";
}

if (document.form.fieldX.value == "") {
    themessage = themessage + " -Math Question \r";
}

//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Packages" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<a name = "top"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Make an Offer to Buy The <%=PackageName%></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "left">
<br />
<blockquote>
Please enter your your contact information below then select the submit button. That will generate an e-mail that will be sent to the package's owner. It will then be up to the seller to contact you to work out the details of the sale. <b>Livestock of America is not responsible for the negotiation of the sale of the package.</b></div><br><br>
</blockquote>
	
<br>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "720" valign ="top">
	<tr>		
		 <td  align = "center" valign ="top">
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width = "420" border = "0"><tr><td   valign="top" width = "420"  align = "left" class = "body">
	<%HideOBO = True %>	
</td>
<td class = "body" valign = "top"  width = "300">
<form  name=form method="post" action="OBOPackageOfferSendEmail.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "420">
<tr><td colspan="4" align="center" width="636" class = "body"> 
( &quot;*&quot; indicates required field)</i>
 <INPUT TYPE="hidden" NAME="PackageName"  Value = "<%=PackageName%>" size="45">
<INPUT TYPE="hidden" NAME="CurrentPeopleID"  Value = "<%=CurrentPeopleID%>" size="45">
</td></tr>
<tr><td width="160" height="20" class = "body2" align = "right" valign = "top">Offer:</td>
			<td  height="20" class = "body" valign = "top" align = "left"> 
 					<input NAME="OBOOffer" value = <%= OBOOffer%> type = "hidden"><b><%=FormatCurrency( OBOOffer,0) %></b>
					
				 </td>
			</td>
		</tr>
		<tr> 
			<td  height="20" class = "body2" align = "right">First Name:*</td>
			<td  height="20" class = "body" align = "left"> 
				<input name="FirstName" size = "40">
				 </td>
			</td>
		</tr>
		<tr> 
			<td  height="20" class = "body2" align = "right">Last Name:*</td>
			<td  height="20" class = "body" align = "left"> 
 						<input name="LastName" size = "40">
				 </td>
			</td>
		</tr>
         	<tr> 
                	<td  height="20" class = "body2" align = "right"> City: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="text" NAME="Fieldname6" size="40">
                	</td>
            	</tr>
            	<tr> 
                	<td  height="20" class = "body2" align = "right"> State:  </td>
                	<td  height="20" class = "body" align = "left">
                    		<INPUT TYPE="TEXT" NAME="Fieldname5" size="5">
							
					 &nbsp; &nbsp;Postal Code:  &nbsp;
                 		<INPUT TYPE="TEXT" NAME="Fieldname4" size="5">
                	</td>
            	</tr>
		
            	<tr> 
                	<td height="20" class = "body2" align = "right">Email*: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="TEXT" NAME="Fieldname2" size="40">
                    		 </td>
                	</td>
            	</tr>
				<tr> 
                	<td height="20" class = "body2" align = "right">Phone#: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="TEXT" NAME="Fieldname0" size="40">
                    		 </td>
                	</td>
            	</tr>
            	<tr> 
                	<td  height="1"  class = "body2" align = "right" valign = "top">Comments:</td>
					<td class = "body" valign = "top" align = "left">
	                    	<TEXTAREA NAME="Fieldname1" cols="30" rows="15" wrap="file"></textarea>
</td></tr>
<tr><td class = "body" colspan = "2" align = "left">
            	  <b>Math Question</b>
            	  Please answer the simple question below so we know that you are a human not a spambot.</td>
            	</tr> 
				<tr> 
                	<td height="20" class = "body" align = "right"><img src = "/images/Mathquestion.jpg"></td>
                	<td  height="20" class = "body" align = "left"> 
	                 		<INPUT TYPE="TEXT" NAME="fieldX" size="3">*
</td></tr>
<tr>
	<td  align = "center" colspan = "2"><input NAME="EMail" size="1" type ="text" class="shoes">
		<input type=button value="Submit" class = "regsubmit2" onclick="verify();">
	</form>

		</td>
</tr>
</table>
</td>
	</tr>
</table> 
 </td>
		 <td width = "300"> 
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "300" valign ="top">
	<tr>		
		 <td  align = "center" valign ="top">
	<!--#Include virtual="/Conn.asp"--> 
<% 
sql = "SELECT  * from Package, People where length(package.PeopleID) > 0 and package.PeopleID = People.PeopleID and Package.PackageID = " & PackageID 

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then 
%>
<!--#Include file="PackageListInclude.asp"-->
 <% Else%>
<div>We do not have any packages that fit that criteria.</div><br><br>
<% End If %>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
	</tr>
</table>
<br /><br />
<!--#Include virtual="/Footer.asp"--> 

</body>
</html>