<?xml version="1.0" encoding="UTF-8"?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% Current3 = "PageContent" %>
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->

 	<div class ="container roundedtopandbottom" >
       <div class ="row">
           <div class = "col">
		        <H1>Delete a Page</H1>
           	To delete an page simply select it below and push the button. <b>But careful. Once a page is deleted, it's gone!</b><br><br>
<%  
dim TempPageLayoutID(40000)
dim PageName(40000)
dim aAdType(40000)
	sql2 = "select * from PageLayout where PeopleID=" & session("PeopleID") & " order by PageName "
'response.write("sql2=" & sql2)
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
<div class="container" style="max-width:400px; align-content:center">
  <div class="row">
    <div class="col body">
      <% If recordcount = 0 Then %>
        <h1>You do not currently have any pages available to be deleted.</h1>
      <% Else %>
        <form action="AdminPageDelete.asp" method="post">
          <input type="hidden" name="PhotoType" value="ListPage">
          <div class="form-group">
            <label for="PageLayoutID">Page<br /></label>
            <select class="formbox" name="PageLayoutID">
              <option name="AID0" value="" selected></option>
              <% count = 1
              While count < acounter %>
                <option name="AID1" value="<%= TempPageLayoutID(count) %>">
                  <%= PageName(count) %>
                </option>
                <% count = count + 1
              Wend %>
            </select>
        
          <button type="submit" class="submitbutton">Delete</button>
        </form>
      <% End If %>
    </div>
  </div>
</div>
    </div>
  </div>
</div>
<br />
   <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>