<% 'Global Variables
Dim IDArray(999999)
Dim alpacaName(999999)
%>
<!--#Include virtual="/ConnLOA.asp"-->
<%

currentwebsite = "Livestock Of The World"

PeopleID = session("PeopleID")
if Len(Session("PeopleID")) < 1 then
Session("PeopleID") = Request.Cookies("PeopleID")
PeopleID = session("PeopleID")
end if  %>


<% Set rsa = Server.CreateObject("ADODB.Recordset")
Set rsb = Server.CreateObject("ADODB.Recordset")





'********************************
'Published Products
'********************************

sqlb = "select * from People where peopleid = " & session("AIID")
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then
Subscriptionlevel = rsb("Subscriptionlevel")
accesslevel  = rsb("accesslevel")


CustCountry = rsb("CustCountry")
addressID = rsb("AddressID")
'response.write("custcountry=" & custcountry)








if not rsb.eof then
tempPeopleID = PeopleID
sqla = "select count(*) as numPublishedproducts from sfproducts where PublishProduct = 1 and PeopleID = " & session("AIID") 
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts")) 
end if
rsa.close

'response.write("numPublishedproducts=" & numPublishedproducts )
'response.write("accesslevel=" & accesslevel )



if len(addressID) > 0 and len(custcountry) < 1 then
sql = "select addresscountry from address where addressID = " & addressID 
rs.Open sql, connLOA, 3, 3
addresscountry = rs("addresscountry")
'response.write("addresscountry = " & addresscountry )
rs.close
end if

if rsb.state  = 0 then
else
rsb.close
end if

sqlb = "select * from People where PeopleID = " & session("AIID")
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then
tempPeopleID = rsb("PeopleID")
sqla = "select count(*) as numPublishedproducts from sfproducts where ProdForSale = 1 and PeopleID = " & tempPeopleID 
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts"))   
if numPublishedproducts > 5 and Subscriptionlevel < 4 then
i=0
while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
if i > 5 then
Query =  " UPDATE sfproducts Set ProdForSale = False  where ProdId = " & TempProdId & ";" 
connLOA.Execute(Query) 
end if
rsa.movenext
wend
end if
end if



connLOA.close %>

<!--#Include virtual="/connLOA.asp"-->

<%
if accesslevel < 1 then
i=0
sqla = "select Prodid from sfproducts where PublishProduct = 1 and PeopleID = " & session(AIID) & " Order by ProdPrice desc"
rsa.Open sqla, connLOA, 3, 3

while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
Query =  " UPDATE sfproducts Set PublishProduct = 0  where ProdId = " & TempProdId & ";" 
connLOA.Execute(Query) 
rsa.movenext
wend
rsa.close
end if



if numPublishedproducts > 5 and Subscriptionlevel < 4 then
i=0
sqla = "select Prodid from sfproducts where PublishProduct = 1 and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, connLOA, 3, 3

while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
if i > 5 then
Query =  " UPDATE sfproducts Set PublishProduct = 0  where ProdId = " & TempProdId & ";" 
connLOA.Execute(Query) 
end if
rsa.movenext
wend
rsa.close
end if

'response.write("Subscriptionlevel=" & Subscriptionlevel )
if numPublishedproducts > 25 and Subscriptionlevel = 5 then
i=0
sqla = "select count(*) as numPublishedproducts from sfproducts where PublishProduct = 1  and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, connLOA, 3, 3

while not rsa.eof
i = i +1
TempProdId = rsa("Prodid")
if i > 25 then
Query =  " UPDATE sfproducts Set PublishProduct = 0 where ProdId = " & TempProdId & ";" 
connLOA.Execute(Query) 
end if
rsa.movenext
wend
rsa.close
end if




'********************************
'Published Animals
'********************************

sqla = "select count(*) as numPublishedAnimals  from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID 
'response.write("sqla=" & sqla )
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))  
'response.write("numPublishedAnimals=" & numPublishedAnimals )
end if
rsa.close

sqla = "select animals.id from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID & " Order by Price desc"
'response.write("sqla=" & sqla )
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then


if accesslevel < 1 then
    i=0
    while not rsa.eof
    i = i +1
    animalId = rsa("id")
        Query =  " UPDATE Animals Set PublishForSale = False  where ID = " & animalId & ";" 
        connLOA.Execute(Query) 
    rsa.movenext
    wend
end if



if numPublishedAnimals > 5 and Subscriptionlevel < 4 then
    i=0
    while not rsa.eof
    i = i +1
    animalId = rsa("id")
    if i > 5 then
        Query =  " UPDATE Animals Set PublishForSale = False  where ID = " & animalId & ";" 
        connLOA.Execute(Query) 
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
        Query =  " UPDATE Animals Set PublishForSale = False  where ID = " & animalId & ";" 
        connLOA.Execute(Query) 
    end if
    rsa.movenext
    wend
end if



end if
rsa.close




sqla = "select count(*) as numPublishedStuds  from animals where Publishstud = 1 and PeopleID = " & tempPeopleID 
'response.write("sqla=" & sqla )
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedStuds = cint(rsa("numPublishedStuds"))  
'response.write("numPublishedAnimals=" & numPublishedAnimals )
end if
rsa.close

sqla = "select animals.id from animals, Pricing where animals.id = Pricing.id and PublishStud = 1 and PeopleID = " & tempPeopleID & " Order by Price desc"
'response.write("sqla=" & sqla )
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then

if accesslevel < 1 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
Query =  " UPDATE Animals Set PublishStud = False where ID = " & animalId & ";" 
connLOA.Execute(Query) 
rsa.movenext
wend
end if



if numPublishedStuds > 5 and Subscriptionlevel < 4 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
if i > 1 then
Query =  " UPDATE Animals Set PublishStud = False where ID = " & animalId & ";" 
connLOA.Execute(Query) 
end if
rsa.movenext
wend
end if
end if
rsa.close





'rsb.movenext
'wend
end if
if rsb.state = 0 then
else
rsb.close
end if




if rsa.state = 0 then
else
rsa.close
end if
sqla = "select count(*) as numPublishedAnimals from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID 
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))   
if numPublishedAnimals > 5 and Subscriptionlevel < 4 then
i=0
while not rsa.eof
i = i +1
animalId = rsa("id")
if i > 5 then
Query =  " UPDATE Animals Set PublishForSale = 0  where ID = " & animalId & ";" 
connLOA.Execute(Query) 
end if
rsa.movenext
wend
end if
end if
rsa.close
'rsb.movenext
'wend
end if
tempPeopleID = PeopleID
if tempPeopleID = 1802 then
sqla = "select count(*) as numPublishedAnimals from animals, Pricing where animals.id = Pricing.id and PublishForSale = 1 and PeopleID = " & tempPeopleID 
If not rsa.eof then
numPublishedAnimals = cint(rsa("numPublishedAnimals"))
End if
rsa.close
sqla = "select count(*) as numPublishedproducts from sfproducts where ProdForSale = 1 and PeopleID = " & tempPeopleID & " Order by ProdPrice desc"
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numPublishedproducts = cint(rsa("numPublishedproducts"))
end if
rsa.close
end if

sqla = "select count(*) as numAlpacas from animals where speciesID = 2 and PeopleID = " & tempPeopleID
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
numAlpacas = rsa("numAlpacas")
End if
rsa.close

if rsb.state = 0 then
else
rsb.close
end if

sqla = "select distinct speciesID from animals where PeopleID = " & tempPeopleID
rsa.Open sqla, connLOA, 3, 3
If not rsa.eof then
while not rsa.eof
tempspeciesid = rsa("speciesid")


sqlb = "select * from ranchspecieslookuptable where speciesiD = " & tempspeciesID & " and PeopleID = " & tempPeopleID
'response.write("sqlb=" & sqlb)
rsb.Open sqlb, connLOA, 3, 3
If rsb.eof then
Query =  " insert into ranchspecieslookuptable (peopleid, speciesid) values (" & temppeopleid & "," & tempspeciesID & ")" 
connLOA.Execute(Query) 
'response.write("Query = " & Query & "<br>")
end if
rsb.close

rsa.movenext
wend
end if
End if
rsa.close


sqlb = "select SubscriptionLevel, custAIEndService, Preferedspecies from People where PeopleID = " & PeopleID
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then
SubscriptionLevel = rsb("SubscriptionLevel")
custAIEndService  = rsb("custAIEndService")
Preferedspecies = rsb("Preferedspecies")
end if
rsb.close

Sitenamelong = "Livestock Of The World"
%>
<title><%=Sitenamelong %> Members Area</title>
<meta name="Title" content="<%=Sitenamelong %> Members Area"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="nofollow"/>
