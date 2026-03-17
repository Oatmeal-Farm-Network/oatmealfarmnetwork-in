<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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

  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth -50%>><tr><td class = "roundedtopandbottom" align = "left" >
		<H3><div align = "left">State Sales Tax</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "100" valign = "top"><br />
         <table border = "0" width = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
        <tr><td class = "body2" align = "right" valign = "bottom">Tax this Item? &nbsp;</td>
        <td class = "body">
        <% if  prodStateTaxIsActive = "Yes" Or  prodStateTaxIsActive = "True" Then %>
						Yes:<input TYPE="RADIO" name="prodStateTaxIsActive" Value = True checked>
						No:<input TYPE="RADIO" name="prodStateTaxIsActive" Value = False >
					<% Else %>
						Yes: <input TYPE="RADIO" name="prodStateTaxIsActive" Value = True >
						No: <input TYPE="RADIO" name="prodStateTaxIsActive" Value = False checked>
				<% End if%>
        </td></tr>
        </table>
<% 
		
sqlt = "select * from people where peopleId = " & Session("PeopleID")
Set rst = Server.CreateObject("ADODB.Recordset")
rst.Open sqlt, conn, 3, 3   
TaxNexusState= rst("TaxNexusState")
TaxRate= rst("TaxRate")
if len(TaxRate) > 0 then
else
TaxRate= 0
end if
rst.close


%>


Tax rate:<%=TaxRate %>%<br />
To change your tax rate select <a href = "/ADMINISTRATION/AdminStoreMaintenance.asp#Taxes" class = "body" >Taxes</a>.
</td></tr></table>

</body>
</html>
