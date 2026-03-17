<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual ="/ConnLOA.asp"-->
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
ProdID = request.QueryString("ProdID")
if len(ProdID) < 1 then
ProdID = Request.Form("ProdID")
end if
'Prodid = 17
Productid = Prodid

sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 
ProdDescription = rs("ProdDescription")
rs.close
%>



 <form action= "membersProductsDescriptionHandleForm.asp" method = "post" name="myform"> 

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%" >
<tr><td  align = "left">
<H2>Description</H2>
  <br />
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Product Description Changes Have Been Made.</b></font></div>
<% end if %>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
<script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.
WYSIWYG.attach("ProdDescription", mysettings);
mysettings.Width = "880px"
mysettings.Height = "300px"
</script>
 
<center><textarea name="ProdDescription" ID="ProdDescription" cols="40" rows="30"  class = "formbox" ><%=ProdDescription%></textarea></center>

<br />
<input name="ProdID" value="<%=ProdID%>" type = hidden>
<div align = "right"><input type=submit name= "button1" value = "SUBMIT DESCRIPTION" class = "regsubmit2"  <%=Disablebutton %> ></div>
</td></tr>
</table>
</form>
</body>
</html>
