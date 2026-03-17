<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Global Grange inc.">
    <title>Delete a Company / Organizations Listing</title>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% BusinessID = Request.querystring("BusinessID")
	sql2 = "SELECT Business.*, businesstypelookup.* FROM Business INNER JOIN businesstypelookup ON Business.businesstypeID = businesstypelookup.businesstypeID WHERE BusinessID = " & BusinessID 
	Set rs2 = Server.CreateObject("ADODB.Recordset")

   ' response.write("sql2=" & sql2)

    rs2.Open sql2, conn, 3, 3 

if Not rs2.eof then
        BusinessName = rs2("BusinessName")
		BusinessType = rs2("BusinessType")
	end if		
	
		rs2.close
		set rs2=nothing
%>


<%  Request.querystring("BusinessID=" & BusinessID)
Current1 = "MembersHome"
Current2="MembersHome" %> 

<style>


	h1 {
		color: #d9534f; /* A color often associated with deletion/warning */
		margin-bottom: 20px;
	}

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

<div class="container">
	<h1>Delete a Company / Organization Listing</h1>

	<p class="confirmation-message">
		Are you sure you want to delete this Company / Organization?
	</p>
	<div class="company-details">
		<h2><%= BusinessName %></h2>
		<p><%= BusinessType %> Account</p>
	</div>
 <div class="form-wrapper">
            <form action="AdminOrgDeleteHandleform.asp" method="post">
                <input type="hidden" name="BusinessID" value="<%= BusinessID %>">
                <input type="submit" value="Delete" class="delete-button">
            </form>
        </div>

</div>



 
 



<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</Body>
</HTML>