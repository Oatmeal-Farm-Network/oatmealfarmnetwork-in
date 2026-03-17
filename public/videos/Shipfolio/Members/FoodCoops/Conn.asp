<% DSN_Name = "LOADBLOA"
Set conn = Server.CreateObject("ADODB.Connection") 
conn.Open "DSN=" & DSN_Name & ";UID=Chimera;PWD=ALEX314159"
Set rs = Server.CreateObject("ADODB.Recordset")
BorderColor = "#ebebeb"
sitename = "LivestockOfAmerica"
Sitenamelong = "Livestock of America"
siteDomainName = "LivestockOfAmerica.US"
SiteURL = "http://www.LivestockofAmerica.US"
PrimaryColor = "#065906"
WebSiteName = "Livestock of America"  %>