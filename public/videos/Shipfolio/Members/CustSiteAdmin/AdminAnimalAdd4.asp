<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<body >

<!--#Include file="AdminHeader.asp"--> 

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

<%	Dim TotalCount
	dim rowcount, ID

	dim FullName(40000)
	dim SampleAge(40000)
	dim SampleDateDay(40000)
	dim SampleDateMonth(40000)
	dim SampleDateYear(40000)
	dim Average(40000)
	dim StandardDev(40000)
	dim COV(40000)
	dim GreaterThan30(40000)
	dim CF(40000)
	dim Curve(40000)
	dim ShearWeight(40000)
	dim BlanketWeight(40000)
	dim Length(40000)
	dim CrimpPerInch(40000)


TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 0

ID=Request.Form("ID")
if len(ID) < 1 then
   ID=Request.querystring("ID")
end if
speciesID  = request.Form("speciesID")
			 sql2 = "select * from fiber where ID = " &  ID & ";" 
			'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof Then


For rowcount = 1 To 10
	FullNamecount = "FullName(" & rowcount & ")"
	SampleDateMonthcount = "SampleDateMonth(" & rowcount & ")"
		SampleDateDaycount = "SampleDateDay(" & rowcount & ")"
			SampleDateYearcount = "SampleDateYear(" & rowcount & ")"
	Averagecount = "Average(" & rowcount & ")"
	StandardDevcount = "StandardDev(" & rowcount & ")"
	COVcount = "COV(" & rowcount & ")"
	GreaterThan30count = "GreaterThan30(" & rowcount & ")"
	CFcount = "CF(" & rowcount & ")"
	Curvecount = "Curve(" & rowcount & ")"
	SampleAgecount = "SampleAge(" & rowcount & ")"
	ShearWeightcount = "ShearWeight(" & rowcount & ")"
	BlanketWeightcount = "BlanketWeight(" & rowcount & ")"
	Lengthcount = "Length(" & rowcount & ")"
	CrimpPerInchcount = "CrimpPerInch(" & rowcount & ")"
	
	
	FullName(rowcount)=Request.Form(FullNamecount) 
	SampleDateMonth(rowcount)=Request.Form(SampleDateMonthcount )
		SampleDateDay(rowcount)=Request.Form(SampleDateDaycount )
			SampleDateYear(rowcount)=Request.Form(SampleDateYearcount )
	Average(rowcount)=Request.Form(Averagecount) 
	StandardDev(rowcount)=Request.Form(StandardDevcount) 
	COV(rowcount)=Request.Form(COVcount) 
	GreaterThan30(rowcount)=Request.Form(GreaterThan30count) 
	CF(rowcount)=Request.Form(CFcount) 
	Curve(rowcount)=Request.Form(Curvecount) 
	SampleAge(rowcount)=Request.Form(SampleAgecount) 
	ShearWeight(rowcount)=Request.Form(ShearWeightcount) 
	BlanketWeight(rowcount)=Request.Form(BlanketWeightcount) 
	Length(rowcount)=Request.Form(Lengthcount) 
	CrimpPerInch(rowcount)=Request.Form(CrimpPerInchcount) 


    

Query =  "INSERT INTO Fiber ( ID, "
if len(SampleDateMonth(rowcount)) > 0 then
    Query =  Query & "SampleDateMonth, "
end if
if len(SampleDateDay(rowcount)) > 0 then
	Query =  Query & " SampleDateDay, "
end if
if len(SampleDateYear(rowcount)) > 0 then		
	Query =  Query & " SampleDateYear,"
end if			
		Query =  Query & " Average, StandardDev, COV,  ShearWeight, CF, Curve,  CrimpPerInch, Length, BlanketWeight, GreaterThan30)" 
	Query =  Query & " Values (" &  ID & " ,"
	if len(SampleDateMonth(rowcount)) > 0 then
	Query =  Query &  " '" & SampleDateMonth(rowcount) & "', " 
	end if
if len(SampleDateDay(rowcount)) > 0 then
	Query =  Query &  " '" & SampleDateDay(rowcount) & "', "
	end if
if len(SampleDateYear(rowcount)) > 0 then	 
	Query =  Query &  " '" & SampleDateYear(rowcount) & "', " 
end if
    Query =  Query &  " '" & Average(rowcount) & "'," 
    Query =  Query &   " '" & StandardDev(rowcount) & "'," 
    Query =  Query &  " '" &  COV(rowcount) & "'," 
	Query =  Query &  " '" &  ShearWeight(rowcount) & "'," 
	Query =  Query &  " '" & CF(rowcount) & "'," 
	Query =  Query &  " '" & Curve(rowcount) & "'," 
	Query =  Query &  " '" &  CrimpPerInch(rowcount) & "'," 
	Query =  Query &  " '" &  Length(rowcount) & "'," 
	Query =  Query &  " '" &  BlanketWeight(rowcount) & "'," 
    Query =  Query &  " '" & GreaterThan30(rowcount)  & "')" 

Conn.Execute(Query) 
	
next

 End If
%>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top" >
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0   width = "960" align = "center" >
	<tr>
		<td class = "body">
			<h2><font color = "black">Description</font></h2>
		</td>
	</tr>
	<tr>
		<td>
		
	</td>
</tr>
<form action= 'AdminAnimalAdd5.asp?wizard=True&PeopleID=<%=PeopleID %>&ID=<%=ID%>' method = "post" name = "myform">

	<tr>
	<td class = "body">
	<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" />
			<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.

WYSIWYG.attach("Description", mysettings);
mysettings.Width = "900px"
mysettings.Height = "300px"
 </script>
	
	
		<textarea name="Description" ID="Description"  ></textarea>
		</td>
	</tr>
<tr>
	<td colspan = "4" align = "right" ><br><br />
		<input type = "hidden" name="ID" value= "<%= ID%>" >
		<input type=submit Value = "Save & Proceed To Next Page" size = "110" class = "regsubmit2"  <%=Disablebutton %> ><br />
    </td>
</tr>
</table>
</form>
 </td>
</tr>
</table> </td>
</tr>
</table>
<br>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>
