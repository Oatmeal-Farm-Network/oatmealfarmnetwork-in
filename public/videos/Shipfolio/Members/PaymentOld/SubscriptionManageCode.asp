<!--#include virtual="/stripefile/aspJSON1.18.asp" -->
<!--#Include virtual="/stripefile/Stripe.asp"-->
<%
	   
dim   stripeToken, SubscriptionID, mode,FromSubscription, ToSubscription
mode   =request.form ("mode")
stripeToken   =request.form ("stripeToken")
SubscriptionID   =request.form ("SubscriptionID")
FromSubscription   =request.form ("FromMembership")
ToSubscription   =request.form ("ToMembership")
 
if(mode="") then
	mode   =request.Querystring("mode")	
	SubscriptionID   =request.Querystring("SubscriptionID")
end if


Dim StripeURL, APIKey
APIKey = StripeAPIkey
'----------------------------------Delete Subscription------------------------------------
 

if(mode="Cancel"  and SubscriptionID <>"") then
	Dim  requestBody2,responseText2, result
		 responseText2 = makeDeleteStripeAPI (requestBody,"https://api.stripe.com/v1/subscriptions/"&SubscriptionID )
	 
		If InStr(responseText2, "doc_url") > 0 Then
			Set oJSON = New aspJSON
			oJSON.loadJSON(responseText2)
			result="Error : " & oJSON.data("error").item("message")
		else
			result="success"
		end if
		Response.write(result) 
	 
end if
'----------------------------------Change Subscription------------------------------------
 
if(mode="UpDown" and SubscriptionID <>"") then	
		Dim requestBody1,responseText1, SubscriptionItemID
		SubscriptionItemID=	GetSubscriptionItemID(SubscriptionID)
		If InStr(SubscriptionItemID, "Error") > 0 Then
			Response.write(SubscriptionItemID) 
		else
			requestBody1 = "cancel_at_period_end=false&proration_behavior=create_prorations&items[0][price]="&ToSubscription&"&items[0][id]="&SubscriptionItemID
			responseText1 = makeStripeAPI (requestBody1,"https://api.stripe.com/v1/subscriptions/"&SubscriptionID )
			Response.write("success")
		end if		
end if
	 
 Function GetSubscriptionItemID(SubscriptionID)
	 if SubscriptionID <>""  Then
		Dim requestBody,responseText,StripeSubItemId
	    dim pos
		requestBody = ""	
		responseText = makeStripeAPI (requestBody,"https://api.stripe.com/v1/subscriptions/"&SubscriptionID )
	 
		If InStr(responseText, "request_log_url") > 0 Then
			Set oJSON = New aspJSON
			oJSON.loadJSON(responseText)
			StripeSubItemId="Error : " & oJSON.data("error").item("message")
		else
			pos=(InStr(responseText,"si_"))
			StripeSubItemId=(Mid(responseText,pos,17))
		end if
		GetSubscriptionItemID= StripeSubItemId
	End if
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

Function makeDeleteStripeAPI(requestBody, APIurl)
	Dim objXmlHttpMain, result
	
	Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP") 
	On Error Resume Next
	objXmlHttpMain.open "DELETE", APIurl, False
	objXmlHttpMain.setRequestHeader "Authorization", "Bearer  "&StripeSecretKey
	objXmlHttpMain.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXmlHttpMain.send requestBody
	result=  objXmlHttpMain.responseText
	makeDeleteStripeAPI =result
End Function


Function GetIdFromJson(strJson)
	
	Set oJSON = New aspJSON
	oJSON.loadJSON(strJson)
	GetIdFromJson= oJSON.data("metadata") 
End Function
%>