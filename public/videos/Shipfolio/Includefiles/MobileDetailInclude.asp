 <a name = "Results"></a>
 <% 
'**********************************************************
' SHOW SEARCH RESULTS
'**********************************************************

datafound = False
target = request.querystring("target")
if len(Target) > 0 then datafound = True
layout = request.querystring("layout")
if len(layout) > 0 then datafound = True
if not len(layout) > 0 then layount=1 
if Sortby= "Name" then Sortby = " Animals.FullName "
if Sortby= "Age" then Sortby = " cint(DOBYear)"
'if len(Sortbysearch) > 2 then Sortbysearch = " Order by " & Sortbysearch

if speciesid = 25 then
sql= " SELECT count(*)  as recordcount"
sql= sql & " FROM Animals, Pricing,  Ancestrypercents, Photos, colors , address, People "
sql= sql & " WHERE animals.speciesID = " & speciesID & " and animals.PeopleID = People.PeopleID  and People.AddressID = address.AddressID And pricing.id=Animals.id and Ancestrypercents.id=Animals.id And Photos.id=Animals.id  and Colors.id=Animals.id and subscriptionlevel > 0 and PublishForSale = 1 and people.country_id = " & country_id  & Categorysearch & Breedsearch & Colorsearch &  OBOSearch & currentmaxpriceSearch & currentminpriceSearch &  QAncestry & QPercentAccoyo & CategorySearch & Statesearch  

else
sql= " SELECT count(*)  as recordcount"
sql= sql & " FROM Animals, Pricing,  Ancestrypercents, Photos, colors , address, People, SpeciesBreedLookupTable "
sql= sql & " WHERE animals.speciesID = " & speciesID & " and animals.PeopleID = People.PeopleID  and  animals.BreedID = SpeciesBreedLookupTable.BreedLookupID and People.AddressID = address.AddressID And pricing.id=Animals.id and Ancestrypercents.id=Animals.id And Photos.id=Animals.id  and Colors.id=Animals.id and subscriptionlevel > 0 and PublishForSale = 1 and people.country_id = " & country_id & Categorysearch & Breedsearch & Colorsearch &  OBOSearch & currentmaxpriceSearch & currentminpriceSearch &  QAncestry & QPercentAccoyo & CategorySearch & Statesearch  
end if

if rs.state = 1 then
rs.close
end if

rs.Open sql, conn, 3, 3
'count = 0
'while not rs.eof
count = rs("recordcount")
'rs.movenext'
'wend
rs.close

'if count  = 0 then
'else
'count = count 
'end if

pagescount = clng(count)/10
'if len(pagescount) = 1 then
'addpage = -1
'else
'addpage = 0
'end if
totalpages = int(pagescount) + 1


if len(pagenumber) > 0 then
else
pagenumber = 1
end if

CurrentPageNumber = pagenumber

perpagecount = 10
'perpagecount = 25


if pagenumber = 1 then
startlimit = 0
else
startlimit = ((pagenumber-1) * perpagecount)
end if

endlimit = startlimit + perpagecount
limit = " RowNumber between  " & startlimit & " and " & (startlimit + 10)
 if count = 0 or count > 1 then
'if pagenumber = 1 then
 '  adstart = 1
 '  adend = 10
'end if

'if pagenumber > 1 then
 '  adstart = (pagenumber -1) * 10
 '  adend = adstart + 9
 '  if adend > count then
 '  adend = count
 '  end if
'end if

Sortby1 = Sortby
if trim(Sortby)= "Animals.FullName" then Sortby = "Name"
if trim(Sortby)= "cint(DOBYear)" then Sortby = "Age"



if sortby = "Color1" then
sortby = "Color"
End if

if len(sortby) > 3 then
else
sortby = "Most Current"
End if %>
<table cellpadding = 0 cellspacing = 0 border = 0 align = "right">
<tr><td class = 'body'><%= adstart %> - <%= adend %> Listings of <%=count %>&nbsp; </td>
<% if cint(Currentpagenumber) < cint(totalpages) and cint(totalpages) > 1  then %>
<td class = "Pagebox" width = "12"><a href = "default.asp?pagenumber=<%=pagenumber + 1 %>&<%=searchvariables %>" class = "NumLinks"><b>></b></a></td>
<% end if %>
<td width = 20></td>
</tr></table>
<% else %>
<div align = Right><%=count %> Result<br></div>
<% end if %>
<br><br />
<%
if speciesid = 25 then
sql= "WITH OrderedList AS"
sql= sql & "( "
sql= sql & " SELECT distinct animals.*, Pricing.Forsale, Pricing.studfee, pricing.price, pricing.pricecomments, pricing.obo, pricing.free, pricing.discount, sold, SalePending,"
sql= sql & " colors.color1, colors.color2, colors.color3, colors.color4, colors.color5, Photos.Photo1, Photos.Photo2,"
sql= sql & " address.*, people.Subscriptionlevel, people.businessID, "
sql= sql & " ROW_NUMBER() OVER (" & Sortbysearch & " ) AS 'RowNumber' "
sql= sql & " FROM Animals, Pricing,  Ancestrypercents, Photos, colors , address, People "
sql= sql & " WHERE animals.speciesID = " & speciesID & " and animals.PeopleID = People.PeopleID and People.AddressID = address.AddressID And pricing.id=Animals.id and Ancestrypercents.id=Animals.id And Photos.id=Animals.id  and Colors.id=Animals.id and subscriptionlevel > 0 and PublishForSale = 1 and people.country_id = " & country_id &  Categorysearch & Breedsearch & Colorsearch &  OBOSearch & currentmaxpriceSearch & currentminpriceSearch &  QAncestry & QPercentAccoyo & CategorySearch & Statesearch  
sql= sql & " ) "
sql= sql & " SELECT * "
sql= sql & " FROM OrderedList "
sql= sql & " WHERE RowNumber BETWEEN " & adstart & " AND " & adend & " " &  Sortbysearch & ";"
else
sql= "WITH OrderedList AS"
sql= sql & "( "
sql= sql & "   SELECT distinct animals.*, Pricing.Forsale, Pricing.studfee, pricing.price, pricing.pricecomments, pricing.obo, pricing.free, pricing.discount, sold, SalePending,    colors.color1, colors.color2, colors.color3, colors.color4, colors.color5, Photos.Photo1, Photos.Photo2,"
sql= sql & " SpeciesBreedLookupTable.Breed as animalbreed, address.*, people.Subscriptionlevel, people.businessID, "
sql= sql & " ROW_NUMBER() OVER (" & Sortbysearch & " ) AS 'RowNumber' "
sql= sql & " FROM Animals, Pricing,  Ancestrypercents, Photos, colors , address, People, SpeciesBreedLookupTable "
sql= sql & " WHERE animals.speciesID = " & speciesID & " and animals.PeopleID = People.PeopleID  and  animals.BreedID = SpeciesBreedLookupTable.BreedLookupID and People.AddressID = address.AddressID And pricing.id=Animals.id and Ancestrypercents.id=Animals.id And Photos.id=Animals.id  and Colors.id=Animals.id and subscriptionlevel > 0 and PublishForSale = 1 and people.country_id = " & country_id & Categorysearch & Breedsearch & Colorsearch &  OBOSearch & currentmaxpriceSearch & currentminpriceSearch &  QAncestry & QPercentAccoyo & CategorySearch & Statesearch  
sql= sql & " ) "
sql= sql & " SELECT * "
sql= sql & " FROM OrderedList "
sql= sql & " WHERE RowNumber BETWEEN " & adstart & " AND " & adend & " " &  Sortbysearch & ";"
end if
'response.write("sql=" & sql)

rs.Open sql, conn, 3, 3   
if rs.eof then %>
<H1><div align = "left"><%=  SaleCategory %></div></H1>
<b>There currently are no <%=CurrentSpecies2 %> that fit that criteria. Please try a different search.</b>
<br><br>
<%else%>
<% DOBMonth =  rs("DobMonth")
if len(DOBMonth) > 0 then
if DOBMonth =  0 then
DOBMonth = ""
end if
end if

DOBDay =  rs("DobDay")
if len(DOBDay) > 0 then
if DOBDay =  0 then
DOBDay = ""
end if
end if

DOBYear =  rs("DobYear")
if len(DOBYear) > 0 then
if DOBMYear =  0 then
DOBYear = ""
end if
end if

DOB = DobMonth & "/" & DOBDay & "/" & Dobyear

' response.write("DOB=" & DOB)
if len(DOB) > 6 then
datemonths = DateDiff("m", DOB, Now())
else
datemonths = 0
end if

Set rsh = Server.CreateObject("ADODB.Recordset")

w = 0
oldanimalid= "0"
newanimalid = "0"
While Not rs.eof and w < 11
w = w+ 1
if len(newanimalid) > 0 then
oldanimalid = newanimalid
end if

counter = counter +1	
newanimalid= rs("id")
if newanimalid = oldanimalid then
'response.write("newanimalid=" & newanimalid )
else

BreedID = rs("BreedID")
BreedID2 = rs("BreedID2")
BreedID3 = rs("BreedID3")
BreedID4 = rs("BreedID4")
if len(BreedID) > 0 then
BreedID = cLng(rs("BreedID"))
end if
if len(BreedID2) > 0 then
BreedID2 = cLng(rs("BreedID2"))
end if
if len(BreedID3) > 0 then
BreedID3 = cLng(rs("BreedID3"))
end if
if len(BreedID4) > 0 then
BreedID4 = cLng(rs("BreedID4"))
end if

Set rsd = Server.CreateObject("ADODB.Recordset")			
for x=1 to 1
   DueDate	= ""
	BredTo	= ""
if DetailType = "Dam" then
	sqld = "SELECT * FROM Femaledata WHERE ID = " & newanimalid 
    rsd.Open sqld, conn, 3, 3   
    if not rsd.eof then
				ExternalStudID	= rsd("ExternalStudID")
				ServiceSireID	= rsd("ServiceSireID")
				DueDate = rsd("DueDate")
				Bred = rsd("Bred")
	end if
end if
 if rs.eof then
	exit for
 end if 
 

AnimalID = rs("ID")
alpacasPrice= rs("Price")
Discount= rs("Discount")
CurrentPeopleID = rs("PeopleID")
sql = "select HerdDiscount from brokeringranches where peopleID = "  &  currentpeopleid
rsh.Open sql, conn, 3, 3
if not rsh.eof then
HerdDiscount = rsh("HerdDiscount")
end if
rsh.close

Discount= rs("Discount")
if len(Discount) > 1 then
else
Discount = HerdDiscount
end if

studFee = rs("StudFee")
PublishStud =rs("PublishStud")

photoID = trim(rs("Photo1"))
if len(photoID) > 3 then
else
photoID = trim(rs("Photo2"))
end if
 
if trim(lcase(photoID))= "https://www.livestockofamerica.com/uploads/"  then
	photoID = "http://www.livestockoftheworld.com/uploads/ImageNotAvailable.jpg"
end if

if Len(photoID) > 1 then
Else
	photoID = "https://www.livestockoftheworld.com/uploads/ImageNotAvailable.jpg"
end if

if len(photoID) = 135 then
photoID = "https://www.livestockoftheworld.com/images/ImageNotAvailable.jpg"
end if 

if len(photoID) < 50 then
photoID = "https://www.livestockoftheworld.com/" & photoID
end if 
str1 = lcase(photoID)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
	photoID= Replace(str1, str2 , "livestockoftheworld.com")
End If  

str1 = lcase(photoID)
str2 = "http:"
If InStr(str1,str2) > 0 Then
	photoID= Replace(str1, str2 , "https:")
End If  



Category = rs("Category")

 FullName = Trim(rs("FullName"))
str1 = FullName
str2 = "''"
If InStr(str1,str2) > 0 Then
	FullName= Replace(str1, str2 , "'")
End If  

if len(FullName) > 1 then
For loopi=1 to Len(FullName)
    spec = Mid(FullName, loopi, 1)
    specchar = ASC(spec)
    
    if specchar < 32 or specchar > 126 then
    	FullName= Replace(FullName,  spec, " ")
   end if
 
  
 Next
end if

if SpeciesID = 4 then 
breedtitle = "Type"
 else 
breedtitle = "Breed"
 end if 
Set rsb = Server.CreateObject("ADODB.Recordset")
if len(BreedID)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = trim(rsb("Breed"))
end if
rsb.close
end if

if len(BreedID2)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID2
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed2 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if

if len(BreedID3)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID3
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed3 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if

if len(BreedID4)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID4
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed4 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if

Color1 =rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")

if len(Color1) < 1 then
  Color1 = ""
end if
if len(Color2) < 1 then
  Color2 = ""
end if
if len(Color3) < 1 then
  Color3 = ""
end if
if len(Color4) < 1 then
  Color4 = ""
end if
if len(Color5) < 1 then
  Color5 = ""
end if														

DOBDay=rs("DOBDay")
if len(DOBDay)> 0 then
	DOBDay = cint(DOBDAY)
else
	'DOBDay  = 0
end if

DOBMonth=rs("DOBMonth")
if len(DOBMonth)> 0 then
	DOBMonth = cint(DOBMonth)
else
	'DOBMonth  = 0
end if
										
DOBYear=rs("DOBYear") 
if len(DOBYear)> 0 then
	DOBYear = cint(DOBYear)
else
	'DOBYear  = 0
end if

DOB = DOBMonth & "/" & DOBDay & "/" & DOBYear


NumberofAnimals =  rs("NumberofAnimals")
if len(NumberofAnimals) < 1 then NumberofAnimals = 1



sql2 = "select SpeciesCategory, SpeciesCategoryPlural from SpeciesCategory where SpeciesID=" & SpeciesID 
'response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
if NumberofAnimals ="1" then
Category = rs2("SpeciesCategory")


else
Category = rs2("SpeciesCategoryPlural")
end if
end if
rs2.close
%>
<div class="container-fluid" align = "center" >

    <div class = "row" align = "center">
        <div class = "col-12 body" style="background-color: #78502e; min-height: 40px;"  >
               <img src ="https://www.livestockofamerica.com/images/px.gif" height="1px" width ="100%" />
           <a href = "/animals/Details.asp?ID=<%=AnimalID%>" class = "AnimalListname" ><%=FullName %></a>
        </div>
    </div>
    <div class = "row nowrap" align = "center" style="background-color: #f9f6ee">
        <div class = "col-12 " >
           <a href = "/Animals/Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>" >
           <center><img src = "<%= PhotoID %>" width ="90%" alt = "Image" style="border:1px solid black;" align="center" ></center></a>
        </div>
</div>
<div class = "row" style="background-color: #f9f6ee">
        <div class = "col-6 body" border = 0 style="min-height:250px; max-height: 250px;">  
        <br />
<% Price = trim(rs("price"))
Discount = trim(rs("Discount"))
If Len(price) > 2 and Len(Discount) < 2 Then %>
Price <b><%=(FormatCurrency(price,0))%></b>
<% End If %>
<% If Len(price) < 2 and Len(Discount) < 2 Then %>
<b>Call For Price</b>
<% End If %>

<% If Len(Discount) > 1 and Len(Price) > 1 Then %>
Price <strike><%=(FormatCurrency(price,0))%></strike><b> <%=formatcurrency(Price * ((100-Discount)/100), 0)%></b>
<% end if 

If rs("Sold") = true Then %>
<b>Sold!</b>
<%End If %>
<% If rs("SalePending")  = true Then %>
<b>Sale Pending</b>
<%End If %>

<% if len(PriceComments) > 3 then
    if len(PriceComments) > 200 then %>
     <b><%=left(PriceComments, 200)%>...</b>
     <% else %>
     <b><%=PriceComments%></b>
     <% end if %>
<% End if%>
<br />
# animals <%=NumberofAnimals %>
<br>
<% 
if Category = "Experienced Male" or Category = "Experienced Males" or Category = "Inexperienced Male"  or Category = "Inexperienced Males" then
if PublishStud =1 and len(studFee) > 1 then %>
<font size = "3"><b><%=(FormatCurrency(Studfee,0))%> Stud Fee</font></b><br><br />
<% else %>
<font size = "3"><b>Call For Stud Fee</font></b><br>
<% End If
end if%>
<br />
<b>Sold By</b></br/>
<% BusinessID = rs("BusinessID")
if len(BusinessID) > 0 then
if rs2.state = 1 then
 rs2.close
end if
sql2 = "select  BusinessName from Business where BusinessID= " & BusinessID
rs2.Open sql2, conn, 3, 3

If not rs2.eof then
BusinessName = rs2("BusinessName")
end if 
rs2.close
end if

BusinessName = trim(CStr(BusinessName))
if len(BusinessName) > 1 then
For loopi=1 to Len(BusinessName)
    spec = Mid(BusinessName, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	BusinessName= Replace(BusinessName,  spec, " ")
   end if
 Next
end if 

if len(BusinessName) > 0 then %>
  <a href="/Ranches/FarmListing.asp?PeopleID=<%=CurrentPeopleID %>"><b><%=trim(BusinessName) %></b></a><br />
<% end if %>
<% Addresscity =trim(rs("addressCity")) 
Addressstate = trim(rs("addressstate"))
if len(Addresscity) > 0 or len(Addressstate) then %>
<% if len(Addresscity) > 0 then%>
<%=trim(addresscity) %>
<% end if %>
<% if len(AddressState) > 0 then %>
<% if len(Addresscity) > 0 then %>,&nbsp;<% end if %>
<%=trim(addressState) %>
<% end if %>
<% end if %>
<br />
<% if len(GGWebsite) > 5 then %>
<br />
<a href = "<%=GGWebsite %>" target = "_blank" class = "body">View Ranch Website</a><br />
<% end if %>

        </div>
        <div class = "col-6 body">  


<% if len(category) > 2 then %>
<br/>Gender Category <br/>
<% end if %>

<% if len(BreedID)> 0 or len(BreedID2)> 0 or len(BreedID3)> 0 or len(BreedID4)> 0 then 
if BreedID> 0 or BreedID2> 0 or BreedID3 > 0 or BreedID4 > 0 then%>

<br/>Breed 
<% showlinks =true
if showlinks = true then  %>
<a href = "http://www.livestockoftheworld.com/<%=pluralanimal%>/breeds.asp?BreedLookupID=<%=BreedID%>&SpeciesID=<%=SpeciesID  %>" class = "body" target = "_blank" ><%=Currentbreed%></a>

<% if len(BreedID2) > 0 and not(BreedID = BreedID2) and BreedID2>0 then %>,
<a href = "http://www.livestockoftheworld.com/<%=pluralanimal%>/breeds.asp?BreedLookupID=<%=BreedID2%>&SpeciesID=<%=SpeciesID  %>" class = "body" target = "_blank"><%=Currentbreed2%></a>
<% end if %>

<% if len(BreedID3) > 0  and not(BreedID = BreedID3) and BreedID3>0 then %>, <a href = "http://www.livestockoftheworld.com/<%=pluralanimal%>/breeds.asp?BreedLookupID=<%=BreedID3%>&SpeciesID=<%=SpeciesID  %>" class = "body" target = "_blank"><%=Currentbreed3%></a>
<% end if %>

<% if len(BreedID4) > 0  and not(BreedID = BreedID4) and BreedID4>0 then %>, <a href = "http://www.livestockoftheworld.com/<%=pluralanimal%>/breeds.asp?BreedLookupID=<%=BreedID4%>&SpeciesID=<%=SpeciesID  %>" class = "body" target = "_blank"><%=Currentbreed4%></a>
<% end if %><br />

<% else %>
<%=Currentbreed%>
<% if len(BreedID2) > 0 and not(BreedID = BreedID2) and BreedID2>0 then %>,
<%=Currentbreed2%></a><% end if %>
<% if len(BreedID3) > 0  and not(BreedID = BreedID3) and BreedID3>0 then %>, <%=Currentbreed3%><% end if %>
<% if len(BreedID4) > 0  and not(BreedID = BreedID4) and BreedID4>0 then %>, <%=Currentbreed4%><% end if %> 
<br>
<% end if 
end if
end if 
%>




<%If len(Color1) > 1 or len(Color2) > 1 or len(Color3) > 1 or len(Color4) > 1 or len(Color5) > 1 Then %>
<% If len(Color1) > 1 Then %>
<%=Color1%>
<% end If %>
<% If Len(Color2) > 1 Then %>
/<%=Color2%>
<% end If %>
<% If Len(Color3) > 1 Then %>
/<%=Color3%>
<% end If %>
<% If Len(Color4) > 1 Then %>
/<%=Color4%>
<% end If %>
<% If Len(Color5) > 1 Then %>
/<%=Color5 %>
<% end If %>
<br />
<% end If %>

<% if len(DOB) > 6 then %>
DOB <%=DOB %><br />
<%end if %>

<% ID = AnimalID %>
<!--#Include virtual="/includefiles/AlpacaEPDFindPercentsInclude.asp"-->
<% if Show1percentemblem = True then %>
<b><font color = "#404040" >Top 1% EPDs!</font></b><br />
<% end if %>

   <form NAME="Details" ACTION="/Animals/Details.asp?ID=<%=AnimalID%>&viewstud=True" METHOD="POST">	
      <input type = "submit" value="Details" class = "regsubmit2" />&nbsp; &nbsp; &nbsp;
   </form>

       </div>
    </div>
</div>




<% 

oldanimalid= rs("ID")
rs.movenext
next end if 
Wend %>

<% end if %>

<% showpagenumbers = True
if showpagenumbers then
 
 if totalpages > 1 then


%>

 <table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top" style="background-color: #f9f6ee">
<tr><td class = "NumLinks" valign = "top" align = "right">
<table><tr>
<td align = left>
<% if cint(Currentpagenumber) > 1 and cint(totalpages) > 3 then %>
<td class = "Pagebox" width = "12"><a href = "default.asp?pagenumber=<%=pagenumber - 1 %>&<%=searchvariables %>" class = "NumLinks"><b><</b></a></td>
<% end if %>

<% 
'************************************************
' If Less then 11 pages
'************************************************

endnum = 10


if totalpages < (endnum + 1) then %>
<td>
<% for pagenumber = 1 to totalpages %>

<% if cint(pagenumber) = cint(currentpagenumber) then %>
 <td class = "PageboxCurrent" width = "36">
 <a href = "default.asp?pagenumber=<%=pagenumber %>&<%=searchvariables %>" class = "NumLinksCurrent"><b><center><%=pagenumber %></center></b></a></td>
 <% else %>
<td class = "Pagebox" width = "18">
<a href = "default.asp?pagenumber=<%=pagenumber %>&<%=searchvariables %>" class = "NumLinks"><b><center><%=pagenumber %></center></b></a></td>
<% end if %>



<% next %>
</td>

<% else %>

<% if Currentpagenumber < (endnum + 1) then 
    start = 1
   else
    start = Currentpagenumber - 5
   end if
%>
<% for pagenumber = Start to (Start + endnum) %>

<% if cint(pagenumber) = cint(currentpagenumber) then %>
 <td class = "PageboxCurrent" width = "12">
 <a href = "default.asp?pagenumber=<%=pagenumber %>&<%=searchvariables %>" class = "NumLinksCurrent"><b><%=pagenumber %></b></a></td>
 <% else %>
 <% if pagenumber> 0 then %>
<td class = "Pagebox" width = "12">
<a href = "default.asp?pagenumber=<%=pagenumber %>&<%=searchvariables %>" class = "NumLinks"><b><%=pagenumber %></b></a></td>
<% end if %>
<% end if %>



<% next %>

<% end if %>
<% if cint(Currentpagenumber) < cint(totalpages) and cint(totalpages) > 3 and (not cint(totalpages) < 11) then %>
<td class = "Pagebox" width = "12"><a href = "default.asp?pagenumber=<%=pagenumber + 1 %>&<%=searchvariables %>" class = "NumLinks"><b>></b></a></td>
<% end if %>
<td width = 20></td>

</tr>
</table>

<% end if %>
<% end if %>
<br /><br /><br />
</td></tr></table>
