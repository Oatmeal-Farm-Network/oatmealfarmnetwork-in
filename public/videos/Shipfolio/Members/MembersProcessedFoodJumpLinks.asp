 
 <% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
ProduceID = request.QueryString("ProduceID")
'response.write("ProduceID!!=" & ProduceID )

'if len(ProduceID) < 1 then
'ProduceID = Request.Form("ProduceID")
'end if
'ID = Request.querystring("ID")
'if len(ID) > 0 and len(ProduceID) < 1 then
'    ProduceID = ID
'end if



'if len(ProduceID) > 0 then
'sql2 = "select  Produce.ID, Produce.FullName, NumberofProduce, SpeciesID, Category from Produce where ID = " & ProduceID & " order by trim(Fullname)"
'acounter = 1
'Set rs2 = Server.CreateObject("ADODB.Recordset")
'rs2.Open sql2, conn, 3, 3 
'if not rs2.eof then
'    NumberofProduce = rs2("NumberofProduce")
'    SpeciesID = rs2("SpeciesID")
'    Category = rs2("Category")
'    if len(NumberofProduce) > 0 then
'    else
'    NumberofProduce = 1
'    end if
'if rs.state > 0 then
'     rs.close
'end if



'sql = "select IngedientID, DOBMonth, DOBDay, DOBYear, Temperment, Weight, Height, Gaited, Warmblooded, BreedID, BreedID2, BreedID3, BreedID4, BreedID5, Category, FullName, BreedID, BreedID2, BreedID3, BreedID4, NumberofProduce, Horns, Vaccinations from Produce where ID=" & ProduceID	
'rs.Open sql, conn, 3, 3
'IngedientID= rs("IngedientID")
'DOBMonth = rs("DOBMonth") 
'DOBDay = rs("DOBDay")
'DOBYear= rs("DOBYear")
'Temperment= rs("Temperment") 
'Weight = rs("Weight") 
'Height = rs("Height") 
'Gaited = rs("Gaited") 
'Warmblooded= rs("Warmblooded")
'BreedID= rs("BreedID")
'BreedID2 = rs("BreedID2")
'BreedID3= rs("BreedID3")
'BreedID4 = rs("BreedID4")
'Category = rs("Category")
'Horns = rs("Horns")
'Producename = rs("FullName")

'BreedlookupID  = rs("BreedID")
'BreedlookupID2  = rs("BreedID2")
'BreedlookupID3  = rs("BreedID3")  
'BreedlookupID4  = rs("BreedID4")
'NumberofProduce = rs("NumberofProduce") 
'Vaccinations = rs("Vaccinations")
'if len(NumberofProduce) > 0 then
'else
'NumberofProduce = 1
'end if
'rs.close

'end if




'response.write("len SpeciesID=" & len(SpeciesID) & "!")
if len(SpeciesID) >0 then
else
SpeciesID = 2
SpeciesName="Alpaca" 
end if

if rs.state > 0 then
rs.close
end if

sql = "select * from SpeciesAvailable where SpeciesID=  " & SpeciesID &""
rs.Open sql, conn, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType")
'response.write("SpeciesSalesType=" & SpeciesSalesType )
end if
rs.close

if len(ProduceID) > 0 then
sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where ID=" & ProduceID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO AncestryPercents (ID)" 
Query =  Query & " Values (" &  ProduceID & ")"
Conn.Execute(Query) 
rs.close

sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where ID=" & ProduceID
rs.Open sql, conn, 3, 3
End If 
PercentPeruvian = rs("PercentPeruvian")
PercentAccoyo = rs("PercentAccoyo")
PercentBolivian = rs("PercentBolivian")
PercentChilean = rs("PercentChilean")
PercentUnknownOther = rs("PercentUnknownOther") 

rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where ID=" & ProduceID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Colors (ID)" 
Query =  Query & " Values (" & ProduceID & ")"
Conn.Execute(Query) 
rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where ID=" & ProduceID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
End If 
Color1 = rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")
rs.close

end if
'end if
%>
<br /><br />
<a href = "#Top" class = "body"></a>
<div class="nav " style ="min-height: 40px">

<% if hidelinks =True then
else
%>
  
  <div >
    <a class="jumplinks" href="MembersProducehome.asp?ID=<%=ProduceID %>#top"><img src= "https://www.GlobalLivestockSolutions.com/icons/ArtisanProducerIcon.png" alt = "edit" height ="64" border = "0"></a>
  </div>
    


<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="MembersProducehome.asp?ID=<%=ProduceID %>#top"><br /><b>List</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersProducehome.asp?ID=<%=ProduceID %>#top">List</a>
  </div>
<%end if %>



<% if Current3 = "Add" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProduceAdd1.asp#top"><b>Add</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProduceAdd1.asp#top">Add</a>
  </div>
<%end if %>



<% if len(ProduceID) > 0 and not Current3 = "Delete" then %>

<% if Current3 = "Basics" then %>
 <div class="jumplinkscellCurrent " style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceBasics.asp?ID=<%=ProduceID %>#top"><b>Basics</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceBasics.asp?ID=<%=ProduceID %>#top">Basics</a>
  </div>
<%end if %>

<% if Current3 = "Pricing" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProducePricing.asp?ID=<%=ProduceID%>#top"><b>Pricing</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProducePricing.asp?ID=<%=ProduceID %>#top">Pricing</a>
  </div>
<%end if %>

<% If InStr("2,8,17,49,51,62,63,80,82,90,91,96,98,102,103,107,117", category) > 0 Then %>
    <% if Current3 = "Breedings" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersFemaleDataFrame.asp?ID=<%=ProduceID %>#top"><b>Breedings</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersFemaleDataFrame.asp?ID=<%=ProduceID %>#top">Breedings</a>
  </div>
<%end if %>
<% end if %>

<% if Current3 = "Description" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceDescription.asp?ID=<%=IDProduceID %>#top"><b>Description</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceDescription.asp?ID=<%=ProduceID %>#top">Description</a>
  </div>
<%end if %>

<% if (not speciesID = 33) and NumberofProduce < 2 then %>
<% if Current3 = "Awards" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceAwards.asp?ID=<%=ProduceID %>#top"><b>Awards</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceAwards.asp?ID=<%=ProduceID %>#top">Awards</a>
  </div>
<%end if %>
<%end if %>



<% if speciesID = 2 or speciesID = 4 or speciesID = 6 or speciesID = 10 or speciesID = 11 and  NumberofProduce = 1 then %>

<% if Current3 = "Fiber" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceFiber.asp?ID=<%=ProduceID %>#top"><b>Fiber</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceFiber.asp?ID=<%=ProduceID %>#top">Fiber</a>
  </div>
<%end if %>

  <% showEPDs=false
  if showEPDs = True then %>
    <% if Current3 = "EPDs" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersAlpacaEPDFrame?ID=<%=ProduceID %>#top"><b>EPDs</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersAlpacaEPDFrame?ID=<%=ProduceID %>#top">EPDs</a>
  </div>
<%end if %>

<% end if %>
<% end if %>

<% if (not speciesID = 33) and NumberofProduce < 2  then %>
<% if Current3 = "Ancestry" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceAncestry.asp?ID=<%=ProduceID %>#top"><b>Ancestry</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersEditProduceAncestry.asp?ID=<%=ProduceID %>#top">Ancestry</a>
  </div>
<%end if %>
<% end if %>

<% if Current3 = "Photos" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="membersPhotos.asp?ID=<%=ProduceID %>#top"><b>Photos</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="membersPhotos.asp?ID=<%=ProduceID %>#top">Photos</a>
  </div>
<%end if %>

<% end if %>

<% if Current3 = "Statistics" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProduceStats.asp?ID=<%=ProduceID %>#top"><b>Statistics</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProduceStats.asp?ID=<%=ProduceID %>#top">Statistics</a>
  </div>
<%end if %>


<% if Current3 = "Delete" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="membersDeleteProduce.asp?ID=<%=ProduceID %>#top"><b>Delete</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="membersDeleteProduce.asp?ID=<%=ProduceID %>#top">Delete</a>
  </div>
<%end if %>

<% if Current3 = "Transfer" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersTransferProduce.asp#top"><b>Transfer</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersTransferProduce.asp#top">Transfer</a>
  </div>
<%end if %>


<%end if %>

</div>
<span class="border-bottom-3"></span>
<% Producename= Replace(Producename, "''", "'")    %>


<table width = "100%" class="body" ><tr><td class = "body"><h3><% =Producename %></h3></td></tr></table>

<% if (len(Producename) > 1) and (not Current3 = "Summary") and (not Current3 = "Delete")  and (not Current3 = "Statistics") and (not Current3 = "AddProduce") then 

    %>

<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item roundedtopandbottom" src="MembersProducePublishFrame.asp?ID=<%=ProduceID %>&NumberofProduce=<%=NumberofProduce %>" height = 110 width= 100%" scrolling="no" style="background-color:white"></iframe>
</div>
<% else %>

<% end if %>