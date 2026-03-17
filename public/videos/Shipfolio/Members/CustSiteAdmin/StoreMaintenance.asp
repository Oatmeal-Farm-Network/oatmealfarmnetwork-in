<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Store Maintenance</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >



<!--#Include virtual="/Administration/Header.asp"--> 
<!--#Include virtual="/Administration/storeHeader.asp"--> 
<table  height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">

<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from SFCustomers where CustID=" & session("CustID")
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   

prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
custEmail = rs("custEmail")
Weblink= rs("Weblink")

If Len(prodPurchasemethod) > 3 Then

else
	prodPurchasemethod ="Contact Me"
End If 

If Len(OtherURL) > 3 Then
else
	OtherURL =Weblink
End If 

If Len(PaypalEmail) > 3 Then
else
	PaypalEmail =custEmail 
End If 


%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "770">
	<tr>
		<td Class = "body" colspan = "3"><br>
			<h1>Your Store Settings</h1>
			<img src = "images/underline.jpg" width = "770"></H2>
		</td>
	</tr>
	<tr>
		<td valign = "top" width = "5">&nbsp;
		</td>
		<td valign = "top">
			 <form action= 'StoreAccountHandleForm.asp' method = "post">
			
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  
		<tr>
			<td  class = "body">
					<b>How can people buy your products? </b>
			</td>
		</tr>
		<tr>
				<td   valign = "top" class = "body">
					
					<select size="1" name="prodPurchasemethod">
						<option value="<%=prodPurchasemethod %>" selected><%=prodPurchasemethod %></option>
						<option value="Contact Me">Contact Me</option>
						<option  value="PayPal">PayPal</option>
						<option  value="Send Users to Another Website">Send Users to Another E-Commerce Site</option>
					</select>
			</td>
		</tr>
		<tr>
			<td  class = "body"><br>
					<b>Email used if your paypal account (if applicable)</b>
			</td>
		</tr>
		<tr>
				<td  valign = "top" class = "body">
					<input name="PaypalEmail"  size = "60" value = "<%=PaypalEmail %>">
			</td>
		</tr>
		<tr>
			<td  class = "body"><br>
					<b>Other Website (if applicable)</b>
			</td>
		</tr>
		<tr>
			<td   valign = "top" class = "body">
					http://<input name="OtherURL"  size = "50" value = "<%= OtherURL %>">
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110"  >
		</td>
		</tr>
		</table></form>

</td>
<td class = "body" bgcolor = "antiquewhite" width = "300">
		<h2><center>Customer Payments</center></h2>
		Customers can purchase your products in the following ways:
		<ul>
			<li>Contact you.</li>
			<li>Pay via Paypal if you have a Paypal account.</li>
			<li>Send buyers to another website.</li>
		</ul>	
		
		<h2><center>Paypal</center></h2>
PayPal is an account-based system that lets anyone with an email address securely send and receive online payments using their credit card or bank. To learn more please go to <a href = "http://www.paypal.com" target = "blank" class = "body">www.Paypal.com</a>. <br><br>

</td>
</tr>
</table>
</td>
</tr>
</table>
<!--#Include file="Footer.asp"-->
</Body>
</HTML>