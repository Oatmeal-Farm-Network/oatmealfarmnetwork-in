<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add an Alpaca Step 6</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">








<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
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
var checkOK = "0123456789$" + comma ;
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
alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
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



</HEAD>

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
	dim AwardYear(40000)
	dim Show(40000)
	dim AClass(40000)
	dim Placing(40000)
	dim AwardDescription(40000)

ID=Request.Form("ID")
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql2 = "select * from awards where ID = " &  ID & ";" 
			
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof Then
'response.write(sql2)
TotalCount= Request.Form("TotalCount")
TotalCount = 20
'rowcount = CInt(rowcount)
rowcount = 1
while (rowcount < 21)
	AwardYearcount = "AwardYear(" & rowcount & ")"
	Showcount = "Show(" & rowcount & ")"
	Placingcount = "Placing(" & rowcount & ")"
	AClasscount = "AClass(" & rowcount & ")"
	AwardDescriptioncount = "AwardDescription(" & rowcount & ")"

	AwardYear(rowcount)=Request.Form(AwardYearcount) 
	Show(rowcount)=Request.Form(Showcount) 
	Placing(rowcount)=Request.Form(Placingcount )
	AClass(rowcount)=Request.Form(AClasscount )
	AwardDescription(rowcount)=Request.Form(AwardDescriptioncount) 
	rowcount = rowcount +1
	
Wend

rowcount = 1

while (rowcount < 21)
	
	If  Len(AwardYear(rowcount)) < 2 Then
			AwardYear(rowcount) = "0" 
	End If 

	If  Len(Show(rowcount)) < 2  Then
		Show(rowcount) = "0" 
	End If 

	If Len(Placing(rowcount))< 2 Then
		Placing(rowcount) = "0" 
	End If 

	If Len(AwardDescription(rowcount))< 2 Then
		AwardDescription(rowcount) = "0" 
	End If 


	str1 = Show(rowcount)
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Show(rowcount)= Replace(str1, "'", "''")
	End If


str1 = Placing(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Placing(rowcount)= Replace(str1, "'", "''")
End If


str1 = AwardDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	AwardDescription(rowcount)= Replace(str1, "'", "''")
End If


	

Query =  "INSERT INTO Awards ( ID, AwardYear, Show, Placing, Type, Awardcomments )" 
	Query =  Query + " Values (" &  ID & ","
	Query =  Query &  " '" & AwardYear(rowcount) & "', " 
	Query =  Query &  " '" & Show(rowcount) & "', " 
	Query =  Query &  " '" & Placing(rowcount) & "', " 
		Query =  Query &  " '" &  AClass(rowcount) & "', " 
   Query =  Query &   " '" & AwardDescription(rowcount) & "' )" 

'response.write("Query=")	
'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

DataConnection.Execute(Query) 

rowcount = rowcount +1

wend


	DataConnection.Close
	Set DataConnection = Nothing 
end if 


%>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<td class = "body">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body"><img src = "images/WizardHeader.jpg">
			<a name="Add"></a>
			<blockquote><H1>Step 6: Pricing</H1>
			Here you can enter up to 20 awards for you animal. There is room to enter the name of the show, your placing, and some Description (i.e. "placed first in a class of 12" or 'the judge said his fleece was outstanding").<br>
			<br></blockquote>

		</td>
	</tr>
	
</table>

  </td>
  </tr>
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "700">
	<tr>
		<td class = "body">
			<h2><font color = "brown">Step 6: Pricing</font> <small></small></h2><br>
		</td>
	</tr>
	</table>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<th  valign = "bottom" width = "150">Stud Fee (if applicable)</th>
		<th  valign = "bottom" width = "180">ForSale?</th>
		<th  valign = "bottom" align = "center" width = "110">Price<br> 
		<small>Must be a number</small></th>
				<th  valign = "bottom" align = "left" >Discount </th>
		<th  valign = "bottom" align = "left">Price Comments</th>

	</tr>



	<form action= 'AddanAlpaca7.asp' method = "post" action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>">
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
    <tr >
		<td class = "body" valign = "top" align = "center"><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='studfee' size=10 maxlength=10></td>
	
		<td class = "body" valign = "top" align = "center">True<input TYPE="RADIO" name="ForSale" Value = "Yes" >
		False<input TYPE="RADIO" name="ForSale" Value = "No" checked></td>

	<td class = "body" valign = "top" align = "center"><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='price' size=10 maxlength=10></td>





	<td class = "body" valign = "top"><select size="1" name="discount">
					<option value="" selected></option>
					<option value="10">10%</option>
					<option  value="20">20%</option>
					<option  value="25">25%</option>
					<option  value="30">30%</option>
					<option  value="40">40%</option>
					<option  value="50">50%</option>
					<option  value="60">60%</option>
					<option  value="70">70%</option>
					<option  value="75">75%</option>
					<option  value="80">80%</option>
					<option  value="90">90%</option>
					<option  value="100">100%</option>
				</select></td>
	<td class = "body" valign = "top"><textarea name="PriceComments" cols="30" rows="7" wrap="VIRTUAL" ><%= PriceComments%></textarea>	</td>	
		
		
	</tr>


<tr>
		<td colspan = "10" align = "center" valign = "middle">
			<img src = "images/underline.jpg" width = "700"><br>
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<input type=submit Value = "Next ->" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
		</td>
</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
