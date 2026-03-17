<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body>


<SCRIPT LANGUAGE="JavaScript">
<!--    Begin
    function checkNumeric(objName, minval, maxval, comma, period, hyphen) {
        var numberfield = objName;
        if (chkNumeric(objName, minval, maxval, comma, period, hyphen) == false) {
            numberfield.select();
            numberfield.focus();
            return false;
        }
        else {
            return true;
        }
    }

    function chkNumeric(objName, minval, maxval, comma, period, hyphen) {
        // only allow 0-9 be entered, plus any values passed
        // (can be in any order, and don't have to be comma, period, or hyphen)
        // if all numbers allow commas, periods, hyphens or whatever,
        // just hard code it here and take out the passed parameters
        var checkOK = "0123456789$ " + comma + period;
        var checkStr = objName;
        var allValid = true;
        var decPoints = 0;
        var allNum = "";

        for (i = 0; i < checkStr.value.length; i++) {
            ch = checkStr.value.charAt(i);
            for (j = 0; j < checkOK.length; j++)
                if (ch == checkOK.charAt(j))
                    break;
            if (j == checkOK.length) {
                allValid = false;
                break;
            }
            if (ch != ",")
                allNum += ch;
        }
        if (!allValid) {
            alertsay = "Please enter only these values \""
            alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
            alert(alertsay);
            return (false);
        }

        // set the minimum and maximum
        var chkVal = allNum;
        var prsVal = parseInt(allNum);
        if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval)) {


        }
    }
//  End -->
</script>
<SCRIPT LANGUAGE="JavaScript">

<!--    Begin
    var submitcount = 0;
    function checkSubmit() {

        if (submitcount == 0) {
            submitcount++;
            document.Surv.submit();
        }
    }


    function wordCounter(field, countfield, maxlimit) {
        wordcounter = 0;
        for (x = 0; x < field.value.length; x++) {
            if (field.value.charAt(x) == " " && field.value.charAt(x - 1) != " ") { wordcounter++ }  // Counts the spaces while ignoring double spaces, usually one in between each word.
            if (wordcounter > 250) { field.value = field.value.substring(0, x); }
            else { countfield.value = maxlimit - wordcounter; }
        }
    }

    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
        { field.value = field.value.substring(0, maxlimit); }
        else
        { countfield.value = maxlimit - field.value.length; }
    }
//  End -->
</script>

<a name="EPD"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "100%" ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">EPDs</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top" width = "100%">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Awards Changes Have Been Made.</b></font></div>
<% end if %>

<% RecordCount = request.QueryString("RecordCount")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if


Set rs2 = Server.CreateObject("ADODB.Recordset")
sql = "select * from EPDAlpacas where AnimalID = " & ID
rs2.Open sql, conn, 3, 3   
	
        
if rs2.eof then
Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
Query =  Query & " Values ('" &  ID & "')"
Conn.Execute(Query) 
if rs2.state = 0 then
else
rs2.close
end if

sql = "select * from EPDAlpacas where AnimalID = " & ID
rs2.Open sql, conn, 3, 3   
end if



If RecordCount  < 11 Then
	NeedToAdd = 12 - RecordCount
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
		Query =  Query & " Values ('" &  ID & "')"

Conn.Execute(Query) 
		NeedToAdd = NeedToAdd - 1
	wend
	
sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = RecordCount +1


End If 
%>
<form action= 'AdminEDPHandleForm.asp' method = "post" name = "fiberform">
<%
if Not rs2.eof  then
 AnimalID=   rs2("AnimalID")
AFD =   rs2("AFD")
AFDAcc =   rs2("AFDAcc")
AFDRank =   rs2("AFDRank")
AFDRank2 =   rs2("AFDRank2")
SDAFD =   rs2("SDAFD")
SDAFDAcc =   rs2("SDAFDAcc")
SDAFDRank =   rs2("SDAFDRank")
SDAFDRank2 =   rs2("SDAFDRank2")
SF =   rs2("SF")
SFAcc =   rs2("SFAcc")
SFRank =   rs2("SFRank")
SFRank2 =   rs2("SFRank2")
PercentFGreaterThan30 = rs2("PercentFGreaterThan30")
percentFgreaterThan30Acc =   rs2("percentFgreaterThan30Acc")
percentFGreaterThan30Rank =   rs2("percentFGreaterThan30Rank")
percentFGreaterThan30Rank2 =   rs2("percentFGreaterThan30Rank2")
MC =   rs2("MC")
MCAcc =   rs2("MCAcc")
MCRank =   rs2("MCRank")
MCRank2 =   rs2("MCRank2")
SDMC =   rs2("SDMC")
SDMCAcc =   rs2("SDMCAcc")
SDMCRank =   rs2("SDMCRank")
SDMCRank2 =   rs2("SDMCRank2")
PercentM =   rs2("PercentM")
PercentMAcc =   rs2("PercentMAcc")
PercentMRank =   rs2("PercentMRank")
PercentMRank2 =   rs2("PercentMRank2")
MSL =   rs2("MSL")
MSLAcc =   rs2("MSLAcc")
MSLRank =   rs2("MSLRank")
MSLRank2 =   rs2("MSLRank2")
FW =   rs2("FW")
FWAcc =   rs2("FWAcc")
FWRank =   rs2("FWRank")
FWRank2 =   rs2("FWRank2")
BW =   rs2("BW")
BWAcc =   rs2("BWAcc")
EPDDate =   rs2("EPDDate")
 end if

if AFDRank = "0" then
AFDRank = ""
end if

if AFDRank2 = "0" then
AFDRank2 = ""
end if

if percentFGreaterThan30Rank = "0" then
percentFGreaterThan30Rank = ""
end if

if percentFGreaterThan30Rank2 = "0" then
percentFGreaterThan30Rank2 = ""
end if


if MCRank = "0" then
MCRank = ""
end if

if MCRank2 = "0" then
MCRank2 = ""
end if

if PercentMRank = "0" then
PercentMRank = ""
end if

if PercentMRank2 = "0" then
PercentMRank2 = ""
end if


if SFRank = "0" then
SFRank = ""
end if

if SFRank2 = "0" then
SFRank2 = ""
end if


if MSLRank = "0" then
MSLRank = ""
end if

if MSLRank2 = "0" then
MSLRank2 = ""
end if

if FWRank = "0" then
FWRank = ""
end if

if FWRank2 = "0" then
FWRank2 = ""
end if


if SDMCRank = "0" then
SDMCRank = ""
end if

if SDMCRank2 = "0" then
SDMCRank2 = ""
end if

if SDAFDRank = "0" then
SDAFDRank = ""
end if

if SDAFDRank2 = "0" then
SDAFDRank2 = ""
end if

%>
<input type = "hidden" name="AnimalID" value="<%=AnimalID%>" >
<table border = "0" width = "100%"  align = "center">
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = 'right'><div align ="right"><b>Trait</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Value</b></div></td>
<td class = "body2"><div align ="center"><b>Accuracy</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Rank</b></div></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">AFD<span class="custom info"><em><div align = "left">Average Fiber Diameter (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="AFD" size = "5" maxlength = 5 value="<%=AFD%>"></td>
<td class = "body2" align = "center"><input name="AFDAcc" value="<%= AFDAcc%>"  size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="AFDRank" value="<%= AFDRank%>"  size = "5" maxlength = 5> Of <input name="AFDRank2" value="<%= AFDRank2%>"   size = "5"></td>
</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD AFD<span class="custom info"><em><div align = "left">Standard Deviation (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDAFD" size = "5" maxlength = 5 value="<%=SDAFD%>"></td>
<td class = "body2" align = "center"><input name="SDAFDAcc" value="<%= SDAFDAcc%>"  size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="SDAFDRank" value="<%= SDAFDRank%>" size = "5" maxlength = 5> Of <input name="SDAFDRank2" value="<%= SDAFDRank2%>" size = "5" maxlength = 5></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%F>30m:<span class="custom info"><em><div align = "left">Percent of Fibers larger than 30 microns (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentFGreaterThan30"  size = "5" maxlength = 5 value="<%=PercentFGreaterThan30%>"></td>
<td class = "body2" align = "center"><input name="percentFgreaterThan30Acc" value="<%=percentFgreaterThan30Acc%>"  size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="percentFGreaterThan30Rank" value="<%=percentFGreaterThan30Rank%>"  size = "5" maxlength = 5> Of <input name="percentFGreaterThan30Rank2" value="<%=percentFGreaterThan30Rank2%>" size = "5" maxlength = 5></td>
</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SF<span class="custom info"><em><div align = "left">Spin Fineness (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SF" size = "5" maxlength = 5 value="<%=SF%>"></td>
<td class = "body2" align = "center"><input name="SFAcc" value="<%=SFAcc%>" size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="SFRank" value="<%= SFRank%>"  size = "5" maxlength = 5> Of <input name="SFRank2" value="<%= SFRank2%>" size = "5" maxlength = 5></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">FW:<span class="custom info"><em><div align = "left">Fleece Weight</div></em></span></a></td>
<td class = "body2" align = "center"><input name="FW" size = "5" maxlength = 5 value="<%=FW%>"></td>
<td class = "body2" align = "center"><input name="FWAcc" value="<%=FWAcc%>" size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="FWRank" value="<%=FWRank%>" size = "5" maxlength = 5> Of <input name="FWRank2" value="<%=FWRank2%>"  size = "5" maxlength = 5></td>
</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SL:<span class="custom info"><em><div align = "left">Mean Staple Length (mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MSL" size = "5" maxlength = 5 value="<%=MSL%>"></td>
<td class = "body2" align = "center"><input name="MSLAcc" value="<%=MSLAcc%>"  size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="MSLRank" value="<%=MSLRank%>" size = "5" maxlength = 5> Of <input name="MSLRank2" value="<%=MSLRank2%>"  size = "5" maxlength = 5></td>
</tr>


<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">MC:<span class="custom info"><em><div align = "left">Mean Curvature (deg/mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MC" size = "5" maxlength = 5 value="<%=MC%>"></td>
<td class = "body2" align = "center"><input name="MCAcc" value="<%=MCAcc%>" size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="MCRank" value="<%=MCRank%>" size = "5" maxlength = 5> Of <input name="MCRank2" value="<%=MCRank2%>" size = "5" maxlength = 5></td>
</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD C:<span class="custom info"><em><div align = "left">Standard Deviation of Curvature</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDMC" size = "5" maxlength = 5 value="<%=SDMC%>"></td>
<td class = "body2" align = "center"><input name="SDMCAcc" value="<%=SDMCAcc%>"  size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="SDMCRank" value="<%=SDMCRank%>"  size = "5" maxlength = 5> Of <input name="SDMCRank2" value="<%=SDMCRank2%>"  size = "5" maxlength = 5"></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%M:<span class="custom info"><em><div align = "left">Percent Medullation (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentM"  size = "5" value="<%=PercentM%>"></td>
<td class = "body2" align = "center"><input name="PercentMAcc" value="<%=PercentMAcc%>" size = "5" maxlength = 5></td>
<td class = "body2" align = "center"><input name="PercentMRank" value="<%=PercentMRank%>"  size = "5" maxlength = 5> Of <input name="PercentMRank2" value="<%=PercentMRank2%>"  size = "5" maxlength = 5></td>
</tr>
</table>
<%
rs2.close
%>
<table width = "800" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0><tr><td class = "body2" align = "center">Note: only numbers are allowed in the above fields. <br />Any non-numerical characters will automatically be removed.<br>
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<input type=submit value = "Submit EPD Changes"  size = "110" Class = "regsubmit2" >
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>
<%conn.close
set Conn = nothing %>
</body>
</html>