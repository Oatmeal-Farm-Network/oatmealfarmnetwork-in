<% 'Global Variables
Dim DatabasePath
Dim MembersistrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor


BorderColor = "#ebebeb"

BackgroundColor = "white"

ReportHighlightColor = "#CBB085"


'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************

sql = "select  * from People where PeopleID= " & PeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
WebsitesID = rs("WebsitesID")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeopleLastName")
Owners = rs("Owners")
if len(Owners) < 2 then
    Owners = PeopleFirstName & " " & PeopleLastName 
end if
PeoplePhone = rs("PeoplePhone")
	PeopleCell = rs("PeopleCell")
	PeopleFax = rs("PeopleFax")
	PeopleEmail = rs("PeopleEmail")
end if
rs.close

sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessName = rs("BusinessName")
end if 

rs.close

sql = "select  Website from Websites where WebsitesID= " & WebsitesID
rs.Open sql, conn, 3, 3
If not rs.eof then
	Website = rs("Website")
end if 

rs.close


sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt") 
	AddressCity = rs("AddressCity")
	AddressState = rs("AddressState")
	AddressZip = rs("AddressZip")

end if 
rs.close

%>

