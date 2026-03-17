<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<body >
><!--#Include file="membersGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct" 
Current3="Delete"%> 
<!--#Include file="membersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">
  <div class="row">
    <div class="col-md-6 col-sm-12" style ="min-height:500px">
<%
dim ID
ID=Request.Form("ID" )

if len(ID) > 0 then
Query =  "Delete From sfProducts where prodID = " &  ID & "" 
conn.Execute(Query) 



Query =  "Delete From productCategoriesList where productID = " &  ID & "" 
conn.Execute(Query) 

Query =  "Delete From ProductStats where prodID = " &  ID & "" 
conn.Execute(Query) 

end if

conn.Close
Set conn = Nothing %>


        <H3>Delete Products</H3>
       <center><b>Your product has been deleted.</b></center> 
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    </div>
</div>
</div>

<br />
<!--#Include file="MembersFooter.asp"-->
</Body>
</HTML>