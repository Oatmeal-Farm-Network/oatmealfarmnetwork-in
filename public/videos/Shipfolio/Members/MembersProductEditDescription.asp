<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->

 </head>
<body >


<!--#Include file="MembersHeader.asp"-->
<% Current1="Products"
Current2 = "EditProduct" 
Current3 = "Description"%> 
<!--#Include file="MembersProductJumpLinks2.asp"-->


<div class ="container roundedtopandbottom">
<div>
    <div align=left>
        <H1>Description</H1>
        <iframe src="membersProductdescriptionFrame.asp?ProdID=<%=ProdID %>" height = '568' width = '90%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no color ="white"></iframe>
    </div>
</div>
</div>


<!--#Include file="membersFooter.asp"--> </Body>
</HTML>