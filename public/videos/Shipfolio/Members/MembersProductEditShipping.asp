<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->

 </head>
<body >

<% Current1="Products"
Current2 = "EditProduct" 
Current3 = "Shipping"%> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">

<% 
if prodPurchasemethod = "PayPal" then

sqls = "select count(*) as recordcount from sfShipping where ProdID=" & ProdID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, conn, 3, 3 
numcountries = rss("recordcount")
rss.close
%>
<div >
    <div  align=left>
        <H1>Shipping & Handling</H1>
        <iframe src ="membersShippingFrame.asp?ProdID=<%=ProdID %>" height="600" width="100%" frameborder = "0" scrolling = "auto" valign = "top" align = "center" ></iframe>
        <br>
    </div>
</div>
<% 
end if %>
</div>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>