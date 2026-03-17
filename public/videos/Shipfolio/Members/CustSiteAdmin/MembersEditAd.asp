<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="adminGlobalVariables.asp"-->
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Products"
Current2 = "EditProduct" 
Current3 = "EditProduct" %> 
<!--#Include file="adminHeader.asp"-->
<br />
<!--#Include file="AdminProductsTabsInclude.asp"-->
<% 'conn.close
'set conn = nothing %> 
<!--#Include virtual="/connloa.asp"-->

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=screenwidth -32%>" class = "roundedtopandbottom">
<tr><td>
<% ProdID=request.form("ProdID") 
If Len(ProdID) < 3 then
	ProdID= Request.QueryString("ProdID") 
End If
Session("ProdID") = ProdID
'response.write("ProdID=")
'response.write(ProdID)
Dim AdType(10000)
dim IDArray(10000)
Dim ProdnameArray1(10000)

 If Len(ProdID) = 0 Then 
  	sql2 = "select * from sfProducts  where PeopleID = " & session("AIID") & " order by Prodname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	if rs2.eof then %>
	 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>"><tr><td  align = "left"><br />
		<H1><div align = "left">Edit Products</div></H1>
        </td></tr>
        <tr><td class = " body" align = "left" valign = "top" height = "300">
        Currently you do not have any products listed. To add products please select the <A href = "MembersPlaceClassifiedAd0.asp" class = "body">Add Products</A> tab above.
<br />
</td>
</tr>
</table>

<%	else
	While Not rs2.eof  
		IDArray(acounter) = rs2("prodID")
		ProdnameArray1(acounter) = rs2("Prodname")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set connloa = nothing
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>"><tr><td  align = "left"><br />
<H1>Edit Your Product</h1><h2>Select a Product</h2>
<form action="MembersAdEdit2.asp" method = "post">
<table border = "0" width = "600"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td width ="30">
&nbsp;
</td>
<td class = "body">
					<br>Select one of your listings:<br>
					<select size="1" name="ProdID" class = "formbox">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=ProdnameArray1(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit"  class = "regsubmit2" >
					<br /><br />
				</td>
			  </tr>
		    </table>
		  </form>
		  	</td>
			  </tr>
		    </table>
		    
<% end if %>		    
<% Else %>
	
 <!-- #include file="MembersProductsPhotoFormInclude2.asp" -->
 <% End if %>
</td>
			  </tr>
		    </table>
<!--#Include file="adminFooter.asp"--> 
 </Body>
</HTML>
