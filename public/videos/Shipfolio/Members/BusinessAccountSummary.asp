<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


<!--#Include file="MembersGlobalVariables.asp"-->

<%  sql = "select * from Business where BusinessID = " & BusinessID

     ' response.write(sql)
       Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
         if  Not rs.eof then 
        Preferedspecies = rs("Preferedspecies") 

        'if Preferedspecies = 2 then
        'PreferedspeciesName="Alpacas" 
        'end if 
        'if Preferedspecies = 3 then
        'PreferedspeciesName="Dogs"
        'end if 
        'if Preferedspecies = 4 then
        'PreferedspeciesName="Llamas"
        'end if 
        'if Preferedspecies = 5 then
        'PreferedspeciesName="Horses"
        'end if 
        'if Preferedspecies = 6 then
        'PreferedspeciesName="Goats"
        'end if 
        'if Preferedspecies = 7 then
        'PreferedspeciesName="Donkeys (includes Mules & Hinnies)"
        'end if 
        'if Preferedspecies = 8 then
        'PreferedspeciesName="Cattle"
        'end if 
        'if Preferedspecies = 9 then
        'PreferedspeciesName="Bison"
        'end if 
        'if Preferedspecies = 10 then
        'PreferedspeciesName="Sheep"
        'end if 
        'if Preferedspecies = 11 then
        'PreferedspeciesName="Rabbits"
        'end if 
        'if Preferedspecies = 12 then
        'PreferedspeciesName="Pigs"
        'end if 
        'if  Preferedspecies = 13 then
        'PreferedspeciesName="Chickens"
        'end if 
        'if Preferedspecies = 14 then
        'PreferedspeciesName="Turkeys"
        'end if 
        'if Preferedspecies = 15 then
        'PreferedspeciesName="Ducks (and other Fowel)"
        'end if 
        'if Preferedspecies = 16 then
        'PreferedspeciesName="Cats"
        'end if 
        'if Preferedspecies = 17 then
        'PreferedspeciesName="Yaks"
        'end if 
        'if Preferedspecies = 18 then
        'PreferedspeciesName="Camels"
        'end if 
        'if Preferedspecies = 19 then
        'PreferedspeciesName="Emus"
        'end if 
        'if Preferedspecies = 20 then
        'PreferedspeciesName="Elks"
        'end if 
        'if Preferedspecies = 21 then
        'PreferedspeciesName="Deer"
        'end if 
        'if Preferedspecies = 22 then
        'PreferedspeciesName="Geese"
        'end if 

        BusinessAcronym = rs("BusinessAcronym")
     BusinessEmail = rs("BusinessEmail")
      '  response.write("BusinessEmail=" & BusinessEmail)
        PreferedBreed = rs("PreferedBreed") 
        SubscriptionLevel = rs("SubscriptionLevel")  
        PhoneID = rs("PhoneID")
        WebsitesID = rs("WebsitesID")

        AddressID = rs("AddressID")

         BusinessName = rs("BusinessName")
         BusinessFacebook = rs("BusinessFacebook") 
	     BusinessX = rs("BusinessX") 
	     BusinessInstagram = rs("BusinessInstagram")
	     BusinessPinterest= rs("BusinessPinterest")
	     BusinessTruthSocial = rs("BusinessTruthSocial")
	     BusinessBlog = rs("BusinessBlog")
	     BusinessYouTube = rs("BusinessYouTube")
	     BusinessOtherSocial1 = rs("BusinessOtherSocial1")
	     BusinessOtherSocial2 = rs("BusinessOtherSocial2")
        end if

    
if len(PhoneID) > 0 then
sql = "select * from Phone where PhoneID =" & PhoneID
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
  if  Not rs.eof then 
        BusinessPhone = rs("phone")
        BusinessCell = rs("Cellphone")
        BusinessFax= rs("fax")
   end if
    
else
   PhoneID = ""
end if



 if len(PhoneID) > 0 then

else

    Query =  "INSERT INTO Phone (Fax)" 
    Query =  Query & " Values ('')" 

    Conn.Execute(Query) 
end if

    if len(PhoneID) > 0 then
         sql = "select * from phone where PhoneID = " &  PhoneID
    else
        sql = "select * from phone order by phoneid desc " 
    end if
    
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
            Phone = rs("Phone")
            Cellphone = rs("Cellphone")
            Fax = rs("Fax")
            PhoneID = rs("PhoneID")
    end if




   
    if len(AddressID) > 0 then

    else

    Query =  "INSERT INTO Address (AddressZip)" 
    Query =  Query & " Values ('')" 

    Conn.Execute(Query) 

    sql = "select  AddressID from Address order by AddressID desc "
    rs.close
        rs.Open sql, conn, 3, 3   
            AddressID = rs("AddressID")
        rs.close

'response.write("AddressID=" & AddressID)
    end if

        sql = "select *  from Address where AddressID = " & AddressID
        if len(AddressID) > 1 then
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        if  Not rs.eof then 
            country_id = rs("country_id")
            StateIndex = rs("StateIndex")
            AddressStreet = rs("AddressStreet")
            AddressApt = rs("AddressApt")
            AddressCity = rs("AddressCity")
            AddressZip = rs("AddressZip")
        end if
        end if 


    
        sql = "select *  from country where country_id = " & country_id
        if len(country_id) > 1 then
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        if  Not rs.eof then 
        AddressCountry = rs("name")
        end if
        end if


        sql = "select * from state_province where StateIndex = " & StateIndex
        if len(StateIndex) > 1 then
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        if  Not rs.eof then 
        AddressState = rs("name")
        end if
        end if

        if len(WebsitesID) > 0 then
         sql = "select distinct * from Websites where WebsitesID = " & WebsitesID

        'response.write (sql)
            Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3   
            if  Not rs.eof then 
                BusinessWebsite = rs("Website")
            end if
        else

            Query =  "INSERT INTO Websites (Website)" 
            Query =  Query & " Values ('')" 
    'response.write("Query=" & Query)
            Conn.Execute(Query) 

            sql = "select WebsitesID from Websites order by WebsitesID desc "
            rs.close
                rs.Open sql, conn, 3, 3   
                    WebsitesID = rs("WebsitesID")
                rs.close

            'response.write("WebsitesID=" & WebsitesID)

        end if
    
   ' response.write(" BusinessWebsite =" &  BusinessWebsite  )
    
    %>
</head>
<body >
<% Current3 = "Summary" %>
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAccountJumpLinks.asp"-->
    <br />
<div class = "container roundedtopandbottom">
<div class="container">
  <div class="row">
    <div class="col-md-6">
      <!-- Left Column Content -->
       <H1>Account Summary</H1>
        <% changesmade = request.querystring("changesmade")
            if changesmade = "True" then %>
               <font color ="maroon"><b><big>Your Changes Have Been Made</big></b></font><br /><br />
         <%  end if %>

      <form  name=form method="post" action="BusinessAccountUpdateAccount.asp?BusinessID=<%=BusinessID%>">
        <div class = row>
        <div class="col body">
        Business Account ID: <%=BusinessID %> </div>
        </div>
        <%=HSpacer %>



         <div class = row>
                <div class="col body">

           <%
               rs.close
               if len(BusinessTypeID) > 0 then
           sql = "select BusinessType from [dbo].[businesstypelookup] where BusinessTypeID = " & BusinessTypeID & ""
            rs.Open sql, conn, 3, 3   
            if  Not rs.eof then 
                CurrentBusinessType = rs("BusinessType")
            end if
            rs.close
         end if  
            %>

             Business /Organizations Type<br />
            <select name="BusinessTypeID" style="min-width:310px" class = formbox>
            <%  if len(CurrentBusinessType) > 1 then %>
                <option value=<%=BusinessTypeID %> selected><%=CurrentBusinessType %></option>
            <% else %>
                <option ></option>
            <% end if %>

        <% sql = "select * from [dbo].[businesstypelookup] order by BusinessType"
            rs.Open sql, conn, 3, 3   
            while Not rs.eof %>
               <option value="<%=rs("BusinessTypeID")%>"><%=rs("BusinessType")%></option>
    
            <% rs.movenext
            wend
            rs.close
    
            %>

        </select>  
         </div>
        </div>
        <%=HSpacer %>


        <div class = row>
        <div class="col body">
        Business /Organizations Name<font color="#abacab">(Optional)</font><br />
        <input name="BusinessName" Value ="<%=BusinessName%>"  size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        </div>
        </div>     
        <%=HSpacer %>
        <div class = row>
          <div class="col body">
            Acronym<font color="#abacab">(Optional)</font><br />
          <input name="BusinessAcronym" Value ="<%=BusinessAcronym%>"  size = "10" maxlength = "10" class = formbox>
          </div>
          </div>     
          <%=HSpacer %>

        
           
         <div>
           <div>

        <% showprimaryspecies = False
          if showprimaryspecies = True then  %>
         <div class = "row" >
            <div class = "body"  >


        <b>Preferences</b>
        Primary Species<br />
        <select size="1" name="PreferedSpecies" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        <% if len(Preferedspecies) > 0 then %>
        <% if Preferedspecies > 0 then %>
        <option value="<%=Preferedspecies %>" selected><%=PreferedspeciesName %></option>
        <%
        end if
        end if
        sql = "select * from SpeciesAvailable where SpeciesID = 2 or SpeciesID = 3 or SpeciesID = 4 or SpeciesID = 5 or SpeciesID = 6 or SpeciesID = 7 or SpeciesID = 8 or SpeciesID = 9 or SpeciesID = 10 or SpeciesID = 11 or SpeciesID = 12 or SpeciesID = 13 or SpeciesID = 14 or SpeciesID = 17 or SpeciesID = 19 Order by Species "
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3   
        while not rs.eof
          %>
        <option  value= "<%=rs("SpeciesID")%>"><%=rs("species")%></option>
        <% 
        rs.movenext
        wend
        rs.close
        %>
        </select>
        </div>
        </div>






        <%=HSpacer %>
        <div class = row>
        <div class="col body">

        <% end if %>



        <% showbreed = false
        if showbreed = true then
        if len(preferedSpecies) > 0 then %>
        <input name="ReturnPage" Value ="membersAccountContactsEdit.asp?PeopleID=<%=PeopleID%>" type="hidden">
        Primary Breed

        <% if len(PreferedBreed) then 
        sql = "select * from SpeciesBreedLookupTable where BreedLookupID = " & PreferedBreed & " and speciesid=" & Preferedspecies &" Order by SpeciesID "
        'response.write("sql=" & sql)
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3  
        if not rs.eof then
        PreferedBreedname = rs("Breed")
        end if
        rs.close 
        %>
        <% end if %>

        <% if Preferedspecies = 3 then
        sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
        else
        sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & Preferedspecies
        end if %>
        <select size="1" name="PreferedBreed" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        <% Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql2, conn, 3, 3 
        if len(PreferedBreedname) > 0 then %>
        <option value="<%=PreferedBreed %>" selected><%=PreferedBreedname %></option>
        <%
        end if
        while not rs.eof %>
        <option  value= "<%=rs("BreedlookupID")%>" ><%=rs("Breed")%></option>
        <% rs.movenext
        wend
        rs.close
        %>
        </select>

        <% end if %>
        <% end if %>

            </div>
        </div>
 

        <div class = row>
        <div class="col body">
        Street <font color="#abacab">(Optional)</font><br />
        <input name="AddressStreet"  value = "<%=AddressStreet%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        </div>
        </div>
        <%=HSpacer %>
        <div class = row>
        <div class="col body">
        Street 2<font color="#abacab">(Optional)</font><br />
        <input name="AddressApt"  value = "<%=AddressApt%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        </div>
        </div>
        <%=HSpacer %>
        <div class = row>
        <div class="col body">
        City<font color="#abacab">(Optional)</font><br />
            <input name="AddressCity" value = "<%=AddressCity%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                </div>
            </div>
            <%=HSpacer %>
            <div class = row>
            <div class="col body">

        <% if len(country_id) > 1 then %>
           
        <% if country_id= 1228 then %>
        State
        <% else %> 
        Province
        <% end if %><br />
        <select size="1" name="StateIndex" size = "40" maxlength = "61" style="min-width:310px; max-width:310px" class = formbox>

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
        wend %>
        </select>
        <% end if %>

            </div>
        </div>

        <%=HSpacer %>
        <div class = row>
        <div class="col body">
        Country<br />
        <select size="1" name="country_id" required size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        <% sql = "select *  from country where active = 1 order by name"
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
        %>

        <option value="<%=Tempcountry_id %>" <%=selected%> ><%=name %></option>

        <% rs.movenext
        wend %>
        </select>

        </div>
        </div>
        <%=HSpacer %>
        <div class = row>
        <div class="col body">
        Postal Code <font color="#abacab">(Optional)</font><br />
        <input name="AddressZip" value = "<%=AddressZip%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        </div>
        </div>
        <%=HSpacer %>
            <div class = row>
            <div class="col body">
            Email<br />
                  <input type="text" id="BusinessEmail" name="BusinessEmail" value = "<%=BusinessEmail%>" required size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                </div>
            </div>
 <%=HSpacer %>
        <div class = row>
        <div class="col body">
        Phone<font color="#abacab">(Optional)</font><br />
        <input name="BusinessPhone"  value = "<%=BusinessPhone%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
        </div>
        </div>




    </div>

    <div class="col-md-6">
      <div class="col-md-6 d-none d-md-block">
      <br /><br />
    </div>
         <%=HSpacer %>
  <%=HSpacer %>
             <%=HSpacer %>
        <div class = row>
        <div class="col body">
        Cell<br />
        <input name="BusinessCell" value = "<%=BusinessCell%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
    
          </div>
        </div>  
   
         <%=HSpacer %>    
        <div class = row>
          <div class="col body">
            Website <font color="#abacab">(Optional)</font><br />
            <input type="text" id="BusinessWebsite" name="BusinessWebsite" value="<%=BusinessWebsite%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
              <br />
            </div>
        </div>
        <%=HSpacer %>

 <div class ="row">
                    <div class ="col  body">
                        Facebook <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessFacebook" Value ="<%=BusinessFacebook%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        X (Twitter) <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessX" Value ="<%=BusinessX%>" size = "40" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        Instagram <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessInstagram" Value ="<%=BusinessInstagram%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                         Pinterest<font color="#abacab">(Optional)</font><br />
                         <input name="BusinessPinterest" Value ="<%=BusinessPinterest%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                  <div class ="row">
                    <div class ="col  body">
                        Truth Social <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessTruthSocial" Value ="<%=BusinessTruthSocial%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                          Blog <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessBlog" Value ="<%=BusinessBlog%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                         YouTube <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessYouTube" Value ="<%=BusinessYouTube%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                  <div class ="row">
                    <div class ="col  body">
                         Other Social Media 1<font color="#abacab">(Optional)</font><br />
                         <input name="BusinessOtherSocial1" Value ="<%=BusinessOtherSocial1%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                 <div class ="row">
                    <div class ="col  body">
                         Other Social Media 2 <font color="#abacab">(Optional)</font><br />
                         <input name="BusinessOtherSocial2" Value ="<%=BusinessOtherSocial2%>" size = "40" maxlength = "61" style="max-width:310px" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

    </div>
  </div>
</div>



<div class = "container ">
  <div class = "row">
    <div class = "col">
    <br />
        <input name="PhoneID" Value ="<%=PhoneID%>" hidden>
        <input name="WebsitesID" Value ="<%=WebsitesID%>" hidden>
        <input name="AddressID" Value ="<%=AddressID%>" hidden>

      <input type=submit value="Update" class = "regsubmit2" >
         

  <br /> <br /> </form>
  </div>
 </div>
</div>
</div>

    <br /><br />
<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>