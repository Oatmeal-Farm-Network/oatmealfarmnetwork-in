<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<%  Current3 = "AddaPage"   %> 
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->

<% 
    serverpath = request.servervariables("APPL_PHYSICAL_PATH")
response.write("serverpath=" & serverpath )


Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if

    TempCategoryType="For Sale"
    PageGroupID = Request.QueryString("PageGroupID")
    

    if len(PageGroupID) > 0 then
    sqlg = "select PageGroupTitle from custPageGroups where custPageGroupID = " & PageGroupID 

    Set rsg = Server.CreateObject("ADODB.Recordset")
	rsg.Open sqlg, conn, 3, 3 
	  PageGroupTitle = rsg("PageGroupTitle")
	rsg.close
	end if
%>  



        
<div class ="container roundedtopandbottom" border = "0" cellpadding=0 cellspacing=0 width = "100%" >
 <div class ="row">
		<div class ="col body">
		<H1>Add a Basic Page</H1>
       This form allows you to easily add a basic webpage to your website. The webpage can contain both images and text, giving you the flexibility to create engaging content. <br /> <br />

	   <div class = "container" border = "0" cellspacing="0" cellpadding = "0"   width = '100%'>
<% Message = request.querystring("Message") 
   PageName = request.querystring("PageName")
   LinkName = request.querystring("LinkName")

if len(Message) > 5 then 
%>
<div class="container">
  <div class="row">
    <div class="col">
      <div class="alert alert-danger">
        <strong>Please correct the following issue(s):</strong>
        <blockquote><%=Message %></blockquote>
      </div>
    </div>
  </div>
</div>
<% end if 

if len(Message2) > 5 then 
%>
<div class="container">
  <div class="row">
    <div class="col">
      <div class="alert alert-danger">
        <strong>Please correct the following issue(s):</strong>
        <blockquote><%=Message2 %></blockquote>
      </div>
    </div>
  </div>
</div>
<% end if %>

    



<form name="myForm" onSubmit="return validatePwd()" action="/members/CustSiteAdmin/AdminPageAddHandleForm.asp" method="post">
  <input name="PageType" value="Standard" type="hidden">
  <div class="container" style="max-width: 500px">
    <div class="row">
      <div class="col">
           Page Name<br />
              <input name="PageName" value="<%=PageName%>" Size="22" class="formbox" Required>
       </div>
      </div>
       <%=HSpacer %>
     <div class ="row">
        <div class ="col">
             Menu Title<br />
              <input name="LinkName" value="<%=LinkName%>" class="formbox" Size="22" maxlength="20" Required><br />
              <small color="#abacab">Will Appear On Your Menu - Max. length = 20 characters</small>
           </div>
      </div>
       <%=HSpacer %>

 <% if Showpagegroups = True then %>
     <div class ="row">
        <div class ="col">
            Menu Group<br />
              <select class="formbox" name="PagegroupID" required  >
                <% if len(PageGroupTitle) > 0 then %>
                <option name="AID1" value="<%=PagegroupID %>"><%=PageGroupTitle %></option>
                <% end if %>
                <% count = 1
                sqlg = "select * from CustPageGroups where PeopleID = " & PeopleID & " order by PageGroupOrder"

                acounter = 1
                Set rsg = Server.CreateObject("ADODB.Recordset")
                rsg.Open sqlg, conn, 3, 3 

                while not rsg.eof	%>
                <option name="AID1" value="<%=rsg("custPageGroupID") %>">
                  <%=rsg("PageGroupTitle") %>
                </option>
                <% 	rsg.movenext
              wend %>
              </select>
         </div>
      </div>
       <%=HSpacer %>
  <% end if %>

     <div class ="row">
        <div class ="col">
              Page Heading<br />
              <input name="PageHeading" value="<%=PageHeading%>"  Size="22" class="formbox" Rerquired>
        </div>
      </div>
       <%=HSpacer %>
        <div class ="row">
         <div class ="col">
              Display<br />
           
            <style>
              .form-check-input:checked {
                background-color: #517031;
              }
            </style>
            <% if len(ShowPage) < 1 then
                ShowPage = "Yes"
              end if%>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ShowPage" value="True" <% if ShowPage = "Yes" Or ShowPage = True Then %>checked<% End if %>>
              <label class="form-check-label">Yes</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ShowPage" value="False" <% if ShowPage = "Yes" Or ShowPage = True Then %> <% else %>checked<% End if %>>
              <label class="form-check-label">No</label>
            </div>


            </div>
        </div>
       <%=HSpacer %>
         <div class ="row">
        <div class ="col">
              <input type="submit" value="Add" class="submitbutton">
            <br /><br>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</form>





   <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>