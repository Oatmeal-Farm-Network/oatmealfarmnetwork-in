<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="style.css">
<base target="_parent" />
</head>
<body>
<%
PageLayoutID = request.Querystring("PageLayoutID")
numproducts = request.QueryString("numproducts")
textblock= request.Querystring("textblock")
if len(textblock) > 0 then
else
textblock= request.Form("textblock")
end if


Add = request.Querystring("Add")
Delete = request.Querystring("Delete")
'response.Write("Delete=" & Delete )
ProdServiceID= request.Form("ProdServiceID")
ProdServiceReferenceID= request.Form("ProdServiceReferenceID")

'response.Write("ProdServiceReferenceID=" & ProdServiceReferenceID )

if len(PageLayoutID) > 0 then
else
PageLayoutID = request.Form("PageLayoutID")
end if
Session("PageLayoutID") = PageLayoutID

DatabasePath = "../../DB/SitedataMaster.mdb"
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;"


Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

if Delete = "True" then
	Query =  "Delete * From ProdServiceReferenceTable where ProdServiceReferenceID = " &  ProdServiceReferenceID & "" 
DataConnection.Execute(Query) 
response.Redirect("AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#TextBlock" & textblock)
end if

if Add = "True" then
Query =  "INSERT INTO ProdServiceReferenceTable (PageLayoutID, ProdServiceID, ProdServiceIDType, textblock)"  
Query =  Query & " Values (" &  PageLayoutID & ", '" & ProdServiceID & "' , 'Product', " & textblock & ")"
response.Write("Query=" & Query )
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing
response.Redirect("AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#TextBlock" & textblock)
end if


 
%>

<a name="Top"></a>
<table width = "350">
<tr><td class = "body" colspan = "3">
<form method="POST" action="AdminPageEditProductsInclude.asp?PageLayoutID=<%= PageLayoutID %>&textblock=<%= textblock %>&Add=True" >
<% sql = "select * from sfProducts " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if rs.eof then %>
 You do not currently have any products listed. <BR /><a hred = "AdminServicesAdPlace.asp" class = "body">Click here to add products.</a> 
<% else %>


<b>Add Product:</b>  
<select name="ProdServiceID" onchange="submit();">
<option value="">Select to Include a Product</option>

<% while Not rs.eof %>
<option value="<%=rs("ProdID") %>"><%=rs("prodName") %></option>
<% rs.movenext
wend
end if 
rs.close
%>
</select></form></td> </tr>

<tr>
	<td class= "body" >
	
	
<% 

sql = "select * from ProdServiceReferenceTable, sfProducts  where PageLayoutID = " & PageLayoutID  & " and ProdServiceIDType = 'Product' and ProdServiceReferenceTable.ProdServiceID = cint(sfProducts.ProdID) and textblock = " & textblock & " order by ProdServiceReferenceID DESC " 
'response.Write("sql=" & sql)
rs.Open sql, conn, 3, 3 
if Not rs.eof then %>
<table border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = 'left' width = '280'>
<Tr><td class = "body"><center><b>Product</b></center></td>
<td class = "body"><center><b>Price<i>(Discount)</i></b></center></td>
<td></td>
</Tr>
<% while not rs.eof %>
 <tr>
   <td class = "body">
    <input type = "hidden" name="ProdServiceID" value= "<%= rs("ProdServiceID") %>" >
     <input type = "hidden" name="textblock" value= "<%= textblock %>" >
    <input type = "hidden" name="ProdServiceIDType" value= "<% = rs("ProdServiceIDType") %>" >
        <%=rs("prodName") %>
    </td>
<td align = 'center'> 

<form method="POST" action="AdminPageEditServicesInclude.asp?PageLayoutID=<%= PageLayoutID %>&textblock=<%= textBlock %>&Delete=True" > <input type=submit value = "X" class = "regsubmit2" ><input name="ProdServiceReferenceID" value="<%=rs("ProdServiceReferenceID") %>" type = "hidden"></td>
  </tr></form>
<% rs.movenext
wend  
end if
rs.close

%>

</td>
</tr>
</table>
</form>
</body>	