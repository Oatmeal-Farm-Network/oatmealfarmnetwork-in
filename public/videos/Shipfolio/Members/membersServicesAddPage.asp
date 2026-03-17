<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
<!--#Include file="MembersGlobalVariables.asp"-->

</head>
<body >
<!--#Include file="MembersHeader.asp"-->
 <% Hidelinks = True %>
<!--#Include File="MembersServicesJumpLinks.asp"--> 
<% 
ServiceID=request.form("ServiceID") 


If len(ServiceID) > 0 then
Else
ServiceID= Request.QueryString("ServiceID") 
End if 


Session("Step2") = False 

ServiceSubCategoryID = request.querystring("ServiceSubCategoryID")
'PeopleID=session("PeopleID" ) 
MissingServiceSubCategoryID = request.querystring("MissingServiceSubCategoryID")
ServiceTitle=trim(request.form("ServiceTitle")) 

ServicePhone  = request.querystring("ServicePhone")
Servicewebsite  = request.querystring("Servicewebsite")
Serviceemail  = request.querystring("Serviceemail")
ServicePrice = request.querystring("Serviceemail")
ServiceContactForPrice= request.querystring("ServiceContactForPrice")
ServiceAvailable = request.querystring("ServiceAvailable")
 
if len(ServiceTitle) > 0 then
else
ServiceTitle = request.querystring("ServiceTitle")
end if

variables = variables & "&ServiceTitle=" & ServiceTitle
ServiceCategoryID=trim(request.form("ServiceCategoryID")) 
if len(ServiceCategoryID) > 0 then
else
ServiceCategoryID = request.querystring("ServiceCategoryID")
end if
variables = variables & "&ServiceCategoryID=" & ServiceCategoryID

Missing = "?Missing=True"

if len(ServiceCategoryID) > 0 then
else
    Missing = Missing & "&Missingcategory=True"
 end if

if len(ServiceTitle) > 1 then
else
    Missing = Missing & "&MissingServiceTitle=True"
 end if
 
 if len(Missing) > 13 then
  response.Redirect("membersServicesAddPage0.asp" & Missing & variables)
end if

if len(ServicecategoryID)> 0 then
sqlg = "select * from servicescategories where ServiceCategoryID = " & ServiceCategoryID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServicesCategory = rsg("ServicesCategory")
end if
rsg.close 
end if 


ServicesID=trim(request.form("ServicesID")) 
ServiceTitle=trim(request.form("ServiceTitle")) 
ServicePrice =trim(request.form("ServicePrice"))
ServiceDiscount = trim(request.Form("ServiceDiscount"))
ServiceQuantityAvailable=trim(request.form("ServiceQuantityAvailable"))
ServiceForSale =request.form("ServiceForSale")
ServicesDescription   =trim(request.form("ServicesDescription"))
ServiceAvailable =trim(request.form("ServiceAvailable"))
PageLayoutID1 =trim(request.form("PageLayoutID1"))
PageName=trim(request.form("PageName"))
PagelayoutID = request.QueryString("PagelayoutID")
LinkName= request.Form("LinkName")
PagegroupID= request.Form("PagegroupID")
PageHeading= request.Form("PageHeading")
ServiceMinQuantity=request.Form("ServiceMinQuantity")
ServiceMaxQuantity=request.Form("ServiceMaxQuantity")
ServiceQuntityIncrements=request.Form("ServiceQuntityIncrements")
ServicePrice=request.Form("ServicePrice")
ServicePhone=request.Form("ServicePhone")
Servicewebsite=request.Form("Servicewebsite")
Serviceemail =request.Form("Serviceemail")
ServiceSubcategoryID = request.form("ServiceSubcategoryID")
ServiceContactForPrice = request.form("ServiceContactForPrice")


str1 = PageHeading
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageHeading= Replace(str1, "'", "''")
End If


str1 = LinkName
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkName= Replace(str1, "'", "''")
End If

str1 = PageName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageName= Replace(str1, "'", "''")
End If

str1 = ServiceTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceTitle= Replace(str1, "'", "''")
End If


str1 = ServicePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicePrice= Replace(str1, "'", "''")
End If


str1 = SalePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1, "'", "''")
End If


str1 = ServicesDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicesDescription= Replace(str1, "'", "''")
End If



str1 = ServicesID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicesID = Replace(str1, "'", "''")
End If
	

    
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

'response.write(sql2)
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
	'response.write(sql2)
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
	
Query =  "INSERT INTO Services (ServiceCategoryID, ServiceTitle,  "
	
if len(ServicePrice) > 0 then
Query = Query & " ServicePrice," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " ServiceDiscount," 
end if


Query = Query & "  Businessid)" 
Query =  Query & " Values (" & ServiceCategoryID & ","

Query =  Query & " '" &  ServiceTitle & "',"


if len(ServicePrice) > 0 then
Query = Query & " '"  &  ServicePrice & "'," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " "  &  ServiceDiscount & "," 
end if

Query =  Query & " " & session("BusinessID") & ")"
		
'response.write(Query)	


Conn.Execute(Query) 

sql2 = "select * from services  where  ServiceTitle = '" & ServiceTitle & "' order by ServicesID desc;"

'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
ServicesID = rs2("ServicesID")
end if
rs2.close

Session("Step2") = True
End if
End if


%>

<div>
    <div align=left class = "roundedtopandbottom">
        <H1>Edit Listing</H1>
        <iframe src="MembersAddServiceFrame.asp?ServicesID=<%=ServicesID %>" height = '960' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
    </div>
</div>
<br>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>