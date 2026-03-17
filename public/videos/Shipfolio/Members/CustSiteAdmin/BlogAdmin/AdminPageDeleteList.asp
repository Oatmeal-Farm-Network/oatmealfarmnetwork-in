<?xml version="1.0" encoding="UTF-8"?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange inc.">
    <title>Global Grange Members Area</title>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% Current3 = "PageContent" %>
</head>
<body>


<!--#Include virtual="/members/MembersHeader.asp"-->

<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Page</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >
     <div align = "left">
			To delete an page simply select it below and push the button. <b>But careful. Once a page is deleted, it's gone!</b></div><br><br>
		
PeopleID=<%=PeopleID %>
<%  
dim TempPageLayoutID(40000)
dim PageName(40000)
dim aAdType(40000)
	sql2 = "select * from PageLayout where PeopleID=" & session("PeopleID") & " order by PageName "
response.write("sql2=" & sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	While Not rs2.eof  
		TempPageLayoutID(acounter) = rs2("PageLayoutID")
		PageName(acounter) = rs2("PageName")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>

<div class="container">
  <div class="row">
    <div class="col-md-6 offset-md-3 rounded-top">
      <h2>Delete a Page</h2>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6 offset-md-3 rounded-bottom body">
      <div>
        To delete a page, simply select it below and click the button. <b>But be careful. Once a page is deleted, it's gone!</b>
      </div>
      <br><br>
      <% If recordcount = 0 Then %>
        <h1>You do not currently have any pages available to be deleted.</h1>
      <% Else %>
        <form action="AdminPageDelete.asp" method="post">
          <input type="hidden" name="PhotoType" value="ListPage">
          <div class="form-group">
            <label for="PageLayoutID">Page:</label>
            <select class="form-control" name="PageLayoutID">
              <option name="AID0" value="" selected></option>
              <% count = 1
              While count < acounter %>
                <option name="AID1" value="<%= TempPageLayoutID(count) %>">
                  <%= PageName(count) %>
                </option>
                <% count = count + 1
              Wend %>
            </select>
          </div>
          <button type="submit" class="btn btn-primary">Delete</button>
        </form>
      <% End If %>
    </div>
  </div>
</div>

<br />
   <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>