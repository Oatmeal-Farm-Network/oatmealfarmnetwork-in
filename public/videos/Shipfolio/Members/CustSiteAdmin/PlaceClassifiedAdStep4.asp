

<html>
<head>

<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Place a Classified Ad</title>
<link rel="shortcut icon" href="/LittleShrew.ico" /> 
<link rel="icon" href="http://www.GreenShrew.com/LittleShrew.ico" /> 
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY>
<!--#Include file="adminHeader.asp"--> 
<!--#Include file="scripts.asp"--> 
<%


	CustID=session("CustID" )
	ID=session("ID" ) 
	Weeks=Request.Form( "Weeks" ) 
	AMonth=Request.Form( "Month" ) 
	ADay=Request.Form( "Day" ) 
	AYear=Request.Form( "Year" ) 
	CCode=Request.Form( "Code" ) 
    AdType=Request.Form( "AdType" ) 

	StartDate = AMonth & "/" & ADay & "/" & AYear 
ValidCoupon = True
CouponFound = False

Enddate = DateAdd("ww",Weeks,StartDate)
'response.write(Len(Trim(CCode)))
If Len(Trim(CCode)) > 1 Then
CouponFound = True
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
		sql = "select * from Coupons where Code = '" & CCode & "' and (AdType = 'All' or  AdType = 'All Types' Or Adtype = '" & AdType & "')"
		'response.write (sql)
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3  
		
		
		If rs.eof Then
			ValidCoupon = False
		else
		    AmountOff = rs("AmountOff")
			AdType = rs("AdType")
		End If 
		rs.close
End If

If ValidCoupon = False then
%>
	<b><font color = "color">Sorry, the coupon code you entered was not valid.</font></b>
		<!--#Include file="PlaceClassifiedAdStep3Include.asp"--> 
<% Else %>
<% If Session("Step4Count") = 0 then
   Session("Step4Count") = 1
	
	  Query =  " UPDATE Products Set ProdStartDate = '" & StartDate & "' ,"
	   Query = QUERY &  "ProdEndDate = '" & Enddate & "' " 
      Query =  Query + " where ID = " & ID & ";" 
		

'response.write(Query)	
'DataConnection.Close
'Set DataConnection = Nothing

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 


DataConnection.Close
Set DataConnection = Nothing
End if
%>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "630">
	<tr>
		<td class = "body" valign = "top"  ><h1>Create an Ad - Step 5: Place Your Order<a name="Add"></a>
			<img src = "images/underline.jpg" width = "600"></h1>
			<blockquote>Below you may pay for your order via PayPal. After your payment is processed your ad will be setup (1-3 days).</blockquote>
		</td>
	</tr>
</table>
		   

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "550">
	<tr>
		<td class = "body" valign = "top"  width = "100">&nbsp;</td>
	</tr>
	<tr>
	   <td>
	<table  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "left"  border = "0">
	<tr>
		<td class = "body"  align = "center">

<table  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "left"  bgcolor = "#edf2e4"  bgcolor = "#edf2e4" border = "1" bordercolor = "#628038" width = "600">
	<tr>
		<td class = "body" width = "160" align = "center" >Rate</font></b></td>
		<td class = "body" width = "160" align = "center" >Number of Weeks</font></b></td>
		<td class = "body" width = "100" align = "center" >Amount</td>
	</tr>
	<tr>

<form target="_paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">

		<td class = "body"  align = "center">$5.00 per Week</td>
	
<td align = "center" class = "body">
<input type="hidden" name="quantity" value="1" size = "5"><%=Weeks%>
</td>
<td class = "body" align = "right">
	<% cost = FormatCurrency(weeks * 5) %>
	<%=cost%>&nbsp;&nbsp;&nbsp;

</td>
</tr>
<% If ValidCoupon = TRUE And CouponFound = True Then %>
<tr>
	<td colspan = "2" align = "right" class = "body">
Discount from Coupon:
	</td>
	<td class = "body" align = "right">
		<%  str1 = AmountOff 
				str2 = "%"
				If InStr(str1,str2) > 0 Then
					AmountOff = Replace(str1, "%", "")
					Discount = FormatCurrency(Cost * (AmountOff/100))
				End If
				
				str1 = AmountOff 
				str2 = "$"
				If InStr(str1,str2) > 0 Then
					AmountOff = Replace(str1, "$", "")
					Discount = FormatCurrency(AmountOff)
				End If
				

				If AmountOff  = "Unlimited" then
				    Discount = Cost
				End If 
				%>

			-<%=Discount %>&nbsp;&nbsp;&nbsp;
	</td>
</tr>
<% End If %>
<tr>
	<td colspan = "2" align = "right" class = "body">
		Total:
	</td>
	<td class = "body"  align = "right">
		<%  Total = Cost - Discount 
				
				%>
		
		
		<%=FormatCurrency(Total)%>&nbsp;&nbsp;&nbsp;
	</td>
</tr>

<% If Total > 0 Then %>
	<input type="hidden" name="add" value="1">
	<input type="hidden" name="cmd" value="_cart">
	<input type="hidden" name="business" value="Jamianne@Charter.net">
	<input type="hidden" name="item_name" value="GreenShrew Ad">
	<input type="hidden" name="amount" value="<%=Total%>">
	<input type="hidden" name="no_shipping" value="0">
	<input type="hidden" name="no_note" value="1">
	<input type="hidden" name="currency_code" value="USD">
	<input type="hidden" name="lc" value="US">
	<input type="hidden" name="bn" value="PP-ShopCartBF">
	<input type="hidden" name="return" value="http://www.GreenShrew.comcompletion.asp">
	<input type="hidden" name="cancel_return" value="http://www.greenshrew.com/PlaceClassifiedAdStep3.asp">
<tr>
<td colspan = "3" align = "center">

 	<input type=submit value = "Pay For Your Order" style="background-image: url('images/background.jpg'); border-width:1px" size = "310" class = "menu" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"/>
		</td>
	</tr>
<% Else %>
		<td colspan = "3" align = "center">
			<h2>Thank you for your order.<br>
			It will be processed in the next 1-3 business days.</h2>

		</td>
<% End If  %>
</table>



</form>
    
      </td>
	</tr>
</table>
</form>
<br>
<div align = "left">
	<blockquote><br><br>
		<table align = "left">
		<tr>
			<td height = "7" colspan = "3" class = "body"><br>

			</td>
		</tr>
		<tr>
		  <td colspan = "3" class = "body">
				<h2>Where To Go Next:</h2>
		  </td>
		  </tr>
			<tr>
				<td class = "body" align = "center" width = "150">
					<a href = "UploadPhotos.asp" class = "body"><img src = "images/Photo.jpg" border = "0"><br>
					Upload A Photo</a>
				</td>
				<td class = "body" align = "center" width = "150">
					<a href = "EditAd.asp" class = "body"><img src = "images/EditAd.jpg" border = "0"><br>
					Edit one of your ads.</a>
				</td>
				<td class = "body" align = "center" width = "150">
						<a href = "Default.asp" class = "body"><img src = "images/Home.jpg" border = "0"><br>
					Go to our home page.</a>
				</td>
			</tr>
		</table>
		
		
	</blockquote>
   </div>
</td>
</table>

<% End If  %>
<!--#Include file="Footer.asp"-->
</BODY>
</HTML>
