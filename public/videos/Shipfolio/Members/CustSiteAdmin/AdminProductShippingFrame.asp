<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/Conn.asp"--> 
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body>

<% 
ProdId = request.QueryString("ProdId")
if len(ProdId) < 1 then
ProdId = Request.Form("ProdId")
end if
screenwidth = request.querystring("screenwidth")
%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" class = "roundedtopandbottom">
<tr><td  align = "left" >
<H3><div align = "left">Shipping & Handling</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "410" valign = "top">


<% sqls = "select * from sfShipping where ProdID=" & ProdID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, conn, 3, 3 
numcountries = rss.recordcount
rss.close
set conn = nothing
%>



<iframe src ="AdminShippingFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth %>" height="<%=(numcountries * 40) + 130 %>" width="<%=screenwidth %>" frameborder = "0" scrolling = "yes" valign = "top" align = "center" style="background-color:white" ></iframe>

</body>
</html>
