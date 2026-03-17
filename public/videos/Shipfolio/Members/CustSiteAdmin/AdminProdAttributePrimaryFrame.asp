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
' Primary Attribute
'****************************************************************  
    	
sql = "select * from SFAttributePrimary where ProdId = " & ProdId 
rs.Open sql, conn, 3, 3  
if rs.eof then
primaryset = False
else 
PrimaryAttribute= rs("PrimaryAttribute")
primaryset = True
end if
rs.close


screenwidth = request.querystring("screenwidth")

%>

<form action= 'AdminProductsAttributesPrimaryHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "<%=screenwidth %>" align = "left">
  <tr>
  <td class = "body" colspan = 3>
  <h3>Primary Attribute</h3>&nbsp;
  <% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Primary Attribute Has Been Changed.</b></font></div>
<% end if %>
  
  
  </td>
  </tr>
<tr>
<td class = "body">
 <select size="1" name="PrimaryAttribute" class = "formbox body">
 
 <option name = "AID0" value= "<%=PrimaryAttribute %>" selected><%=PrimaryAttribute %></option>
 <% if PrimaryAttribute= "Color" then %>
 <option name = "AID0" value= "Dimension" >Dimension</option>
 <% end if %>

  <% if PrimaryAttribute= "Dimension" then %>
 <option name = "AID0" value= "Color" >Color</option>

 <% end if %>


</option>
</select></td>
<td class = "body" >
  <input type = "hidden" name="Screenwidth" value= "<%= Screenwidth%>" >
    <input type = "hidden" name="ProdID" value= "<%= prodID%>" >
	<input type="submit" class = "regsubmit2"  <%=Disablebutton %> value="SUBMIT PRIMARY ATTRIBUTE"  >
</td>
<td class = "body" valign = "top"><font color = "#777777">Your primary Attribute is the attribute that will always be displayed if there inconsistency in your data. For instance if you set color as your primary attribute, but enter an option of length without a color, then that option will not be available to customers.</font></td>
  </tr>
</table>
</form>
</body>
</html>
