<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Global Grange inc.">
    <title>Delete a Company / Organizations Listing</title>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<%  Request.form("BusinessID=" & BusinessID)
Current1 = "MembersHome"
Current2="MembersHome" %> 

<style>




	.confirmation-message {
		font-size: 1.1em;
		margin-bottom: 30px;
		line-height: 1.5;
	}

	.company-details {
		border: 1px solid #ddd;
		padding: 20px;
		border-radius: 5px;
		margin-bottom: 30px;
		background-color: #f9f9f9;
	}

	.company-details h2 {
		color: #5cb85c; /* A color for positive identification */
		margin-top: 0;
		margin-bottom: 10px;
	}

	.company-details p {
		margin: 5px 0;
		font-size: 0.95em;
	}

	.delete-button {
		background-color: #d9534f;
		color: white;
		padding: 12px 25px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		font-size: 1.1em;
		transition: background-color 0.3s ease;
	}

	.delete-button:hover {
		background-color: #c9302c;
	}

	.form-wrapper {
		display: flex;
		justify-content: center; /* Center the form content */
		align-items: center;
	}
</style>
</head>
<body>
	<% 
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   

BusinessID  = request.form("BusinessID")
BusinessTypeID  = request.form("BusinessTypeID")

if len(BusinessID) > 0 then
  Query =  "Update Business set BusinessTypeID = " & BusinessTypeID & " where BusinessID = " & BusinessID & "; "
  response.write("Query=" & Query)
  Conn.Execute(Query)
end if

Conn.Close
Set Conn = Nothing 

response.Redirect("MembersAccountChangeType.asp?BusinessID=" & BusinessID & "&status=success")

%>




<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</Body>
</HTML>





