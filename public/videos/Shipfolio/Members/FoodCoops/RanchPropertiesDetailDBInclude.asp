<% 	propID= Request.QueryString("propID") 
dim buttonimages(20)
dim buttontitle(20)
Set rsA = Server.CreateObject("ADODB.Recordset")
sql = "select * from Properties, PropertyPhotos where PropertyPhotos.propid = Properties.Propid and Properties.PropID=" & PropID & ""
rsA.Open sql, conn, 3, 3 
Description = rsA("PropDescription")
str1 = Description
str2 = vblf
If InStr(str1,str2) > 0 Then
Description= Replace(str1, str2 , "</br>")
End If  
str1 = Description
str2 = vbtab
If InStr(str1,str2) > 0 Then
Description= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
If Len(rsA("PropImage1")) < 2 And Len(rsA("PropImage2"))< 2  And Len(rsA("PropImage3")) < 2  And Len(rsA("PropImage4")) < 2  And Len(rsA("PropImage5")) < 2 And Len(rsA("PropImage6")) < 2  And Len(rsA("PropImage7")) < 2  And Len(rsA("PropImage8")) < 2 then 
click = "<img width=""260"" src=""/Uploads/NotAvailable.jpg""> "
noimage = True
Else 
noimage = false
End If
if not rsA.eof then 
pcounter = 0
counter = 0
counttotal = 8
foundimagecount = 0
While counter < counttotal
counter = counter +1
Photonum = "PropImage" & counter
Captionnum = "PhotoCaption" & counter
image = rsA(Photonum)
If Len(image)> 2 Then
foundimagecount =foundimagecount  + 1
pcounter = pcounter +1
If Len(image) < 30 Then 
buttonimages(pcounter) = "/Uploads/" & image
Else
buttonimages(pcounter) =  image
End If 
buttontitle(pcounter) = Caption
newimage = buttonimages(pcounter)
%>
<script language="JavaScript">
if (document.images) version = "n3";
else version = "n2";
if (version == "n3") {
but<%=pcounter%>on = new Image(85, 115);
but<%=pcounter%>on.src = "<%=newimage %>";
}
function img<%=pcounter%>(imgName) {
if (version == "n3") {
imgOn = eval("but<%=pcounter%>on.src");
document [imgName].src = imgOn;               }       }
</script>
<% 
End if
wend
end if 
sql = "SELECT  * FROM Properties, People, PropertyPhotos WHERE Properties.propID=PropertyPhotos.propID and Properties.peopleID = people.peopleID and Propforsale = true and  Properties.PropID = " & Propid & "  order by PropPrice DESC " 
rs.Open sql, conn, 3, 3   
PropName=rs("PropName" ) 
PropMLS=rs("PropMLS" ) 
propPrice=rs("propPrice" ) 
propTaxes=rs( "propTaxes" ) 
PropSqFeet=rs( "PropSqFeet" ) 
PropAcres=rs( "PropAcres" ) 
PropBedrooms=rs("PropBedrooms")
PropBathrooms=rs("PropBathrooms")
PropFirePlaces=rs("PropFirePlaces") 
PropGarage=rs("PropGarage") 
PropRoof=rs("PropRoof") 
PropDescription=rs("PropDescription") 
PropForSale=rs("PropForSale") 
PropSold=rs("PropSold") 
PropStreet1=rs("PropStreet1") 
PropStreet2=rs("PropStreet2") 
PropCity=rs("PropCity") 
PropState=rs("PropState") 
PropZip=rs("PropZip") 
propStyle=rs("propStyle") 
PropYearBuilt=rs("PropYearBuilt") 
str1 = PropDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
PropDescription= Replace(str1, str2 , "</br>")
End If  
str1 = PropDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
PropDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
PropOutBuildings = rsA("PropOutBuildings")
str1 = PropOutBuildings
str2 = vblf
If InStr(str1,str2) > 0 Then
PropOutBuildings= Replace(str1, str2 , "</br>")
End If  
str1 = PropOutBuildings
str2 = vbtab
If InStr(str1,str2) > 0 Then
PropOutBuildings= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  

BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName	= rs("PeopleLastName")
PeoplePhone = rs("PeoplePhone")
PeopleFax = rs("PeopleFax")
PeopleCell = rs("PeopleCell")
Weblink = rs("Weblink")
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("default.asp")
end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
Addresscountry = rs("AddressCountry")
Addresszip = rs("AddressZip")

end if 
rs.close

%>