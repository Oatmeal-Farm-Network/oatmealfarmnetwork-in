<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="membersGlobalVariables.asp"-->

<%
variables = ""
ProdName=request.querystring("ProdName") 
if len(ProdName) > 0 then
else
ProdName=request.form("ProdName") 
end if
variables = variables & "&ProdName=" & ProdName


ProdQuantityAvailable=request.querystring("ProdQuantityAvailable") 
if len(ProdQuantityAvailable) > 0 then
else
ProdQuantityAvailable=request.form("ProdQuantityAvailable") 
end if
variables = variables & "&ProdQuantityAvailable=" & ProdQuantityAvailable

ProdPrice =request.querystring("ProdPrice")
if len(ProdPrice) > 0 then
else
ProdPrice=request.form("ProdPrice") 
end if
variables = variables & "&ProdPrice=" & ProdPrice

SalePrice =request.querystring("SalePrice")
if len(SalePrice) > 0 then
else
SalePrice=request.form("SalePrice") 
end if
variables = variables & "&SalePrice=" & SalePrice


'prodCategory1ID=request.querystring("prodCategory1ID") 
'if len(prodCategory1ID) > 0 then
'else
'prodCategory1ID=request.form("prodCategory1ID") 
'end if
'variables = variables & "&prodCategory1ID=" & prodCategory1ID


'prodCategory2ID=request.querystring("prodCategory2ID") 
'if len(prodCategory2ID) > 0 then
'else
'prodCategory2ID=request.form("prodCategory2ID") 
'end if
'variables = variables & "&prodCategory2ID=" & prodCategory2ID

'response.write("prodCategory2ID=" & prodCategory2ID )

ProdForSale =request.querystring("ProdForSale")
if len(ProdForSale) > 0 then
else
ProdForSale=request.form("ProdForSale") 
end if
variables = variables & "&ProdForSale=" & ProdForSale


prodCustomOrder = request.querystring("prodCustomOrder")
if len(prodCustomOrder) > 0 then
else
prodCustomOrder=request.form("prodCustomOrder") 
end if
variables = variables & "&prodCustomOrder=" & prodCustomOrder


prodCallForPrice=request.querystring("prodCallForPrice") 
if len(prodCallForPrice) > 0 then
else
prodCallForPrice=request.form("prodCallForPrice") 
end if
variables = variables & "&prodCallForPrice=" & prodCallForPrice


Missing = "?Missing=True"

if len(ProdName) > 0 then
else
  missing= missing & "&MissingProdName=true"
end if

'if len(prodCategory1ID) > 0 then
'if prodCategory1ID > 1 then
'else
'missing= missing & "&Missingcategory=true"
'end if

'else
 ' missing= missing & "&Missingcategory=true"
'end if


 str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1,  str2, "''")
End If

sql2 = "select * from sfProducts where ProdName = '" & ProdName & "' and peopleid = " & session("peopleid") & " order by ProdID"
'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if  Not rs2.eof then
ProdNameFound = True
ProdID = cint(rs2("ProdID"))
   
session("ID") = cint(rs2("ProdID"))
session("ProdID") = cint(rs2("ProdID"))
	
	End if
rs2.close


if ProdNameFound = True then
'Conn.close
'set conn=nothing 
 'response.Redirect("membersClassifiedAdPlace0.asp" & Missing & "&ProdNameFound=true" & variables)
end if

 if len(Missing) > 13 then
Conn.close
set conn=nothing 
response.Redirect("membersClassifiedAdPlace0.asp" & Missing & variables)
end if




'Category3ID=request.querystring("Category3ID") 
'Category3ID=request.querystring("Category3ID") 
Subject="For Sale"
'MissingSubCategory = request.QueryString("MissingSubCategory")
MissingProdName = request.QueryString("MissingProdName")
MissingProdPrice= request.QueryString("MissingProdPrice")
'Missingcategory= request.QueryString("Missingcategory")
ProductID=request.querystring("ProductID") 
'prodSubCategory1ID = request.querystring("prodSubCategory1ID")
'prodSubCategory2ID = request.querystring("prodSubCategory2ID") 
'prodSubCategory3ID = request.querystring("prodSubCategory3ID")


prodCustomOrder =request.querystring("prodCustomOrder")
if len(ProdForSale) > 0 then
else
ProdForSale = True
end if
ProdAnimalID =request.querystring("ProdAnimalID")
ProdProductID =request.querystring("ProdProductID")
ProdDescription   =request.querystring("ProdDescription")
ProdSellStore =request.querystring("ProdSellStore")
Prodsize1 =request.querystring("Prodsize1")
Prodsize2 =request.querystring("Prodsize2")
Prodsize3 =request.querystring("Prodsize3")
Prodsize4 =request.querystring("Prodsize4")
Prodsize5 =request.querystring("Prodsize5")
Prodsize6=request.querystring("Prodsize6")
Prodsize7 =request.querystring("Prodsize7")
Prodsize8 =request.querystring("Prodsize8")
Prodsize9 =request.querystring("Prodsize9")
Prodsize10 =request.querystring("Prodsize10")
ExtraCost1 =request.querystring("ExtraCost1")
ExtraCost2 =request.querystring("ExtraCost2")
ExtraCost3 =request.querystring("ExtraCost3")
ExtraCost4 =request.querystring("ExtraCost4")
ExtraCost5 =request.querystring("ExtraCost5")
ExtraCost6=request.querystring("ExtraCost6")
ExtraCost7 =request.querystring("ExtraCost7")
ExtraCost8 =request.querystring("ExtraCost8")
ExtraCost9 =request.querystring("ExtraCost9")
ExtraCost10 =request.querystring("ExtraCost10")

Color1=request.querystring("Color1" )
Color2=request.querystring("Color2" ) 
Color3=request.querystring("Color3" ) 
Color4=request.querystring("Color4" ) 
Color5=request.querystring("Color5" ) 
Color6=request.querystring("Color6" ) 
Color7=request.querystring("Color7" ) 
Color8=request.querystring("Color8" ) 
Color9=request.querystring("Color9" ) 
Color10=request.querystring("Color10") 
Color11=request.querystring("Color11" ) 	
Color12=request.querystring("Color12") 
Color13=request.querystring("Color13") 
Color14=request.querystring("Color14") 
Color15=request.querystring("Color15")
Color16=request.querystring("Color16")
Color17=request.querystring("Color17")
Color18=request.querystring("Color18")
Color19=request.querystring("Color19")
Color20=request.querystring("Color20")

Color21=request.querystring("Color21")
Color22=request.querystring("Color22")
Color23=request.querystring("Color23")
Color24=request.querystring("Color24")
Color25=request.querystring("Color25")
Color26=request.querystring("Color26")
Color27=request.querystring("Color27")
Color28=request.querystring("Color28")
Color29=request.querystring("Color29")
Color30=request.querystring("Color30")

Color31=request.querystring("Color31") 
Color32=request.querystring("Color32")
Color33=request.querystring("Color33")
Color34=request.querystring("Color34")
Color35=request.querystring("Color35")
Color36=request.querystring("Color36")
Color37=request.querystring("Color37")
Color38=request.querystring("Color38")
Color39=request.querystring("Color39")
Color40=request.querystring("Color40")

Color41=request.querystring("Color41")
Color42=request.querystring("Color42")
Color43=request.querystring("Color43")
Color44=request.querystring("Color44")
Color45=request.querystring("Color45")
Color46=request.querystring("Color46")
Color47=request.querystring("Color47")
Color48=request.querystring("Color48")
Color49=request.querystring("Color49")
Color50=request.querystring("Color50")

ProdMadeIn=request.querystring("ProdMadeIn")

ProdFiberType1=request.querystring("ProdFiberType1") 
ProdFiberType2=request.querystring("ProdFiberType2") 
ProdFiberType3=request.querystring("ProdFiberType3") 
ProdFiberType4=request.querystring("ProdFiberType4") 
ProdFiberType5=request.querystring("ProdFiberType5") 
prodFiberPercent1=request.querystring("prodFiberPercent1") 
prodFiberPercent2=request.querystring("prodFiberPercent2")
prodFiberPercent3=request.querystring("prodFiberPercent3")
prodFiberPercent4=request.querystring("prodFiberPercent4")
prodFiberPercent5=request.querystring("prodFiberPercent5")





'if len(prodCategory1ID) > 0 then
 '   if prodCategory1ID > 0 then
  '  sql = "select CatName from SFCategories where CatID= " & prodCategory1ID
    'response.write("sql=" & sql)
'	Set rs = Server.CreateObject("ADODB.Recordset")
'    rs.Open sql, Conn, 3, 3 
'        if not rs.eof then
'            Category1 = rs("CatName")
'        end if 
'        rs.close
'    end if
'end if

'if len(Category2ID) > 0 then
'    if Category2ID > 0 then
'    sql = "select CatName from SFCategories where CatID= " & Category2ID
'	Set rs = Server.CreateObject("ADODB.Recordset")
'    rs.Open sql, conn, 3, 3 
'        if not rs.eof then
'            Category2 = rs("CatName")
'        end if 
'           rs.close
'    end if
'end if

'if len(Category3ID) > 0 then
'    if Category3ID > 0 then
'    sql = "select CatName from SFCategories where CatID= " & Category3ID
'	Set rs = Server.CreateObject("ADODB.Recordset")
'    rs.Open sql, conn, 3, 3 
'        if not rs.eof then
'            Category3 = rs("CatName")
'        end if
'     rs.close       
'    end if
'end if
%>


<% 
Session("Step2") = False 
Session("PhotoPageCount") = 0
'*******************Get Customer Location *********************
'sql = "select AddressID from People where Peopleid = 695;" 
'response.write(sql2)
'	Set rs = Server.CreateObject("ADODB.Recordset")
'    rs.Open sql, conn, 3, 3 
'AddressID = rs("AddressID")
'rs.close

'sql = "select * from Address where AddressID = " & AddressID 
'response.write(sql2)
'Set rs = Server.CreateObject("ADODB.Recordset")
' rs.Open sql, conn, 3, 3 
'AddressCity = rs("AddressCity")
'AddressZip = rs("AddressZip")
'AddressState  = rs("AddressState")
'rs.close

If SubCategoryIDCount > 0 then
sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
Set rs = Server.CreateObject("ADODB.Recordset")
	'Response.write(sql)
	rs.Open sql, conn, 3, 3 
	CatCounter= 0
	For CatCounter = 0 To (SubCategoryIDCount -1 )
		If Not( rs. eof )Then
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)
		
			rs.movenext
		End If
	Next
	rs.MovePrevious
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)


 sql = "select * from SFSubCategories where subcatId = " & SubCategoryID & ";"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	If Not rs.eof Then
		SubCategoryName = rs("SubCategoryName")

	End If

End If 
%>


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

<body >

<% Current1="Products"
Current2 = "AddaProduct"
Current3 = "Add" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<% If not rs.State = adStateClosed Then
 rs.close
End If %>

<div class =" container roundedtopandbottom">
<div>
   <div>
        <h2>Step 2: Add More Information</h2>
        <% ProdNameFound = Request.querystring("ProdNameFound")
        if ProdNameFound = "true" then%>
            <div>
               <div>
                    <font color = "maroon"><b>Product name already exists! Please enter a new product name.</font>
                </div>
            </div>
      <%= HSpacer %>
        <% end if%>

        <% if len(MissingProdName) > 0 or len(MissingProdName) > 0 or len(MissingProdPrice) > 0 or len(MissingSubCategory) > 0 then %>
          <div>
             <div>
               <font color = "maroon"><b>Missing Information!
                 <ul>
                <%  if len(MissingProdName) > 0 then %>
                    <li>Please enter a Product Name.</li>
                <% end if %>
                <%  if len(Missingcategory) > 0 then %>
                    <li>Please select a category.</li>
                <% end if %>
                <%  if len(MissingProdPrice) > 0 then %>
                    <li>Please enter a price greater than $0.</li>
                <% end if %>
                <%  if len(MissingSubCategory) > 0 then %>
                    <li>Please enter at least one category and subcategory.</li>
                    <% end if %>
                </ul></font></b>
     </div>
</div>
<% end if %>

<div>
    <div>
  <%= HSpacer %>
  </div>
</div>
<div>
    <div>
<form name="myform" method="post" action= 'membersClassifiedAdPlaceStep2.asp' >
<font color=maroon>*</font> Product Name&nbsp;<br>
<input name="ProdName" value="<%=ProdName %>" size = "40" class = "formbox"><br>
Product ID&nbsp;<br>
<input name="SKU" value="<%=SKU %>" size = "40" class = "formbox"><br>
  </div>
</div>
<div>
    <div><br />
    <iframe src="membersAddProductCategoriesInclude.asp?prodCategory1ID=<%=prodCategory1ID %>&prodCategory2ID=<%=prodCategory2ID %>&prodCategory3ID=<%=prodCategory3ID %>&prodSubCategory1ID=<%=prodSubCategory1ID %>&prodSubCategory2ID=<%=prodSubCategory2ID %>&prodSubCategory3ID=<%=prodSubCategory3ID %>&twocatagories=True" height = '280' width = '360' frameborder= '0' seamless = Yes scrolling = no  color = "#404040"></iframe><br><br />
  </div>
</div>
<div>
    <div>
        Price<br>
        $<input name="ProdPrice" type="number"  min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" value="<%=ProdPrice%>" class="formbox currency" id="c1" /><br>
        <i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
     <div>
    <div>
  <%= HSpacer %>
  </div>
</div>
<div>
    <div>
        Sale Price<br>
        $<input name="SalePrice" type="number"  min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" value="<%=SalePrice%>" class="formbox currency" id="c1" /><br>
        <i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
  </div>
</div>

<div>
    <div>
  <%= HSpacer %>
  </div>
</div>
<div>
    <div>
        Custom Order?
        <br>
        <% if prodCustomOrder = True  Then %>
            Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True checked>
            No<input TYPE="RADIO" name="prodCustomOrder" Value = False >
        <% Else %>
            Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True >
            No<input TYPE="RADIO" name="prodCustomOrder" Value = False checked>
        <% End if%>
        <br><i><font color = "#404040"><small>Customers cannot place custom orders online, they must contact you to place their order. </small></font></i><br>
       <div>
    <div>
  <%= HSpacer %>
  </div>
</div>
<div>
    <div>

        # Available<br>
        <% if len(ProdQuantityAvailable) < 1 then
            ProdQuantityAvailable = ""
          else
          if ProdQuantityAvailable = 0 then
            ProdQuantityAvailable = ""
         end if
end if%>

<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "20" class = "formbox"> 
<div>
    <div>
  <%= HSpacer %>
  </div>
</div>
<div>
    <div>
Made In<br>
<select size="1" name="ProdMadeIn" class = formbox>
<option value=""> - </option>

<%  sql = "select * from country order by name asc "
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
  while not rs.eof %>
    <option value="<%=rs("iso_code") %>"><%=rs("name") %></option>
   <% rs.movenext 
  wend%>
  
</select>

<div>
    <div>
  <%= HSpacer %>
  </div>
</div>
Description<br />
<textarea name="ProdDescription" ID="ProdDescription" cols="50" rows="12" class ="roundedtopandbottom"  ><%=ProdDescription%></textarea>
<br><br>
<div align = "center"><input type=submit value = "Save & Proceed" class = "regsubmit2"  <%=Disablebutton %> ></div>
</form>
<br />
</div>
</div>
</div>
</div>
</div>
</div>
        </div>
</div>
</div>
<br><br>
<!--#Include File="membersFooter.asp"--> 
</Body>
</HTML>