<!--#Include virtual="/Conn.asp"-->
<% WebSiteName = "Livestock Of America"
BorderColor = "#ebebeb"
sitename = "Livestock Of America"
sitecountry = "America"
searchcountry = "USA"
fullcountryname = "United States Of America"
currencycode = "USD"
countrysearch = " and (address.addresscountry = 'USA' or address.addresscountry = 'America' or address.addresscountry = 'USA' ) "
websiteURL = "http://www.LivestockOfAmerica.com"
Set rs = Server.CreateObject("ADODB.Recordset")
PeopleID = request.QueryString("PeopleID")
if len(PeopleID) < 1 then
PeopleID = session("currentPeopleID")
end if
if len(PeopleID) < 1 then
PeopleID = session("PeopleID")
end if
CurrentPeopleID = PeopleID
currentdate = now
HeaderAdfound = false
FFAADiscount = 40
%>
<!--#Include virtual="/MobileWidthInclude.asp"-->
 