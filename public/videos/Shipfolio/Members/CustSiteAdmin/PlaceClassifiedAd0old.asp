<html>
<head>

<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Place a Classified Ad</title>
<link rel="shortcut icon" href="/LittleShrew.ico" /> 
<link rel="icon" href="http://www.GreenShrew.com/LittleShrew.ico" /> 
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

<% 
Subject=request.form("Subject") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Subject") 
End If

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 



Dim CategoryID(100,100)
Dim CategoryName(100,100)

Dim SubCategoryID(100)
Dim SubCategoryName(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from Categories where categorytype = '" &  Subject & "' order by Categoryname " 
			response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CategoryID")
		CategoryName(CatCounter,0) = rs("CategoryName")
		'response.write(CategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
  

	<% sql = "select * from SubCategories where CategoryID = " & CategoryID(CatCounter,0) & " Order by SubcategoryName"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	Varieties =  Varieties  & " ["" Sub Categories "", "
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("SubCategoryID") 
		CategoryName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryID(SubCatCounter2) = rs("SubCategoryID") 
		SubCategoryName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CategoryName(CatCounter,SubCatCounter)  %>
		
      

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
response.write(Varietielen)
Varieties = Left(Varieties, (Varietielen-3))
%>



<script type="text/javascript">
<!--
var varieties=[
<%=Varieties%>
];

function Box2(idx) {
var f=document.myform;
f.box2.options.length=null;


for(i=0; i<varieties[idx].length - 1; i++) {
f.box2.options[i]=new Option(varieties[idx][i], i);
}
}

onload=function() {
	Box2(0);
}
 //-->
</script>

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

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<!--#Include file="Header.asp"-->
<%=Varieties%>


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "600">
	<tr>
		<td class = "body" valign = "top"  >

			<a name="Add"></a>
			<h1>Create an <% if Subject="For Sale" Then %>
					  For Sale
				<%   End If
				    if Subject="WantAd" Then %>
					   Want 
				<%   End If
				    if Subject="Barter" Then %>
					   Barter
				<%   End If
				    if Subject="Donation" Then %>
						Non-Profit Donation Want 
				<%   End If
				%> Ad</h1><br>
			<H2>Step 1: Choose Categories.<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br>
		</td>
	</tr>
</table>
<form name="myform" method="post" action= 'PlaceClassifiedAd.asp' >

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
<tr>
			<td  class = "body" align = "right" width = "200">
			Type of Ad:
		</td>
		<td width = "470" class = "body" height = "25">
			<b><% = Subject%></b>
	

		</td>
	</tr>



<tr>
			<td  class = "body" align = "right" >
			Category:
		</td>
		<td width = "570">
			<div>



<select name="box1" onchange="Box2(this.selectedIndex)">
<% 
	CatCounter = 0
		While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter,0)%>"><%=CategoryName(CatCounter,0)%></option>
	<% Wend %>
</select>


<select name="box2" onchange="Box2IDpick(this.selectedIndex)"></select>
</div>
	<input name="box2ID" size = "30" value = "0" type = "hidden">
	

		</td>
	</tr>

	<tr>
		<td  colspan = "2" align = "center" valign = "middle" class = "body" >
			<br>
				<input name="Subject" value = "<%=Subject%>" type = "hidden">
			<input type=submit value = "Submit Ad" style="background-image: url('images/background.jpg'); border-width:1px" size = "310" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
 
<br><br><br>
<!--#Include file="Footer.asp"--> </Body>
</HTML>