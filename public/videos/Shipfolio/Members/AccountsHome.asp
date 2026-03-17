<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>


<% 


sql = "SELECT * FROM People JOIN Address ON People.AddressID = Address.AddressID WHERE PeopleID =" & PeopleID
         
    'sql = "SELECT BusinessName FROM business where BusinessID = " &  BusinessID 
      ' response.write("sql=" & sql)
         
         Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3  
        if not rs.eof then 
            PeopleEmail = rs("PeopleEmail")
            PeopleFirstName = rs("PeopleFirstName")
            PeopleLastName = rs("PeoplelastName")
            PeoplePhone = rs("PeoplePhone")
            AddressApt = rs("AddressApt")
            AddressCity= rs("AddressCity")
            AddressZip = rs("AddressZip")
            AddressStreet = rs("AddressStreet")
            PeopleCell = rs("PeopleCell")
            Logo= rs("Logo")
            Owners= rs("Owners")
            AddressCountry= rs("AddressCountry")
            StateIndex= rs("StateIndex")
        end if
        rs.close
    

    
        sql = "select name from state_province where StateIndex = " & StateIndex
        if len(StateIndex) > 1 then
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        if  Not rs.eof then 
        AddressState = rs("name")
        end if
        end if
  %>
<div class="container-flex" >
<div class = container>
    <h1>Account  Listing</h1>

    <br />
<button type="button" class = "body" style="border: none" onclick="location.href='CreateNewOrgAccount.asp'">
  <span><img src="/icons/Add.svg" width ="32px" border ="0"/></span>
</button><a href='CreateNewOrgAccount.asp?PeopleID=<%=PeopleID%>' class = "body"><b>Add a Business Unit</b></a>

<h1>Business Units</h1>
<% 
sql = "SELECT * from businessaccess, business, businesstypelookup WHERE businessaccess.Businessid = business.businessid and Business.BusinessTYpeID = businesstypelookup.Businesstypeid and PeopleID =" & PeopleID & " order by BusinessTypeIDOrder "
         
  'response.write("sql=" & sql)    
         Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3 
        if rs.eof then %>
           <div class = body>You currently don't have any Business Units (such as farms, food hubs, associations, etc.) listed, <a href=CreateNewOrgAccount.asp class = body><b>Click Here</b></a> to add one.</div>

       <% end if

        while not rs.eof 
        CurrentBusinessID = rs("BusinessID")
        CurrentBusinessTypeID = rs("BusinessTypeID")
        CurrentBusinessName = rs("BusinessName")
        Icon= "/icons/" & rs("BusinessTypeIcon")
        BusinessType = rs("BusinessType")
       'response.write("Icon=" & Icon )

        %>


         <% if CurrentBusinessTypeID = 1 then %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>

   
           <% if CurrentBusinessTypeID = 2 or CurrentBusinessTypeID = 3 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


               <% if CurrentBusinessTypeID = 4 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>




               <% if CurrentBusinessTypeID = 5 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


               <% if CurrentBusinessTypeID = 6 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


               <% if CurrentBusinessTypeID = 7 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>

               <% if CurrentBusinessTypeID = 8 then  %>

               <div class="container roundedtopandbottom">
                <div class="row">
                    <!-- Column 1: Icon -->
                    <div class="text-center" style="width: 80px;">
                        <a class="jumplinks" href="MembersAccountContactsEdit.asp#top">
                            <img src="<%=icon %>" alt="Account" height="70" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                        </a>
                    </div>
            
                    <!-- Column 2: Business Information -->
                    <div class="col-lg-4 col-md-6">
                        <h2><%=CurrentBusinessName %></h2>
                        <p><%=BusinessType %> Account</p>
                    </div>
            
                    <!-- Column 3: Links -->
                    <div class="col-lg-4 col-md-12">
                        <ul class="list-unstyled">
                            <li><a class="body" href="MembersProduceInventory.asp?BusinessID=<%=CurrentBusinessID %>">Produce Inventory</a></li>
                            <li><a class="body" href="MembersSellerOrders.asp?BusinessID=<%=CurrentBusinessID %>">Orders</a></li>
                            <li><a class="body" href="AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a></li>
                            <li><a class="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            
          <%=HSpacer %>
           <% end if %>


               <% if CurrentBusinessTypeID = 9 then  %>

               <div class="container roundedtopandbottom">
                <div class="row">
                    <!-- Column 1: Icon -->
                    <div class="text-center" style="width: 80px;">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top">
                        <img src="<%=icon %>" alt="Account" height="70" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    </a>
                    </div>
            
                    <!-- Column 2: Business Information -->
                    <div class="col-lg-4 col-md-6">
                        <h2><%=CurrentBusinessName %></h2>
                        <p><%=BusinessType %> Account</p>
                    </div>
            
                    <!-- Column 3: Links -->
                    <div class="col-lg-4 col-md-12">
                        <ul class="list-unstyled">
                            <li><a class="body" href="MembersProduceOrder.asp?BusinessID=<%=CurrentBusinessID %>">Order Produce</a></li>
                            <li><a class="body" href="MembersShoppingCart.asp?BusinessID=<%=CurrentBusinessID %>">Shopping Cart</a></li>
                            <li><a class="body" href="MembersBuyerOrders.asp?BusinessID=<%=CurrentBusinessID %>">Orders</a></li>
                            <li><a class="body" href="AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a></li>
                            <li><a class="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            
          <%=HSpacer %>
           <% end if %>

               <% if CurrentBusinessTypeID = 10 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


               <% if CurrentBusinessTypeID = 11 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>



               <% if CurrentBusinessTypeID = 12 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>




               <% if CurrentBusinessTypeID = 13 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                         <%=BusinessType %> Account<br />
                         <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>




            <% if CurrentBusinessTypeID = 14 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>







               <% if CurrentBusinessTypeID = 15 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>




           <% if CurrentBusinessTypeID = 16 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


        <% if CurrentBusinessTypeID = 17 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


         <% if CurrentBusinessTypeID = 18 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 19 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 20 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>

                   <% if CurrentBusinessTypeID = 21 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 22 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>



                   <% if CurrentBusinessTypeID = 23 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 24 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 25 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 26 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>




               
                   <% if CurrentBusinessTypeID = 27 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


                   <% if CurrentBusinessTypeID = 28 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon%>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>


                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                       
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>


         <% if CurrentBusinessTypeID = 29 then  %>

              <div class ="container roundedtopandbottom" >
                 <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                      <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                        <h2><%=CurrentBusinessName %></h2>
                        <%=BusinessType %> Account<br />
                        <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                        <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                    </div>
                </div>
            </div>
          <%=HSpacer %>
           <% end if %>



           <% if CurrentBusinessTypeID = 30 then  %>

           <div class ="container roundedtopandbottom" >
              <div class="row">
                 <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                   <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
                 </div>
                 <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                     <h2><%=CurrentBusinessName %></h2>
                     <%=BusinessType %> Account<br />
                     <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                     <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
                 </div>
             </div>
         </div>
       <%=HSpacer %>
        <% end if %>


        <% if CurrentBusinessTypeID = 31 then  %>

        <div class ="container roundedtopandbottom" >
           <div class="row">
              <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
                <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
              </div>
              <div class="col-lg-4 col-md-8 col-sm-8 col-8">
                  <h2><%=CurrentBusinessName %></h2>
                  <%=BusinessType %> Account<br />
                  <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
                  <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
              </div>
          </div>
      </div>
    <%=HSpacer %>
     <% end if %>


     <% if CurrentBusinessTypeID = 32 then  %>

     <div class ="container roundedtopandbottom" >
        <div class="row">
           <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
             <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
           </div>
           <div class="col-lg-4 col-md-8 col-sm-8 col-8">
               <h2><%=CurrentBusinessName %></h2>
               <%=BusinessType %> Account<br />
               <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
               <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
           </div>
       </div>
   </div>
 <%=HSpacer %>
  <% end if %>



  
  <% if CurrentBusinessTypeID = 33 then  %>

  <div class ="container roundedtopandbottom" >
     <div class="row">
        <div class="col-lg-2 col-md-4 col-sm-4 col-4"style="max-width:90px; min-width:70px">
          <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "<%=icon %>" alt = "Account" height ="70" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
        </div>
        <div class="col-lg-4 col-md-8 col-sm-8 col-8">
            <h2><%=CurrentBusinessName %></h2>
            <%=BusinessType %> Account<br />
            <a class ="body" href=" AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>">Delete</a><br>
            <a class ="body" href="default.asp?BusinessID=<%=CurrentBusinessID %>"><b>Manage Account</b></a>
        </div>
    </div>
</div>
<%=HSpacer %>
<% end if %>


        <% rs.movenext
            wend
        rs.close  %>












  
  <br /> <br /> <br />


<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>