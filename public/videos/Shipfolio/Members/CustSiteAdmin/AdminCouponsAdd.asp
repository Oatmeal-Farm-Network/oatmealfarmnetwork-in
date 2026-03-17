<!DOCTYPE HTML >
<HTML>
<HEAD>
 <title>Add a Coupon</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% 
    TempCategoryType="For Sale"
%>  
 
<!--#Include file="AdminHeader.asp"--> 
<%  Current3 = "AddCoupons"   %> 
<!--#Include virtual="/Administration/AdminCouponsTabsInclude.asp"-->
<% if mobiledevice = False  then %>
        <% if screenwidth < 989 then %>
        <table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth  %>">
        <% else %>
        <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>">
        <% end if %>
    <tr><td class = "roundedtop" align = "left">
    <H1>Add a Coupon</H1></td></tr>
    <tr><td class = "roundedBottom" align = "center" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<% end if %>


<% Message = request.querystring("Message") 
CouponContactFirstName = request.querystring("CouponContactFirstName")
    CouponContactLastName = request.querystring("CouponContactLastName")
   CouponEmail = request.querystring("CouponEmail")
    Message2 = request.querystring("Message2") 
    CouponPhone = request.querystring("CouponPhone")
    CouponMinQTY  = request.querystring("CouponMinQTY")
    CouponPrice = request.querystring("CouponPrice")
     CouponCode = request.querystring("CouponCode")  
        CouponCompany = request.querystring("CouponCompany")   
    CouponURL = request.querystring("CouponURL") 
    
    
if len(Message) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<font color = "brown"><b>Please correct the following issue(s):<blockquote><%=Message %></blockquote></b></font>
   </td>
  </tr>
 </table>
<% end if 

if len(Message2) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<font color = "brown"><b><%=Message2%></b></font>
   </td>
  </tr>
 </table>
<% end if %>


<form name=myForm action= 'AdminCouponAddhandleform.asp' method = "post">
<table border = "0" cellpadding=0 cellspacing=0 width = "100%" >
<tr>
	<td  align = "right" class = "body">
			Coupon Name:*
		</td>
		<td  align = "left" class = "body" colspan = "3">
					<input name="CouponCode" value= "<%=CouponCode%>" size = "14" maxlength = "12">		    
		</td>
</tr>
<tr>
	<td  align = "right" class = "body">
			Coupon Code:
		</td>
		<td  align = "left" class = "body" colspan = "3">
					<input name="CouponCode" value= "<%=CouponCode%>" size = "14" maxlength = "12"><font color = "grey"><i>At least 4 characters long. Max length of 12 characters. No apostrophes.</i></font>
		    
		</td>

	</tr>
	<tr>
	  <td  align = "right" class = "body" >
			Discount Price:
			<td  align = "left" class = "body" >
			$<input name="CouponDiscount" class="positive" value= "<%=CouponDiscount%>" size = "5">

	
	<script type="text/javascript">

	    $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
	
	</script>
	</td>
	<td>
	
	
	
	</td>
	</tr>
	<tr>
		<td  align = "right" class = "body" >
			Discount Price:
			<td  align = "left" class = "body" >
			$<input name="CouponPrice" class="positive" value= "<%=CouponPrice%>" size = "5">

	
	<script type="text/javascript">
	
	$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
	
	</script>
	
	
		</td>
		<td  class = "body" colspan = "2">
			Min Quantity for Discount:
			<select size="1" name="CouponMinQTY">
					<% if len(CouponMinQTY) < 1 then %>
					<option value="" selected></option>
				<% else %>
					<option value="<%=CouponMinQTY%>" selected><%=CouponMinQTY%></option>
				<% end if %>

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
	                <option  value="15">15</option>
	                <option  value="20">20</option>
				</select>
			

		</td>
	</tr>
	
<tr>
		<td colspan = "4" valign = "middle" align = "center">
		
			<input type=submit value="Add Coupon" Class = "Regsubmit2" ><br>
<br>

	</td>
</tr>
</table>
</form>





</td>
</tr>
</table>
<br><br>
<!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>