

<br /><br />
<div class ="container">
<div class ="row">
    <div class = "col body roundedtopandbottom" valign = "top" width = 200>
            <div class ="row">
                <div class ="col"><h2>Search</h2></div>
            </div>
               
            <div class = "row">
              <div class = "col" align= "left">
        <form method="POST" action="/foodhubs/" class = "body">
            <% Currentcountry_id = request.Form("country_id")
           %>

              Country<br />
   
        <% 
            if len(Currentcountry_id) = 0 then
                 Currentcountry_id = 1228
                Currentname = "USA"
                ProvinceTitle="State"
            else

             sql = "select name, ProvinceTitle  from country where country_id=" & Currentcountry_id
                rs.Open sql, conn, 3, 3   
                if Not rs.eof then
                    Currentname = rs("name") 
                    ProvinceTitle=rs("ProvinceTitle")
                end if
               
            end if
            %>



     <select size="1" name="country_id" style="width: 190px" class = "formbox">
           <%  
            
       sql = "select distinct people.country_id, name from people, business, country where people.businessid = business.businessid  and people.country_id = Country.country_id and businesstypeid=8 order by name"
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        while Not rs.eof 
        name = rs("name") 
               
        Tempcountry_id = rs("country_id") 
        if lcase(name) = lcase(AddressCountry) then
          selected = "Selected"
        else
          selected = ""
        end if


        if cint(Currentcountry_id) = cint(Tempcountry_id) then
               selected = "Selected"
        else
               selected=""
        end if
        %>

        <option value="<%=Tempcountry_id %>" <%=selected%> ><%=name %></option>

        <% rs.movenext
        wend %>
        </select>
                   <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
                        </form>
                 
            </div>
         </div>


            <div class = "row">
                <div class = "col" align= "left">
                     <br />
                  <form method="POST" action="/FoodHubs/" class = "body">
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


                    <% sql = "select *  from state_province where country_id =" & Currentcountry_id & " order by name"
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
                      <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
                        </form>
         </div>
    </div>


     <div class ="row">
         <div class ="col">
             <br />
             <form method="POST" action="/foodhubs/" class = "body">
                Name&nbsp;<br />
            
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
         <form method="POST" action="/foodhubs/RanchSearchResults.asp" class = "body">
            Owners' Name&nbsp;<br />
        <% Ownersearch = request.form("Ownersearch") %>

  
           <input type=text name = "Ownersearch" value = "<%=Ownersearch %>" class = "formbox"  >
           <input type=submit value = "Search" class = "regsubmit2"  class = "body" >&nbsp;
        </form>
    </div>
   </div>

<% end if %>

<br />

</div>
</div>
   <div class ="row d-none d-lg-block ">
         <div class ="col d-none d-lg-block">


<br />
<br />

<%
    if rs.state > 0 then
    rs.close
    end if



' Define the function to validate and correct the link
Function ValidateAndFixLink(link)
    ' Check if the link starts with "https://"
    If Left(link, 8) <> "https://" Then
        ' If not, prepend "https://" to the link
        link = "https://" & link
    End If
    
    ' Check if the link is a valid URL
    If InStr(link, "://") > 0 And InStr(link, " ") = 0 Then
        ' If it is, return the corrected link
        ValidateAndFixLink = link
    Else
        ' If not, return an empty string (or handle the error as per your requirement)
        ValidateAndFixLink = ""
    End If
End Function



Query = "SELECT TOP 3 * FROM Ads WHERE ShowonLOA = 1 and AdType='Logo' ORDER BY NEWID()"


rs.Open Query, conn, 3, 3
x = 0
while not rs.eof 
 
    
    AdFooterID(x) = rs("AdID")
    AdFooterImage(x)  = rs("AdImage") 
    AdFooterLink(x) = rs("AdLink")

    AdFooterLink(x) = ValidateAndFixLink(AdFooterLink(x))

    Link1=""
    Link2 = ""
    if len(AdFooterLink(x)) > 3 then
    Link1=  AdFooterLink(x)
    Link2= "https://" & AdFooterLink(x)
    else
     AdFooterLink(x) = ".Farms/RanchHome.asp?CurrentPeopleID=" & PeopleID
    end if

     AdYear = rs("AdYear")
    AdMonth = rs("AdMonth")


    ShowOnLOA=rs("ShowOnLOA")

    Lastmonth = cint(month(now) -1)


    if admonth > 0 then
    else
    admonth = month(now)
    end if
 x = x + 1
    rs.movenext
wend



    if len(AdFooterLink(x)) > 0  then
    Query =  "INSERT INTO AdStats (AdID, ClickDate, AdType, Impression)" 
    Query =  Query & " Values ('" &  AdFooterID(x) & "', GETDATE(), 'Logo', 1)" 

    'response.write(Query)	

    Conn.Execute(Query) 
    end if

rs.close
%>

<% if len(AdFooterLink(1)) > 0 then %>
 <center><a href = "<%=AdFooterLink(1) %>" target = "_blank"><img src = "<%= AdFooterImage(1)%>" width ="200" style ="max-width:200px" border = "0"></a></center>
<br />
 <center><a href = "<%=AdFooterLink(2) %>" target = "_blank"><img src = "<%= AdFooterImage(2)%>" width ="200" style ="max-width:200px" border = "0"></a></center>
<br />
 <center><a href = "<%=AdFooterLink(3) %>" target = "_blank"><img src = "<%= AdFooterImage(3)%>" width ="200" style ="max-width:200px" border = "0"></a></center>
<br />
<% end if %>
</div>

</div>
</div>
