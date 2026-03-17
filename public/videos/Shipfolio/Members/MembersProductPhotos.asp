<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->

 </head>
<body >

<% Current1="Products"
Current3 = "Photos" %> 
<!--#Include file="MembersHeader.asp"-->

<!--#Include file="MembersProductJumpLinks2.asp"-->
<%  
Dim IDArray2(1000)
Dim ProductName2(1000)
Dim prodNameArray(10000)
ID= Request.QueryString("ID")
 
If Len(ID) < 1 then
	ID= Request.Form("ID") 
End If 

If Len(ID) < 1 then
	ID= Request.querystring("prodID") 
End If 

Session("ProductId")= ID
ProdID = ID
Dim ProductName(200) 

If Len(ProdID) < 1 Then 
sql2 = "select ProdID, ProdName from sfProducts where PeopleID = " & session("peopleID") & "  order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ProdID")
		ProductName2(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>

<div >
    <div>
		<H1>Upload Photos</H1>

        <% if acounter > 1 then %>
            <form action="MembersProductPhotos.asp" method = "post">
			<br>Select one of your products:
			<select size="1" name="ID" class = "formbox">
				<option name = "AID0" value= "" selected></option>
				<% count = 1
					while count < acounter %>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ProductName2(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select"  class = "regsubmit2" >
			
		  </form>
	</div>
			  </div>
<% else %>
Currently you do not have an products listed. To add products please select the <A href = "PlaceClassifiedAd0.asp" class = "body">Add Products</A> tab above.!
<% end if %>
<% Else %>
	
 <!-- #include file="MembersProductsPhotoFormInclude2.asp" -->
 <% End if %>
</div>
</div>
<!--#Include File="membersFooter.asp"--> 
 </Body>
</HTML>
