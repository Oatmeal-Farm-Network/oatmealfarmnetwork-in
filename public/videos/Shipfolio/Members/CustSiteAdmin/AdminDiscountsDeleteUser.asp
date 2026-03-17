<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete Coupon</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

  </HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white" >
<!--#Include virtual="/Administration/GlobalVariables.asp"--> 
<!--#Include virtual="/Administration/Header.asp"--> 
<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "1000">
 <tr>
		<td colspan = "9" align = "center">
		
		
<% Message = request.querystring("Message") 
   
if len(Message) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<br><big><b><%=Message %></b></big><br><br>
   </td>
  </tr>
 </table>
<% end if %>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
	<tr>
		<td Class = "body" >
			<h1>&nbsp;&nbsp;Delete an Affiliate / Coupon</h1>
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" bgcolor = "#CDE1EF">
	<tr>
		<td class = "body">
			&nbsp;&nbsp;Select a coupon to be deleted from the list below:
			
		</td>
	</tr>

<%  
dim OldCouponID(800)
dim OldFirstName(800)
dim OldLastName(800)
dim CouponCompany(800)
dim CouponURL(800)
dim CouponCode(800)	

						 
	sql2 = "select * from  coupons order by CouponCompany"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		OldCouponID(acounter) = rs2("CouponID")
		CouponCompany(acounter) = rs2("CouponCompany")
		CouponURL(acounter) = rs2("CouponURL")
		CouponCode(acounter) = rs2("CouponCode")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		



%>
	<tr>
		<td align = "left">
		<table width = "700" align = "center"><tr><td>

			<form action= 'AdminCouponsDeleteHandleform.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
			   <tr>
			   <td width = "150" class = 'body' align = "right">Affiliates / Coupon :</td>
				 <td>
						<select size="1" name="OldCouponID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=OldCouponID(count)%>">
							<%=CouponCompany(count)%> (<%=CouponCode(count)%>)
						</option>
					<% 	count = count + 1
					wend %>
					</select><br>
				</td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type=submit value = "Delete User"  style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ><br><br>
				</td>
			  </tr>
		    </table>
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
<br><br>
<!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>