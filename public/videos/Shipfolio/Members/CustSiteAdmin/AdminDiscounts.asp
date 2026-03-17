<!DOCTYPE HTML >
<HTML>
<HEAD>
 <!--#Include virtual="/members/MembersGlobalVariables.asp"-->
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
<% Action =  request.querystring("Action") 
DiscountID=request.form("DiscountID") 
DiscountCode=Request.Form("DiscountCode" ) 
DiscountType=Request.Form("DiscountType" ) 
DiscountAmount=Request.Form("DiscountAmount" )
DiscountMinimumPurchase=Request.Form("DiscountMinimumPurchase" ) 
DiscountActive=Request.Form("DiscountActive" ) 
DiscountIsACoupon = Request.Form("DiscountIsACoupon")
DiscountMinimumQTY = Request.Form("DiscountMinimumQTY")
DiscountEndDateMonth = Request.Form("DiscountEndDateMonth")
DiscountEndDateDay = Request.Form("DiscountEndDateDay")
DiscountEndDateYear= Request.Form("DiscountEndDateYear")
DiscountName= Request.Form("DiscountName")
DiscountAppliesTo= Request.Form("DiscountAppliesTo")

	str1 = DiscountName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DiscountName= Replace(str1, "'", "''")
	End If
	
	
	str1 = DiscountCode
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DiscountCode= Replace(str1, "'", "''")
	End If




If Action = "Update" then
	Query =  " UPDATE Discounts Set DiscountCode = '" & DiscountCode & "' , " 
	Query =  Query & " DiscountName = '" & DiscountName & "', " 
	Query =  Query & " DiscountType = '" & DiscountType & "', " 
	if len(DiscountAmount) > 0 then
	Query =  Query & " DiscountAmount = " & DiscountAmount & ", " 
	else
	Query =  Query & " DiscountAmount = 0, " 
	end if
	if len(DiscountMinimumPurchase) > 0 then
	Query =  Query & " DiscountMinimumPurchase = " & DiscountMinimumPurchase & ", " 
	else
	Query =  Query & " DiscountMinimumPurchase = 0, " 
	end if
	
	if len(DiscountMinimumQTY) > 0 then
	Query =  Query & " DiscountMinimumQTY = " & DiscountMinimumQTY & ", " 
	else
		Query =  Query & " DiscountMinimumQTY = 0, " 
	end if
	if len(DiscountEndDateMonth) > 0 then
	Query =  Query & " DiscountEndDateMonth = " & DiscountEndDateMonth & ", "
		end if
	if len(DiscountEndDateDay) > 0 then 
	Query =  Query & " DiscountEndDateDay = " & DiscountEndDateDay & ", " 
		end if
	if len(DiscountEndDateYear) > 0 then
	Query =  Query & " DiscountEndDateYear = " & DiscountEndDateYear & ", " 
	end if
	
	if len(DiscountAppliesTo) > 1 then
	Query =  Query & " DiscountAppliesTo = '" & DiscountAppliesTo & "', " 
	end if
	
	
	Query =  Query & " DiscountIsACoupon = " & DiscountIsACoupon & ", " 
	Query =  Query & " DiscountActive = " & DiscountActive & " " 
    Query =  Query & " where DiscountID = " & DiscountID & ";" 
End If 


If Action = "Delete" then
	Query =  "Delete * From Discounts where DiscountID = " &  DiscountID & ""
End If 




If Action = "Add" then
Query =  "INSERT INTO Discounts (DiscountCode, DiscountType,"
if len(DiscountAmount) > 0 then
Query = Query & " DiscountAmount, "
end if


if len(DiscountEndDateMonth) > 0 then
Query = Query & " DiscountEndDateMonth, "
end if

if len(DiscountEndDateDay) > 0 then
Query = Query & " DiscountEndDateDay, "
end if

if len(DiscountEndDateYear) > 1 then
Query = Query & " DiscountEndDateYear, "
end if


Query = Query & " DiscountName, DiscountAppliesTo, "




if len(DiscountMinimumPurchase) > 0 then
Query = Query & " DiscountMinimumPurchase, "
end if
 
if len(DiscountMinimumQTY) > 0 then
Query = Query & " DiscountMinimumQTY, "
end if

Query = Query & " DiscountIsACoupon, DiscountActive)" 
Query =  Query & " Values ('" &  DiscountCode & "', '" & DiscountType & "' , " 
if len(DiscountAmount) > 0 then
Query = Query &  DiscountAmount & ", "
end if

if len(DiscountEndDateMonth) > 0 then
Query = Query &  DiscountEndDateMonth  & " , "
end if

if len(DiscountEndDateDay) > 0 then
Query = Query & DiscountEndDateDay & " , "
end if

if len(DiscountEndDateYear) > 0 then
Query = Query & DiscountEndDateYear & " , "
end if


Query =  Query &  "  '" & DiscountName & "' , '" &  DiscountAppliesTo & "' , " 

if len(DiscountMinimumPurchase) > 0 then
Query = Query &  DiscountMinimumPurchase & " , "
end if 

if len(DiscountMinimumQTY) > 0 then
Query = Query &  DiscountMinimumQTY & " , "
end if 


Query = Query  & DiscountIsACoupon & " ," & DiscountActive & ")"
End If 

	If Len(Query) > 13 then
    	Set DataConnection = Server.CreateObject("ADODB.Connection")
        DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
       DataConnection.Execute(Query) 
    	DataConnection.Close
	    Set DataConnection = Nothing 
	    
	    response.write("DatabasePath=" & DatabasePath)
	    response.redirect("AdminDiscounts.asp?Tabs=Services")
    end if 
	
Dim DiscountIDArray(9999)
Dim DiscountCodeArray(9999)
Dim DiscountTypeArray(9999)
Dim DiscountAmountArray(9999)
Dim DiscountMinimumPurchaseArray(9999)
Dim DiscountActiveArray(9999)
Dim DiscountIsACouponArray(9999)
Dim DiscountMinimumQTYArray(9999)
Dim DiscountEndDateMonthArray(9999)
Dim DiscountEndDateDayArray(9999)
Dim DiscountEndDateYearArray(9999)
Dim DiscountNameArray(9999)
Dim DiscountAppliesTo(9999)
Dim DiscountAppliesToArray(9999)



sql = "select * from Discounts order by DiscountCode " 

	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	DiscountCounter= 0
	 While Not rs.eof 
		DiscountCounter = DiscountCounter + 1
		DiscountNameArray(DiscountCounter) = rs("DiscountName")
		DiscountIDArray(DiscountCounter) = rs("DiscountID")
		DiscountCodeArray(DiscountCounter) = rs("DiscountCode")
		DiscountActiveArray(DiscountCounter) = rs("DiscountActive")
		DiscountTypeArray(DiscountCounter) = rs("DiscountType") 
		DiscountAmountArray(DiscountCounter) = rs("DiscountAmount")
		DiscountMinimumPurchaseArray(DiscountCounter) = rs("DiscountMinimumPurchase")
DiscountIsACouponArray(DiscountCounter) = rs("DiscountIsACoupon")
DiscountMinimumQTYArray(DiscountCounter) = rs("DiscountMinimumQTY")
DiscountEndDateMonthArray(DiscountCounter) = rs("DiscountEndDateMonth")
DiscountEndDateDayArray(DiscountCounter) = rs("DiscountEndDateDay")
DiscountEndDateYearArray(DiscountCounter) = rs("DiscountEndDateYear")
DiscountAppliesToArray(DiscountCounter) = rs("DiscountAppliesTo")	

		rs.movenext
	Wend
		FinalDiscountCounter = DiscountCounter

dim CategoryID(99999) 
dim CatName(99999) 

DiscountCounter= 0
Set rsc = Server.CreateObject("ADODB.Recordset")
sqlc = "select * from SFCategories  order by Catname " 

rsc.Open sqlc, conn, 3, 3 
	CatCounter= 0
	 While Not rsc.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter) = rsc("CatID")
		CatName(CatCounter) = rsc("CatName")
		rsc.movenext
	Wend
FinalCatCounter = CatCounter
rsc.close

Set rsp = Server.CreateObject("ADODB.Recordset")
Tabs = request.QueryString("Tabs")
Current3 = "Discounts"   
%>
<!--#Include virtual="/members/MembersHeader.asp"-->

<form action= 'AdminDiscounts.asp?Action=Add&Tabs=Services' method = "post">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Discounts / Coupons</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "<%=screenwidth - 35 %>" >
<tr>
<td width = "100%" valign = "top" class = "body">

		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
		<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Create a New Coupon / Discount</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "470">
        <font color="gray"><b>Important:</b> Once you create a coupon / discount, the name cannot be changed and you can only us a name once.</font>
        
       <table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%" >
      <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
         <tr>
			<td class = "body2" align = "right" valign = "top">
			<b>Coupon or Discount</b>
			</td>
			<td width ="3"></td>
			<Td class = "body">	
						<input TYPE="RADIO" name="DiscountIsACoupon" Value = True ><b>Coupon</b> <font color="gray">Buyers have to enter a coupon code.</font><br />
						<input TYPE="RADIO" name="DiscountIsACoupon" Value = False checked><b>Discount</b> <font color="gray">Available to all buyers.</font>
	
				</Td>
			</tr>
			<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
			<tr>
			<td class = "body2" align = "right" >
			<b>Discount Name:</b>
			</td>
			<td width ="3"></td>
			<Td class = "body"><input type=text  size = "25" maxlength=20 class = "body" name="DiscountName"></Td>
			</tr>
	
<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
        
        
		<tr>
			<td class = "body2" align = "right" >
			<b>Coupon Code:</b>
			</td>
			<td width ="3"></td>
			<Td class = "body"><input type=text  size = "25" maxlength=20 class = "body" name="DiscountCode"></Td>
			</tr>
			<tr>
			<td class = "body2" align = "right" >
		
			</td>
			<td width ="3"></td>
			<Td class = "body">
			<font color = "gray">Used only with coupons. Must be between 5 and 20 letters or numbers (no spaces).</font></Td>
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
			<select size="1" name="DiscountType" class = "body">	
			<option  value="Percent Discount">Percent</option>
			<option  value="Free Shipping">Free Shipping</option>
			<option  value="Fixed Dollar Amount Discount">Fixed Dollar Amount Discount</option>
            </select>	
            </td>
			</tr>
			 </tr>
			 		<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
			<tr>	
				<td class = "body2" align = "right">
				<b>Discount Applies To:</b>
			</td>	
			<td width ="3"></td>
			<td class = "body"> 	
			<select size="1" name="DiscountAppliesTo" class = "body">	
			<option  value="Everything">Everything</option>
			<%  if ECommerceAvailable = True then %>
	
			<option  value="All Products">All Products</option>
				<option value="An Individual Product">An Individual Product</option>
			<% 	CatCounter = 0 %>
			<% if FinalCatCounter  > 0 then %>
			<option value="0">Product Categories:</option>
			<% end if %>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="ProductCategory-<%=CatName(CatCounter)%>">&nbsp;&nbsp;<%=CatName(CatCounter)%></option>
	<% Wend %>
			<% end if %>
			
			<option value="0">--</option>
			<% if ServicesAvailable = True then %>
			<option  value="All Services">All Services</option>
		
		
			
 <% 
 
  sqlp = "select * from Services  " 
	' response.Write(sql) 
	    Set rsp = Server.CreateObject("ADODB.Recordset")
	    rsp.Open sqlp, conn, 3, 3 
	    if not rsp.eof then %>
	  <option value="0">Services:</option>
	  <% while not  rsp.eof %>

	<option  value="Service-<%=rsp("ServiceTitle")%>">&nbsp;&nbsp;<%=rsp("ServiceTitle")%></option>

    <% rsp.movenext
    wend 
    rsp.close 
    end if %>
    
    	<% end if %>
    
            </select>	
            </td>
			</tr>
			    <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
        <tr>
			<td class = "body2" align = "right" >
			<b>Discount Amount:</b>
			</td>
			<td width ="3"></td>
			<Td class = "body"><input type=text  size = "3" maxlength=3 class = "body" name="DiscountAmount">% or $ Off</Td>
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
	name="DiscountMinimumPurchase" size=3 maxlength=3 > 
	
	<b>Minimum Quantity:</b> <input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="DiscountMinimumQTY" size=3 maxlength=3 >
	
	</Td>
			</tr>
<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
        
            <tr>
			<td class = "body2" align = "right" >
			<b>Ends:</b>
			</td>
			<td width ="3"></td>
			<Td class = "body">
        <select size="1" name="DiscountEndDateMonth">
					<option value="" selected></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
				</select>
				<select size="1" name="DiscountEndDateDay">
					<option value="" selected></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="DiscountEndDateYear">
					<option value="" selected></option>
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=currentyear To (currentyear + 3)  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
        
        </Td>
			</tr>
<tr>
        <td  height = "10" colspan = "3"></td>
        </tr>    
         <tr>
			<td class = "body2" align = "right" valign = "top">
			<b>Status:</b>
			</td>
			<td width ="3"></td>
			<Td class = "body">	
						<input TYPE="RADIO" name="DiscountActive" Value = True ><b>Active</b> <font color="gray">available for immediate use.</font><br />
						<input TYPE="RADIO" name="DiscountActive" Value = False checked><b>Inactive</b> <font color="gray">not available for use until set to active.</font>
	
				</Td>
			</tr>
			 <tr>
        <td  height = "10" colspan = "3"></td>
        </tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "3" class = "body">
					<center><input type=submit value = "Add Discount / Coupon" size = "110" class = "regsubmit2 body" ></center>
					</td>
			</tr>
			</table>

</td>
</tr>
</table>
</form>
</td>
</tr>

<tr>
	    <td width = "100%" valign = 'top'>
<% if FinalDiscountCounter > 0 then %>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>">
<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Coupons / Discounts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "100%">
        <tr>
        <td class = "body2" align = "center" width = "100"><b>Name <br />/ Code</b></td>
         <td class = "body2" align = "center" colspan = "2"><b>Status<br /></b></td>
        <td class = "body2" align = "center"><b>Amount Off<br />/ Type</b></td>
        <td class = "body2" align = "center"><b>Min Amount <br />/ Min QTY</b></td>
         <td class = "body2" align = "center"><b>End Date<br /> / Applies To</b></td>
        <td colspan = '2'></td>
        </tr>
 
<% 
order = "even"
While DiscountCounter < FinalDiscountCounter
	DiscountCounter= DiscountCounter +1 %>
	<form action= 'AdminDiscounts.asp?Action=Update&Tabs=Services' method = "post" style="margin-bottom:0;" >
<% if order = "even" then  
order = "odd"%>
<tr bgcolor = "#dddddd">
<% else 
order = "even" %>
<tr>
<% end if %>


<td class = "body" valign = "top"> 
			<div style="display: inline;">
			<input name="DiscountName" value ="<%= DiscountNameArray(DiscountCounter) %>"  size = "20">
			<% if DiscountIsACouponArray(DiscountCounter) = "True" then %><br />
			<input name="DiscountCode" value ="<%= DiscountCodeArray(DiscountCounter) %>"  size = "20"><% end if %></div>
			</td>
			<td class = "body">
				<% 	
		if DiscountActiveArray(DiscountCounter) = "Yes" Or DiscountActiveArray(DiscountCounter) = True Then %>
			<input TYPE="RADIO" name="DiscountActive" Value = "Yes" checked>Active<br />
			<input TYPE="RADIO" name="DiscountActive" Value = "No" >Inactive
		<% Else %>
			<input TYPE="RADIO" name="DiscountActive" Value = "Yes" >Active<br />
			<input TYPE="RADIO" name="DiscountActive" Value = "No" checked>Inactive
		<% End If %>
			</td>
				<td class = "body">
				<% 	
		if DiscountIsACouponArray(DiscountCounter) = "Yes" Or DiscountIsACouponArray(DiscountCounter) = True Then %>
			<input TYPE="RADIO" name="DiscountIsACoupon" Value = "Yes" checked>Coupon<br />
			<input TYPE="RADIO" name="DiscountIsACoupon" Value = "No" >Discount
		<% Else %>
			<input TYPE="RADIO" name="DiscountIsACoupon" Value = "Yes" >Coupon<br />
			<input TYPE="RADIO" name="DiscountIsACoupon" Value = "No" checked>Discount
		<% End If %>
			</td>
			
			<td class = "body" valign = "top">
			
              <% if  not DiscountTypeArray(DiscountCounter) = "Free Shipping" then%>
           
              <% if  DiscountTypeArray(DiscountCounter) = "Fixed Dollar Amount Discount" then%>
              $
            <% end if %>
            <input name="DiscountAmount" value ="<%= DiscountAmountArray(DiscountCounter) %>"  size = "2">
            <% if  DiscountTypeArray(DiscountCounter) = "Percent Discount" then%>
            % 
            <% end if %>Off
             <% end if %><br />
          <select size="1" name="DiscountType">	
			<option  value= "<%=DiscountTypeArray(DiscountCounter)%>" selected><%=DiscountTypeArray(DiscountCounter)%></option>
			<option  value="Percent Discount">Percent</option>
			<option  value="Free Shipping">Free Shipping</option>
			<option  value="Fixed Dollar Amount Discount">Fixed Dollar Amount Discount</option>
            </select>
            </td>
    
		<td align = 'center' class = "body2">
		<% if DiscountMinimumPurchaseArray(DiscountCounter) = 0 then 
		DiscountMinimumPurchaseArray(DiscountCounter) = ""
		end if 
		if  DiscountMinimumQTYArray(DiscountCounter)  = 0 then 
		 DiscountMinimumQTYArray(DiscountCounter)  = ""
		end if 
		
		%>
		$<input name="DiscountMinimumPurchase" value ="<%= DiscountMinimumPurchaseArray(DiscountCounter) %>"  size = "2"> <br />
		QTY: <input name="DiscountMinimumQTY" value ="<%= DiscountMinimumQTYArray(DiscountCounter) %>"  size = "2">
		
		</td> 
		
		<Td class = "body" valign = "top">
        <select size="1" name="DiscountEndDateMonth">
					<option value="<%= DiscountEndDateMonthArray(DiscountCounter)%>" selected><%= DiscountEndDateMonthArray(DiscountCounter)%></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
				</select>
				<select size="1" name="DiscountEndDateDay">
					<option value="<%= DiscountEndDateDayArray(DiscountCounter)%>" selected><%= DiscountEndDateDayArray(DiscountCounter)%></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="DiscountEndDateYear">
					<option value="<%= DiscountEndDateYearArray(DiscountCounter)%>" selected><%= DiscountEndDateYearArray(DiscountCounter)%></option>
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=currentyear To (currentyear + 3)  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select><br />
					
<select size="1" name="DiscountAppliesTo" class = "body">	
<option value="<%= DiscountAppliesToArray(DiscountCounter)%>" selected><%= DiscountAppliesToArray(DiscountCounter)%></option>
<option  value="Everything">Everything</option>
			<%  if ECommerceAvailable = True then %>
			<option  value="All Products">All Products</option>
				<option value="An Individual Product">An Individual Product</option>
			<% 	CatCounter = 0 %>
			<% if FinalCatCounter  > 0 then %>
			<option value="0">Product Categories:</option>
			<% end if %>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="ProductCategory-<%=CatName(CatCounter)%>">&nbsp;&nbsp;<%=CatName(CatCounter)%></option>
	<% Wend %>
			<% end if %>
			
			<option value="0">--</option>
			<% if ServicesAvailable = True then %>
			<option  value="All Services">All Services</option>
		
 <% 
 
  sqlp = "select * from Services  " 
	' response.Write(sql) 
	    Set rsp = Server.CreateObject("ADODB.Recordset")
	    rsp.Open sqlp, conn, 3, 3 
	    if not rsp.eof then %>
	  <option value="0">Services:</option>
	  <% while not  rsp.eof %>

	<option  value="Service-<%=rsp("ServiceTitle")%>">&nbsp;&nbsp;<%=rsp("ServiceTitle")%></option>

    <% rsp.movenext
    wend 
    rsp.close 
    end if %>
    
    	<% end if %>
    
            </select>	
        
        </Td>
		
		       <td> <input type=hidden value = "<%= DiscountIDArray(DiscountCounter) %>" name=DiscountID >	
			<input type=submit value = "submit"  class = "regsubmit2" >
			</form>
		</td>
		<td align = 'center'><form method="POST" action="AdminDiscounts.asp?Action=Delete&Tabs=Services" > <input type=hidden value = "<%= DiscountIDArray(DiscountCounter) %>" name=DiscountID > <input type=submit value = "X" class = "regsubmit2" ></form></td>
		</tr>
<tr><td colspan = "7" height = '10'></td></tr>
<% wend %>
</table>
<% end if %>
	    </td>
	    </tr>
</table>
  </td>
	    </tr>
</table>
  </td>
	    </tr>
</table>
<br><br />
   <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>