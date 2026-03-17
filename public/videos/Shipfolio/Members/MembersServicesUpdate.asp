<!doctype html>
<html>
<head>
<!--#Include file="membersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
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
ServicesDescription =  trim(request.form("ServicesDescription"))



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

response.write(Query)

Conn.Execute(Query) 
 

response.redirect("MembersEditServiceFrame.asp?ServicesID=" & ServicesID & "&changesmade=True#Top") %>

 </Body>
</HTML>