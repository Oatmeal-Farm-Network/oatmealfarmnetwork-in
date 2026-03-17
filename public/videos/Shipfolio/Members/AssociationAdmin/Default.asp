<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Global Grange inc.">
    <title>Harvest Hub Dashboard</title>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<%
If Not rs.State = adStateClosed Then
rs.Close
End If
%>
<%
sql = "SELECT People.PeopleFirstName, People.PeopleLastName, People.Owners, People.PeoplePhone, People.Logo, People.PeopleEmail, People.PeopleCell, Business.BusinessName, Address.AddressStreet, Address.AddressCity, " & _
  " Address.AddressCountry, Address.AddressState, Address.AddressApt, Address.AddressZip, Address.StateIndex, Websites.Website FROM People JOIN Address ON People.AddressID = Address.AddressID " & _
  " JOIN Business ON People.BusinessID = Business.BusinessID " & _
  " JOIN Websites ON People.WebsitesID = Websites.WebsitesID " & _
  " WHERE People.PeopleID =" & PeopleID

'sql = "SELECT BusinessName FROM business where BusinessID = " & BusinessID
'response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if rs.eof then

' Insert a new record into the Address table
Query = "INSERT INTO Address (AddressStreet, AddressCity, AddressState, AddressZip, StateIndex, country_id) VALUES ('', '', '', '', 0, '')"
Conn.Execute(Query)

' Get the newly inserted AddressID
Set rs = Conn.Execute("SELECT @@IDENTITY AS NewAddressID")
NewAddressID = rs("NewAddressID")
rs.Close

' Update the People table with the new AddressID
Query = "UPDATE People SET AddressID = " & NewAddressID & " WHERE PeopleID = " & PeopleID
Conn.Execute(Query)

rs.Open sql, conn, 3, 3
end if

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
Website= rs("Website")
StateIndex= rs("StateIndex")
end if
rs.Close


sql = "select name from state_province where StateIndex = " & StateIndex
if len(StateIndex) > 1 then
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if Not rs.eof then
    AddressState = rs("name")
end if
rs.Close
end if

if len(BusinessID) > 1 then

sql = "SELECT BusinessEmail, BusinessLogo FROM business where BusinessID = " & BusinessID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
BusinessLogo = rs("BusinessLogo")
BusinessEmail = rs("BusinessEmail")
'response.write("<Br>BusinessLogo=" & len(BusinessLogo))

if len(trim(BusinessLogo)) > 5 then
else
Query = " UPDATE Business Set BusinessLogo = '" & Logo & "' where BusinessID = " & BusinessID
'' response.write("Query=" & Query)
Conn.Execute(Query)
end if


if len(trim(BusinessEmail)) > 5 then
else
Query = " UPDATE Business Set BusinessEmail = '" & PeopleEmail & "' where BusinessID = " & BusinessID
'response.write("Query=" & Query)
Conn.Execute(Query)
end if
'response.write("Logo=" & Logo )
'response.write("BusinessLogo=" & BusinessLogo )

if len(Logo) > 5 then
else
Logo =BusinessLogo
end if

end if
%>


<%
showheader = false
If showheader = True then
if SubscriptionLevel < 2 then %>
<center><a href = "/invest/default.asp" target = "_blank"><img src = "/images/InvestHeaderAd2.jpg" width ="100%" style ="max-width:1400px" border = "0"></a></center>
<% else %>
<img src ="/members/images/HomeHeader.jpg" width ="100%" style="max-width: 1400px" />
<% end if %>
<%if len(BusinessName ) > 1 then %>
<% else %>
<br /><br />
<%
end if
End If %>


<div class="row">
  <div class="col-12"> 
    <div class="container roundedtopandbottom">
        <div class="row">
            <% if SelectedBusinessTypeID= 8 or SelectedBusinessTypeID=  10 or SelectedBusinessTypeID=  14 or SelectedBusinessTypeID=  26 or SelectedBusinessTypeID= 29 or SelectedBusinessTypeID=  31 then %>
            <div class="col-md-6 mb-4">
                <div class="d-flex align-items-center">
                    <a class="jumplinks" href="/Members/MembersProduceInventory.as#top">
                        <img src="/icons/produce.webp" alt="Produce" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    </a>
                    <div class="ml-3">
                        <h2>Produce</h2>
                        <ul>
                            <li><a class="body" href="/Members/MembersProduceInventory.asp">Inventory</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <% end if %>

            <% if SelectedBusinessTypeID= 8 then %>
            <div class="col-md-6 mb-4">
                <div class="d-flex align-items-center">
                    <a class="jumplinks" href="MembersAnimalshome.asp?ID=<%=AnimalID %>#top">
                        <img src="/icons/Livestock.svg" alt="Livestock" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    </a>
                    <div class="ml-3">
                        <h2>Livestock</h2>
                        <ul>
                            <li><a class="body" href="/Members/MembersAnimalshome.asp">List of Animals</a></li>
                            <li><a class="body" href="/Members/MembersAnimalAdd1.asp#top">Add</a></li>
                            <li><a class="body" href="membersDeleteanimal.asp?AnimalID=<%=AnimalID %>">Delete</a></li>
                            <li><a class="body" href="/Members/MembersTransferAnimal.asp">Transfer</a></li>
                            <li><a class="body" href="/Members/MembersAnimalsStats.asp">Statistics</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <% end if %>

         
            <div class="col-md-6 mb-4">
                <div class="d-flex align-items-center">
                    <a class="jumplinks" href="MembersProductList.asp?ID=<%=AnimalID %>#top">
                        <img src="/icons/Products.svg" alt="Products" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    </a>
                    <div class="ml-3">
                        <h2>Products</h2>
                        <ul>
                            <li><a class="body" href="/members/MembersProductList.asp">List</a></li>
                            <li><a class="body" href="/members/MembersClassifiedAdPlace0.asp">Add</a></li>
                            <li><a class="body" href="/Members/MembersProductECommerce.asp">Settings</a></li>
                            <% if numberofproducts > 0 then %>
                            <li><a class="body" href="/Members/MembersProductStats.asp">Statistics</a></li>
                            <% end if %>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="d-flex align-items-center">
                    <a class="jumplinks" href="MembersservicesHome.asp?ID=<%=AnimalID %>#top">
                        <img src="/icons/Services.svg" alt="Services" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    </a>
                    <div class="ml-3">
                        <h2>Services</h2>
                        <ul>
                            <li><a  class="body" href="/members/MembersservicesHome.asp">List</a></li>
                            <li><a  class="body" href="/Members/membersServicesAddPage0.asp">Add</a></li>
                            <li><a  class="body" href="/Members/membersServiceDelete.asp">Delete</a></li>
                            <li><a  class="body" href="/Members/MembersServicesSuggestCategory.asp">Suggest Category</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <% if SelectedBusinessTypeID=8 or SelectedBusinessTypeID= 30  then %>
            <div class="d-flex align-items-center">
                <img src="/icons/Real-Estate.svg" alt="Properties" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px; max-width:80px; min-width:80px;">
                <div class="ml-3">
                    <h2>My Properties</h2>
                    <a name="Properties"></a>

                    <a href="PropertiesHome.asp" class="body">List of Properties</a><br>
                    <a href="membersAddaProperty.asp" class="body">Add a Property</a><br>

                    <% sql = "select * from Properties where PeopleID = " & session("PeopleID") & " order by propname"
                    Set rs = Server.CreateObject("ADODB.Recordset")
                    rs.Open sql, conn, 3, 3
                    if rs.eof then %>
                    Currently you do not have any properties listed. To add a property <a href="membersAddaProperty.asp" class="body">click here</a>.
                    <% else %>
                    My Properties:<br>
                    <ul>
                        <% rowcount = 1
                        While Not rs.eof %>
                        <li><a href="membersEditProperty0.asp?propID=<%= rs("propID") %>#BasicFacts" class="body"><%=rs("propName")%></a>
                            <% if rs("PropForSale") = 1 then %> - For Sale<% end if %>
                            <% if len(rs("propPrice")) > 0 then %> - $<%=rs("propPrice")%><% end if %>
                        </li>
                        <% rs.movenext
                        rowcount = rowcount + 1
                        Wend %>
                    </ul>
                    <% end if
                    rs.close %>
                </div>
            </div>
            <% end if %>


            <% if SelectedBusinessTypeID=1  then %>
            <div class="col-md-6 mb-4">
                <div class="d-flex align-items-center">
                    <img src="/icons/Assoc-administration-icon.svg" alt="Website" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
                    <div class="ml-3">
                        <h2>Associations</h2>
                        <ul>
                            <li><a class="body" href="/Members/AssociationAdmin/SetupAssociationAccountExistingmember.asp">Create Account</a></li>
                            <li><a class="body" href="/Members/AssociationAdmin/AssociationDeleteAccount.asp">Delete Account</a></li>
                        
                            <% if rs.state > 0 then
                            rs.close
                            end if %>
                            <% Associationsfound = False
                            sql2 = "select associationmembers.AssociationID, AssociationName from associations, associationmembers where accesslevel > 1 and associations.AssociationID = associationmembers.AssociationID and associationmembers.PeopleID = " & PeopleID
                            acounter = 1
                            rs.Open sql2, Conn, 3, 3
                            if not rs.eof then Associationsfound = True %>
                            <% if Associationsfound = True then %>
                            <li>Edit Association Account:
                                <ul>
                                    <% while not rs.eof %>
                                    <li><a href="/Members/AssociationAdmin/AssociationHome.asp?AssociationID=<%=rs("AssociationID") %>" class="body"><%= rs("AssociationName")%></a></li>
                                    <% rs.movenext
                                    wend %>
                                </ul>
                            </li>
                            <% end if %>
                            <% if Associationsfound = True then %>
                            <% end if %>
                            <% rs.close %>
                        </ul>
                    </div>
                </div>
            </div>
            <% end if %>
        </div>
    </div>
</div>
</div>
<%=HSpacer %>


<% if people = 1016 then %>
<div class="row">
<div class="col-md-6 mb-4">
    <div class="d-flex align-items-center">
        <img src="/icons/Website.svg" alt="My Website" height="70" width="70" loading="lazy" border="0" style="margin-top: 16px; margin-bottom: 16px;">
        <div class="ml-3">
            <h3>My Website</h3>
            <a href="MemberssiteDesign.asp" class="body">Graphic Design (colors, fonts, etc.)</a><br />
            <a href="membersRanchhomeMembers.asp?PeopleID=<%=PeopleID %>" class="body">Home Page</a><br />
            <a href="membersPageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class="body">About Us Page</a><br />
            <% showpackages = True
            if showpackages = True and SubscriptionLevel > 3 then %>
            <div><b>Packages:</b></div>
            <div align="center">
                <a href="membersPackagesAdd.asp" class="body"><b>Add a Package</b></a>&nbsp;|
                &nbsp;<a href="membersPackagesDelete.asp" class="body"><b>Delete Packages</b></a>&nbsp;|
                &nbsp;<a href="membersPackageStats.asp" class="body"><b>Statistics</b></a>
            </div>
            <% end if %>
        </div>
    </div>
</div>
</div>
 <% end if %>






<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>