<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange Inc.">
    <title>Harvest Hub</title>
<!--#Include virtual="/includefiles/globalvariables.asp"-->

<body >
<% Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Summary"  %> 
<!--#Include virtual="/Header.asp"-->


<!--#Include file="RanchPagesTabsInclude.asp"-->

<div class="container d-none d-lg-block" align = "center" style=" min-height: 70px" >
  <h2>Animals For Sale</h2>
<div class="container roundedtopandbottom">
   
     <%  sql = "select distinct Photo1, Pricing.*, animals.ID, animals.Category, animals.speciesID, "_
              & " speciesCategory.SpeciesCategory , FullName, PublishForSale, PublishStud, "_
              & " speciesavailable.SpeciesPriority from Photos, SpeciesCategory, speciesavailable, Animals, Pricing "_
              &  " where animals.id =photos.id and animals.category = SpeciesCategory.SpeciesCategoryID and animals.speciesID = speciesavailable.SpeciesID "_
              &  " and Animals.ID =Pricing.ID and  PeopleID = " & CurrentPeopleID & " order by SpeciesPriority, FullName "
     'response.write("sql=" & sql)
         
         Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3  
        if rs.eof then %>
            Currently you do not have any animals listed. To add an animal <a href = "MembersAnimalAdd1.asp" >click here</a>.
        <% else    
            rowcount = 1
        %>
  <table width =" 100%" >
      <tr>
        <td class ="text-left body"></td>
        <td class ="text-left body"></td>
           <td class="text-left body d-none d-md-table-cell" ><div align = left>Category</div></td>
        <td class="text-left body" width="125px" style="max-width:125px; min-width:125px"><div align = left>Species</div></td>
        <td class="text-right body" style="text-align:right" >Price (Discount)</td>
      </tr>
     <tr >
	    <td colspan="6" style="background-color: #abacab; min-height: 1px"></td>
      </tr>
      <%
dim PhotoArray(3000) 
dim NameArray(3000) 
dim PriceArray(3000) 
dim ForSaleArray(3000) 
dim SoldArray(3000)
dim ShowOnWebsiteArray(3000) 
dim DiscountArray(3000) 
dim PublishForSaleArray(3000) 
dim PublishStudArray(3000)
dim SpeciesIDArray(3000)
dim CategoryArray(3000)
dim IDArray (30000)
While Not rs.eof  
	IDArray(rowcount) =   rs("ID")
	NameArray(rowcount) =   rs("FullName")

str1 = NameArray(rowcount)
str2 = "''"
If InStr(str1,str2) > 0 Then
NameArray(rowcount)= Replace(str1,  str2, "'")
End If 

    PhotoArray(rowcount) =   rs("Photo1")
    CategoryArray(rowcount) =   rs("SpeciesCategory")
	PriceArray(rowcount) =   rs("Price")
	ForSaleArray(rowcount) =   rs("ForSale")
    SoldArray(rowcount) =   rs("Sold")
	ShowOnWebsiteArray(rowcount) =   rs("ShowOnWebsite")
	DiscountArray(rowcount) =   rs("Discount")
	PublishForSaleArray(rowcount) =   rs("PublishForSale")
	PublishStudArray(rowcount) =   rs("PublishStud")
    SpeciesName = ""
SpeciesIDArray(rowcount) = rs("SpeciesID")
if SpeciesIDArray(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesIDArray(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesIDArray(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesIDArray(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesIDArray(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesIDArray(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesIDArray(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesIDArray(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesIDArray(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesIDArray(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesIDArray(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesIDArray(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesIDArray(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesIDArray(rowcount) = 15 then
SpeciesName="Duck"
end if 

if  SpeciesIDArray(rowcount) = 17 then
SpeciesName="Yak"
end if 

if SpeciesIDArray(rowcount) = 18 then
 SpeciesName="Camels"
end if 

if SpeciesIDArray(rowcount) = 19 then
 SpeciesName="Emus"
end if 

if SpeciesIDArray(rowcount) = 21 then
 SpeciesName="Deer"
end if 

if SpeciesIDArray(rowcount) = 22 then
 SpeciesName="Geese"
end if 

if SpeciesIDArray(rowcount) = 23 then
 SpeciesName="Bees"
end if 

if SpeciesIDArray(rowcount) = 25 then
 SpeciesName="Alligators"
end if 

if SpeciesIDArray(rowcount) = 26 then
 SpeciesName="Guinea Fowl"
end if 

if SpeciesIDArray(rowcount) = 27 then
 SpeciesName="Musk Ox"
end if 

if SpeciesIDArray(rowcount) = 28 then
 SpeciesName="Ostriches"
end if 

if SpeciesIDArray(rowcount) = 29 then
 SpeciesName="Pheasants"
end if 

if SpeciesIDArray(rowcount) = 30 then
 SpeciesName="Pigeons"
end if 

if SpeciesIDArray(rowcount) = 31 then
 SpeciesName="Quails"
end if 

if SpeciesIDArray(rowcount) = 33 then
 SpeciesName="Snails"
end if 

if SpeciesIDArray(rowcount) = 34 then
 SpeciesName="Buffalo"
end if 

if DiscountArray(rowcount) > 0 then
     TempPrice = PriceArray(rowcount)
     TempDiscount = DiscountArray(rowcount)
TempDiscount2 =  TempDiscount / 100


    Tempdiscountprice12 = clng(TempPrice) * TempDiscount2 
else
          Tempdiscountprice12  = 0
end if


%>
      <tr>
      <td >
            <% if not PhotoArray(rowcount) = "0" then %>
            <center><a href="/Ranches/Details.asp?ID=<%= IDArray(rowcount)%>&DetailType=&CurrentPeopleID=<%= CurrentPeopleID%>#top" class = "body"><img src="<%= PhotoArray(rowcount)%>" height ="70" /></center></a>
          <% end if %>
        </td>
        <td >

            <a href="/Ranches/Details.asp?ID=<%= IDArray(rowcount)%>&DetailType=&CurrentPeopleID=<%= CurrentPeopleID%>#top" class = "body"><%= NameArray(rowcount)%> </a>

        </td>
        <td class="body d-none d-md-table-cell" ><div align = left>
         <%=CategoryArray(rowcount) %>
            </div>
        </td>

        <td class="body" >
            <%=SpeciesName %>   
        </td>

        <td class="body" style="text-align:right" >
            <% if len(PriceArray(rowcount)  ) > 1 then %>
            <%= formatcurrency(PriceArray(rowcount),2)%> 
            <% else %>
            Call For Price
            <% end if %>

            <% if len(Tempdiscountprice12  ) > 1 then %>
           &nbsp;(<%= formatcurrency(Tempdiscountprice12 ) %>)
            <% end if %>
        </td>
      </tr>
           <tr >
	    <td colspan="6" style="background-color: #dddddd; min-height: 1px"></td>
      </tr>
<%	rs.movenext
Wend		

end if
rs.close %>
</table>
</div>
</div>
<div class="row">
    <div class ="col">
        <br />
    </div>
</div>

<!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>