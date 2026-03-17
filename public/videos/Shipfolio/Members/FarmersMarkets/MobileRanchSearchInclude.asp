

<br /><br />
<div class ="container-fluid" width ="100%">
<div class ="row">
    <div class = "col body roundedtopandbottom" valign = "top" style="width:100%">
            <div class ="row">
                <div class ="col"><h2>Farm Search</h2></div>
            </div>
                 
            <div class = "row">
                <div class = "col" align= "left">

                  <form method="POST" action="SearchResultsPage.asp" class = "body">
                    <% State = request.form("State") 
                    if len(State) > 0 then
                    else
                    State = request.querystring("State")
                    end if
                       ' response.write("StateIndex=" & StateIndex)
                    %>

                    <%=ProvinceTitle %><br />
                <select size="1" name="StateIndex" style="width: 190px" class = "formbox">
                    <% if len(StateIndex) < 1 then StateIndex = 0
      
                        if StateIndex > 0 and not StateIndex = 10000 then 
                            sql2 = "select name from state_province where StateIndex=" & StateIndex
                           response.write("sql2=" & sql2)
                            rs.Open sql2, conn, 3, 3
                                name = rs("name")
                            rs.close %>
                            <option value="<%=StateIndex %>" selected><%=name %></option>
                            <option value="10000"><br />Any</option>
                        <% else %>
                            <option value="10000">Any</option>
                        <% end if %>


                    <% sql = "select *  from state_province where country_id =" & country_id & " order by name"
                    Set rs = Server.CreateObject("ADODB.Recordset")
                    rs.Open sql, conn, 3, 3 
                    while Not rs.eof 
                        province = rs("name") 
                        TempStateIndex= rs("StateIndex") 

                        if lcase(province) = lcase(AddressState) then
                            selected = "Selected"
                        else
                            selected = ""
                        end if
                    %>
                    <option value="<%=TempStateIndex %>" <%=selected%> > <%=province %></option>


                    <% rs.movenext
                    wend 
                    rs.close 
                     %>
                      &nbsp; <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
                        </form>
         </div>
    </div>


     <div class ="row">
         <div class ="col">
             <br />
             <form method="POST" action="SearchResultsPage.asp" class = "body">
               Farm Name&nbsp;<br />
            
            <% Name = request.form("Name")
            if len(Name) > 0 then
            else
            Name = request.querystring("Name")
            end if
             %> 

             <input type=text name = "Name" value = "<%=Name %>" class = "formbox"  >
             <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
                </form>

        </div>
      </div>

<% showownersearch = false
   if showownersearch = True then %>
     <div class ="row">
         <div class ="col">
         <form method="POST" action="SearchResultsPage.asp" class = "body">
            Owners' Name&nbsp;<br />
        <% Ownersearch = request.form("Ownersearch") %>

  
           <input type=text name = "Ownersearch" value = "<%=Ownersearch %>" class = "formbox"  >
           <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
        </form>
    </div>
   </div>

<% end if %>

<br />




<br />
<br />


</div>
</div>
