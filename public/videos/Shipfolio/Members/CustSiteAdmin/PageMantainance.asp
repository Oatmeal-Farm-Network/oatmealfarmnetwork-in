<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Page Maintanance</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<% pagename = request.querystring("pagename") %>


<!--#Include virtual="/Administration/Header.asp"--> 
<% showstandard= True
%>

<% If pagename = "Links" Then 
       showstandard= false%>
		<!--#Include virtual="/Administration/LinksHeader.asp"-->

<% End If %>

<% If pagename = "Products for Sale" Then  
		showstandard= false%>
		<!--#Include virtual="/Administration/StoreHeader.asp"-->
<% End If 

If  showstandard= True then %>
		<!--#Include virtual="/Administration/PagesHeader.asp"-->
<% End If %>
<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

<td class = "body" valign = "top">

<!--#Include virtual="/administration/PageMantainanceInclude.asp"-->

</td>
</tr>
</table>

</Body>
</HTML>