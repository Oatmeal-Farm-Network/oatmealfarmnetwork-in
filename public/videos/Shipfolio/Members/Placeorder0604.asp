<!--#include virtual="/aspJSON1.18.asp" -->
<%
	dim StripeSecretKey
StripeSecretKey="sk_test_51M9fLlKoUhwamYBwsp8vruIu7h0QQ4Nlad2FdgKq8hM2t880X5M0MH3JDoYRrie6acQ9OD4QQ1znB0UI4Vc21INR00lITZrrwA"

  dim   stripeToken, StripeCustomerID, StripePaymentMethodID, StripeSubscriptionID, StripePriceID
	dim name, email, phone,description
 stripeToken   =request.form ("stripeToken")
StripePriceID   =request.form ("stripe_product_price")
PeopleID   =request.form ("PeopleID")
name   =request.form ("name")
email   =request.form ("email")
phone   =request.form ("phone") 
description=PeopleID
Dim StripeURL, APIKey
APIKey = StripeAPIkey
'----------------------------------Add Customer------------------------------------
 
AddCustomer name, email, phone, description
'Response.Write "success|StripeCustomerID|StripeSubscriptionID"

Function AddCustomer(name, email, phone, description)
	Dim customerDetails, requestBody,responseText
	requestBody = "name="& name &"&email="& email &"&phone="& phone	 &"&description="& description	
	responseText = makeStripeAPI (requestBody,"https://api.stripe.com/v1/customers" )
	StripeCustomerID=GetIdFromJson(responseText)
	 

	StripePaymentMethodID=AddPaymentMethod
	AttachPaymentMethod StripeCustomerID ,StripePaymentMethodID
	AddDefaultPaymentMethod StripeCustomerID ,StripePaymentMethodID
	StripeSubscriptionID=AddSubscription( StripeCustomerID , StripePriceID)
	Response.Write "success|"& StripeCustomerID &"|"& StripeSubscriptionID
End Function

'----------------------------------Add PaymentMethod------------------------------------
Function AddPaymentMethod
	dim   stripeTokenPM, card_name, cardNumber,cardExpMonth, cardExpYear,cardCVC
	stripeTokenPM=	request.form ("stripeToken")
	card_name=	request.form ("card_name")
	cardNumber=	request.form ("cardNumber")
	cardExpMonth=	request.form ("cardExpMonth")
	cardExpYear=	request.form ("cardExpYear")
	cardCVC=	request.form ("cardCVC")

	Dim requestBody,requestText
	requestBody = "type=card&card[number]="& cardNumber &"&card[exp_month]="& cardExpMonth &"&card[exp_year]="& cardExpYear &"&card[cvc]="& cardCVC
	responseText = makeStripeAPI(requestBody,"https://api.stripe.com/v1/payment_methods")
	AddPaymentMethod=GetIdFromJson(responseText)
End Function


'----------------------------------Attach PaymentMethod------------------------------------

Function AttachPaymentMethod(StripeCustomerID,StripePaymentMethodID)
	Dim payment_methodsAttachURL
	payment_methodsAttachURL = "https://api.stripe.com/v1/payment_methods/"& StripePaymentMethodID &"/attach"

	Dim requestBody,requestText
	requestBody ="customer="+StripeCustomerID
	responseText = makeStripeAPI(requestBody,payment_methodsAttachURL)
End Function
	 
'----------------------------------Default Payment Method------------------------------------
Function AddDefaultPaymentMethod(StripeCustomerID,StripePaymentMethodID)
	dim DefaultPMURL, CustomerIDDefaultPM, PM
	DefaultPMURL = "https://api.stripe.com/v1/customers/"& StripeCustomerID
	Dim requestBody,requestText
	requestBody ="invoice_settings[default_payment_method]="& StripePaymentMethodID
	responseText = makeStripeAPI(requestBody,DefaultPMURL)	 
End Function

		'----------------------------------Add subscription------------------------------------

Function AddSubscription(StripeCustomerID,StripePriceID)
	dim subscriptionURL, CustomerIDSub
	subscriptionURL = "https://api.stripe.com/v1/subscriptions"
	Dim requestBody,requestText
	requestBody ="customer="+StripeCustomerID+"&items[0][price]="& StripePriceID
	responseText = makeStripeAPI(requestBody,subscriptionURL)	 
	AddSubscription=GetIdFromJson(responseText)
	 
End Function
 

'chargeCard "01", "20", "123", "4242424242424242", "400"
StripeURL = "https://api.stripe.com/v1/charges"

Function chargeCard(month, year, cvc, number, cost)
	Dim cardDetails, requestBody
	cardDetails = "source[exp_month]="& month &"&source[exp_year]="& year &"&source[number]="& number &"&source[cvc]="& cvc
	requestBody = "currency=usd&amount="& cost &"&source[object]=card&"& cardDetails
	
	chargeCard = makeStripeAPICall(requestBody)
End Function

Function chargeCardWithToken(token, cost)
	Dim requestBody
	requestBody = "currency=usd&amount="& cost &"&source="& token
	
	chargeCardWithToken = makeStripeAPICall(requestBody)
End Function

Function makeStripeAPI(requestBody, APIurl)
	Dim objXmlHttpMain, result
	
	Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP") 
	On Error Resume Next
	objXmlHttpMain.open "POST", APIurl, False
	objXmlHttpMain.setRequestHeader "Authorization", "Bearer  "&StripeSecretKey
	objXmlHttpMain.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXmlHttpMain.send requestBody
	result=  objXmlHttpMain.responseText
	
	makeStripeAPI =result
End Function

Function GetIdFromJson(strJson)
	'Dim http,URL
	'URL = "http://localhost/global/jsondata.txt"
	'Set http = CreateObject("Msxml2.XMLHTTP")
	'http.open "GET",URL,False
	'http.send
	'strJson = http.responseText
	Set oJSON = New aspJSON
	oJSON.loadJSON(strJson)
	GetIdFromJson= oJSON.data("id") 
End Function

 %>