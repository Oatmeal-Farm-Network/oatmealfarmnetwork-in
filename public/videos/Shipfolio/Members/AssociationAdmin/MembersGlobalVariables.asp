  <link rel="shortcut icon" type="image/png" href="https://www.GlobalLivestockSolutions.com/icons/HarvestHubFavIcon.png"/>
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5948717535197315"
     crossorigin="anonymous"></script>

<% 'Global Variables
Dim IDArray(999999)
Dim alpacaName(999999)

PageBackgroundColor = "#f9f6ee"

currentwebsite = "Global Grange"
cookieExpiration = DateAdd("d", 7, Now()) ' expires in 7 days

if Len(WebsiteID) < 1 then
Session("WebsiteID") = Request.querystring("WebsiteID")
WebsiteID = session("WebsiteID")
end if
 

PeopleID= request.querystring("PeopleID")
'response.write("Peopleid = " & PeopleID)

if Len(PeopleID) > 0 then
Session("PeopleID") = PeopleID
Session.Timeout = 40
end if  



'response.write("PeopleID2 = " & PeopleID )
'if Len(Session("PeopleID")) < 1 then
'Session("PeopleID") = Request.Cookies("PeopleIDCookie")
'end if  

PeopleID = Session("PeopleID")

'response.write("PeopleID=" & PeopleID)
    if len(PeopleID)< 1 then 
        response.redirect("https://www.harvesthub.world/logout.asp")
    end if
'response.write("PeopleID1 = " & PeopleID )
'response.write("PeopleID3 = " & PeopleID )
%>
<!--#Include virtual="/members/Conn.asp"-->

<%
dim CWNameArray(10)
dim CWIDArray(10)
'**************************************************************
' Check if the About Us Page is listed in RanchPageLayout
'**************************************************************
sql = "select * from RanchPageLayout where PageName = 'About Us' and PeopleID = " & PeopleID
   ' response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
If  rs.eof then
rs.close
Query =  "INSERT INTO RanchPageLayout (PeopleID, LinkOrder, Linkname, Editlink, FileName, PageName, PageAvailable, ShowPage )" 
Query =  Query & " Values (" &  PeopleID  & ", "
Query =  Query &  " 4," 
Query =  Query &  " 'About Us'," 
Query =  Query &  " 'PageData2.asp?pagename=About Us&PeopleID=" & PeopleID & "'," 
Query =  Query &  " 'RanchAboutUs.asp?PeopleID=" & PeopleID & "'," 
Query =  Query &  " 'About Us' ," 
Query =  Query &  " 1 ,"
Query =  Query &  " 0 )"
Conn.Execute(Query) 
sql = "select PageLayoutID from RanchPageLayout where PeopleID = " & PeopleID & " and LinkName='About Us'"
rs.Open sql, conn, 3, 3
PageLayoutID = rs("PageLayoutID")
rs.close
X = 0
while X < 9
X = X + 1 
Query =  "INSERT INTO RanchPageLayout2 (PeopleID, BlockNum, PageLayoutID )" 
Query =  Query & " Values (" & PeopleID & ", " 
Query =  Query &  " " &  X & ", " 
Query =  Query &  " " & PageLayoutID & " )" 
Conn.Execute(Query) 
wend
else
end if 
If not rs.State = adStateClosed Then
rs.close
End If  
%>

<!--#Include virtual="/members/Conn.asp"-->
<% Set rsa = Server.CreateObject("ADODB.Recordset")
Set rsb = Server.CreateObject("ADODB.Recordset")





'********************************
'Published Products
'********************************

sqlb = "select * from People where peopleid = " & PeopleID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then
Subscriptionlevel = rsb("Subscriptionlevel")
accesslevel  = rsb("accesslevel")
BusinessID = rsb("BusinessID")
if Subscriptionlevel = 1 then
   QuantityTypeScrtipt = " and QuantityType = 'Any' "
else
     QuantityTypeScrtipt = "  "
end if


addressID = rsb("AddressID")
'response.write("custcountry=" & custcountry)

while not rsb.eof 
tempPeopleID = PeopleID
sqla = "select count(*) as numPublishedproducts from sfproducts where PublishProduct = 1 and PeopleID = " & tempPeopleID 
'response.write("sqla=" & sqla )

rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts")) 
end if
rsa.close

'response.write("numPublishedproducts=" & numPublishedproducts )
'response.write("accesslevel=" & accesslevel )

if accesslevel < 1 then
i=0
sqla = "select Prodid from sfproducts where PublishProduct = 1 and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, conn, 3, 3

while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
Query =  " UPDATE sfproducts Set PublishProduct = 0  where ProdId = " & TempProdId & ";" 
Conn.Execute(Query) 
rsa.movenext
wend
rsa.close
end if



if numPublishedproducts > 5 and Subscriptionlevel < 4 then
i=0
sqla = "select Prodid from sfproducts where PublishProduct = 1 and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, conn, 3, 3

while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
if i > 5 then
Query =  " UPDATE sfproducts Set PublishProduct = 0  where ProdId = " & TempProdId & ";" 
Conn.Execute(Query) 
end if
rsa.movenext
wend
rsa.close
end if

'response.write("Subscriptionlevel=" & Subscriptionlevel )
if numPublishedproducts > 25 and Subscriptionlevel = 5 then
i=0
sqla = "select count(*) as numPublishedproducts from sfproducts where PublishProduct = 1  and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, conn, 3, 3
'response.write("sqla=" & sqla)
while not rsa.eof
i = i +1
'TempProdId = rsa("Prodid")
'if i > 25 then
'Query =  " UPDATE sfproducts Set PublishProduct = 0 where ProdId = " & TempProdId & ";" 
'Conn.Execute(Query) 
'end if
rsa.movenext
wend
rsa.close
end if



if len(addressID) > 0 then
sql = "select StateIndex, country_id from address where addressID = " & addressID 

rs.Open sql, conn, 3, 3
country_id = rs("country_id")
StateIndex = rs("StateIndex")
rs.close
end if


if len(country_id) > 0  then
sql = "select name from country where country_id = " & country_id 
rs.Open sql, conn, 3, 3
AddressCountry = rs("name")
rs.close
end if

'response.write("StateIndex=" & StateIndex )
if len(StateIndex) > 0 and not StateIndex = 0  then
sql = "select name from state_province where StateIndex = " & StateIndex 
rs.Open sql, conn, 3, 3
AddressCountry = rs("name")
rs.close
end if

'********************************
'Published Animals
'********************************

sqla = "select count(*) as numPublishedAnimals  from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID 
'response.write("sqla=" & sqla )
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))  
'response.write("numPublishedAnimals=" & numPublishedAnimals )
end if
rsa.close

sqla = "select animals.id from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID & " Order by Price desc"
rsa.Open sqla, conn, 3, 3
If not rsa.eof then


if accesslevel < 1 then
    i=0
    while not rsa.eof
    i = i +1
    animalId = rsa("id")
        Query =  " UPDATE Animals Set PublishForSale = 1  where ID = " & animalId & ";" 
        Conn.Execute(Query) 
    rsa.movenext
    wend
end if



if numPublishedAnimals > 5 and Subscriptionlevel < 4 then
    i=0
    while not rsa.eof
    i = i +1
    animalId = rsa("id")
    if i > 5 then
        Query =  " UPDATE Animals Set PublishForSale = 1  where ID = " & animalId & ";" 
        Conn.Execute(Query) 
    end if
    rsa.movenext
    wend
end if

if numPublishedAnimals > 25 and Subscriptionlevel =5 then
    i=0
    while not rsa.eof
    i = i +1
    animalId = rsa("id")
    if i > 25 then
        Query =  " UPDATE Animals Set PublishForSale = 1  where ID = " & animalId & ";" 
        Conn.Execute(Query) 
    end if
    rsa.movenext
    wend
end if



end if
rsa.close




sqla = "select count(*) as numPublishedStuds  from animals where Publishstud = 1 and PeopleID = " & tempPeopleID 
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedStuds = cint(rsa("numPublishedStuds"))  
'response.write("numPublishedAnimals=" & numPublishedAnimals )
end if
rsa.close

sqla = "select animals.id from animals, Pricing where animals.id = Pricing.id and PublishStud = 1 and PeopleID = " & tempPeopleID & " Order by Price desc"
'response.write("sqla=" & sqla )
rsa.Open sqla, conn, 3, 3
If not rsa.eof then

if accesslevel < 1 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
Query =  " UPDATE Animals Set PublishStud = 0 where ID = " & animalId & ";" 
Conn.Execute(Query) 
rsa.movenext
wend
end if



if numPublishedStuds > 5 and Subscriptionlevel < 4 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
if i > 1 then
Query =  " UPDATE Animals Set PublishStud = 0 where ID = " & animalId & ";" 
Conn.Execute(Query) 
end if
rsa.movenext
wend
end if
end if
rsa.close





rsb.movenext
wend
end if
rsb.close


skip = True
    If skip =False then

sqlb = "select * from People where Subscriptionlevel = 1"
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then
while not rsb.eof 
tempPeopleID = rsb("PeopleID")
sqla = "select count(*) as numPublishedproducts, Prodid from sfproducts where ProdForSale = 1 and PeopleID = " & tempPeopleID & " group by Prodid"
  
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts"))   
if numPublishedproducts > 5 and Subscriptionlevel < 2 then
i=0



while not rsa.eof
i = i +1
    if not rsa.eof then
        TempProdId = rsa("Prodid")
    end if
if i > 5 then
Query =  " UPDATE sfproducts Set ProdForSale = 1  where ProdId = " & TempProdId & ";" 
Conn.Execute(Query) 
end if
rsa.movenext
wend
end if
end if
rsa.close
sqla = "select count(*) as numPublishedAnimals, animals.id from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID & " Group by animals.id "
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))   
if numPublishedAnimals > 5 and Subscriptionlevel < 4 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
if i > 5 then
Query =  " UPDATE Animals Set PublishForSale = 1  where ID = " & animalId & ";" 
Conn.Execute(Query) 
end if
rsa.movenext
wend
end if
end if
rsa.close
rsb.movenext
wend
end if
tempPeopleID = PeopleID
if tempPeopleID = 1802 then
sqla = "select count(*) as numPublishedAnimals from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID 
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))
End if
rsa.close
sqla = "select count(*) as numPublishedproducts from sfproducts where ProdForSale = 1 and PeopleID = " & tempPeopleID 
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts"))
end if
rsa.close
end if

sqla = "select count(*) as numAlpacas from animals where speciesID = 2 and PeopleID = " & tempPeopleID
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numAlpacas = rsa("numAlpacas")
End if
rsa.close

rsb.close

sqla = "select distinct speciesID from animals where PeopleID = " & tempPeopleID
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
while not rsa.eof
tempspeciesid = rsa("speciesid")

if len(tempspeciesID) >0 then
else
tempspeciesID = 2
end if

if  len(tempspeciesID) > 0 then 
sqlb = "select * from ranchspecieslookuptable where speciesiD = " & tempspeciesID & " and PeopleID = " & tempPeopleID

rsb.Open sqlb, conn, 3, 3
If rsb.eof then
Query =  " insert into ranchspecieslookuptable (peopleid, speciesid) values (" & temppeopleid & "," & tempspeciesID & ")" 
Conn.Execute(Query) 
'response.write("Query = " & Query & "<br>")
end if
rsb.close
end if

rsa.movenext
wend
End if
rsa.close
end if ' End Skip

sqlb = "select SubscriptionLevel, custAIEndService, Preferedspecies from People where PeopleID = " & PeopleID
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then
SubscriptionLevel = rsb("SubscriptionLevel")
custAIEndService  = rsb("custAIEndService")
Preferedspecies = rsb("Preferedspecies")
end if
rsb.close

Sitenamelong = "Global Grange"


%>
<title><%=Sitenamelong %> Members Area</title>
<meta name="Title" content="<%=Sitenamelong %> Members Area"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="nofollow"/>
