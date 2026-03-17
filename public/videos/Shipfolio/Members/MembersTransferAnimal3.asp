<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Transfer Alpaca to Another farm</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
  <% 
   Current2="AlpacasHome"
   Current3="TransferOwnership" %> 
<!--#Include file="MembersHeader.asp"-->
   <br /> 
   
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
 <div class="container mt-5">
  <div class="card mx-auto">
      <h5 class="card-header">
          Animal Transfer Status
      </h5>
      <div class="card-body text-center">
          
          <%
          ' --- ASP Logic - Unchanged ---
          AlpacaID = Request.Form("AlpacaID")
          NewOwnerID = Request.Form("NewOwnerID")

          ' Update the animal's owner
          Query = " UPDATE Animals Set PeopleID = '" & NewOwnerID & "' "
          Query = Query & " where ID = " & AlpacaID
          Conn.Execute(Query)

          ' Update the animal's sale status and pricing
          Query = " UPDATE Pricing Set ForSale = No, "
          Query = Query & " studFee = 0 , "
          Query = Query & " Price = 0 , "
          Query = Query & " SalePrice = 0 , "
          Query = Query & " Discount = 0 , "
          Query = Query & " Sold = No , "
          Query = Query & " SalePending = No "
          Query = Query & " where ID = " & AlpacaID
          Conn.Execute(Query)
          %>

          <div class="alert alert-success mt-3" role="alert">
              <h4 class="alert-heading">Transfer Completed! ✅</h4>
              <p>Your animal's ownership has been successfully transferred.</p>
          </div>

          <a href="/some-return-page.asp" class="btn btn-primary mt-3">Return to Dashboard</a>

      </div>
  </div>
</div>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>
