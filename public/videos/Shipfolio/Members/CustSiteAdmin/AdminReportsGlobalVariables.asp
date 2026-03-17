<% 'Global Variables

BorderColor = "#ebebeb"

BackgroundColor = "white"

ReportHighlightColor = "#CBB085"


'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************
Set rs = Server.CreateObject("ADODB.Recordset")


 sql = "select distinct People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = 667"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

if  Not rs.eof then   
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
 AddressStreet = rs("AddressStreet")
 PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Owners= rs("Owners")
 rs.close
  end if
  
  
   sql = "select * from SiteDesign where PeopleID=667 "
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
logo = rs("Logo")
rs.close

 sql = "select distinct BusinessName, BusinessLogo, Business.BusinessID from People, Business where People.BusinessID = Business.BusinessID and  people.PeopleID = 667" 

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
 BusinessName = rs("BusinessName")
 BusinessLogo = rs("BusinessLogo")
 BusinessID = rs("BusinessID")
end if
%>