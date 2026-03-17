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
dim	DimensionArray(999)
dim ColorArray(999)
dim AttrPriceChangeArray(999)
dim attrIDarray(999)

screenwidth = request.QueryString("screenwidth")

category = request.QueryString("category")
ProdId = request.QueryString("ProdId")
if len(ProdId) < 1 then
ProdId = Request.Form("ProdId")
end if

Dim Showname(1000)
order = "even"		
Set rs = Server.CreateObject("ADODB.Recordset")	
    
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


if primaryset = False then
Query =  " Insert into SFAttributePrimary (ProdId, PrimaryAttribute )  " 
Query =  Query & " Values ( " & ProdId & ", 'Color')"
Conn.Execute(Query) 
PrimaryAttribute= "Color"
end if


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


if DimensionTitleset = False then
Query =  " Insert into SFAttributeTitles (ProdId, DimensionTitle )  " 
Query =  Query & " Values ( " & ProdId & ", 'Size')"
'response.write("Query=" & Query )

Conn.Execute(Query) 
PrimaryAttribute= "Color"
end if




 sql = "select * from sfattributes where ProdId = " & ProdId & " order by  " & PrimaryAttribute & " DESC"

'response.write ("sql=" &sql)

    rs.Open sql, conn, 3, 3   
	rowcount = 1
	Recordcount = rs.RecordCount +1
	%>
	


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "roundedtop" align = "left">
		<H2><div align = "left">Attributes</div></H2>
    </td><a name="Awards"></a>
</tr>
<tr>
    <td class = "roundedBottom" align = "left" width = "<%=screenwidth - 50 %>">

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" >
<tr>
    <td  align = "left">


</td>
</tr>
<tr>
<td height = 10>
</td>
</tr>
<tr>
<td >

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth - 80 %>">
<tr>
    <td class = "roundedtopandbottom" align = "left">
<iframe src="AdminProductDimensionTitleFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth -80%>" height = '130' width = '<%=screenwidth -80%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td>
</tr>
<tr>
<td height = 10>
</td>
</tr>
</table>



<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth - 55 %>">
<tr>
    <td  align = "left">
<iframe src="
AdminProductsAttributeValuesFrame.asp?ProdID=<%=ProdID %>&PrimaryAttribute=<%=PrimaryAttribute %>&DimensionTitle=<%=DimensionTitle %>&screenwidth=<%=screenwidth -80%>" height = '<%=100 + Recordcount*50%>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td>
</tr>
<tr>
<td height = 10>
</td>
</tr>
</table>

</td>
</tr>
</table>

</body>
</html>
