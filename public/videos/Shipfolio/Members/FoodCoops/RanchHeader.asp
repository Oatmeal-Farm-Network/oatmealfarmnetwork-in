<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<!--    Begin
    function NewWindow(mypage, myname, w, h, scroll) {
        var winl = (screen.width - w) / 2;
        var wint = (screen.height - h) / 2;
        winprops = 'height=' + h + ',width=' + w + ',top=' + wint + ',left=' + winl + ',scrollbars=' + scroll + ',resizable'
        win = window.open(mypage, myname, winprops)
        if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
    }
//  End -->
</script>

<script type="text/javascript"><!--    //--><![CDATA[//><!--

    sfHover = function () {
        var sfEls = document.getElementById("nav").getElementsByTagName("LI");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += " sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp(" sfhover\\b"), "");
            }
        }
    }
    if (window.attachEvent) window.attachEvent("onload", sfHover);

    //--><!]]></script>

<%
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3 
if not rs.eof then
      
Header = rs("Header")
logo = rs("Logo")
   
MenuBackgroundColor = rs("MenuBackgroundColor")
PageBackgroundColor = rs("PageBackgroundColor")
FooterBackgroundColor = rs("FooterColor")
MenuBackgroundImage = rs("MenuBackgroundImage")
PageBackgroundImage = rs("PageBackgroundImage")
FooterBackgroundImage = rs("FooterImage")

TitleColor = rs("TitleColor")
TitleFont = rs("TitleFont")
TitleSize = rs("TitleSize")
TitleAlign = rs("TitleAlign")
TitleWeight = rs("TitleWeight")
TitleItalics = rs("TitleItalics")

DBMenuColor = rs("MenuColor")
DBMenuFontMouseOverColor = rs("MenuFontMouseOverColor")
DBMenuSize = rs("MenuSize")
DBMenuFont = rs("MenuFont")
DBMenuAlign = rs("MenuAlign")
DBMenuWeight = rs("MenuWeight")
DBMenuItalics = rs("MenuItalics")
DBMenuHyperlinkColor = rs("MenuHyperlinkColor")

DBPageTextColor = rs("PageTextColor")
DBPageTextFontsize = rs("PageTextFontSize")
DBPageTextFont = rs("PageTextFont")
DBPageTextHyperlinkColor = rs("PageTextHyperlinkColor")
DBPageTextMouseOverColor = rs("PageTextMouseOverColor")
DBPageTextAlign = rs("PageTextAlign")
DBPageTextWeight = rs("PageTextWeight")
DBPageTextItalics = rs("PageTextItalics")

DBFooterColor = rs("FooterColor")
DBFooterTextColor = rs("FooterTextColor")
DBFooterTextSize = rs("FooterTextSize")
DBFooterTextFont = rs("FooterTextFont")
DBFooterHyperlinkColor = rs("FooterHyperlinkColor")
DBFooterMouseOverColor = rs("FooterMouseOverColor")
DBFooterAlign = rs("FooterAlign")
DBFooterWeight = rs("FooterWeight")
DBFooterItalics = rs("FooterItalics")
DBFooterImage = rs("FooterImage")

DBH2Color = rs("H2Color")
DBH2size = rs("H2Size")
DBH2Font = rs("H2Font")
DBH2HyperlinkColor = rs("H2HyperlinkColor")
DBH2MouseOverColor = rs("H2MouseOverColor")
DBH2Align = rs("H2Align")
DBH2Weight = rs("H2Weight")
DBH2Italics = rs("H2Italics")

DBH3Color = rs("H3Color")
DBH3size = rs("H3Size")
DBH3Font = rs("H3Font")
DBH3HyperlinkColor = rs("H3HyperlinkColor")
DBH3MouseOverColor = rs("H3MouseOverColor")
DBH3Align = rs("H3Align")
DBH3Weight = rs("H3Weight")
DBH3Italics = rs("H3Italics")

DBH4Color = rs("H4Color")
DBH4size = rs("H4Size")
DBH4Font = rs("H4Font")
DBH4HyperlinkColor = rs("H4HyperlinkColor")
DBH4MouseOverColor = rs("H4MouseOverColor")
DBH4Align = rs("H4Align")
DBH4Weight = rs("H4Weight")
DBH4Italics = rs("H4Italics")
end if

 
if mobiledevice = True or is_iPad = true then 
if screenwidth > 1000 then%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% else %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% end if %>
<%'
menuSize = "12"
menuFont = "Verdana"
menuAlign = "Left"
menuWeight =" Normal"
menucolor= "white"
menuBackgroundImage = ""
menuBackgroundColor = "white"
menuradiusleft  = "3px"
menuradiusright = "3px"
menuradiusleft = "3px"
menuradiusright = "3px"

menumenuColorMouseover= "white"
menumenuColor= "white"
menuShadow = True
menuFontMouseOverColor= "Black"

MenuSize =MenuSize + 22
TitleSize = TitleSize + 10
FooterTextSize = FooterTextSize+ 10
H1Size = H1Size + 10
H2Size = H2Size + 10
H3Size = H3Size + 10
PageTextFontsize = PageTextFontsize + 12
buttonheight = 80
else
buttonheight = 50
end if

rs.close

dim Owners
PropertiesFound = False
if len(CurrentPeopleID) > 0 then
	sql = "select  * from Properties where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
PropertiesFound = True
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 2 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
Showalpacas = True
else
Showalpacas = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 3 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowDogs = True
else
ShowDogs = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 4 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowLlamas = True
else
ShowLlamas = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 5 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowHorses = True
else
ShowHorses = False
end if
rs.close


sql = "select  * from ranchspecieslookuptable where speciesid = 6 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowGoats = True
else
ShowGoats = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 7 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowDonkeys = True
else
ShowDonkeys = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 8 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowCattle = True
else
ShowCattle = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 9 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowBison = True
else
ShowBison = False
end if
rs.close


sql = "select  * from ranchspecieslookuptable where speciesid = 10 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowSheep = True
else
ShowSheep = False
end if
rs.close


sql = "select  * from ranchspecieslookuptable where speciesid = 11 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowRabbits = True
else
ShowRabbits = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 12 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowPigs = True
else
ShowPigs = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 13 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowChickens = True
else
ShowChickens = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 14 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowTurkeys = True
else
ShowTurkeys = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 15 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowDucks = True
else
ShowDucks = False
end if
rs.close


sql = "select  * from ranchspecieslookuptable where speciesid = 17 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowYaks = True
else
ShowYaks = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 18 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowCamels = True
else
ShowCamels = False
end if
rs.close


sql = "select  * from ranchspecieslookuptable where speciesid = 19 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowEmus = True
else
ShowEmus = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 20 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowElk = True
else
ShowElk = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 21 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowDeer = True
else
ShowDeer = False
end if
rs.close

sql = "select  * from ranchspecieslookuptable where speciesid = 22 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
ShowGeese = True
else
ShowGeese = False
end if
rs.close





sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeopleLastName")
RanchHomeText = rs("RanchHomeText")
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
WebsitesID= rs("WebsitesID")
RanchHomeText = rs("RanchHomeText")
Logo = rs("Logo")

str1 = lcase(Logo)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
Header = rs("Header")
str1 = lcase(Header)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Header= Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  


Phone = rs("PeoplePhone")
Cellphone = rs("PeopleCell")
Fax = rs("PeopleFax")
Owners = rs("Owners")
ScreenBackground=rs("ScreenBackground")
if len(trim(Owners)) < 2 then
	Owners = PeopleFirstName & " " & PeopleLastName
end if
screenbackground = rs("screenbackground")

str1 = lcase(screenbackground)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
screenbackground= Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 
rs.close
if len(WebsitesID) > 0 then
 sql = "select distinct * from Websites where WebsitesID = " & WebsitesID
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
PeopleWebsite = rs("Website")
end if
rs.close
end if
if len(BusinessID) > 0 then
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessName = rs("BusinessName")
end if 
rs.close
end if
if len(addressID) > 0 then
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
AddressCountry = rs("AddressCountry")
AddressZip = rs("AddressZip")
end if 
rs.close
end if
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
MenuColor = rs("MenuColor")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
MenuSize = rs("MenuSize")
MenuFont = rs("MenuFont")
MenuAlign = rs("MenuAlign")
MenuWeight = rs("MenuWeight")
MenuItalics = rs("MenuItalics")
MenuHyperlinkColor = rs("MenuHyperlinkColor")
TitleColor = rs("TitleColor")
TitleFont = rs("TitleFont")
TitleSize = rs("TitleSize")
TitleAlign = rs("TitleAlign")
TitleWeight = rs("TitleWeight")
TitleItalics = rs("TitleItalics")
PageBackgroundColor = rs("PageBackgroundColor")
PageTextColor = rs("PageTextColor")
LayoutStyle = rs("LayoutStyle")
PageTextColor = rs("PageTextColor")
PageTextFontsize = rs("PageTextFontSize")
PageTextFont = rs("PageTextFont")
PageTextHyperlinkColor = rs("PageTextHyperlinkColor")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
PageTextAlign = rs("PageTextAlign")
PageTextWeight = rs("PageTextWeight")
PageTextItalics = rs("PageTextItalics")
End If
rs.close 
end if
HEMalesForSaleCount = 0
HIMalesForSaleCount = 0
HEFemalesForSaleCount = 0
HIFemalesForSaleCount = 0
HNBForSaleCount = 0
SEMalesForSaleCount = 0
SIMalesForSaleCount = 0
SEFemalesForSaleCount = 0
SIFemalesForSaleCount = 0
SNBForSaleCount = 0
TotalAllStuds= 0
HTotalStuds = 0
STotalstuds = 0
HEStudsCount = 0
HIStudsCount = 0
SEStudsCount = 0
SIStudsCount = 0

'Alpaca Studs
totalAlpacasStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 2"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 2 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
count= rs("count")
if len(count) > 0 then
totalAlpacasStuds = CLng(count)
end if
end if
rs.close

'Cattle Studs
totalCattleStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 8"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 8 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalCattleStuds = CLng(rs("count"))
end if
rs.close

'Dogs Studs
totalDogsStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 3"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 3 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalDogsStuds = CLng(rs("count"))
end if
rs.close

'Donkeys Studs
totalDonkeysStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 7"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 7 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalDonkeysStuds = CLng(rs("count"))
end if
rs.close

'Goats Studs
totalGoatsStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 6"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 6 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalGoatsStuds = CLng(rs("count"))
end if
rs.close

'Horses Studs
totalHorsesStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 5"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 5 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalHorsesStuds = CLng(rs("count"))
end if
rs.close

'Llamas Studs
totalLlamasStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 4"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 4 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalLlamasStuds = CLng(rs("count"))
end if
rs.close

'Pigs Studs
totalPigsStuds = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and Brokered = 1 and speciesID = 12"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 12 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalPigsStuds = CLng(rs("count"))
end if
rs.close

'Sheep Studs
totalSheepStuds = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishStud = 1 and speciesID = 10 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalSheepStuds = CLng(rs("count"))
end if
rs.close


'Rabbit Studs
totalSheepStuds = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and PublishStud = 1 and speciesID = 11 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalRabbitStuds = CLng(rs("count"))
end if
rs.close



'Yak Studs
totalYaksStuds = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and PublishStud = 1 and speciesID = 17 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
 totalYaksStuds = CLng(rs("count"))
end if
rs.close



'Alpacas
totalAlpacasforSale = 0
if CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and Brokered = 1 and speciesID = 2"
else
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 2 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalAlpacasforSale = CLng(rs("count"))
end if
rs.close

'Dogs
totalDogsforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 3 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalDogsforSale = CLng(rs("count"))
end if
rs.close

'Llamas
totalLlamasforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 4 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalLlamasforSale = CLng(rs("count"))
end if
rs.close

'Horses
totalHorsesforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 5 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalHorsesforSale = CLng(rs("count"))
end if
rs.close

'Goats
totalGoatsforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 6 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalGoatsforSale = CLng(rs("count"))
end if
rs.close

'Donkeys
totalDonkeysforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 7 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalDonkeysforSale = CLng(rs("count"))
end if
rs.close

'Cattle
totalCattleforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 8 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalCattleforSale = CLng(rs("count"))
end if
rs.close

'Bison
totalBisonforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 9 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalBisonforSale = CLng(rs("count"))
end if
rs.close

'Sheep
totalSheepforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 10 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalSheepforSale = CLng(rs("count"))
end if
rs.close

'Rabbits
totalRabbitsforSale= 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 11 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalRabbitsforSale= CLng(rs("count"))
end if
rs.close

'Pigs
totalPigsforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 12 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalPigsforSale= CLng(rs("count"))
end if
rs.close

'Chickens
totalChickensforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 13 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalChickensforSale= CLng(rs("count"))
end if
rs.close

'Turkeys
totalTurkeysforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 14 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalTurkeysforSale= CLng(rs("count"))
end if
rs.close

'Ducks
totalDucksforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 15 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalDucksforSale = rs("count")
end if
rs.close

'Emus
totalEmusforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 19 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalEmusforSale = rs("count")
end if
rs.close

'Yaks
totalYaksforSale = 0
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and  PublishForSale = 1 and speciesID = 17 and PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalYaksforSale = rs("count")
end if
rs.close

totalAlpacas = 0
totalBuffalo = 0
totalCattle = 0
totalChickens = 0
totalDogs = 0
totalDonkeys = 0
totalEmus = 0
totalGoats = 0
totalHorses = 0
totalLlamas =0
totalPigs = 0
totalRabbits = 0
totalTurkeys = 0
totalYaks = 0


totalAlpacas = totalAlpacasforSale + totalAlpacasStuds
totalBuffalo = totalBuffaloforSale + totalBuffaloStuds
totalCattle = totalCattleforSale + totalCattleStuds
totalChickens = totalChickensforSale 
totalDogs = totalDogsforSale + totalDogsStuds
totalDonkeys = totalDonkeysforSale + totalDonkeysStuds
totalEmus = totalEmusforSale 
totalGoats = totalGoatsforSale + totalGoatsStuds
totalHorses = totalHorsesforSale + totalHorsesStuds
totalLlamas = totalLlamasforSale + totalLlamasStuds
totalPigs = totalPigsforSale + totalPigsStuds
totalRabbits = totalRabbitsforSale + totalRabbitsStuds
totalTurkeys = totalTurkeysforSale 
totalYaks = cint(totalYaksforSale) + cint(totalYaksStuds)




'Products
totalProducts = clng(0)
sql = "select Count(*) as count from sfProducts where Publishproduct = 1 and   PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
totalProducts = clng(rs("count"))
end if
rs.close


if len(menuBackgroundColor) > 0 then
else
menuBackgroundColor = "#e6e6e6"
end if

if len(PageBackgroundColor) > 0 then
else
PageBackgroundColor = "white"
end if

totalanimals = cLng(totalAlpacas) + cLng(totalDogs) + cLng(totalLlamas) + cLng(totalHorses) + cLng(totalGoats) + cLng(totalDonkeys) + cLng(totalCattle) + cLng(totalBison) + cLng(totalSheep) + cLng(totalRabbits) + cLng(totalPigs) + cLng(totalChickens) + cLng(totalTurkeys) + cLng(totalDucks)  + cLng(totalEmus)  + cLng(totalYaks)


If CurrentPeopleID = 1016 then
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and sold = 0 and (Category  = 'Experienced Male' or Category  = 'Experienced Males') and PublishStud = 1 and Brokered= 1"
else   
sql = "select Count(*) as count from Animals, Pricing where Animals.ID = Pricing.ID  and sold = 0 and (Category  = 'Experienced Male' or Category  = 'Experienced Males') and PublishStud = 1 and PeopleID= " & CurrentPeopleID
end if
rs.Open sql, conn, 3, 3
If not rs.eof Then
TotalAllStuds = cLng(rs("count"))
end if
rs.close

%>
<style>
H1 {font: <%=TitleSize + 2 %>pt <%=TitleFont %>; color: <%=TitleColor %>; font-weight: <%=TitleWeight %>; align: left}
H2 {font: <%=TitleSize %>pt <%=TitleFont %>; color: <%=TitleColor %>; font-weight: <%=TitleWeight %>; align: left}
H3 {font: <%=TitleSize - 2 %>pt <%=TitleFont %>; color: <%=TitleColor %>; font-weight: <%=TitleWeight %>; align: left}
.body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; color: <%=PageTextColor %>}
A.body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; color:<%=PageTextHyperlinkColor%>}
A.body:hover { color: <%=PageTextMouseOverColor%>}

.menu2 {font-family : <%=TitleFont %>;
	font-size : 11px;
	line-height : 14px;
	color : black;
	font-weight: normal;
}

A.menu2 {font-family : <%=TitleFont %>;
	font-size : 11px;
	line-height : 14px;
	color : <%=TitleColor %>;
	font-weight: 600;
	text-decoration :none;
}
A.menu2:Hover {
	color : #EFAE15;
	text-decoration : none;
}


.tabtopoff
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:2px 2px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #065906 ;
margin:0px;
background:white;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

.tabtopoff2{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:4px 4px; 
box-shadow: 8px 8px 10px #ababab;
background-color: #065906 ;
margin:0px;
background:white;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

.tabtopon2
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:8px 8px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #065906 ;
margin:0px;
background:#065906;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

.tabtopon{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:4px 4px; 
box-shadow: 5px 5px 10px #ababab;
background-color: <%=menuBackgroundColor%>  ;
margin:0px;
background: <%=menuBackgroundColor%> ;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}


</style>
 <%	 if len(ScreenBackground) > 4 then %>
<style>
.RanchScreenbackground{
	background-image : url("<%=ScreenBackground%>");
	background-size: 1900px 900px;
	background-color : #e6e6e6;
	background-repeat : no-repeat;
	background-attachment: scroll;
		background-position:Top;
	background-position:0 0px;
	}	
</style>
<%
 end if
LayoutStyle = "Classic Portrait"			
%>


<style type="text/css"> 


                                           
.roundedtop
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: <%=menuBackgroundColor%> ;
margin:0px;

border-top-left-radius:3px;
border-top-right-radius:3px;
-moz-border-radius-topleft:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:3px; /* Firefox 3.6 and earlier */
}
.roundedBottom
{
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:0px;
 margin-bottom:10px;
 margin-right:0px;
 margin-left:0px;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: <%=PageBackgroundColor%>;
border-bottom-left-radius:3px;
border-bottom-right-radius:3px;
-moz-border-radius-bottomleft:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:3px; /* Firefox 3.6 and earlier */
}


.roundedtopandbottom
{
border-top:1px solid #dddddd;
border-left:1px solid #dddddd;
border-right:1px solid #dddddd;
padding:5px 10px; 
box-shadow: 1px 1px 1px #dddddd;
margin:0px;
background:<%=PageBackgroundColor%>;
background-color: <%=PageBackgroundColor%> ;
border-top-left-radius:3px;
border-top-right-radius:3px;
border-bottom-left-radius:3px;
border-bottom-right-radius:3px;
-moz-border-radius-topleft:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:3px; /* Firefox 3.6 and earlier */
}

</style>





<style> 
.builtby {
font-family: arial,sans-serif;
 color: Black;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby{
font-family: arial,sans-serif;
 color: Black;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby:hover{
 text-decoration: none; 
 color: grey;
}


select {
content: <%=mobiledropdownBackgroundColor%>;
 width:150px;
 border:1px solid <%=mobiledropdownBackgroundColor%>;
 -webkit-border-top-right-radius: 15px;
 -webkit-border-bottom-right-radius: 15px;
 -moz-border-radius-topright: 15px;
 -moz-border-radius-bottomright: 15px;
 border-top-right-radius: 15px;
 border-bottom-right-radius: 15px;
 padding:2px;
}

label.custom-select {
position: relative;

  }

.custom-select select {
display: none;padding: 4px 3px 3px 5px;
margin: 0;
font: inherit;
outline:none; /* remove focus ring from Webkit */
line-height: 1.2;
background: white;
color: #bababa;
border:0;
 }


/* Select arrow styling */
.custom-select:after 
{
content: <%=mobiledropdownBackgroundColor%>;
position: absolute;
top: 0;
right: 0;
bottom: 0;
font-size: 60%;
line-height: 30px;
padding: 0 7px;
background: #000;
color: white;
}

* html #Footer { zoom: 1; } /* IE6 */
* html #mobiledropdown { zoom: 1; } /* IE6 */
*:first-child+html #mobiledropdown { zoom: 1; } /* IE7 */
</style>




<%
'********************************************
' If OVER 800 Pixels wide
'********************************************

if screenwidth > 800 then %>
<!--#Include virtual="/WebHeaderTabs2.asp"-->

<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
<tr bgcolor="white"><td align="center">
<div class="transbox3" >
<table width="<%=screenwidth %>" cellpadding="0" cellspacing="0" border="0"  align="center">
<td align="right"  colspan = 7 >

<a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Home | </a>
<a href="/livestock/default.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Livestock For Sale |</a>
<a href="/Products/default.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Products For Sale |</a>
<a href="/Ranches/default.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Ranch Directory |</a>
<a href="/aboutus.asp?Screenwidth=<%=Screenwidth %>" class="webheader">About Us | </a>
<a href="/Contactus.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Contact Us | </a>

<% if len(Session("PeopleID")) > 1 then %>
<img src="/images/px.gif" alt="Animals for Sale" target="_blank" width=1/><a href="Http://www.LivestockOfTheWorld.com/members/?Screenwidth=<%=Screenwidth %>" class="webheader" >Your Account</a><img src = "/images/px.gif" width = 40 height =1 alt = "Livestock Of the World" border = 0/>
<% else %>
<img src="/images/px.gif" alt="Animals for Sale" target="_blank" width=1/><a href="Http://www.LivestockOfTheWorld.com/members/?Screenwidth=<%=Screenwidth %>" class="webheader" >Sign In<img src = "/images/px.gif" width = 40 height =1 alt = "Livestock Of the World" border = 0/></a>
<% end if %>

</td>
</tr></table>
</div>
</td></tr>
<tr ><td align=center >
<div class="background" width =130 height=100>
<table width="<%=screenwidth %>" cellpadding="0" cellspacing="0" border="0"  align="center" >
<tr>
<% if screenwidth > 650 then %>
<td width="<%=screenwidth-650 %>" align="center" valign="bottom"><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOALogoMenu.png" align="center" width="309" alt="Livestock"></a></td>
<% else %>
<td  valign="bottom"><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOALogoMenu.png" align="left" width="<%=screenwidth %>" alt="Livestock"></a></td>
<% end if %>
<td width=130 valign="top">
<a href="/Livestock/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Livestock For Sale"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Sales"/>Livestock<br />Listings</p>
</div></a></td>

<td width=130 valign="top">
<a href="/Products/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox2" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Animal Product"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Animal Products"/>Product<br />Listings</p>
</div></a>
</td>
<td width=130 valign="top">
<a href="/Ranches/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox3" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Livestock Ranches"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Farms"/>Ranch<br />Directory</p>
</div></a>
</td>
<% if len(Session("PeopleID")) > 1 then %>
<td width=130 valign="top">
<div class="transbox4" width =130 height=100>
<a href="Http://www.LivestockOfTheWorld.com/members/?Screenwidth=<%=Screenwidth %>" target="_blank" class="webheader"><img src="/images/px.gif" width =130 height=1 alt="Livestock Website"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Website Account"/>My<br />Account</p></a>
</div>
</td>
<% else %>
<td width=130 valign="top">
<div class="transbox4" width =130 height=100>
<a href="http://www.livestockoftheworld.com/Join/?website=LOA&Screenwidth=<%=Screenwidth %>" target = blank class="webheader"><img src="/images/px.gif" width =130 height=1 alt="Livestock Website"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Website Account"/>Sell Your<br />Products & Animals</p></a>
</div>
</td>
<% end if %>
<td  width=130></td>
</tr>

</table></div>
</td></tr>
<tr bgcolor="#EBEBEB"><td height = 80 class = "slogan" valign = middle ><center><img src="/images/px.gif" width="300" height=15 /><b><i>Shop Directly From Ranches Across America</i></b>
<img src="/images/px.gif" width="300" height=15 /></center>
</td></tr>
<tr><td>
<!--#Include virtual="/ranches/LivestockRanchHeader.asp"-->
</td></tr>
<tr ><td height=500 valign="top">
<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="center" >
<tr><td width="100%" valign="top"  class= "RanchScreenbackground" >
<% end if %>

<% 
'********************************************
' If UNDER 800 Pixels wide
'********************************************

if screenwidth < 801 then %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
<% if screenwidth > 640 then %>

<tr><td valign="bottom" align="center" colspan=6><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOALogoMenu.png" align="center" width="80%" alt="Livestock"></a></td></tr>
<% else %>
<tr><td valign="bottom" colspan=6><center><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOALogoMenu.png" align="center" width="80%" alt="Livestock"></a></center></td></tr>
<% end if %>
<tr ><td height=80 class="slogan"><center><b><i>Shop Directly From <br />Ranches Across America.</i></b></center></td></tr>
<tr ><td align="center">

<table width="<%=screenwidth%>" cellpadding="0" cellspacing="0" border="0"  align="center" bgcolor = "#3D6B33">
<tr>
<td align="left" width=100% height = 30>
<ul id="mobiledropdown">
<li><a href = "#"  ><font color = white>Menu</font></a>
<ul>
<li ><a href = "/livestock/?screenwidth=<%=screenwidth %>" >Livestock For Sale</a></li>
<li ><a href = "/Products/?screenwidth=<%=screenwidth %>" >Products For Sale</a></li>
<li ><a href = "/Ranches/?screenwidth=<%=screenwidth %>" >Ranch Directory</a></li>
<% if len(Session("PeopleID")) > 1 then %>
<li ><a href = "/login.asp?screenwidth=<%=screenwidth %>" >My Account</a></li>
<% else %>
<li ><a href = "http://www.livestockoftheworld.com/Join/?website=LOA&Screenwidth=<%=Screenwidth %>" >Sell Your Animals & Products</a></li>
<li ><a href = "/login.asp?screenwidth=<%=screenwidth %>" >Sign In</a></li>
<% end if %>
<li><a href = "/AboutUs.asp?screenwidth=<%=screenwidth %>"  >About Us</a></li>
<li><a href = "/ContactUs.asp?screenwidth=<%=screenwidth %>"  >Contact Us</a></li>
<li><a href = "/Default.asp?screenwidth=<%=screenwidth %>"  >Home</a></li>
</ul>
</li>
</ul>
</td>
</tr>
<tr><td align="left" width=100% height = 30>&nbsp;</td></tr>
</table>
</td>
</tr></table>
</td></tr>
<tr bgcolor="#EBEBEB"><td height=500 valign="top">

<table width="<%=screenwidth - 5 %>" cellpadding="0" cellspacing="0" border="0"  align="center" >
<tr><td width="<%=screenwidth - 5 %>" valign="top"  height=500>

<% end if %>


<% 'screenwidth =989 %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>"  height = "646" align = "center" >
<td width = "<%=screenwidth %>" class = "body" valign = "top" >
