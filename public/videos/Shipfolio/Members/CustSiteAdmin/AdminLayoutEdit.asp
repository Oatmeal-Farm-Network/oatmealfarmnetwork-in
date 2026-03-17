<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="adminglobalvariables.asp"--> 
 <title>Edit Website Layout</title>
<base target="_top">
 <% Page = "Editwebsite" %>
</head>
<body >
<!--#Include virtual="/members/MembersHeader.asp"-->
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Website Fonts</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "980"> 
<!--#Include file="AdminLayoutHeader.asp"--> 
	<br />
<iframe src ="AdminStyleFonts.asp" width="960" height="1580" frameborder = "0" scrolling = "no" style="background-color:white" align = "center">
<p>Your browser does not support iframes.</p>
</iframe>
	</td>
	</tr>
	</table>
<br>
<!-- #include virtual="/members/MembersFooter.asp" -->
 </Body>
</HTML>
