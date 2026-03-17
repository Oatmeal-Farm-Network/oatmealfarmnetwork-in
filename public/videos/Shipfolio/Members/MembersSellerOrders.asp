<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% 
BusinessID = Request.form("BusinessID")

'response.write(emailerror )
If emailerror = False Then
Query =  "INSERT INTO emaillist (ReceiveEmails, EmailFirstName, EmailLastName, Newsletter, Address)" 
Query =  Query & " Values (1,"
Query =  Query &   " '" & FirstName& "', '" & lastName& "', 1, "
Query =  Query &   " '" & Email  & "' )" 
'response.write("Query=" & Query )
conn.Execute(Query) 
End If 
%>

<link rel="stylesheet" href="Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Pricing" %> 
<!--#Include file="MembersHeader.asp"-->

<% Current3 = "ProduceOrders" %>


<div class="container roundedtopandbottom">
    <h1>Produce Orders</h1>
  <%
  Query = "Select produce.BusinessID, business.BusinessName, IngredientShoppingCart.*, ingredients.PlantId, Ingredients.IngredientName, Produce.QualityID, Produce.MeasurementID, Produce.WholesalePrice, Produce.AvailableDate, Produce.Quantity as MaxQuantity  " &_ 
  		" from Business, IngredientShoppingCart , Produce , ingredients " &_ 
		  " where produce.BusinessID=business.BusinessID and IngredientShoppingCart.produceid=Produce.produceid  " &_ 
		  " and ingredients.Ingredientid = Produce.IngredientID and BuyerBusinessID = " & Session("BusinessID") & " and Status='Submitted' order by Business.BusinessName, ingredients.IngredientName "
  'response.write("Query=" & Query)
  Set rs = Server.CreateObject("ADODB.Recordset")
  rs.Open Query, conn, 3, 3  

  If rs.eof Then 
%>
<p>You have no orders.</p>
<%
  Else 
%>
<table class="table" style="width: 100%;">
  <thead>
	  <tr>
		  <th width = 200px >Ingredient</th>
		 
		  <th><center>Quality</center></th>
		  <th><center>Available Date</center></th>
		  <th ><center>Quantity</center></th>
		  <th><center>Unit Price</center></th>
		  <th><center>Total</center></th>
	  </tr>
  </thead>
  <tbody>
	  <% 
	  rowcount = 1
	  TotalOrderPrice = 0
	  OldBusinessName=rs("BusinessName")
	  While Not rs.eof  
		  ShoppingCartID = rs("ShoppingCartID")
		  PlantID = rs("PlantID")
		  QualityID = rs("QualityID")
		  MeasurementID = rs("MeasurementID")
		  IngredientName = rs("IngredientName")
		  ProduceID = rs("ProduceID")
		  WholesalePrice = rs("WholesalePrice")
		  IngredientID = rs("IngredientID")
		  OrderQuantity = rs("Quantity")
		  
		  Quantity = rs("Quantity")
		  MaxQuantity = rs("MaxQuantity")
		  'response.write("MaxQuantity=" & MaxQuantity)
		  'RetailPrice = rs("RetailPrice")
		  PlantID = rs("PlantID")
		  AvailableDate =rs("AvailableDate")
	  if len(QualityID)> 0 then
		  sql2 = "SELECT * FROM IngredientQuality where QualityID = " & QualityID
		  Set rs2 = Server.CreateObject("ADODB.Recordset")
		  rs2.Open sql2, conn, 3, 3 
		  if not rs2.eof then 
			  QualityName = rs2("QualityName")

		  end if 
		  rs2.close
	  else
	  QualityID = 1
	  end if


	  if len(PlantID)> 0 then
	  sql2 = "SELECT Plantname FROM Plant where PlantID = " & PlantID
	  Set rs2 = Server.CreateObject("ADODB.Recordset")
	  rs2.Open sql2, conn, 3, 3 
	  if not rs2.eof then 
		  Plantname = rs2("Plantname")

	  end if 
	  rs2.close

  end if


if OldBusinessName = NewBusinessName then 
else%>
<tr><td colspan="6"><b>Seller: <%=OldBusinessName %></b></td></tr>
<% 
NewBusinessName= rs("BusinessName")
end if %>
		  <tr>
			  <td>
				  <input name="IngredientID" value="<%=IngredientID %>" type="hidden">
				  <%=IngredientName %>&nbsp;(<%=PlantName %>)
			  </td>
			  
			  <td class="col-lg-1 body" style="width:90px">
				  <center><%=Qualityname %></center>
			  </td>
			  
			  <td align="center">
				  <%= FormatDateTime(AvailableDate, vbShortDate) %>
			  </td>
			  <td align="center">
				  <%=Quantity%>
	  
				  <% 
				  sql2 = "SELECT * FROM MeasurementLookup where MeasurementID= " & MeasurementID
				  Set rs2 = Server.CreateObject("ADODB.Recordset")
				  rs2.Open sql2, conn, 3, 3 
				  if not rs2.eof then %>
					  <%=rs2("Measurement") %>
				  <% end if
				  rs2.close %> 

			  </td>
			  
			  <td align="center">
				  <% if len(WholesalePrice) > 0 then %>
				  $<%=FormatNumber(WholesalePrice, 2)%>
				  <% end if %>
			  </td>
	  
			  <td align="center">
				  <% 
				  ItemPrice = FormatNumber(WholesalePrice, 2) * FormatNumber(Quantity, 2) 
				  TotalOrderPrice=  TotalOrderPrice + ItemPrice %>
				  <b>$<%=FormatNumber(ItemPrice, 2)%></b>
			  </td>
	  

		  </tr>
	  </form>
	  
	 
	  
	  <% 
		  rowcount = rowcount + 1
		  rs.movenext
	  Wend
	  end if
	  rs.close 
	  %>
  </tbody>
  <% if TotalOrderPrice > 0 then %>
  <tr>
	  <td class = "body" colspan = 5><style align = "right">Total:</style> </td>
	  <td><center><b>$<%=FormatNumber(TotalOrderPrice, 2)%></b></center></td>
	  </tr>

  <% end if %>
</table>
<br>

	
	</div>
	</div>
</div><br /><br /><br /><br /><br /><br /><br /><br />

<% 

strBody = ""

strBody = strBody & "<html>" & vbCrLf
strBody = strBody & "<head>" & vbCrLf
strBody = strBody & "<style>" & vbCrLf
strBody = strBody & "body { font-family: Arial, sans-serif; width: 340px; }" & vbCrLf  ' Set body width to 340px
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }" & vbCrLf
strBody = strBody & "#header-img { max-width: 340; height: auto; }" & vbCrLf  ' Use max-width for responsive image
strBody = strBody & "</style>" & vbCrLf
strBody = strBody & "</head>" & vbCrLf
strBody = strBody & "<body>" & vbCrLf

strBody = strBody & "<table width='340'>"  

strBody = strBody & "<tr><td colspan='2'><img src='https://www.globallivestocksolutions.com/logos/Harvest-Hub-logo.png' alt='Header Image' id='header-img' width = 340 style='max-width:340'></td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><b>Thanks for subscripting to our newsletters.</b><br><br>" & vbCrLf

	strBody = strBody & "We are excited to have you join our community of passionate farmers and ranchers.<br><br>" & vbCrLf

strBody = strBody & "At Global Grange, your privacy is paramount. We'll never share your information with anyone without your permission.<br><br>" & vbCrLf

strBody = strBody & "Farming and ranching are in our blood, and we can't wait to share our news with you. Look forward to insightful articles, valuable resources, and exciting updates to help you grow your operation.<br><br>" & vbCrLf

strBody = strBody & "<b>Didn't subscribe?</b>Please let us know if you received this message in error at <a href='https://www.GlobalGrange.world/Contactus.asp' >https://www.GlobalGrange.world/Contactus.asp</a><br><br>" & vbCrLf

strBody = strBody & "Sincerely,<br>" & vbCrLf

strBody = strBody & "The Global Grange Team<br><br></td></tr>" & vbCrLf



strBody = strBody & "<tr><td></td><td>" & Fieldname1 & "</td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><a href='https://www.harvesthub.world/' class='body'>www.harvesthub.world</a> is part of the <a href='https://www.GlobalGrange.world' class='body'>Global Grange</a> Family of websites.<br><br></td></tr>"
strBody = strBody & "<tr><td colspan='2'> <a href='https://www.GlobalGrange.world'><img src='https://www.globallivestocksolutions.com/Logos/GlobalGrangelogoHorizontal.png' alt='Header Image' id='header-img' style='max-width:340' width = 340></a></td></tr>"

strBody = strBody & "</table>" & vbCrLf
strBody = strBody & "</body>" & vbCrLf
strBody = strBody & "</html>" & vbCrLf

'response.write("strBody=" & strBody )


strTo = Email

strFrom = "thankyou@livestockemails.com"
strSubject = "Thanks for subscripting to our newsletters"

   


Set oMail = Server.CreateObject("CDO.Message")
Set iConf = Server.CreateObject("CDO.Configuration")
Set Flds = iConf.Fields
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.sendgrid.net"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
iConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True

iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "apikey"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "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"
iConf.Fields.Update
Set oMail.Configuration = iConf

if len(Email) > 4 then
 oMail.ReplyTo =Email
end if
oMail.To = strTo
'oMail.To = "john@globalgrange.world"

oMail.From = sitename & "<status@livestockemails.com>"

oMail.Subject = strSubject
oMail.BCC =  "contactus@globalgrange.world"
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
'oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing %>


<div></div>

	<!--#Include file="MembersFooter.asp"-->
</body></html>