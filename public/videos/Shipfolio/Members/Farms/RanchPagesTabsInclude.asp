<% 'CurrentPeopleID = request.querystring("PeopleID")
'if len(CurrentPeopleiD) > 0 then
'else
''    CurrentPeopleID = request.querystring("CurrentPeopleID")
'end if
ShowLivestock = "False"
    if rs.state > 0 then rs.close

sql = "SELECT count(*) as count from animals where PublishForSale = 1 and peopleID = " & PeopleID  


rs.Open sql, conn, 3, 3 
Livestockcount=rs("count")
If Livestockcount > 0 Then 
ShowLivestock  = "True"
end if
'response.write("ShowLivestock=" & ShowLivestock)


ShowStuds = "False"
    if rs.state > 0 then rs.close

sql = "SELECT count(*) as count from animals where PublishStud = 1 and peopleID = " & PeopleID  
'response.write("sql=" & sql)

rs.Open sql, conn, 3, 3 
Studcount=rs("count")
If Studcount > 0 Then 
ShowStuds  = "True"
end if
'response.write("ShowLivestock=" & ShowLivestock)


    




    Function CheckAnimals(SpeciesID, PeopleID)
    Set rs = Server.CreateObject("ADODB.Recordset")
    
    sql = "SELECT count(*) as count from animals where PublishForSale = 1  and SpeciesID = " & SpeciesID & " and peopleID = " & CurrentPeopleID 
   'response.write("sql=" & sql)
    rs.Open sql, conn, 3, 3  
    AnimalCount = rs("count")
    If AnimalCount > 0 Then
        CheckAnimals = "True"
    Else
        CheckAnimals = "False"
    End If
    
    rs.close

    End Function

'response.write("ShowAlpacas=" & CheckAnimals(2, PeopleID) )

  if rs.state > 0 then
     rs.close
  end if
    
ShowPackages = "False"
sql = "SELECT  * from Package where len(packagename) > 1 and peopleID = " & CurrentPeopleID 
rs.Open sql, conn, 3, 3   
If Not rs.eof Then 
ShowPackages = "True"
end if

ShowProducts = "False"
sql = "SELECT  * from sfProducts where len(prodName) > 1 and peopleID = " & CurrentPeopleID 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then 
ShowProducts = "True"
end if

sql = "select PageLayoutID from RanchPageLayout where PageName = 'About Us' and PeopleID=" & CurrentPeopleID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
TempPageLayoutID  = rs("PageLayoutID")
else
Query =  "INSERT INTO RanchPageLayout (PageName , PeopleID)" 
Query =  Query & " Values ('About Us', " & CurrentPeopleID & " )"
Conn.Execute(Query) 
rs.close
sql = "select PageLayoutID from RanchPageLayout where PageName = 'About Us' and PeopleID=" & CurrentPeopleID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then   
TempPageLayoutID  = rs("PageLayoutID")
end if 
end if 


If not rs.State = adStateClosed Then
rs.close
End If  
ShowAboutUs = "False"
sql = "select * from RanchPageLayout2 where PageLayoutID  = " & TempPageLayoutID & "  order by BlockNum"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof and ShowAboutUs = "False"
if len(rs("PageText")) > 4 then
ShowAboutUs = "True"
end if
rs.movenext
wend


ShowAuctions = False
sql = "select * from AuctionDutch  where len(AuctionStartDateDay)> 0 and len(AuctionStartDateMonth)> 0 and len(AuctionStartDateYear)> 0 and len(AnimalID1) > 1 and PeopleID='" & CurrentPeopleID & "' order by AuctionLevel"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if not rs.eof then 
auctionstartdate = rs("AuctionStartDateMonth") & "/" & rs("AuctionStartDateDay") & "/" & rs("AuctionStartDateYear")
if len(auctionstartdate) > 7 then
TimePast = DateDiff("s", FormatDateTime(auctionstartdate,2), now)
TotalAuctionSeconds=3628800 
secondsRemaining =  TotalAuctionSeconds - TimePast 
Daysremaining = round(secondsRemaining / 86400,0)
MinutesRemainder = round((secondsRemaining - (Daysremaining * 86400)) / 60, 0) 
if secondsRemaining > 0 then	
 ShowAuctions = True
end if
end if
end if
%>

<%
rs.close
PeopleID = CurrentPeopleID
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	 PageTitle = rs("RanchHomeHeading")
    RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")

	Header = rs("Header")
	str1 = RanchHomeText
str2 = vblf
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("/default.asp")
end if


If Len(Logo) > 2 then

str1 = lcase(Logo)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "https://www.livestockoftheworld.com")
End If  

str1 = lcase(Logo)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "livestockoftheworld.com")
End If  


str1 = lcase(Logo)
str2 = "http:"
If InStr(str1,str2) > 0 Then
	Logo= Replace(str1, str2 , "https:")
End If  
    end if

if len(AddressID) > 0 then
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
end if


if len(BusinessID) > 0 then
sql = "select  BusinessName, Logo from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
Logo = rs("Logo")
end if 
rs.close
end if

 if len(Header) > 4 then 
str1 = lcase(Header) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Header=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
end if
%>

<br />

<div class="container " align = "center" style=" min-height: 70px" >
    <div class = "row" align = "center" >
        <div class = "col body" >
           <% if len(Header) > 4 then %> 
            <center><img src = "<%=Header %>" border = "0" height ="100px"/></center>
        <% else 
           if len(Logo)> 1 then %>


                <center><img src="<%=Logo%>" align ="center" height ="100px"/></center>
           <% else %>
             <h1><center><%=BusinessName%></center></h1>
        <% end if %>
        <% end if %>
        </div>
    </div>



<div class="navbar navbar-expand-lg navbar-light justify-content-center"  >
    <div class="container body AnimalListname" style="width: 100%; height: 45px; background-color:#441c15">
      <a class="navbar-brand" href="#"></a>
        <button class="navbar-inverse navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" >
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <% if  ShowLivestock  = "True" then %>
          <li class="nav-item dropdown">
              <% if country_id = 1228 then %>
                <a class="AnimalListname " href="https://www.LivestockOfAmerica.com/Ranches/RanchAnimallist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Animals For Sale&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>
                 <% if country_id = 1039 then %>
                <a class="AnimalListname" href="https://www.livestockofcanada.ca//Ranches/RanchAnimallist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Animals For Sale&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>
              <% if country_id = 1226 then %>
                <a class="FarmMenu " href="https://livestockoftheuk.co.uk//Ranches/RanchAnimallist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Animals For Sale&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>

            </li>
            <% end if %>
               <% if ShowStuds = "True" then %>
             <li class="nav-item dropdown">
                     <% if country_id = 1228 then %>
                <a class="FarmMenu " href="https://www.LivestockOfAmerica.com/Ranches/RanchStudlist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Stud Services&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>
                 <% if country_id = 1039 then %>
                <a class="FarmMenu " href="https://www.livestockofcanada.ca//Ranches/RanchStudlist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Stud Services&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>
              <% if country_id = 1226 then %>
                <a class="FarmMenu " href="https://livestockoftheuk.co.uk//Ranches/RanchStudlist.asp?CurrentPeopleID=<%=CurrentPeopleID %>" target="_blank" aria-expanded="false">Stud Services&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <% end if %>

          </li>
            <% end if %>

            <% ShowProducts= "False"
                if ShowProducts= "True" then %>

           <li class="nav-item dropdown">
            <a class="FarmMenu dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Products</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=FarmMenuColor%>">
            <% sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = 1 and sfproducts.peopleID = " & CurrentpeopleID & " order by catname"
			    acounter = 1
			    Set rs2 = Server.CreateObject("ADODB.Recordset")
			    rs2.Open sql2, conn, 3, 3 
			    While Not rs2.eof %>    
                    <li><a class="FarmMenu" href = "RanchStore.asp?catID=<%=rs2("CatID")%>&CurrentPeopleID=<%=CurrentpeopleID %>"><%=rs2("CatName")%></a> </li>
	                <% rs2.movenext
			    Wend %>
              </ul>
            </li>
           <% end if %> 
            
           <% if showProperties = "True" then %>
          <li class="nav-item dropdown">
               <a class="FarmMenu" href="Properties.asp?CurrentPeopleID=<%=CurrentPeopleID %>"  id="dropdown07"  aria-expanded="false">Properties</a>&nbsp;&nbsp;&nbsp;&nbsp;
          </li>
        <% end if %>
         <li class="nav-item dropdown">
              <a class="FarmMenu" href="FarmListing.asp?CurrentPeopleID=<%=CurrentPeopleID %>"  id="dropdown07"  aria-expanded="false">About / Contact Us</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </li>
        </ul>
      </div>
    </div>
  </div>
    </div>