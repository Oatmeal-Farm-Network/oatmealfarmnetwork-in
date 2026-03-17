<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
 
<!--#Include file="AdminHeader.asp"--> 
 <%  Tabs = request.QueryString("Tabs")
Current3 = "Payments" %>  
<!--#Include file="AdminPagesTabsInclude.asp"-->
 
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Your Store Settings</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "300" valign = "top" >   


<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from people where peopleId = 667"
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   

prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
peopleEmail = rs("peopleEmail")
Weblink= rs("Weblink")
TaxNexusState= rs("TaxNexusState")
TaxRate= rs("TaxRate")
TaxActive= rs("TaxActive")
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




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "960" align = "center">
	<tr>
		<td valign = "top">
			 <form action= 'AdminStoreAccountHandleForm.asp' method = "post">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Payment Method</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" valign = "top"><br />
          
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500">
  
		<tr>
			<td  class = "body"><br />
					<b>How can people pay for your products? </b>
			</td>
		</tr>
		<tr>
				<td   valign = "top" class = "body">
					<select size="1" name="prodPurchasemethod" class = "body">
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
</table>
				</td></tr></table>
		<br /><a name="Taxes"></a>
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Taxes</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" valign = "top"><br />
          
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500"><tr>
<td class = "body2" align = "right" height = "25" width = "120">State / Provence:&nbsp;</td>
<td class = "body"  height = "25" align = "left">
<select size="1" name="TaxNexusState" width="125" style="width: 125px">
<% if len(TaxNexusState) > 1 then %>
<option value="<%=TaxNexusState %>"><%=TaxNexusState %></option>
<% end if %>
<option value="">---</option>
<option value="Alaska">Alaska</option>
<option  value="Arkensas">Arkensas</option>
<option  value="Arazona">Arazona</option>
<option  value="Arkansas">Arkansas</option>
<option  value="California">California</option>
<option  value="Colorado">Colorado</option>
<option  value="Connecticut">Connecticut</option>
<option  value="Delaware">Delaware</option>
<option  value="District of Columbia">District of Columbia</option>
<option  value="Florida">Florida</option>
<option  value="Georgia">Georgia</option>
<option  value="Hawaii">Hawaii</option>
<option  value="Idaho">Idaho</option>
<option  value="Illinois">Illinois</option>
<option  value="Indiana">Indiana</option>
<option  value="Iowa">Iowa</option>
<option  value="Kansas">Kansas</option>
<option  value="Kentucky">Kentucky</option>
<option  value="Louisiana">Louisiana</option>
<option  value="Maine">Maine</option>
<option  value="Maryland">Maryland</option>
<option  value="Massachusetts">Massachusetts</option>
<option  value="Michigan">Michigan</option>
<option  value="Minnesota">Minnesota</option>
<option  value="Mississippi">Mississippi</option>
<option  value="Missouri">Missouri</option>
<option  value="Montana">Montana</option>
<option  value="Nebraska">Nebraska</option>
<option  value="Nevada">Nevada</option>
<option  value="New Hampshire">New Hampshire</option>
<option  value="New Jersey">New Jersey</option>
<option  value="New Mexico">New Mexico</option>
<option  value="New York">New York</option>
<option  value="North Carolina">North Carolina</option>
<option  value="North Dakota">North Dakota</option>
<option  value="Ohio">Ohio</option>
<option  value="Oklahoma">Oklahoma</option>
<option  value="Oregon">Oregon</option>
<option  value="Pennsylvania">Pennsylvania</option>
<option  value="Rhode Island">Rhode Island</option>
<option  value="South Carolina">South Carolina</option>
<option  value="South Dakota">South Dakota</option>
<option  value="Tennessee">Tennessee</option>
<option  value="Texas">Texas</option>
<option  value="Utah">Utah</option>
<option  value="Vermont">Vermont</option>
<option  value="Virginia">Virginia</option>
<option  value="Washington">Washington</option>
<option  value="West Virginia">West Virginia</option>
<option  value="Wisconsin">Wisconsin</option>
<option  value="Wyoming">Wyoming</option>
<option  value=""></option>
<option  value="Ontario">Ontario</option>
<option  value="Quebec">Quebec</option>
<option  value="British Columbia">British Columbia</option>
<option  value="Alberta">Alberta</option>
<option  value="Manitoba">Manitoba</option>
<option  value="Saskatchewan">Saskatchewan</option>
<option  value="Nova Scotia">Nova Scotia</option>
<option  value="New Brunswick">New Brunswick</option>
<option  value="Newfoundland">Newfoundland</option>
<option  value="Prince Edward Island">Prince Edward Island</option>
<option  value="Northwest Territories">Northwest Territories</option>
<option  value="Yukon">Yukon</option>
<option  value="Nunavut">Nunavut</option>
</select>
</td>
</tr>
<tr><td class = "body2" align = "right" height = "25" >Tax Rate:</td>
<td class = "body" align = "left">
<input name="TaxRate"  size = "3" value = "<%= TaxRate %>">%
</td>
</tr>
		</table>
			</td>
		</tr>
		</table>
	<br />
	<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500"><tr><td align = "right"><input type=submit value = "Submit Changes" class = "regsubmit2" ></td></tr></table>
		</form>

</td>
<td class = "body" bgcolor = "#dedede" width = "400" >
    <table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
        <tr><td class = "roundedtop" align = "left">

<br /><blockquote>
		<h2><center>Customer Payments</center></h2>
		Customers can purchase your products in the following ways:
		<ul>
			<li>Contact you.</li>
			<li>Pay via Paypal if you have a Paypal account.</li>
			<li>Send buyers to another website.</li>
		</ul>	
		
		<h2><center>Paypal</center></h2>
PayPal is an account-based system that lets anyone with an email address securely send and receive online payments using their credit card or bank. To learn more please go to <a href = "http://www.paypal.com" target = "blank" class = "body">www.Paypal.com</a>. <br><br>
<h2><center>US Sales Taxes</center></h2>
US sales taxes are governed by a legal concept known as nexus. Basically, nexus means that a business,  must have some physical connection to a state to be required to collect sales taxes there. “Physical presence” might be employees, a warehouse, or some other assets located inside the state.  Simply shipping products via common carriers or directing marketing to customers in a particular state is not enough of a connection to establish nexus. If you do not have a physical presence in a particular state, you are not required to collect sales taxes.<br /><br />
 
Each state defines nexus differently, but all agree that if you have a store or office of some sort, a nexus exists. If you are uncertain whether or not your business qualifies as a physical presence, contact your state's revenue agency. <br /><br />

<b>State Exemptions</b><br /><br />

Keep in mind that not every state and locality has a sales tax. Alaska, Delaware, Hawaii, Montana, New Hampshire and Oregon do not have a sales tax. In addition, most states have tax exemptions on certain items, such as food or clothing. If you are charging sales tax, you need be familiar with applicable rates.

<br /><br />
 
You can view a list of sales tax rates by going to: 
<a href = "http://www.salestaxinstitute.com/resources/rates" class = "body" target = "blank">www.salestaxinstitute.com/resources/rates</a>
</blockquote><br>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br />
<!--#Include file="AdminFooter.asp"-->
</Body>
</HTML>