<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<link rel="stylesheet" type="text/css" href="style.css">
<head>
<!--#Include virtual="/conn.asp"-->
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 2;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 2;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 2;

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
ProdId = request.querystring("ProdId")

'****************************************************************
' Dimension Title
'****************************************************************  
    	
sql = "select * from SFAttributetitles where ProdId = " & ProdId 
rs.Open sql, conn, 3, 3  
if rs.eof then
DimensionTitleset = False
else 
DimensionTitle= rs("DimensionTitle")
DimensionTitleset = True
end if
rs.close

 
screenwidth = request.querystring("screenwidth")
%>

<form action= 'AdminProductsAttributesDimensionTitleHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "<%=screenwidth%>">
  <tr>
  <td class = "body" colspan = 3>
  <h3>Dimension Title</h3>

<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Primary Attribute Has Been Changed.</b></font></div>
<% end if %>
</td>
  </tr>
<tr>
<td class = "body">
 <input name="DimensionTitle" value= "<%=DimensionTitle%>" size = "8">
</td>
<td class = "body" valign = "top">
  <input type = "hidden" name="Screenwidth" value= "<%= Screenwidth%>" >
    <input type = "hidden" name="ProdID" value= "<%= prodID%>" >
	<input type="submit" class = "regsubmit2"  <%=Disablebutton %> value="SUBMIT DIMENSION TITLE"  >
</td>

<td class = "body" valign = "top"><font color = "#777777">The dimension attribute can be length, size, weight, etc. Whatever title you give it will be what users will see.</font></td>
  </tr>
</table>
</form>
<br /><br />
</body>
</html>
