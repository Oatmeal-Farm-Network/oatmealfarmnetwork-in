<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="membersGlobalVariables.asp"-->

 

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
rs.Open sql, conn, 3, 3 
ProdDescription = rs("ProdDescription")
rs.close
%>

 <form action= "membersProductsDescriptionHandleForm.asp" method = "post" name="myform"> 
<div>
 <div align = "left">
    <% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div>
	<div style="background-color: floralwhite; min-height:60px">
        <br /><b>&nbsp;&nbsp;&nbsp;Your Product Basic Facts Changes Have Been Made.</b><br>
	</div>
</div>
<% end if %>
     <br />
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
    // attach the editor to the textarea with the identifier 'textarea1'.
    WYSIWYG.attach("ProdDescription", mysettings);
    mysettings.Width = "100%"
    mysettings.Height = "300px"
    </script>
 
    <center><textarea name="ProdDescription" ID="ProdDescription" cols="40" rows="30"  class = "formbox" ><%=ProdDescription%></textarea></center>
    <br />
    <input name="ProdID" value="<%=ProdID%>" type = hidden>
    <div align = "right"><input type=submit name= "button1" value = "Submit" class = "regsubmit2"  <%=Disablebutton %> ></div>
</form>
</body>
</html>
