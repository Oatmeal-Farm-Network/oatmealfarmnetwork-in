<html>
<head>
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Add a Product</title>
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

<% 
Subject="For Sale"


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 



Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryID(100)
Dim SubCatName(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from SFCategories  order by Catname " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CatName(CatCounter,0) = rs("CatName")
		'response.write(CatName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
  

	<% sql = "select * from SFSubCategories where CategoryID = '" & CategoryID(CatCounter,0) & "' Order by SubcategoryName"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	Varieties =  Varieties  & " ["" Sub Categories "", "
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("subcatId") 
		CatName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryID(SubCatCounter2) = rs("subcatId") 
		SubCatName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  %>
		
      

		<% rs.movenext
			If Not(rs.eof) Then 
				Varieties  = Varieties  &  """ , " 
			 End If 
	Wend
	Varieties  = Varieties & """ ]," & vbCrLf
	Else
	Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
	End If 
wend

FinalSubCatCounter2 = SubCatCounter2
   		FinalSubCatCounter = CatCounter

Varietielen  = Len(Varieties)
'response.write(Varietielen)
Varieties = Left(Varieties, (Varietielen-3))
%>

 <script type="text/javascript">
<!--
var varieties=[<%=Varieties%>];

function Box2IDpick(box2pick) {
var f=document.myform;
f.box2ID.value=null;

f.box2ID.value = box2pick
}


 //-->
</script>




<script type="text/javascript">
var varieties=[<%=Varieties%>];

function Box2(idx) {
var f=document.myform;
f.box2.options.length=null;
for(i=0; i<varieties[idx].length; i++) {
    f.box2.options[i]=new Option(varieties[idx][i], i); 
    }    
}

onload=function() {Box2(0);};
</script>
</head>
<body>
<!--#Include file="AdminHeader.asp"--> 

<table  height = "300" width = "900" align = "center" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td valign = "top">
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "900">
	<tr>
		<td class = "body" valign = "top"  colspan = "2>

			<a name="Add"></a><br>
			<h1>Add a Product</h1><br>
<% nosubcat=Request.QueryString("nosubcat") 
If nosubcat="true" Then %>
<font color = "red"><big>Please select a sub category.</big></font><br>

<% End If %>
			<H2>Step 1: Choose Categories<H2>
		</td>
	</tr>
	<tr>
		<td bgcolor = "#abacab" height = "1" colspan = "2"><img src = "images/px.gif"></td>
	</tr>

<form name="myform" method="post" action= 'AdminClassifiedAdPlace.asp' >
	<tr>
			<td  class = "body"  >
			Category:
		</td>
		<td width = "800" class = "body">
			<div>
<div>
<select name="box1" onchange="Box2(this.selectedIndex)">
    <% 
	CatCounter = 0
		While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter,0)%>"><%=CatName(CatCounter,0)%></option>
	<% Wend %>
</select>


</div>
	<input name="box2ID" size = "30" value = "0" type = "hidden">
</div>
<tr>
		<td  colspan = "2" align = "center" valign = "middle" class = "body" >
			<br>
				<input name="Subject" value = "<%=Subject%>" type = "hidden">
			<input type=submit value = "Proceed to the Next Step ->"  size = "310" class = "body" >
			</form>
		</td>
</tr>
</table>
  </td>
  </tr>
 </table>

<br><br><br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>