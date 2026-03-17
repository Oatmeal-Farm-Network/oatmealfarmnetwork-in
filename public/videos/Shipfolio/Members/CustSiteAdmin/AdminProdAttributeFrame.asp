<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->

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
        var checkOK = "0123456789- " + comma + period;
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
</HEAD>
<%
Set rs = Server.CreateObject("ADODB.Recordset")

prodid = request.querystring("prodid")
Category1ID = request.querystring("Category1ID")
Category2ID = request.querystring("Category2ID")
Category3ID = request.querystring("Category3ID")
TotalCount = request.form("TotalCount")

dim attrDetailValue(1000)
dim attrDetailID(1000)
dim ExtraCostArray(1000)

Update = request.form("update")
if Update = "True" then
Update = "False"
rowcount = 0

while (rowcount < cint(TotalCount) )

attrDetailValuecount = "attrDetailValue(" & rowcount & ")"
attrDetailValue(rowcount)=Request.Form(attrDetailValuecount )
attrDetailIDcount = "attrDetailID(" & rowcount & ")"
attrDetailID(rowcount)=Request.Form(attrDetailIDcount)

ExtraCostcount = "ExtraCost(" & rowcount & ")"
ExtraCostArray(rowcount)=Request.Form(ExtraCostcount)

rowcount = rowcount +1
wend


rowcount = 0
while (rowcount < cint(TotalCount) )
Query =  " UPDATE sfattributeDetail Set attrDetailValue = '" &  attrDetailValue(rowcount)
if len(ExtraCostArray(rowcount)) > 0 then
Query = Query  & "', attDetailExtraCost = " & ExtraCostArray(rowcount) & " " 
else
Query = Query  & "' " 
end if

Query =  Query & " where attrDetailID = " & attrDetailID(rowcount) 

if len(attrDetailID(rowcount)) > 0 then

conn.Execute(Query) 
end if
rowcount = rowcount + 1
wend
end if


dim attrIDarray(999)
dim attrnamearray(999)
dim AddattributedetailIDarray(999)
Dim attrDisplayOrderArray(9999)
Dim attrControltypeArray(9999)
Dim attrRequiredArray(9999)
Dim attrAvailableToAllProdsArray(9999)
Dim attrCatagoryIdArray(9999)
Dim attrExtraCostAllowedArray(9999)


sql = "select * from sfattributes where (attrAvailableToAllProds = Yes  "
if len(Category1ID) > 0 then
sql = sql & " or (attrAvailableToAllProds = No and attrCatagoryId = " & Category1ID & ")"
end if
if len(Category2ID) > 0 then
sql = sql & " or (attrAvailableToAllProds = No and attrCatagoryId = " & Category2ID & ")"
end if
 if len(Category3ID) > 0 then
sql = sql & " or (attrAvailableToAllProds = No and attrCatagoryId = " & Category3ID & ")"
end if
sql = sql & " ) order by attrDisplayOrder " 

rs.Open sql, conn, 3, 3 
Counter= 0
while not rs.eof 
Counter = Counter + 1
attrIDarray(Counter) =  rs("attrID") 
attrnamearray(Counter) = rs("attrName")

attrDisplayOrderArray(Counter) = rs("attrDisplayOrder")
attrControltypeArray(Counter) = rs("attrControltype")
attrRequiredArray(Counter) = rs("attrRequired")
attrAvailableToAllProdsArray(Counter) = rs("attrAvailableToAllProds")
attrCatagoryIdArray(Counter) = rs("attrCatagoryId")
attrExtraCostAllowedArray(Counter) = rs("attrExtraCostAllowed")



rs.movenext
wend
totalcounter = Counter
Counter= 0
i = 0
while Counter < totalcounter
rs.close
Counter = Counter + 1
sql2 = "select * from sfattributeDetail where attrID = " & attrIDarray(Counter) & " and ProdID = " & prodid & " order by attrDetailOrder "
'response.write("sql2=" & sql2) 
rs.Open sql2, conn, 3, 3 
if rs.eof then
i = i + 1
AddattributedetailIDarray(i) = attrIDarray(Counter)
end if
wend
totalattributestoadd = i

i = 0

'response.write("i=" & i & "<br>") 
'response.write("totalattributestoadd=" & totalattributestoadd & "<br>") 
while i < totalattributestoadd
i = i + 1
'response.write(AddattributedetailIDarray(i))
Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" & AddattributedetailIDarray(i)  & "," & prodid & " )" 
conn.Execute(Query) 
Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" &  AddattributedetailIDarray(i)  & "," & prodid & " )" 
conn.Execute(Query) 
Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" &  AddattributedetailIDarray(i)  & "," & prodid & " )" 
conn.Execute(Query) 
wend
rs.close


'************************************************************
'  Find the Total Number of Attributes
'************************************************************
sql2 = "select * from sfattributeDetail where attrID = " & attrIDarray(Counter) & " and ProdID = " & prodid & " order by attrDetailOrder "
rs.Open sql2, conn, 3, 3 
if not rs.eof then
NumAttributes = rs.recordcount
end if
rs.close



'************************************************************
'  Find the Number of Filled Attributes
'************************************************************
sql2 = "select * from sfattributeDetail where attrID = " & attrIDarray(Counter) & " and ProdID = " & prodid & " and len(attrDetailvalue) order by attrDetailOrder "
rs.Open sql2, conn, 3, 3 
if not rs.eof then
NumFilledattributes = rs.recordcount
end if
rs.close

'response.write("NumAttributes=" & NumAttributes & "<br>")
'response.write("NumFilledattributes=" & NumFilledattributes & "<br>" )

if (NumAttributes-2) < NumFilledattributes then

Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" & attrIDarray(Counter)  & "," & prodid & " )" 
conn.Execute(Query) 
Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" &  attrIDarray(Counter)  & "," & prodid & " )" 
conn.Execute(Query) 
Query =  "INSERT INTO sfattributeDetail (attrID, prodid)" 
Query =  Query & " Values (" &  attrIDarray(Counter)  & "," & prodid & " )" 
conn.Execute(Query) 
end if


Counter= 0
i = 0
while Counter < totalcounter
Counter = Counter + 1
if rs.state = 0 then
else
rs.close
end if


sql2 = "select * from sfattributeDetail where attrID = " & attrIDarray(Counter) & " and ProdID = " & prodid & " order by attrDetailValue desc,  attrDetailOrder asc"
rs.Open sql2, conn, 3, 3 
if rs.eof then
i = i + 1
AddattributedetailIDarray(i) =  attrIDarray(Counter)
end if
wend
Counter= 0
i = 0
while Counter < totalcounter
Counter = Counter + 1 %>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left"  class = "roundedtopandbottom"><tr><td><h3>Attribute: <%=attrnamearray(Counter)%></h3><br /></td></tr>

<form action= "AdminProdAttributeFrame.asp?prodid=<%=prodid%>&Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>" method = "post">

<% 
rs.close

rowcount = 0

sql2 = "select * from sfattributeDetail where attrID = " & attrIDarray(Counter) & " and ProdID = " & prodid & " order by attrDetailValue desc, attrDetailOrder asc"
rs.Open sql2, conn, 3, 3 
if not rs.eof then %>
<tr bgcolor = "#cccccc"><td class = "body"><b>Value</b></td>
<% if attrExtraCostAllowedArray(Counter) = "True" then %>
<td class = "body" width = "80" ><b>Extra Cost</b></td>
<% end if%>
<td class = "body2" align = "center"></td>
<% if attrControltypeArray(Counter) = "Images Squares" then %>
<td class = "body2" align = "center"><b>Images</b></td>

<% end if%>


<% end if
while not rs.eof 
TempattrDetailID = rs("attrDetailID") 
TempattrDetailValue = rs("attrDetailValue") %>
<tr>
<td class = "body">
<input name="attrDetailID(<%=rowcount%>)" value= "<%=TempattrDetailID %>" type  ="hidden">
<input name="attrDetailValue(<%=rowcount%>)" value= "<%=TempattrDetailValue %>" size = "27" class = "body">
</td>
<% if attrExtraCostAllowedArray(Counter) = "True" then %>
<td class = "body" ><%=Currencycode%><input name = "ExtraCost(<%=rowcount%>)" type=text size = "2" onBlur="checkNumeric(this,-5,5000,',','.','-');" value ="<%=rs("attDetailExtraCost") %>" /></td>

<% end if%>

<td class = "body">
<iframe src="AdminFrameDeleteattributebutton.asp?ProdID=<%=ProdID %>&attrDetailID=<%=TempattrDetailID %>" height = '40' width = '70' frameborder= '0' valign=bottom seamless = Yes scrolling = no></iframe></td>

<% if attrControltypeArray(Counter) = "Images Squares" then %>

<td class = "body">
<iframe src="AdminFrameAddAttributephotos.asp?ProdID=<%=ProdID %>&attrDetailID=<%=TempattrDetailID %>&totalcounter=<%=totalcounter%>&Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>" height = '60' width = '500' frameborder= '0' seamless = Yes scrolling = no></iframe></td>

<% end if%>
</tr>

<%
rowcount = rowcount + 1
If Not rs.eof Then
rs.movenext
End if
Wend
%>
<tr>
<td  align = "center" colspan = "2">
<input type = "hidden" name="Update" value= "True" >
<input type = "hidden" name="TotalCount" value= "<%= rowcount%>" >
<div align = "center"><input type="Submit" class = "regsubmit2 body" value="Submit Attribute Changes"  ></div>
</form>
</td>
<% if attrControltypeArray(Counter) = "Images Squares" then %>
<td valign = "top" colspan = '2'>
<small><i>Note: Selecting the Submit Attribute Changes button will not upload images, and uploading images will not save your attributes.</i></small>
<% end if %>
</td>
</tr>
</table>
<BR /><img src="/images/px.gif" height = 5" width= "<%=screenwidth %>" />
<BR />
<% wend %>

</td>
</tr>
</table>


</body>
</html>