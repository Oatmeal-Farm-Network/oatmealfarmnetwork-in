<!DOCTYPE HTML >

<HTML>
<HEAD>
 <title>Add an Animal Step 6</title>
<link rel="stylesheet" type="text/css" href="/style.css">
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
var checkOK = "0123456789$." + comma ;
var checkStr = objName;
var allValid = true;
var decPoints = 2;
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
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 
<% Current2="AddAlpaca" %> 
<!--#Include file="MembersHeader.asp"-->
<%

Dim TotalCount
dim rowcount
	dim AwardYear(40000)
	dim Show(40000)
	dim AClass(40000)
	dim Placing(40000)
	dim AwardDescription(40000)

ID=Request.Form("ID")
if len(ID) > 0 then
else
ID = Request.querystring("ID")
end if

SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if

			 sql2 = "select * from awards where ID = " &  ID & ";" 
'response.Write("ID=" & ID)			
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof Then
'response.write(sql2)
TotalCount = 13
rowcount = 1
while (rowcount < 14)
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

while (rowcount < 14)
	
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

Conn.Execute(Query) 

rowcount = rowcount +1

wend



end if 

 sql2 = "select * from animals where ID = " &  ID & ";" 
			
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If Not  rs2.eof Then
	category = rs2("category")
	End If
	rs2.close
%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top" height = "650">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 35 %>" align = "center" >
	<tr>
		<td class = "body">
			<h2><font color = "black">Pricing</font></h2><br>
		</td>
	</tr>

	<form action= 'MembersAnimalAdd7.asp?wizard=True&PeopleID=<%=PeopleID %>&ID=<%=ID%>' method = "post" action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>">
	<input type = "hidden" name="ID" Value = "<%=  ID%>">

<tr>
<td>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" ><tr bgcolor = "#ffffcc">
<td  align = "right"  height = "30" class = "body2" ><b>For Sale?</b>&nbsp;</td>
<td   class = "body2"  align = "left"> Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" checked>
No<input TYPE="RADIO" name="ForSale" Value = "No" > </td>
</tr>	
<tr bgcolor = "#ffffcc">
<td  align = "right"  height = "30" class = "body2" ><b>Free?</b>&nbsp;</td>
<td   class = "body2"  align = "left"> Yes<input TYPE="RADIO" name="Free" Value = "Yes" >
No<input TYPE="RADIO" name="Free" Value = "No" checked > </td>
</tr>	
<tr>
<td  align = "right" class = "body2" ><div align = "right"><b>Price:</b>&nbsp;</div></td>
<td  valign = "top"  class = "body2" align = "left">$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='Price' size=10 maxlength=10  align = "left">  <small>Must be a number</small></td>
</tr>
<tr >
<td class = "body2" height = "30" align = "right">
<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info" align = "left"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</span></a>
		
		</td>
		<td align = "left" class = "body2">
		<% 		
		if OBO = "Yes" Or OBO = True Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="OBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" >
			No<input TYPE="RADIO" name="OBO" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
	<tr> 
		<td  align = "right" class = "body2" ><b>Discount:</b>&nbsp; </td>
		<td  valign = "bottom"  class = "body2"  align = "left"> <select size="1" name="discount">
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
				</select> </td>
	</tr>
	<tr>
			<td  align = "right" class = "body2" valign = "top"><b>Price Comment:</b>&nbsp; <br />
			</td>
		<td  valign = "top" align = "left" class = "body2" >(a short comment like "Great Price!" or "Wonderful Fiber!")
	<br>
	<textarea name="PriceComments" cols="45" rows="2" wrap="VIRTUAL" ><%= PriceComments%></textarea> </td>
	</tr>


<% If trim(category) = "Experienced Female" Or trim(category) = "Inexperienced female" Then %>
<tr ><td class = "body2"  align = "right" valign = "top">
<a class="tooltip" href="#"><b> Embryos For Sale?:</b><span class="custom info"  align = "left"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Embryos For Sale?</em>Are you offering for sale embryos donated by this animal?</span></a>
		
		</td>
		<td align = "left" class = "body2">
		<% 		
		if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
<tr>
<td class = "body2" height = "30" align = "right"><b>Embryo Price:</b>
</td>
<td align = "left" >
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name="EmbryoPrice" size=3 maxlength=6 Value= "<%= EmbryoPrice%>"> per embryo.
				</td>
		</tr>
<% end if

If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			If Len(StudFee) < 2 Then
				StudFee = ""
			End If
		%>
		<tr>
				<td class = "body2" height = "30" align = "right"><b>Stud Fee:</b>
				</td>
		<td align = "left" >
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
				</td>
		</tr>
        <tr >
				<td class = "body2"  align = "right" valign = "top">
<a class="tooltip" href="#"><b>  Semen For Sale?:</b><span class="custom info"  align = "left"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Semen For Sale?</em>Are you offering for sale semen donated by this animal?</span></a>
		
		</td>
		<td align = "left" class = "body2">
		<% 		
		if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
        		<tr>
				<td class = "body2" height = "30" align = "right"><b>Semen price:</b>
				</td>
		<td align = "left" >
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name="SemenPrice" size=3 maxlength=6 Value= "<%= SemenPrice%>"> per straw.
				</td>
		</tr>
		<tr >
				<td class = "body2"  align = "right" valign = "top">
<a class="tooltip" href="#"><b>  Offer Pay What You Can Stud Breedings?:</b><span class="custom info"  align = "left"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>About Pay What You Can </em>By offering <i>Pay What You Can</i>you are adding the ability for potential buyers to make you an offer on a  Stud Breeding based upon what they can afford; however, that does not mean that you have to accept an offer, if you don't want to.</span></a>
		</td>
		<td align = "left" class = "body2">
		<% 		
		if PayWhatYouCanStud = "Yes" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" checked>
		<% End If %>
		<br><br>
		</td>
		</tr>
	<tr>
	
		
	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>
	
	
	

	<tr>
		<td   align = "right" class = "body2" ><b>Foundation Animal?</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2"  align = "left">Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" >
			No<input TYPE="RADIO" name="Foundation" Value = "No" checked>  </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerBusiness1' value='<%=CoOwnerBusiness1%>' size=20 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerName1' value='<%=CoOwnerName1%>' size=20 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left">http://<input type=text name='CoOwnerLink1' value='<%=CoOwnerLink1%>' size=20>  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerBusiness2' value='<%=CoOwnerBusiness2%>' size=20 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerName2' value='<%=CoOwnerName2%>'  size=20 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left">http://<input type=text name='CoOwnerLink2' value='<%=CoOwnerLink2%>' size=20>  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerBusiness3' value='<%=CoOwnerBusiness3%>' size=20 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left"> <input type=text name='CoOwnerName3' value='<%=CoOwnerName3%>' size=20 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body2" align = "left">http://<input type=text name='CoOwnerLink3'  value='<%=CoOwnerLink3%>' size=20>  </td>
	</tr>
	<tr>
		<td  align = "right" valign = "middle" colspan = "2"><br />
            <Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<input type=submit Value = "Save & Proceed to Next Page" size = "110" class = "regsubmit2" ><br />
			</form>
		</td>
</tr>
</table>
		</td>
		
</tr>
</table>
	</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->
</Body>
</HTML>
