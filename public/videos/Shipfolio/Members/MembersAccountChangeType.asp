<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Global Grange inc.">
    <title>Change Company / Organizations Type</title>

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


<%  
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
	<% 
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<style>
	/* CSS rules from your code */
	select {
	  -webkit-appearance: menulist;
	  -moz-appearance: menulist;
	  appearance: menulist;
	}
	
	.company-details {
	  margin-bottom: 25px;
	  padding: 15px;
	  background-color: #f9f9f9;
	  border-radius: 8px;
	  border: 1px solid #e0e0e0;
	}
	.company-details p {
	  color: #777;
	  margin: 0;
	  font-size: 16px;
	}
	.form-wrapper {
	  text-align: left;
	}
	label {
	  display: block;
	  margin-bottom: 8px;
	  color: #555;
	  font-weight: bold;
	}
	.confirmation-message {
	  color: green;
	  font-weight: bold;
	  text-align: center;
	  margin-bottom: 15px;
	}
	
	/* New CSS to fix the layout */
	.form-row {
	  display: flex;
	  align-items: center; /* Aligns items vertically in the middle */
	  gap: 10px; /* Space between the dropdown and the button */
	}
	
	.form-control {
		-webkit-appearance: menulist;
  -moz-appearance: menulist;
  appearance: menulist;
	  flex: 1; /* Allows the dropdown to take up remaining space */
	}
	.regsubmit2 {
	  white-space: nowrap; /* Prevents button text from wrapping */
	}
	</style>
	
	<div class="container">
	  <h1>Change Account Type</h1>
	  <p class="confirmation-message">
		<% 
		if Request.QueryString("status") = "success" then
		  Response.Write "Account type updated successfully!"
		end if
		%>
	  </p>
	  <div class="company-details">
		<h2><%= BusinessName %></h2>
		<p><%= BusinessType %> Account</p>
	  </div>
	  <div class="form-wrapper">
		<form action="AdminAccountChangeTypeHandleform.asp" method="post">
		  <% 
		  if len(BusinessTypeID) > 0 then
			sql = "select BusinessType from [dbo].[businesstypelookup] where BusinessTypeID = " & BusinessTypeID & ""
			rs.Open sql, conn, 3, 3 
			if Not rs.eof then 
			  CurrentBusinessType = rs("BusinessType")
			end if
			rs.close
		  end if
		  %>
		  <label for="BusinessTypeID">Account Type</label>
		  <div class="form-row">
			<select name="BusinessTypeID" class="form-control" required>
			  <% 
			  if len(CurrentBusinessType) > 1 then 
			  %>
				<option value="<%=BusinessTypeID%>" selected><%=CurrentBusinessType%></option>
			  <% 
			  else 
			  %>
				<option></option>
			  <% 
			  end if 
			  %>
			  <% 
			  sql = "select * from [dbo].[businesstypelookup] order by BusinessType"
			  rs.Open sql, conn, 3, 3 
			  while Not rs.eof 
			  %>
				<option value="<%=rs("BusinessTypeID")%>"><%=rs("BusinessType")%></option>
			  <% 
			  rs.movenext
			  wend
			  rs.close
			  %>
			</select> 
			<input type="hidden" name="BusinessID" value="<%= BusinessID %>">
			<input type="submit" value="Change" class="regsubmit2">
		  </div>
		</form>
	  </div>
	</div>



<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</Body>
</HTML>