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
BusinessID=request.querystring("BusinessID")

ProduceID=request.querystring("ProduceID")
Quantity = request.form("Quantity")
IngredientID = request.form("IngredientID")
MeasurementID = request.form("MeasurementID")
RetailPrice = request.form("RetailPrice")
WholesalePrice = request.form("WholesalePrice")
AvailableDate = request.form("AvailableDate")
IngredientID = request.form("IngredientID")
ShowProduce = request.Form("ShowProduce")
if len(ShowProduce)> 0 then
else
ShowProduce = 0
end if

if Update = "True" then
	response.write("ProduceID=" & ProduceID)


	Query =  " UPDATE Produce Set Quantity = " & Quantity & ", " 
	Query =  Query & " MeasurementID = " & MeasurementID & "," 
	Query =  Query & " RetailPrice = " & RetailPrice & "," 
	Query =  Query & " WholesalePrice = " & WholesalePrice & "," 
	Query =  Query & " AvailableDate = '" & AvailableDate & "'," 
	Query =  Query & " ShowProduce = "  & ShowProduce & ","
	Query =  Query & " IngredientID = " & IngredientID & "" 
	Query =  Query & " where ProduceID = " & ProduceID & ";" 

	response.write("Query=" & Query)

	'On Error Resume Next
	Conn.Execute(Query)

	conn.Close
	Set conn = Nothing

	Session("SuccessMessage") = "Your Changes Have Been Made."
	Response.Redirect "MembersProduceInventory.asp?BusinessID=" & BusinessID

end if



If Delete = "True" then


Query =  "DELETE From  Produce where ProduceID = " & ProduceID & ";" 

response.write("Query=" & Query)

On Error Resume Next
Conn.Execute(Query)

conn.Close
Set conn = Nothing

Response.Redirect "MembersProduceInventory.asp?BusinessID=" & BusinessID




end if


%>

</Body>
</HTML>