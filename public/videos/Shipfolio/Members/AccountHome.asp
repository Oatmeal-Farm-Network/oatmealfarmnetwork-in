<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Oatmeal AI">
    <title>Harvest Hub Dashboard</title>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->


<%
BusinessID = request.querystring("BusinessID")


sql = "SELECT " & _
" SubscriptionStartDate, SubscriptionEndDate, Business.subscriptionLevel, BusinessName, address.AddressID, Business.BusinessID, businesstypelookup.BusinessTypeID, state_province.name, BusinessType, BusinessEmail, BusinessLogo, People.PeopleID, People.PeopleEmail, People.PeopleFirstName, People.PeopleLastName, " & _
" People.PeoplePhone, People.PeopleCell, People.Logo, People.Owners, " & _
" Address.AddressStreet, Address.AddressApt, Address.AddressCity, Address.AddressZip, Address.AddressCountry, " & _
" state_province.name AS AddressState, business.BusinessName, Websites.Website " & _
" FROM People " & _
" JOIN BusinessAccess ON People.PeopleID = BusinessAccess.PeopleID " & _
" JOIN Business ON BusinessAccess.BusinessID = Business.BusinessID " & _
" JOIN businesstypelookup ON business.Businesstypeid= businesstypelookup.Businesstypeid " & _
" JOIN Address ON Business.AddressID = Address.AddressID " & _
" JOIN Websites ON People.WebsitesID = Websites.WebsitesID " & _
" JOIN state_province ON Address.StateIndex = state_province.StateIndex " & _
" WHERE BusinessAccess.BusinessID = " & BusinessID

'response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then
    subscriptionLevel = rs("subscriptionLevel")
    BusinessName = rs("BusinessName")
    BusinessID = rs("BusinessID")
    BusinessTypeID = rs("BusinessTypeID")
    BusinessType = rs("BusinessType")
  
    BusinessAddressID = rs("AddressID")
    PeopleID = rs("PeopleID")
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
    BusinessLogo = rs("BusinessLogo")
    BusinessEmail = rs("BusinessEmail")
    AddressState = rs("name")
    SubscriptionStartDate = rs("SubscriptionStartDate")
    SubscriptionEndDate = rs("SubscriptionEndDate")
end if




if len(BusinessAddressID) > 1 then
else
    ' Insert a new record into the Address table
    Query = "INSERT INTO Address (AddressStreet, AddressCity, AddressState, AddressZip, StateIndex, country_id) VALUES ('', '', '', '', 0, '')"
    Conn.Execute(Query)

    ' Get the newly inserted AddressID
    Set rs = Conn.Execute("SELECT @@IDENTITY AS NewAddressID")
    NewAddressID = rs("NewAddressID")
    rs.Close

end if



FavoriteAssocitaionID = 0
sql = "select FavoriteAssocitaionID, associationname from Business, associations where Business.FavoriteAssocitaionID= associations.associationid and Business.BusinessID = " & BusinessID 
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
  FavoriteAssocitaionID = rs("FavoriteAssocitaionID")
  FavoriteAssocitaionName = rs("associationname")
end if
rs.close

'response.write("BusinessType=" & BusinessType)'
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<div class="container-fluid roundedtopandbottom">
    <div class="row">
        <div class="col-6 body">
           <br>
                            Account Name: <b><%=BusinessName%></b> <br>
                            Account Type: <b><%=BusinessType%></b><br>
                            <a href="MembersAccountChangeType.asp?BusinessID=<%=businessID%>" class="body">Change Account Type</a></br>
                            Subscription Level: <%=subscriptionLevel %></br>
                            Subscription Ends: <%=SubscriptionEndDate %></br>
                            Favorite Association: <% if len(FavoriteAssocitaionName) > 0 then %> <br>&nbsp;&nbsp;&nbsp;<%=FavoriteAssocitaionName%><% else %> Not Set<% end if %><br>
                            <a href="/Members/MembersAssociations.asp?BusinessID=<%=BusinessID %>" class="body">Set Favorite Association</a></p>
            <br>
       </div>
       <div class="col-6 body">
        <br>

        <a href="ContactsEdit.asp?BusinessID=<%=businessID%>" class="body">Account Profile</a></br>
        <a href="MembersRenewSubscription.asp" class="body">Renew / Upgrade Membership</a><br>
        <a href="AdminOrgDelete.asp?BusinessID=<%=BusinessID%>" class = "body">Delete Account</a>
     
        </a>
        
<br>
</div>
    </div>
    <div class="row">
            <div class="col-12 body">

            <table class="table table-striped table-hover align-middle w-100">
                <tbody>
                    <% if BusinessTypeID = 8 or BusinessTypeID = 10 or BusinessTypeID = 14 or BusinessTypeID = 26 or BusinessTypeID = 29 or BusinessTypeID = 31 then %>
                    <tr>
                        <td class="icon-cell">
                            <a class="jumplinks" href="/Members/MembersProduceInventory.asp?BusinessID=<%=BusinessID%>#top">
                                <img src="/icons/produce.webp" alt="Produce" width="40" height="40" loading="lazy" border="0">
                            </a>
                        </td>
                        <td>
                            <b card-title">Produce</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="/Members/MembersProduceInventory.asp?BusinessID=<%=BusinessID%>">Inventory</a></li>
                            </ul>
                        </td>
                    </tr>
                    <% end if %>
                    
                    <% if BusinessTypeID = 8 then %>
                    <tr>
                        <td class="icon-cell">
                            <a class="jumplinks" href="MembersAnimalshome.asp?ID=<%=AnimalID %>#top">
                                <img src="/icons/Livestock.svg" alt="Livestock" width="40" height="40" loading="lazy" border="0">
                            </a>
                        </td>
                        <td>
                            <b card-title">Livestock</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="/Members/MembersAnimalshome.asp?BusinessID=<%=BusinessID%>">List of Animals</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersAnimalAdd1.asp?BusinessID=<%=BusinessID%>#top">Add</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/membersDeleteanimal.asp?BusinessID=<%=BusinessID%>&AnimalID=<%=AnimalID %>">Delete</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersTransferAnimal.asp?BusinessID=<%=BusinessID%>&AnimalID=<%=AnimalID %>">Transfer</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersAnimalsStats.asp?BusinessID=<%=BusinessID%>&AnimalID=<%=AnimalID %>">Statistics</a></li>
                            </ul>
                        </td>
                    </tr>
                    <% end if %>
    
                    <tr>
                        <td class="icon-cell">
                            <a class="jumplinks" href="MembersProductList.asp?ID=<%=AnimalID %>&BusinessID=<%=BusinessID%>#top">
                                <img src="/icons/Products.svg" alt="Products" width="40" height="40" loading="lazy" border="0">
                            </a>
                        </td>
                        <td>
                            <b card-title">Products</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="/members/MembersProductList.asp?BusinessID=<%=BusinessID%>">List</a></li>
                                <li class="list-inline-item"><a class="body" href="/members/MembersClassifiedAdPlace0.asp?BusinessID=<%=BusinessID%>">Add</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersProductECommerce.asp?BusinessID=<%=BusinessID%>">Settings</a></li>
                                <% if numberofproducts > 0 then %>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersProductStats.asp?BusinessID=<%=BusinessID%>">Statistics</a></li>
                                <% end if %>
                            </ul>
                        </td>
                    </tr>
    
                    <tr>
                        <td class="icon-cell">
                            <a class="jumplinks" href="MembersservicesHome.asp?ID=<%=AnimalID %>#top">
                                <img src="/icons/Services.svg" alt="Services" width="40" height="40" loading="lazy" border="0">
                            </a>
                        </td>
                        <td>
                            <b card-title">Services</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="/members/MembersservicesHome.asp">List</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/membersServicesAddPage0.asp">Add</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/membersServiceDelete.asp">Delete</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/MembersServicesSuggestCategory.asp">Suggest Category</a></li>
                            </ul>
                        </td>
                    </tr>
    
                    <% if BusinessTypeID = 8 or BusinessTypeID = 30 then %>
                    <tr>
                        <td class="icon-cell">
                            <img src="/icons/Real-Estate.svg" alt="Properties" width="40" height="40" loading="lazy" border="0">
                        </td>
                        <td>
                            <b card-title">Properties</b>
                            <a name="Properties"></a>
                            <ul class="list-inline mb-2">
                                <li class="list-inline-item"><a class="body" href="PropertiesHome.asp">List of Properties</a></li>
                                <li class="list-inline-item"><a class="body" href="membersAddaProperty.asp">Add a Property</a></li>
                            </ul>
                            <%
                            sql = "select * from Properties where PeopleID = " & session("PeopleID") & " order by propname"
                            Set rs = Server.CreateObject("ADODB.Recordset")
                            rs.Open sql, conn, 3, 3
                            if rs.eof then %>
                            <p class="text-muted small">Currently you do not have any properties listed. To add a property <a class="body" href="membersAddaProperty.asp">click here</a>.</p>
                            <% else %>
                            <p class="mb-1">My Properties:</p>
                            <ul class="list-unstyled">
                                <% rowcount = 1
                                While Not rs.eof %>
                                <li>
                                    <a class="body" href="membersEditProperty0.asp?propID=<%= rs("propID") %>#BasicFacts"><%=rs("propName")%></a>
                                    <% if rs("PropForSale") = 1 then %> - <span class="badge bg-success">For Sale</span><% end if %>
                                    <% if len(rs("propPrice")) > 0 then %> - $<%=rs("propPrice")%><% end if %>
                                </li>
                                <% rs.movenext
                                rowcount = rowcount + 1
                                Wend %>
                            </ul>
                            <% end if
                            rs.close %>
                        </td>
                    </tr>
                    <% end if %>
    
                    <% if BusinessTypeID = 1 then %>
                    <tr>
                        <td class="icon-cell">
                            <img src="/icons/Assoc-administration-icon.svg" alt="Website" width="40" height="40" loading="lazy" border="0">
                        </td>
                        <td>
                            <b card-title">Associations</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="/Members/AssociationAdmin/SetupAssociationAccountExistingmember.asp">Create Account</a></li>
                                <li class="list-inline-item"><a class="body" href="/Members/AssociationAdmin/AssociationDeleteAccount.asp">Delete Account</a></li>
                                <%
                                if rs.state > 0 then
                                rs.close
                                end if
                                Associationsfound = False
                                sql2 = "select associationmembers.AssociationID, AssociationName from associations, associationmembers where accesslevel > 1 and associations.AssociationID = associationmembers.AssociationID and associationmembers.PeopleID = " & PeopleID
                                acounter = 1
                                rs.Open sql2, Conn, 3, 3
                                if not rs.eof then Associationsfound = True %>
                                <% if Associationsfound = True then %>
                                <li class="list-inline-item">Edit Association Account:
                                    <ul class="list-unstyled ms-3 mt-2">
                                        <% while not rs.eof %>
                                        <li><a class="body" href="/Members/AssociationAdmin/AssociationHome.asp?AssociationID=<%=rs("AssociationID") %>"><%= rs("AssociationName")%></a></li>
                                        <% rs.movenext
                                        wend %>
                                    </ul>
                                </li>
                                <% end if %>
                                <% rs.close %>
                            </ul>
                        </td>
                    </tr>
                    <% end if %>
    
                    <tr>
                        <td class="icon-cell">
                            <img src="/icons/Website.svg" alt="My Website" width="40" height="40" loading="lazy" border="0">
                        </td>
                        <td>
                            <b card-title">My Website</b>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><a class="body" href="MemberssiteDesign.asp">Graphic Design (colors, fonts, etc.)</a></li>
                                <li class="list-inline-item"><a class="body" href="membersRanchhomeMembers.asp?PeopleID=<%=PeopleID %>">Home Page</a></li>
                                <li class="list-inline-item"><a class="body" href="membersPageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>">About Us Page</a></li>
                            </ul>
                            <% if showpackages = True and SubscriptionLevel > 3 then %>
                            <div class="mt-3">
                                <b class="mb-1">Packages:</b>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item"><a class="body" href="membersPackagesAdd.asp">Add</a></li>
                                    <li class="list-inline-item"><a class="body" href="membersPackagesDelete.asp">Delete</a></li>
                                    <li class="list-inline-item"><a class="body" href="membersPackageStats.asp">Statistics</a></li>
                                </ul>
                            </div>
                            <% end if %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    
<style>
/* Optional: Adds a little more padding to the icon column for better alignment */
.icon-cell {
    width: 90px;
    min-width: 90px;
    max-width: 90px;
    vertical-align: top;
}
</style>




<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>