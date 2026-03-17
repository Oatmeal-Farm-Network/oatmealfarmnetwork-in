<!--#Include virtual="/includefiles/Conn.asp"-->
<% 


WebSiteName = "Agriculture Associations Of The World"
BorderColor = "#ebebeb"
sitename = "Agriculture Associations Of The World"
Sitenamelong = "Agriculture Associations Of The World"
Set rs = Server.CreateObject("ADODB.Recordset")

PeopleID = Session("PeopleID")

if len(PeopleID) < 1 then
PeopleID = request.QueryString("PeopleID")
end if


CurrentPeopleID = PeopleID
currentdate = now
HeaderAdfound = false
FFAADiscount = 40
%>
 <link rel="shortcut icon" type="image/png" href="https://www.HarvestHub.world/images/HarvestHubFavicon.png"/>
<meta name="msvalidate.01" content="B3CD3001A90F0BEAD4B91C6F98650E6C" />
<% HSpacer = "<div class = row ><div class=col-12 body style=min-height:20px></div></div>"%>
<!--#Include file="associationSecurityInclude.asp"-->



