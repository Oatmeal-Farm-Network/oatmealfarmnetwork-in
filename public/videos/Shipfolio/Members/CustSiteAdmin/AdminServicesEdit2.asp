<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<meta name="author" content="The Andresen Group">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

<%
ServicesID = request.QueryString("ServicesID")
PageLayoutID = request.QueryString("PageLayoutID")
if len(ServicesID) > 0 then
else
ServicesID = request.Form("ServicesID")
end if

%>
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ServicesID=' + ServicesID + '&ScreenWidth=' + self.innerWidth);">

<!--#Include file="AdminHeader.asp"-->
<% Current3 = "EditServices" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
<% 
UpsellPageID1 = request.form("UpsellPageID1")
UpsellPageID2 = request.form("UpsellPageID2")
UpsellPageID3 = request.form("UpsellPageID3")
UpsellPageID4 = request.form("UpsellPageID4")
Session("Step2") = False 
UpdateUpselling=request.QueryString("UpdateUpselling")

Session("PhotoPageCount") = 0
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		  "Data Source=" & server.mappath(databasepath) & ";" & _
		  "User Id=;Password= ;" 
				
if UpdateUpselling="True" and (len(UpsellPageID1)> 0 or len(UpsellPageID2)> 0 or len(UpsellPageID3)> 0 or len(UpsellPageID4)> 0 ) then

Query =  " UPDATE PageLayout Set "
if len(UpsellPageID1) > 0 then
  Query = Query  & " UpsellPageID1= " & UpsellPageID1 
  if len(UpsellPageID2)> 0 or len(UpsellPageID3)> 0 or len(UpsellPageID4)> 0 then  
  Query = Query  &  " ,"
  else
   Query = Query  &  " "
  end if
end if
if len(UpsellPageID2) > 0 then
  Query = Query  & " UpsellPageID2= " & UpsellPageID2 
   if len(UpsellPageID3)> 0 or len(UpsellPageID4)> 0 then  
  Query = Query  &  " ,"
  else
   Query = Query  &  " "
  end if
  
  
end if
if len(UpsellPageID3) > 0 then
  Query = Query  & " UpsellPageID3= " & UpsellPageID3 
     if  len(UpsellPageID4)> 0 then  
  Query = Query  &  " ,"
  else
   Query = Query  &  " "
  end if
  
end if
if len(UpsellPageID4) > 0 then
  Query = Query  & " UpsellPageID4= " & UpsellPageID4 & " "
end if
Query =  Query & " where PageLayoutID = " & PageLayoutID & ";" 


Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
response.Redirect("AdminServicesEdit2.asp?PageLayoutID=" & PageLayoutID)

end if				
Set rst = Server.CreateObject("ADODB.Recordset")						
Set rsA = Server.CreateObject("ADODB.Recordset")
if len(PagelayoutID) >0 then
sql = "select * from Services where PagelayoutID=" & PagelayoutID
else
sql = "select * from Services where ServicesID=" & ServicesID
end if
rsA.Open sql, conn, 3, 3 
if not rsA.eof then
ServiceTitle = rsA("ServiceTitle")
ServiceDescription= rsA("ServiceDescription")
ServicePrice= rsA("ServicePrice")
ServiceShowPrice= rsA("ServiceShowPrice")
ServiceAvailable = rsA("ServiceAvailable")
PagelayoutID=rsA("PagelayoutID")
ServicesID=rsA("ServicesID")
ServiceMinQuantity=rsA("ServiceMinQuantity")
ServiceMaxQuantity=rsA("ServiceMaxQuantity")
ServiceQuntityIncrements=rsA("ServiceQuntityIncrements")

end if
rsA.close


Set rsA = Server.CreateObject("ADODB.Recordset")
sql = "select * from PageLayout where PagelayoutID=" & PagelayoutID
rsA.Open sql, conn, 3, 3 
if not rsA.eof then
PageGroupID=rsA("PageGroupID")
UpsellPageID1 = rsA("UpsellPageID1")
UpsellPageID2 = rsA("UpsellPageID2")
UpsellPageID3 = rsA("UpsellPageID3")
UpsellPageID4 = rsA("UpsellPageID4")
TopImage = rsA("TopImage")
PageName = rsA("PageName")
session("PageName") = PageName
PageTitle = rsA("PageTitle")
LinkName= rsA("LinkName")
PageHeading= rsA("PageHeading1")
PageHeading1= rsA("PageHeading1")
PageHeading2= rsA("PageHeading2")
PageHeading3= rsA("PageHeading3")
PageHeading4= rsA("PageHeading4")
PageHeading5= rsA("PageHeading5")
PageHeading6= rsA("PageHeading6")
PageHeading7= rsA("PageHeading7")
PageHeading8= rsA("PageHeading8")
PageText = rsA("PageText")
PageText2 = rsA("PageText2")
PageText3 = rsA("PageText3")
PageText4 = rsA("PageText4")
PageText5 = rsA("PageText5")
PageText6 = rsA("PageText6")
PageText7 = rsA("PageText7")

PageText8 = rsA("PageText8")
Image1= rsA("Image1")
Image2= rsA("Image2")
Image3= rsA("Image3")
Image4= rsA("Image4")
Image5= rsA("Image5")
Image6= rsA("Image6")
Image7= rsA("Image7")
Image8= rsA("Image8")
ImageCaption1= rsA("ImageCaption1")
ImageCaption2= rsA("ImageCaption2")
ImageCaption3= rsA("ImageCaption3")
ImageCaption4= rsA("ImageCaption4")
ImageCaption5= rsA("ImageCaption5")
ImageCaption6= rsA("ImageCaption6")
ImageCaption7= rsA("ImageCaption7")
ImageCaption8= rsA("ImageCaption8")
ImageOrientation1= rsA("ImageOrientation1")
ImageOrientation2= rsA("ImageOrientation2")
ImageOrientation3= rsA("ImageOrientation3")
ImageOrientation4= rsA("ImageOrientation4")
ImageOrientation5= rsA("ImageOrientation5")
ImageOrientation6= rsA("ImageOrientation6")
ImageOrientation7= rsA("ImageOrientation7")
ImageOrientation8= rsA("ImageOrientation8")
TopImage= rsA("TopImage")

if ImageCaption1 = "0" then
   ImageCaption1 = ""
end if


if ImageCaption2 = "0" then
   ImageCaption2 = ""
end if

if ImageCaption3 = "0" then
   ImageCaption3 = ""
end if

if ImageCaption4 = "0" then
   ImageCaption4 = ""
end if

if ImageCaption5 = "0" then
   ImageCaption5 = ""
end if

if ImageCaption6 = "0" then
   ImageCaption6 = ""
end if

if ImageCaption7 = "0" then
   ImageCaption7 = ""
end if

if ImageCaption8 = "0" then
   ImageCaption8 = ""
end if


str1 = PageHeading1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, " ")
End If 

str1 = PageHeading1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, "'")
End If 

str1 = PageHeading2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, " ")
End If 

str1 = PageHeading2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, "'")
End If 

str1 = PageHeading3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, " ")
End If 

str1 = PageHeading3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, "'")
End If 

str1 = PageHeading4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, " ")
End If 

str1 = PageHeading4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption1
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption2
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption3
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, "'")
End If 

str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 


str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 

str1 = PageText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 = PageText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, " ")
End If 

str1 = PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, "'")
End If 

str1 = PageText5
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, " ")
End If 

str1 = PageText5
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, "'")
End If 

str1 = PageText6
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, " ")
End If 

str1 = PageText6
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, "'")
End If 

str1 = PageText7
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, " ")
End If 

str1 = PageText7
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, "'")
End If 

str1 = PageText8
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText8
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, " ")
End If 

str1 = PageText8
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, "'")
End If 

end if
rsA.close

%>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
		numberfield.select();
		numberfield.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789. " + comma + period ;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK +  "\"."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{
}
}
//  End -->
</script>


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

<% if len(PageGroupID)> 0 then
sqlg = "select * from PageGroups where PageGroupID = " & PageGroupID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
PageGroupTitle = rsg("PageGroupTitle")
end if
rsg.close 
end if 
%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Service<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top" width = "100%">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr>
    <td valign = "top" align = "right" width = "<%=(screenwidth-35)/2 %>">
   
   
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Top Image<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" valign = "top" width = "100%">
      
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp?PagelayoutID=<%=PagelayoutID %>&ImageNum=Top&ServicesID=<%=ServicesID%>&ReturnPage=AdminServicesEdit2.asp?ServicesID=<%=ServicesID%>" >
<% if len(TopImage) > 0 then %>
<img src = "<%=TopImage%>" width = "50%" /><br />
<% end if %>
	<input name="attach" type="file" size=35 class = "regsubmit2 body">
	<input  type=submit value="Upload" class = "regsubmit2 body">
</form>
<td></tr>
</table>

    
    
<form name="myform" method="post" action= 'AdminServicesUpdate.asp?PagelayoutID=<%=PagelayoutID %>' >
<input name="ServicesID" value="<%=ServicesID %>" type = "hidden">
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Basic Facts<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" valign = "top" width = "100%">     
 <table border = "0"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
   <tr>
   <td colspan = "2">
    <div align = "right"><font class="body2">* = Required Field</font></div>
   </td>
   </tr> 
   
  <tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Name:</b>&nbsp;</div>
		</td><td  align = "left" class = "body">
			<input name="PageName" value= "<%=PageName%>" type = "hidden"><%=PageName%>
		</td>
</tr>
<tr>	
		<td  align = "right" class = "body">
		    <div align = "right"><b>Menu Title:*</b>&nbsp;</div>
		</td>
		<td  align = "left" class = "body">
		    <input name="LinkName" value= "<%=LinkName%>" size = "20" maxsize = "20">
		   <font color = "gray">Max. length = 20 charecters</font>
		</td>
</tr>
<tr>
<td  align = "right" class = "body">
			<div align = "right"><b>Page Group:*</b>&nbsp;</div>
		</td>
		<td  align = "left" class = "body">
			<select size="1" name="PagegroupID">
<% if len(PageGroupTitle) > 0 then %>
<option name = "AID1" value="<%=PagegroupID %>"><%=PageGroupTitle %></option>
<% end if %>	
<% count = 1
	sqlg = "select * from PageGroups order by PageGroupOrder"

	acounter = 1
	Set rsg = Server.CreateObject("ADODB.Recordset")
	rsg.Open sqlg, conn, 3, 3 
					
while not rsg.eof	%>
<option name = "AID1" value="<%=rsg("PagegroupID") %>">
	<%=rsg("PageGroupTitle") %>
</option>
<% 	rsg.movenext
wend %>
</select>
</td>
</tr>
<tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Heading:</b>&nbsp;</div>
		</td>
		<td  align = "left" class = "body">
					<input name="PageHeading" value= "<%=PageHeading%>" size = "40">
		</td>
</tr>
 <tr><td  class = "body" height = '30'><div align = "right">
			<b>Price:</b>&nbsp;</div>
		</td>
		<td class ="body" align = "left" height = '30'>
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ServicePrice" size=5 maxlength=10 value="<%=ServicePrice%>">

			<i><font color = "#404040">Must be a number & greater than 0.</font></i>
</td></tr>
<tr><td  class = "body" height = '30'><div align = "right">
			<b>Min Qty:</b>&nbsp;</div>
		</td>
		<td class ="body" align = "left" height = '30'>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ServiceMinQuantity" size=5 maxlength=10 value="<%=ServiceMinQuantity%>">

			<i><font color = "#404040">Must be a number & greater than 0.</font></i>
</td></tr>
<tr><td  class = "body" height = '30'><div align = "right">
			<b>Max Qty:</b>&nbsp;</div>
		</td>
		<td class ="body" align = "left" height = '30'>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ServiceMaxQuantity" size=5 maxlength=10 value="<%=ServiceMaxQuantity%>">

			<i><font color = "#404040">Must be a number & greater than 0.</font></i>
</td></tr>

<tr>
<td  align = "right" class = "body">
			<div align = "right"><b>Qty Increments:*</b>&nbsp;</div>
		</td>
		<td  align = "left" class = "body">
			<select size="1" name="ServiceQuntityIncrements">
<% if len(ServiceQuntityIncrements) > 0 then %>
<option  value="<%=ServiceQuntityIncrements %>"><%=ServiceQuntityIncrements %></option>
<% end if %>
<option  value="1">1</option>
<option  value="5">5</option>
<option  value="10">10</option>
<option  value="50">50</option>
<option  value="100">100</option>
<option  value="250">250</option>
<option  value="500">500</option>
<option  value="1000">1000</option>
</select>
</td>
</tr>
<tr><td  class = "body" height = '30'><div align = "right">
			<b>Show Price:</b>&nbsp;</div>
		</td>
		<td class = "body">
			<%
		 if  ServiceShowPrice = "Yes" Or ServiceShowPrice = True Then %>
						Yes<input TYPE="RADIO" name="ServiceShowPrice" Value = True checked>
						No<input TYPE="RADIO" name="ServiceShowPrice" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ServiceShowPrice" Value = True >
						No<input TYPE="RADIO" name="ServiceShowPrice" Value = False checked>
				<% End if%>
		</td>
	</tr>

<tr><td  class = "body" height = '30'><div align = "right">
			<b>Available:</b>&nbsp;</div>
		</td>
		<td class = "body">
			<%
		 if  ServiceAvailable = "Yes" Or  ServiceAvailable = True Then %>
						Yes<input TYPE="RADIO" name="ServiceAvailable" Value = True checked>
						No<input TYPE="RADIO" name="ServiceAvailable" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ServiceAvailable" Value = True >
						No<input TYPE="RADIO" name="ServiceAvailable" Value = False checked>
				<% End if%>
		</td>
	</tr>
	<tr>
	<td colspan = "2" align = "right">
		<input type=submit value = "Update ->" class = "regsubmit2" ></form>
	
	</td></tr>	
</table>
</td></tr>	
</table>
    
    
    
      <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "410">
  <tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Shipping & Handling</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "410" valign = "top">
<%  
conns = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(databasepath) & ";" & _
			"User Id=;Password= ;" 
sqls = "select * from sfShipping where ServicesID=" & ServicesID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, conns, 3, 3 
numcountries = rss.recordcount
rss.close
set conns = nothing

%>
        <iframe src ="AdminShippingFrame.asp?ServicesID=<%=ServicesID %>" height="<%=(numcountries * 40) + 130 %>" width="453" frameborder = "0" scrolling = "yes" valign = "top" align = "center" style="background-color:white" ></iframe>
				</td>
			</tr>
			</table>	

    </td>
    <td valign = "top">
    <table border = "0" width = "100%" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Options</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" width = "100%" valign = "top">
  <% ListCounter = 0  
 Frameheight = 160
 Set rss = Server.CreateObject("ADODB.Recordset")
   sql = "select * from ServicesOptions where ServicesID = " & ServicesID 
rs.Open sql, conn, 3, 3 
while Not rs.eof 
ListCounter = ListCounter + 1
ServicesOptionID = rs("ServicesOptionID")

Frameheight = Frameheight+ 90
sqls = "select * from ServicesOptionsAttributes where ServicesOptionID = " & ServicesOptionID
'response.Write("sqls=" & sqls )
rss.Open sqls, conn, 3, 3 
while not rss.eof 

    FrameCount = rss.recordcount
    Frameheight = Frameheight+ 120
rss.movenext
wend
rss.close
rs.movenext
wend
rs.close

if Frameheight < 480 then
Frameheight = 475
end if
%>

<iframe src="AdminServicesOptionFrame.asp?ServicesID=<%=ServicesID %>" height = '<%=Frameheight %>' width = '100%' frameborder= '0' seamless = Yes scrolling = yes align = 'left'></iframe>
         
</td></tr></table>
<%
dim ServicesIDArray(999999) 
dim ServicesNameArray(999999)
ListCounter = 0
sql = "select * from Services,  PageLayout where Services.PageLayoutId = PageLayout.PageLayoutId" 
rs.Open sql, conn, 3, 3 
while Not rs.eof 
ListCounter = ListCounter + 1
ServicesIDArray(ListCounter) = rs("Services.PagelayoutID")
ServicesNameArray(ListCounter) = rs("PageName")
rs.movenext
wend
rs.close
TotalListCounter = ListCounter
%>
<form name="myform" method="post" action= 'AdminServicesEdit2.asp?PageLayoutID=<%=PagelayoutID %>&UpdateUpselling=True' >
<table border = "0" width = "100%" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Upselling</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "100" width = "100%" valign = "top">
The following show up as links on the bottom of your <%=pagename %> page encouraging users to check out these other services: <br />
  <table align = "center" width = "400">
  <tr>
  <td class = "body2" align = 'right'>
  Service:
  </td>
   <td width = "300">
<% if len(UpsellPageID1) > 0 then
sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID1
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle1 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
<select size="1" name="UpsellPageID1">
<% if len(UpsellPageID1) > 0  then 
 if not UpsellPageID1 = 0 then  %>
<option  value="<%=UpsellPageID1 %>"><%=ServiceTitle1%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID1 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
  <td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID2) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID2
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle2 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID2">
<% if len(UpsellPageID2) > 0  then 
 if not UpsellPageID2 = 0 then  %>
<option  value="<%=UpsellPageID2 %>"><%=ServiceTitle2%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID2 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
 <td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID3) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID3
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle3 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID3">
<% if len(UpsellPageID3) > 0  then 
 if not UpsellPageID3 = 0 then  %>
<option  value="<%=UpsellPageID3 %>"><%=ServiceTitle3%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID1 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
<td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID4) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID4
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle4 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID4">
<% if len(UpsellPageID4) > 0  then 
 if not UpsellPageID4 = 0 then  %>
<option  value="<%=UpsellPageID4 %>"><%=ServiceTitle4%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID4 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
<td align = "center" colspan = "2">
	<input type=submit value = "Update" class = "regsubmit2" ></form>
</td></tr>
</table>


 </td>
</tr>
</table>
 </td>
 </tr>
<tr>
<td colspan = "2">

<br />
<table border = 0>
<tr><td>

<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<% 
 textblocknum = 1
   TempPageText =  PageText
  TempTB = "TB1"
  TempImageOrientation = ImageOrientation1
  tempImageCaption  = ImageCaption1
  tempImage = Image1
  returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock1"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 


<%  textblocknum = 2
   TempPageText =  PageText2
  TempTB = "TB2"
  TempImageOrientation = ImageOrientation2
  tempImageCaption  = ImageCaption2
  tempImage = Image2
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock2"%>
<!--#Include file="AdminPageBlocksInclude.asp"--> 

<%  textblocknum = 3
   TempPageText =  PageText3
  TempTB = "TB3"
  TempImageOrientation = ImageOrientation3
  tempImageCaption  = ImageCaption3
  tempImage = Image3
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock3"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 


<%  textblocknum = 4
   TempPageText =  PageText4
  TempTB = "TB4"
  TempImageOrientation = ImageOrientation4
  tempImageCaption  = ImageCaption4
  tempImage = Image4
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock4"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 

<%  textblocknum = 5
   TempPageText =  PageText5
  TempTB = "TB5"
  TempImageOrientation = ImageOrientation5
  tempImageCaption  = ImageCaption5
  tempImage = Image5
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock5"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 

<%  textblocknum = 6
   TempPageText =  PageText6
  TempTB = "TB6"
  TempImageOrientation = ImageOrientation6
  tempImageCaption  = ImageCaption6
  tempImage = Image6
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock6"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 


<%  textblocknum = 7
   TempPageText =  PageText7
  TempTB = "TB7"
  TempImageOrientation = ImageOrientation7
  tempImageCaption  = ImageCaption7
  tempImage = Image7
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock7"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 

<%  textblocknum = 8
   TempPageText =  PageText8
  TempTB = "TB8"
  TempImageOrientation = ImageOrientation8
  tempImageCaption  = ImageCaption8
  tempImage = Image8
    returnpage = "AdminServicesEdit2.asp?ServicesID=" & ServicesID & "#" & TempTB
  returnpage2 = "AdminServicesEdit2.asp"
   TempTextBlock = "TextBlock8"%>
      <a name= <%=TempTextBlock %> ></a>
<!--#Include file="AdminPageBlocksInclude.asp"--> 
<br><br><br>

<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>	
 <br><br>


<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>