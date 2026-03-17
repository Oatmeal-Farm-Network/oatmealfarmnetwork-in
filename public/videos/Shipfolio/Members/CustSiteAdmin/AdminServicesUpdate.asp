<!doctype html>
<html>
<head>

<!--#Include file="AdminGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The Andresen Group Content Management System</title>
<link rel="shortcut icon" href="/LittleShrew.ico" /> 
<link rel="icon" href="http://www.GreenShrew.com/LittleShrew.ico" /> 
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">


<SCRIPT LANGUAGE="JavaScript">

<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>

</head>
<body >

<!--#Include file="AdminHeader.asp"-->
 <!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Product</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td >
<% 
ServicesID=trim(request.form("ServicesID")) 
ServiceTitle=trim(request.form("ServiceTitle")) 
ServicePrice =trim(request.form("ServicePrice"))
ServiceDiscount = trim(request.Form("ServiceDiscount"))
ServiceQuantityAvailable=trim(request.form("ServiceQuantityAvailable"))
ServiceForSale =request.form("ServiceForSale")
ServiceDescription   =trim(request.form("ServiceDescription"))
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

IF len(ServiceMinQuantity) > 0 then
   ServiceMinQuantity = cint(ServiceMinQuantity)
else
    ServiceMinQuantity = 0
end if

'response.Write("ServiceMaxQuantity=" & ServiceMaxQuantity )
IF len(ServiceMaxQuantity) > 0 then
   ServiceMaxQuantity = cdbl(ServiceMaxQuantity)
else
    ServiceMaxQuantity = 0
end if

IF len(ServiceQuntityIncrements) > 0 then
  ServiceQuntityIncrements = cint(ServiceQuntityIncrements)
else
  ServiceQuntityIncrements = 0
end if

response.Write("ServiceMinQuantity=" & ServiceMinQuantity)
Missing = "?Missing=True"

ServiceTitle  =PageName
if len(ServiceTitle) > 1 then
else
    Missing = Missing & "&MissingServiceTitle=True"
 end if
 
  if len(ServicePrice) > 0 then
 if ServicePrice > 0 then
else
    Missing = Missing & "&MissingServicePrice=True"
 end if
 else
    Missing = Missing & "&MissingServicePrice=True"
 end if
 
 if len(Missing) > 13 then
  'response.Redirect("AdminServicesEdit2.asp?PageLayoutID=77" & Missing & variables)
end if


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


str1 = ServiceDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceDescription= Replace(str1, "'", "''")
End If



str1 = ServicesID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicesID = Replace(str1, "'", "''")
End If
	


Query =  " UPDATE Services Set "
  Query = Query  & " ServiceTitle= '" & ServiceTitle & "' ,"
 if ServiceMinQuantity > 0 then 
  Query = Query  & " ServiceMinQuantity= " & ServiceMinQuantity & " ,"
  end if 
   if ServiceMaxQuantity > 0 then 
  Query = Query  & " ServiceMaxQuantity= " & ServiceMaxQuantity & " ,"
  end if 
   if ServiceQuntityIncrements > 0 then 
  Query = Query  & " ServiceQuntityIncrements= " & ServiceQuntityIncrements & " ,"
  end if 
  
  if len(ServicePrice) > 0 then  
  if ServicePrice > 0 then  
  Query = Query  & " ServicePrice= " & ServicePrice & " ,"
  end if
  end if
  if len(ServiceDiscount) > 0 then
 Query = Query  & " ServiceDiscount= '" & ServiceDiscount & "' ,"
 end if
  
if len(PageLayoutID) > 0 then
 Query = Query  & " PageLayoutID= '" & PageLayoutID & "' ,"
 end if
Query = Query  & " ServiceAvailable = " & ServiceAvailable  & " ,"
Query = Query  & " ServiceDescription= '" & ServiceDescription & "' "
Query =  Query & " where ServicesID = " & ServicesID & ";" 

response.write(Query)

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 


Query =  " UPDATE PageLayout Set PageName= '" & PageName & "', "
Query = Query & " LinkName= '" & LinkName & "', "
Query = Query & " PagegroupID= '" & PagegroupID & "' ,"
Query = Query & " PageHeading1= '" & PageHeading & "' "
Query =  Query & " where PageLayoutID = " & PageLayoutID & ";" 

response.write(Query)

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 

response.redirect("AdminServicesEdit2.asp?ServicesID=" & ServicesID ) %>

 </Body>
</HTML>