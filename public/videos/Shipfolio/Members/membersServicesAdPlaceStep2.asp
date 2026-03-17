<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<%	variables = variables & "&LinkName=" & LinkName

ServiceCategoryID=Request.Form("ServiceCategoryID")
variables = variables & "&ServiceCategoryID=" & ServiceCategoryID

ServiceSubCategoryID=Request.Form("ServiceSubCategoryID")
variables = variables & "&ServiceSubCategoryID=" & ServiceSubCategoryID

ServiceID=trim(request.form("ServiceID")) 
variables = variables & "&ServiceID=" & ServiceID
ServiceTitle=trim(request.form("ServiceTitle")) 
variables = variables & "&ServiceTitle=" & ServiceTitle
ServicePrice =trim(request.form("ServicePrice"))
variables = variables & "&ServicePrice=" & ServicePrice
ServiceAvailable=trim(request.form("ServiceAvailable"))
variables = variables & "&ServiceAvailable=" & ServiceAvailable
ServiceDescription   =trim(request.form("ServiceDescription"))
variables = variables & "&ServiceDescription=" & ServiceDescription
ServiceContactForPrice =trim(request.form("ServiceContactForPrice"))
variables = variables & "&ServiceContactForPrice=" & ServiceContactForPrice 
PagegroupID =trim(request.form("PagegroupID"))
variables = variables & "&PagegroupID=" & PagegroupID 
PageType =trim(request.form("PageType"))
variables = variables & "&PageType=" & PageType
ServicesPagelayoutID = request.QueryString("ServicesPagelayoutID")



ServicePhone =trim(request.form("ServicePhone"))
variables = variables & "&ServicePhone=" & ServicePhone

Servicewebsite=trim(request.form("Servicewebsite"))
variables = variables & "&Servicewebsite=" & Servicewebsite
Serviceemail=trim(request.form("Serviceemail"))
variables = variables & "&Serviceemail=" & Serviceemail

if len(ServiceContactForPrice) > 0 then

else
ServiceContactForPrice = False
end if


Missing = "?Missing=True"

if len(ServiceSubCategoryID) > 0 then
else
    Missing = Missing & "&MissingServiceSubCategoryID=True"
 end if


 
if len(Missing) > 13 then
  response.Redirect("membersServicesAddPage.asp" & Missing & variables)
end if


str1 = Servicewebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	Servicewebsite= Replace(str1, "'", "''")
End If

str1 = lcase(Servicewebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Servicewebsite= Replace(str1, "http://", "")
End If

str1 = lcase(Servicewebsite)
str2 = "https://"
If InStr(str1,str2) > 0 Then
	Servicewebsite= Replace(str1, "http://", "")
End If



str1 = ServiceTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceTitle= Replace(str1, "'", "''")
End If

str1 = ServicePhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicePhone= Replace(str1, "'", "''")
End If

str1 = Serviceemail
str2 = "'"
If InStr(str1,str2) > 0 Then
	Serviceemail= Replace(str1, "'", "''")
End If



str1 = ServicePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicePrice= Replace(str1, "'", "''")
End If

str1 = ServiceDiscount
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceDiscount= Replace(str1, "'", "''")
End If


str1 = ServiceDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceDescription= Replace(str1, "'", "''")
End If



str1 = ServiceID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceID = Replace(str1, "'", "''")
End If


	str1 = LinkName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		LinkName= Replace(str1,  str2, "''")
	End If  

if len(LinkName) < 1 then
  Message=Message & "<br>Please enter a menu title."
  Proceed="False"
end if 
	
Session("Step2") = false
If 	Session("Step2") = false then
			
	ServiceTitleFound = False

if len(ServicePrice) < 1 then
 ServicePrice = 0
end if
if len(ServicesPagelayoutID) > 0 then
sql2 = "select * from Services where  ServicesPagelayoutID = '" & ServicesPagelayoutID & "'  order by ServicesPagelayoutID Desc"
else
sql2 = "select * from Services where  ServiceTitle = '" & ServiceTitle & "'  order by ServicesID"
end if

response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if  Not rs2.eof then
		ServiceTitleFound = True
		ServicesID = rs2("ServicesID")
		session("ID") = rs2("ServicesID")
		session("ServicesID") = rs2("ServicesID")
		ServicesPagelayoutID = rs2("ServicesPagelayoutID")
	End if
rs2.close	
	
If ServiceTitleFound = True then
'		 response.Redirect("AdminPageAdd.asp?PageAlreadyExists=True"  & variables)
end if

	If ServiceTitleFound = False then
	
sql2 = "select * from Pagelayout "	
	response.write(sql2)
	acounter = 1
	rs2.Open sql2, conn, 3, 3  
if Not rs2.eof then
    LinkOrder = rs2.recordcount - 1
end if
rs2.close
	
	
	
	sql2 = "select * from Services  order by ServiceTitle"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	If Not rs2.eof then

		ServicesID = rs2.recordcount + 1
		session("ID") = ServicesID
		session("ServicesID") = ServicesID
		rs2.close
   End If 

If ServicesID > 0 Then
Else
	ServicesID = 1
		session("ID") = ServicesID
		session("ServicesID") = ServicesID
End If

if rs2.state = 0 then
else
rs2.close
end if

		sql2 = "select * from Services where ServicesID  = " & ServicesID 

	'	response.write(sql2)
		rs2.Open sql2, conn, 3, 3 
		If Not rs2.eof Then
		    notfound=true
				While notfound=true
						sql2 = "select * from Services where ServicesID  = " & ServicesID 

					'response.write(sql2)
					Set rs2 = Server.CreateObject("ADODB.Recordset")
					rs2.Open sql2, conn, 3, 3 
					If Not rs2.eof Then
						ServicesID = ServicesID+ 1
						notfound=True
					Else
					    notfound=false
					End If
							rs2.close
				wend	
		End If




sql2 = "select * from services  where  ServiceTitle = '" & ServiceTitle & "';"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
Query =  "INSERT INTO Services (ServiceCategoryID, ServiceSubCategoryID, ServiceTitle,  "
	
if len(ServicePrice) > 0 then
Query = Query & " ServicePrice," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " ServiceDiscount," 
end if


Query = Query & "  Peopleid)" 
Query =  Query & " Values (" & ServiceCategoryID & ","
Query =  Query & " " & ServiceSubCategoryID & ","
Query =  Query & " '" &  ServiceTitle & "',"




if len(ServicePrice) > 0 then
Query = Query & " '"  &  ServicePrice & "'," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " "  &  ServiceDiscount & "," 
end if



Query =  Query & " " & session("PeopleID") & ")"
		
response.write(Query)	


Conn.Execute(Query) 

sql2 = "select * from services  where  ServiceTitle = '" & ServiceTitle & "' order by ServicesID desc;"

response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
ServicesID = rs2("ServicesID")
end if
rs2.close

Session("Step2") = True
End if
End if

'End if
'set conn = nothing
'conn.close

response.Redirect("MembersServicesEdit2.asp?ServicesID=" & ServicesID & "&ServicesPagelayoutID=" &  ServicesPagelayoutID)
%>

</head>
<body >


</Body>
</HTML>
