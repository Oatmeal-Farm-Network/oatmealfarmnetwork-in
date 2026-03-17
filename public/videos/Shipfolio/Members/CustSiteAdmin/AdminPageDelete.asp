<!DOCTYPE HTML>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% Current3 = "PageContent" %>
<% Current3 = "DeleteServices" %>
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->
 
 <div class="container  roundedtopandbottom">
  <div class="row">
    <div class="col-md-6 offset-md-3 rounded-top">
      <h2>Delete a Page</h2>
    </div>
  </div>
  <div class="row ">
    <div class="col-md-6 offset-md-3 rounded-bottom body" align="center">
      <div class="text-left">
        <br />
        <% PageLayoutID = request.QueryString("PageLayoutID") 
          if len(PageLayoutID) > 0 then
          else
          PageLayoutID = request.Form("PageLayoutID") 
          end if

          dim ServicesID(40000)
          dim ServiceTitle(40000)
          dim aAdType(40000)
          Set rs2 = Server.CreateObject("ADODB.Recordset")

          sql = "select * from Pagelayout where PagelayoutID = " & PagelayoutID & ""
          rs2.Open sql, conn, 3, 3
          PagelayoutID = rs2("PagelayoutID")   
          PageGroupID = rs2("PageGroupID")
          PageName = rs2("PageName")
          PageTitle = rs2("PageTitle")
          LinkName = rs2("LinkName")
          PageType =  rs2("PageType")
          rs2.close
          set rs2 = nothing
          set conn = nothing
        %>
        <form action="AdminPageDeleteHandleForm.asp" method="post">
          <input name="PageType" size="60" value="<%= PageType %>" type="hidden">
          <input name="PageLayoutID" size="60" value="<%= PageLayoutID %>" type="hidden">
          <div class="form-group row">
            <label class="col-sm-4 col-form-label text-right"><b>Page Named:</b></label>
            <div class="col-sm-8">
              <%= PageName %>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label text-right"><b>Menu Title:</b></label>
            <div class="col-sm-8">
              <%= LinkName %>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label text-right"><b>Page Group:</b></label>
            <div class="col-sm-8">
              <%= PageGroupTitle %>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label text-right"><b>Page Heading:</b></label>
            <div class="col-sm-8">
              <%= PageHeading %>
            </div>
          </div>
          <div class="text-center">
            <p class="text-danger"><b>Warning! Once a page is deleted from your database, it's gone!</b></p>
            <a href="AdminPageDeleteList.asp" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="submitbutton">Delete</button>
          </div>
        </form>
          <br />
      </div>
    </div>
  </div>
</div>


<br />
 <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>