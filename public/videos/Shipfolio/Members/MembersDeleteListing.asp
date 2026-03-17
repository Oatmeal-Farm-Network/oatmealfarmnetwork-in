<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>

<body >

<!--#Include file="MembersGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct"
Current3 = "Delete"%> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">
    <div align = "left">
        <H1>Delete Products</H1></div>
<%  
dim aID(40000)
dim aName(40000)
dim aAdType(40000)

	sql2 = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then %>
	You have no products to delete.<br />
        <A href = "MembersClassifiedAdPlace0.asp" class = "body">Add a Product</A> 
<br />
<%	else
	recordcount = rs2.recordcount
	While Not rs2.eof  
		aID(acounter) = rs2("prodID")
		aName(acounter) = rs2("ProdName")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<div class = "container">
<div class = "row">
	<div class = "body" valign = "top" align = "center">
    </div>
</div>
    	<% If recordcount = 0 then %>
          <div>
             <div>	
		       <h1>You do not currently have any products listed to delete.</h1>
             </div>
         </div>
		<% Else %>

<div class = "row">
	<div class = "col-12" align = center>
		<form action= 'membersDeleteListinghandleform1.asp' method = "post">
			<input type = "hidden" name="PhotoType" value= "ListPage">
        <b>Product</b>
		<select size="1" name="ID" class="formbox">
		<option name = "AID0" value= "" selected></option>
		<% count = 1
			while count < acounter %>
				<option name = "AID1" value="<%=aID(count)%>">
				<%=aName(count)%>
				</option>
			<% 	count = count + 1
			wend %>
		</select>
		<input type=submit value = "Delete"  class = "regsubmit2" >
	</div>
</div>
</form>
 <% End If %>
<% End If %>
<br /><br />
</div>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>