<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>

</head>
<body >

<!--#Include file="MembersGlobalVariables.asp"-->


<%
Update = Request.form("Update")
response.write("Update=" & Update)
Delete = Request.Querystring("Delete")
response.write("Delete=" & Delete)

ProcessedFoodID = request.querystring("ProcessedFoodID")

Quantity = request.form("Quantity")
ProcessedFoodID = request.Querystring("ProcessedFoodID")


RetailPrice = request.form("RetailPrice")
WholesalePrice = request.form("WholesalePrice")
AvailableDate = request.form("AvailableDate")
ShowProcessedFood = request.Form("ShowProcessedFood")
BusinessID = request.form("BusinessID")


If Delete = "True" then
	response.write("ProcessedFoodIDXX=" & ProcessedFoodID)

	Query =  "DELETE From ProcessedFood where ProcessedFoodID = " & ProcessedFoodID & ";" 

	response.write("Query=" & Query)

	On Error Resume Next
	Conn.Execute(Query)

	conn.Close
	Set conn = Nothing

	Response.Redirect "MembersProcessedFoodInventory.asp"


end if

if Update = "True" then
	response.write("ProcessedFoodID=" & ProcessedFoodID)


	Query =  " UPDATE ProcessedFood Set Quantity = " & Quantity & ", " 
	Query =  Query & " BusinessID = " & BusinessID & ","
	Query =  Query & " RetailPrice = " & RetailPrice & "," 
	Query =  Query & " WholesalePrice = " & WholesalePrice & "," 
	if ShowProcessedFood = 1 then
	Query =  Query & " ShowProcessedFood = 1"  
	else
	Query =  Query & " ShowProcessedFood = 0"  
	end if
	Query =  Query & " where ProcessedFoodID = " & ProcessedFoodID & ";" 

	response.write("Query=" & Query)

	'On Error Resume Next
	Conn.Execute(Query)

	conn.Close
	Set conn = Nothing

	Session("SuccessMessage") = "Your Changes Have Been Made."
	Response.Redirect "MembersProcessedFoodInventory.asp"

end if






%>

</Body>
</HTML>