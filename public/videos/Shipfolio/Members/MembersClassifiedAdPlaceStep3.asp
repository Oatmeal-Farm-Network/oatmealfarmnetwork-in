<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
<link rel="stylesheet" href="https://www.GlobalGrange.world/members/Membersstyle.css">
</head>
<body>
 <!--#Include File="MembersHeader.asp"--> 
  <!--#Include File="MembersServicesJumpLinks.asp"--> 
<% 
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
	


Query =  " UPDATE Services Set "
Query = Query  & " ServiceTitle= '" & ServiceTitle & "' ,"
Query = Query  & " ServiceSubcategoryID = " & ServiceSubcategoryID & " ,"
Query = Query  & " ServicePrice= '" & ServicePrice & "' ,"
Query = Query  & " ServicesDescription= '" & ServicesDescription & "' "
Query =  Query & " where ServicesID = " & ServicesID & ";" 

'response.write(Query)

Conn.Execute(Query) 

%>






<div class ="container roundedtopandbottom" style ="min-height:500px">
  <div class ="row">
      <class ="col">
          <h3>Added</h3>
         <center> <b>Your Service listing has been added.</b></center>

      </class>
  </div>
</div>
    <!--#Include File="membersFooter.asp"--> 
</body>
</HTML>
