<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
   <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
 
 
    <!--#Include file="AdminHeader.asp"--> 


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
<%Action =  request.querystring("Action") 
    CouponID=request.form("CouponID") 
	CouponCode=Request.Form("CouponCode" ) 
	CouponDiscountType=Request.Form("CouponDiscountType" ) 
	CouponDiscountAmount=Request.Form("CouponDiscountAmount" ) 
	CouponMinimumPurchase=Request.Form("CouponMinimumPurchase" ) 
	CouponActive=Request.Form("CouponActive" ) 

	str1 = CouponCode
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		CouponCode= Replace(str1, "'", "''")
	End If

If Action = "Update" then
	Query =  " UPDATE SFCoupons Set CouponCode = '" & CouponCode & "' , " 
	Query =  Query & " CouponDiscountType = " & CouponDiscountType & ", " 
	Query =  Query & " CouponDiscountAmount = " & CouponDiscountAmount & ", " 
	Query =  Query & " CouponMinimumPurchase = " & CouponMinimumPurchase & ", " 
	Query =  Query & " CouponActive = " & CouponActive & " " 
    Query =  Query & " where CouponID = " & CouponID & ";" 
End If 

If Action = "Add" then
Query =  "INSERT INTO SFCoupons (CouponCode, CouponDiscountType, CouponDiscountAmount, CouponMinimumPurchase, CouponActive)" 
Query =  Query & " Values ('" &  CouponCode & "', '" & CouponDiscountType & "' , " & CouponDiscountAmount & " , " & CouponMinimumPurchase & " , " & CouponActive & ")"
		response.write(Query)
End If 
	If Len(Query) > 13 then
    	Set DataConnection = Server.CreateObject("ADODB.Connection")
        DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
    	DataConnection.Execute(Query) 
    	DataConnection.Close
	    Set DataConnection = Nothing 
    end if 
	
%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Coupons</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width= "900" >
	<tr>
	    <td width = "360">
<% Dim CouponID(100)
Dim CouponCode(100)
Dim CouponDiscountType(100)
Dim CouponDiscountAmount(100)
Dim CouponMinimumPurchase(100)
Dim CouponActive(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from SFcoupons  order by CouponCode " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CouponCounter= 0
	 While Not rs.eof 
		CouponCounter = CouponCounter + 1
		CouponID(CouponCounter) = rs("CouponID")
		CouponCode(CouponCounter) = rs("CouponCode")
		CouponActive(CouponCounter) = rs("CouponActive")
		CouponDiscountType(CouponCounter) = rs("CouponDiscountType")
		CouponDiscountAmount(CouponCounter) = rs("CouponDiscountAmount")
		CouponMinimumPurchase(CouponCounter) = rs("CouponMinimumPurchase")
		rs.movenext
	Wend
		FinalCouponCounter = CouponCounter

CouponCounter= 0
%>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "400">
			<tr>
		<td  class = "body" valign = "top" colspan = "3">
		<H2>Edit Coupons</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "3"></td>
        </tr>	
        <tr>
        <td class = "body" align = "center"><b>Name</b></td>
         <td class = "body" align = "center"><b>Display Page</b></td>
          <td></td>
        </tr>
<% While CouponCounter < FinalCouponCounter
	CouponCounter= CouponCounter +1 %>

			
			<tr>
			<td class = "body"> <form action= 'AdminCoupons.asp?Action=Update' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			<input name="CouponCode" value ="<%= CouponCode(CouponCounter) %>"  size = "20"></div>
			</td>
			<td class = "body"> 
				<% 	
		if CouponActive(CouponCounter) = "Yes" Or CouponActive(CouponCounter) = True Then %>
			True<input TYPE="RADIO" name="CouponActive" Value = "Yes" checked>
			False<input TYPE="RADIO" name="CouponActive" Value = "No" >
		<% Else %>
			True<input TYPE="RADIO" name="CouponActive" Value = "Yes" >
			False<input TYPE="RADIO" name="CouponActive" Value = "No" checked>
		<% End If %>
			</td>
			<td class = "body"> 	
			<select size="1" name="CouponDiscountType">	
			<option  value= "<%=CouponDiscountType%>" selected><%=CouponDiscountType%></option>
			<option  value="Percent Discount">Percent</option>
			<option  value="Free Shipping">Free Shipping</option>
			<option  value="Fixed Dollar Amount Discount">Fixed Dollar Amount Discount</option>
            </select>	
            </td>
            <td>	
			<input type=submit value = "submit"  class = "regsubmit2" >
			</form>
		</td>
		</tr>

<% wend %>
</table>
	    </td>


	    <td width = "500" valign = "top" class = "body">
	    
	    

<form action= 'AdminCoupons.asp?Action=Add' method = "post">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Create a New Coupon</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "470">
        <font color="gray"><b>Important:</b> Once you create a coupon, the name cannot be changed. You can only usa  name once.</font>
        
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" >
      <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
		<tr>
			<td class = "body2" align = "right" >
			<b>Coupon Code</b>
			</td>
			<td width ="3"></td>
			<Td class = "body"><input type=text  size = "25" maxlength=20 class = "body" ></Td>
			</tr>
			<tr>
			<td class = "body2" align = "right" >
		
			</td>
			<td width ="3"></td>
			<Td class = "body">
			<font color = "gray">Must be a alphanumeric code between 5 and 20 character (no spaces).</font></Td>
			</tr>
			    <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
			<tr>	
				<td class = "body2" align = "right">
				<b>Discount Type</b>
			</td>	
			<td width ="3"></td>
			<td class = "body"> 	
			<select size="1" name="CouponDiscountType" class = "body">	
			<option  value="Percent Discount">Percent</option>
			<option  value="Free Shipping">Free Shipping</option>
			<option  value="Fixed Dollar Amount Discount">Fixed Dollar Amount Discount</option>
            </select>	
            </td>
			</tr>
			    <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
        <tr>
			<td class = "body2" align = "right" >
			<b>Minimum Purchase</b>
			</td>
			<td width ="3"></td>
			<Td class = "body">$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="CouponDiscountAmount" size=10 maxlength=10 >USD</Td>
			</tr>
<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
         <tr>
			<td class = "body2" align = "right" valign = "top">
			<b>Status</b>
			</td>
			<td width ="3"></td>
			<Td class = "body">	
						<input TYPE="RADIO" name="CouponActive" Value = True ><b>Active</b> <font color="gray">available for immediate use.</font><br />
						<input TYPE="RADIO" name="CouponActive" Value = False checked><b>Inactive</b> <font color="gray">not available for use until set to active.</font>
	
				</Td>
			</tr>
			 <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "3" class = "body">
					<font color="gray">Note: percent or fixed dollar amount coupons need the discount amount (percent or dollar amount) set after you create them.</font>
						<center><input type=submit value = "Add Category" size = "110" class = "regsubmit2 body" ></center>
					</td>
			</tr>
			</table>
	
	
</td>
			</tr>
			</table>
					</form>
<br /><br />
<form action= 'AdminCoupons.asp?Action=Delete' method = "post">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a New Coupon</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "450">


	<input name="CategoryType" type = "hidden" Value = "<%=CategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "2"></td>
        </tr>
              <tr>
        </tr>
			<tr>
					<td width = "140" class = "body" align = "right">
							<div align = "right">Coupon:</div>
					</td>
					<td class = "body" >
							<select size="1" name="CategoryID">	
							<option  value= "" selected>select a category</option>
						<%	CouponCounter = 0 
								While CouponCounter < (FinalCouponCounter +1) 
								CouponCounter = CouponCounter +1 
						%>
								 <option  value="<%= CouponID(CouponCounter) %>"><%= CouponCode(CouponCounter) %></option>
	
							<% 
							Wend %>
							</select>
							
							
							
					</td>
			</tr>
			<tr>
					<td  align = "right" valign = "middle" colspan = "2"><br />
						<input type=submit value = "Delete Coupon" size = "110" class = "regsubmit2 body" >
					</td>
			</tr>
			</table>
			
			</td>
			</tr>
			</table>
			</form>


   </td>
   </tr>
</table><br><br><br>
	    </td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>