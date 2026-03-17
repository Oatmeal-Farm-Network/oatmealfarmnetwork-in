<%@LANGUAGE="VBScript"

%>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<!--#include file="aspJSON1.19.asp"-->
<!--#Include virtual="/members/JSON.asp"-->


</head>
<body>
  <% MasterDashboard= True 
    BladeSection = "accounts"
    Pagename = "accounts"%>
<!--#Include virtual="/members/membersheader.asp"-->
<style>
/* Dashboard Table */
.dashboard-table {
    width: 100%;
    border-collapse: collapse;
}

.dashboard-table th,
.dashboard-table td {
    padding: 0.75rem 1rem;
    text-align: left;
    border-bottom: 1px solid #E5E7EB;
}

.dashboard-table th {
    background-color: #F3F4F6;
    font-weight: 600;
    color: #4B5563;
    text-transform: uppercase;
    font-size: 0.75rem;
    letter-spacing: 0.05em;
}

.dashboard-table tr:nth-child(odd) {
    background-color: white;
}

.dashboard-table tr:last-child td {
    border-bottom: none;
}
</style>



<div class="container">
  <div class="row">
    <div class="col-md-12 dashboard-section">
        <h2 class="text-3xl font-bold mb-6 border-b-2 pb-3">
            Accounts
        </h2>
        
        <table class="dashboard-table">
            <thead>
                <tr>
                    <th>Account Name</th>
                    <th>Type</th>
                    <th style="min-width:120px">Actions</th>
                </tr>
            </thead>
            <tbody class = "body">
              <% 
              ' --- Classic ASP for fetching data ---
              sql = "SELECT Business.BusinessID, BusinessName, BusinessType, business.BusinessTypeID from businessaccess, business, businesstypelookup WHERE businessaccess.Businessid = business.businessid and Business.BusinessTYpeID = businesstypelookup.Businesstypeid and PeopleID = " & PeopleID & " order by BusinessTypeIDOrder"
              'response.write("sql="& sql)
              ' Set the connection and recordset objects (assuming 'conn' is already defined)
              Set rs = Server.CreateObject("ADODB.Recordset")
              rs.Open sql, conn, 3, 3
         

                ' Loop through the recordset and display each account as a table row
                While Not rs.EOF
                    CurrentBusinessID = rs("BusinessID")
                    CurrentBusinessTypeID = rs("BusinessTypeID")
                    CurrentBusinessName = rs("BusinessName")
                    BusinessType = rs("BusinessType")
                %>
                <tr>
                    <td><a href="AccountHome.asp?BusinessID=<%=CurrentBusinessID %>" class = "body"><%= CurrentBusinessName %></a></td>
                    <td><%= BusinessType %></td>
                    <td >
                        <a href="MembersOrgAccountUsers.asp?BusinessID=<%=CurrentBusinessID %>"><img src="/icons/Account.svg" width="20px" alt="users" ></a> | 
                        <a href="AccountHome.asp?BusinessID=<%=CurrentBusinessID %>"><img src="/icons/Edit.svg" width = 20px alt="Edit"></a> | 
                        <a href="AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>"><img src="/icons/Delete.svg" width = 20px alt="Delete"></a>
                    </td>
                </tr>
                <tr>
                 <td colspan = 3> 
                  <% if CurrentBusinessTypeID = 8 then %>
                    <a class="body" href="MembersAnimalAdd1.asp?BusinessID=<%=CurrentBusinessID %>">Add Livestock</a> | 
                    <a class="body" href="MembersAnimalshome.asp?BusinessID=<%=CurrentBusinessID %>">List of Livestock</a> |
                    <a class="body" href="MembersProduceInventory.asp?BusinessID=<%=CurrentBusinessID %>">Produce Inventory</a>|
                    <a class="body" href="MembersSellerOrders.asp?BusinessID=<%=CurrentBusinessID %>">Orders</a> |
                <% else %>
                  <a class="body" href="list_events.asp?BusinessID=<%=CurrentBusinessID %>">Events</a>
                <% end if %>
                  </td>
              </tr>
                <%
                    rs.MoveNext
                Wend
                ' Close the recordset and connection
                rs.Close
                Set rs = Nothing
                Set conn = Nothing
                %>
            </tbody>
        </table>


    </div>
  </div>
</div>

<!--#Include virtual="/members/membersfooter.asp"-->
</body>
</html>