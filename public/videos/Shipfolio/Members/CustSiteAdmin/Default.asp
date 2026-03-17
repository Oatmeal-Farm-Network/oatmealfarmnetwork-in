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
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->


<div class ="container roundedtopandbottom">
     <h1>Website Pages</h1>

 <% if  AddPages = True then %>
  To change Page Group titles and order select the <a href = "/Administration/AdminPageGroups.asp" Class = "body">Page Groups tab.</a>
  <% end if %>

<table class ="table" width="100%">
<%

if Showpagegroups = True then 
 showpageorder  = True  %>
<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">

 
    <tr>
        <th>Page Name</th>
        <th>Menu Title</th>
        <% if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and addpages = True and not (showpageorder  = True) then %>
            <th>Page Type</th>
        <% else 
        if showpageorder  = True then%>
        <th>Page Order</th>
        <% 
        end if
        end if %>
        <th>Display</th>
        <th>Options</th>
    </tr>

        <% sql3 = "select * from CustPagegroups where peopleID=" & PeopleID & " and pagegroupavailable = 1 order by PageGrouporder"
            acounter = 1
            Set rs3 = Server.CreateObject("ADODB.Recordset")
            rs3.Open sql3, conn, 3, 3 
            While Not rs3.eof 
            PageGroupTitle = rs3("PageGroupTitle")
            CustPageGroupID = rs3("CustPageGroupID") 
         %>
        <tr><td bgcolor = "#e6e6e6" class = "body" colspan = "5" height = "20"><b><%=PageGroupTitle%> Page Group</b></td></tr>
        <%
         row = "odd"
         sql2 = "select * from Pagelayout where peopleID=" & PeopleID & " and PageAvailable = 1 and PageGroupID = " & CustPageGroupID & " order by linkOrder"

        'response.write(" sql2=" &  sql2 ) 
        Set rs2 = Server.CreateObject("ADODB.Recordset")

        rs2.Open sql2, conn, 3, 3 
  
        While Not rs2.eof 
        linecount = linecount + 1  
        TotalPages = rs2.recordcount
        PageLayoutID = rs2("PageLayoutID")
        PageGroupID = rs2("PageGroupID")
        PageType = rs2("PageType")
        ShowPage = rs2("ShowPage")
        LinkName = rs2("LinkName")
        EditLinkName = rs2("EditLink")
        PageAvailable  = rs2("PageAvailable")
        if PageAvailable = "True" then
           PageAvailable = "Yes"
        else
        PageAvailable = "No"
        end if 

        if len(EditLinkName)> 0 then
        else
        if PageType  = "Standard" or len(PageType) < 3 then
         EditLinkName ="AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
        end if

        if PageType  = "Service" then
         EditLinkName ="AdminServicesEdit2.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
        end if
        end if



        'if  rs2("PageName")  = "Home Page" then
        '  EditLinkName = "AdminHomePage.asp"
        'end if
         %>
        <tr>
         <% if CustPageGroupID = 19 then %>
        <td class= "body"  width = '100%'>
        <a href = "/ADMINISTRATION/BlogAdmin/Default.asp#CatID<%=BlogCatID %>" class = "body">Blog Admin</a><br>
        <% sqlb = "select * from BlogCategories where peopleID=" & PeopleID & " order by BlogCategoryOrder " 
        Set rsb = Server.CreateObject("ADODB.Recordset")
        rsb.Open sqlb, conn, 3, 3 
        CatCounter= 0
            While Not rsb.eof 
            BlogCatID = rsb("BlogCatID")
            BlogCategoryName = rsb("BlogCategoryName")%>
            <a href = "/ADMINISTRATION/BlogAdmin/Default.asp#CatID<%=BlogCatID %>" class = "body"><%=BlogCategoryName%></a><br>
            <% rsb.movenext
            Wend
            rsb.close
            %>
             </td>
            <td class= "body"  width = '170'>
            <% sqlb = "select * from BlogCategories order by BlogCategoryOrder " 
            rsb.Open sqlb, conn, 3, 3 
            CatCounter= 0
            While Not rsb.eof 
            BlogCatID = rsb("BlogCatID")
            BlogCategoryName = rsb("BlogCategoryName") %>
            <%=BlogCategoryName%> Blog<br />

            <% rsb.movenext 
            Wend
            rsb.close
            %>
            </td>

    <% else %>
    <td class= "body" >
    <a href = "<%=EditLinkName %>" class = "body"><%=rs2("PageName")%></a>
    </td>
    <td class= "body"  width = '170'>
    <%=rs2("LinkName")%>
    </td>
    <% end if %>
    <% 
    if showpageorder  = True then%>
    <td class= "body2"  align ="center" width = "190">

    <%
     LinkOrder = rs2("LinkOrder") 
     if LinkOrder = 0 then
     LinkOrder = 1
     end if
    PageGroupID = rs2("PageGroupID") 
    ' if LinkOrder =  previouslinkorder  and  (cint(CustPageGroupID)  = cint(previousCustPageGroupID)) then
     ' LinkOrder = LinkOrder +1
     'end if

     'previouslinkorder  = linkOrder 
      previousPageGroupID  = PageGroupID %>
    <select size="1" name="LinkOrder(<%=linecount%>)">
    <% if len(LinkOrder) > 0 then %>
    <option name = "AID1" value="<%=LinkOrder %>">
	    <%=LinkOrder %>
    </option>
    <option  value="0">1</option>
    <% else %>
    <option name = "AID1" value="">--</option>
    <% end if %>
    <% count = 2
    while count < (TotalPages+1) %>
    <option name = "AID1" value="<%=count %>">
    <%=count %>
    </option>
    <% count = count + 1
    wend %>
    </select>
    <input type="hidden" name="pagelayoutid(<%=linecount%>)" value="<%=rs2("pagelayoutid") %>" >

    <input type="hidden" name="CustPageGroupID(<%=linecount%>)" value="<%=CustPageGroupID %>" >
    </td>
    <% end if %>
    <td class= "body2"  align = "left" width = "100">
    <% if rs2("PageName") ="Home Page" then %>
    Always
    <% else %>   
    <% if ShowPage  = True then %>
    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked >Yes
    <% else %>
     <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
    <% end if %>
    <% end if %></td>
    <td class= "body" width = "150">
    <% if rs2("PageName")  = "Home Page" then %>
    <a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "https://www.globallivestocksolutions/icons/Edit.svg" alt = "edit" height ="12" border = "0"></a>
        |&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "SEO" height ="14" border = "0"></a>
     <% if SlideshowAvailable = True then %>
    |&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "https://www.globallivestocksolutions/icons/Photo.svg" height = "18" border = "0" alt = "Slideshow Photos"></a>
    <% end if %>



    <% else %>
    <a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "http://www.globallivestocksolutions.com/icons/edit.svg" alt = "edit" height ="18" border = "0"></a>|
        &nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "http://www.globallivestocksolutions.com/icons/Delete.svg" alt = "delete" height ="18" border = "0"></a>

    |&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "http://www.globallivestocksolutions.com/icons/seo-icon.png" alt = "seo" height ="18" border = "0"></a>
    <% if not(Pagetype = "Basic") and  AddPages = True and convertpages = true then %>
    |&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "http://www.globallivestocksolutions.com/icons/ConvertIcon.png" alt = "Convert Page Type" height ="18" border = "0"></a>

    <% end if %>
    <% end if %>
    </td>
    </div>

    <%catcounter  = catcounter  +1
     rs2.movenext
    wend
    rs2.close %>

    <% rs3.movenext
    wend
    rs3.close
    %>
    <td>

</tr>

<% else %>
 <%  
row = "even"
sql2 = "select * from PageLayout where PeopleID = " & PeopleID & " and PageAvailable = 1 order by LinkOrder,  PageName, PageGroupID "

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not  rs2.eof then
'response.write("showpageorder =" & showpageorder )
 acounter = 1
recordcount = rs2.recordcount
showpageorder = True
%>


<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
<tr border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
    <td class = "body" width = '<%=pagenamewidth%>'><b>Page Name</b></td>
    <td class = "body2" width = "<%=menutitlewidth %>" align = "center"><b>Menu Title</b></td>
    <% if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and addpages = True then %>
    <td class = "body2" width = "100" align = "center"><b>Page Type</b></td>
    <td class = "body2" width = "190" align = "center"><b>Page Group</b></td>
    <% else 
    if showpageorder  = True then%>
    <td class = "body2" width = "190" align = "right"><b>Page Order</b></td>
    <% 
    end if
    end if %>
    <td class = "Body2" width = "100" align = "center"><b>Display</b></td>
    <td class = "body2" width = "150" align = "center"><b>Options</b></td>
</tr>
     <% linecount = 0
        While Not rs2.eof 
        linecount = linecount + 1
        TotalPages = rs2.recordcount
         PageLayoutID = rs2("PageLayoutID")

        PageGroupID = rs2("PageGroupID")
        PageType = rs2("PageType")
        ShowPage = rs2("ShowPage")
        LinkName = rs2("LinkName")
        EditLinkName = rs2("EditLink")
        PageAvailable  = rs2("PageAvailable")
        if PageAvailable = "True" then
           PageAvailable = "Yes"
        else
        PageAvailable = "No"
        end if
         if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and len(PageGroupID)> 0 then 
   
        sql = "select * from PageGroups where PageGroupID = " & PageGroupID & ""
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3
        if not  rs.eof then
        PageGroupTitle = rs("PageGroupTitle")
        end if
           else
           PageGroupTitle = ""
        end if
        if len(EditLinkName)> 0 then
        else
        if PageType  = "Standard" or len(PageType) < 3 then
         EditLinkName ="AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
        end if

        if PageType  = "Service" then
         EditLinkName ="AdminServicesEdit2.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
        end if
        end if

        'if  rs2("PageName")  = "Home Page" then
        '  EditLinkName = "AdminHomePage.asp"
        'end if

      %>
      <tr>
        <td class= "body" >
             <a href = "<%=EditLinkName %>" class = "body"><%=rs2("PageName")%></a>
        </td>
        <td class= "body"  width = '170'>
            <%=rs2("LinkName")%>
        </td>
        <% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
            <td class= "body2"  align ="left" width = "100"><%= PageType %></td>
            <td class= "body2"  align ="left" width = "190"><%= PageGroupTitle %></td>
        <% else 
         if showpageorder  = True then%>
            <td class= "body2"  align ="center" width = "190">
            <% LinkOrder = rs2("LinkOrder") %>
            <select size="1" name="LinkOrder(<%=linecount%>)">
            <% if len(LinkOrder) > 0 then %>
            <option name = "AID1" value="<%=LinkOrder %>">
	            <%=LinkOrder %>
            </option>
            <% else %>
            <option name = "AID1" value="">--</option>
            <% end if %>
            <% count = 1
            while count < (TotalPages+1) %>
            <option name = "AID1" value="<%=count %>">
            <%=count %>
            </option>
            <% count = count + 1
            wend %>
            </select>
            <input type="hidden" name="pagelayoutid(<%=linecount%>)" value="<%=rs2("pagelayoutid") %>" >
            </td>
        <% end if %>
        <% end if %>

        <td class= "body2"  align = "left" width = "100">
            <% if rs2("PageName") ="Home Page" then %>
                Always
            <% else %>   
            <% if ShowPage  = True then %>
                <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked >Yes
            <% else %>
                 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
            <% end if %>
            <% end if %>
        </td>
        <td class= "body" width = "150">
        <% if rs2("PageName")  = "Home Page" then %>
        <a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "https://www.globallivestocksolutions.com/icons/edit.svg" alt = "edit" height ="18" border = "0"></a>
            |&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "https://www.globallivestocksolutions.com/icons/seo.svg" alt = "seo" height ="18" border = "0"></a>
         <% if SlideshowAvailable = True then %>
        |&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "https://www.globallivestocksolutions.com/icons/Photo.svg" height = "18" border = "0" alt = "Slideshow Photos"></a>
        <% end if %>
        <% else %>
        <a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "https://www.globallivestocksolutions.com/icons/Edit.svg" alt = "edit" height ="18" border = "0"></a>
            |&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "https://www.globallivestocksolutions.com/icons/Delete.svg" alt = "edit" height ="18" border = "0"></a>

        |&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "https://www.globallivestocksolutions.com/icons/seo.svg" alt = "edit" height ="18" border = "0"></a>
        <% if not(Pagetype = "Basic") and  AddPages = True then %>
        |&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "https://www.globallivestocksolutions.com/icons/Convert.svg" alt = "Convert Page Type" height ="18" border = "0"></a>

        <% end if %>
        <% end if %>
        </td>
        </tr>

        <%catcounter  = catcounter  +1
        rs2.movenext
        Wend
        FinalCatCounter = catcounter 
        end if
        rs2.close%>

    <% end if %>
</table>
<br />
   <input type="hidden" name="totallinecount" value="<%=linecount%>" >
	            <input type=submit value = "Update" class = "regsubmit2" ></form>
<br />
<br />

</div>
<br />

   <!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</html>