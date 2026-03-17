<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Coupon</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="jquery.numeric.js"></script>
  </HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white" >
<!--#Include virtual="/Administration/GlobalVariables.asp"--> 
<!--#Include virtual="/Administration/Header.asp"--> 
<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "1000">
 <tr>
		<td colspan = "9" align = "center">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
	<tr>
		<td Class = "body" >
			<h1>&nbsp;&nbsp;Edit Coupon</h1>
		</td>
	</tr>
</table>


<%
 sql = "select * from Coupons order by CouponCompany"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim CouponID(800)
	dim CouponURL(800)
	dim CouponContactLastName(800)
	dim CouponContactFirstName(800)
	dim CouponEmail(800)
	dim CouponPhone(800)
    dim  CouponMinQTY(800)
    dim  CouponPrice(800)
   dim CouponCompany(800)
   dim CouponCode(800)
   dim ProgramPage(800)
	        
	        
Recordcount = rs.RecordCount +1
%>
<form action= 'AdminCouponhandleform.asp' method = "post">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
<tr><td colspan = "6" bgcolor = "black" height = "1"><img src = "images/px.gif" height = "1" width = "1"></td></tr>

	
<%
order = "odd"	

 While  Not rs.eof         
	 CouponID(rowcount) =   rs("CouponID")
	 CouponContactFirstName(rowcount) =   rs("CouponContactFirstName")
	 CouponContactLastName(rowcount) =   rs("CouponContactLastName")
	 CouponEmail(rowcount) =   rs("CouponEmail")
	 CouponPhone(rowcount) =   rs("CouponPhone")
	 CouponURL(rowcount) = rs("CouponURL")
	 CouponMinQTY(rowcount) = rs("CouponMinQTY")
     CouponPrice(rowcount) = rs("CouponPrice")
     CouponCompany(rowcount) = rs("CouponCompany")
	CouponCode(rowcount) = rs("CouponCode")
   ProgramPage(rowcount) = rs("ProgramPage")
   
	 if order = "odd" then 
	  order = "even" 
	  bgcolor = "#CDE1EF"
     else 
	  order = "odd" 
	  bgcolor = "white" 
 end if %>
 	<tr><td colspan = "6" height = "7" bgcolor = "<%=bgcolor %>"><img src = "images/px.gif" height = "2" width = "1"></td></tr>
    <tr bgcolor = "<%=bgcolor %>"><td class = "body" >Coupon code:&nbsp;
        </td>
        <td class = "body">
		<input  name="CouponCode(<%=rowcount%>)" value= "<%=CouponCode(rowcount)%>" size = "12" maxlength = "12" class = "body" />
		</td>
    	<td class = "body" colspan = "4">
	      
		</td>
		</tr>

 <tr bgcolor = "<%=bgColor%>">	   
	<td class = "body" align = "right">
			Company:&nbsp;
		</td>
	 <td class = "body">
		<input  name="CouponCompany(<%=rowcount%>)" value= "<%=CouponCompany(rowcount)%>" size = "30" class = "body" />
	</td>

	<td class = "body" align = "right">
			Contact Last Name:&nbsp;
		</td>
	 <td class = "body">
			<input  name="CouponContactLastName(<%=rowcount%>)" value= "<%=CouponContactLastName(rowcount)%>" size = "30" class = "body">
		</td>
			<td class = "body" align = "right" >
			Contact First Name:&nbsp;
		</td>

		<td class = "body">
			<input  name="CouponContactFirstName(<%=rowcount%>)" value= "<%=CouponContactFirstName(rowcount)%>" size = "20" class = "body">
		</td>
	</tr>
	<tr bgcolor = "<%=bgColor%>">
		<td class = "body" align = "right">
			Email:&nbsp;
		</td>

		<td class = "body">
			<input  name="CouponEmail(<%=rowcount%>)" value= "<%=CouponEmail(rowcount)%>" size = "30" class = "body">
		
		  <input  type = "hidden" name="CouponID(<%=rowcount%>)" value= "<%=  CouponID(rowcount)%>" >

		 </td>
		 	<td class = "body" align = "right">
			Website:&nbsp;
		</td>

		 <td class = "body" ><input  name="CouponURL(<%=rowcount%>)" value= "<%=CouponURL(rowcount)%>" size = "30" class = "body">
</td>
	<td class = "body" align = "right">
			Phone:&nbsp;
		</td>
	  	<td class = "body" ><input  name="CouponPhone(<%=rowcount%>)" value= "<%=CouponPhone(rowcount)%>" size = "20" class = "body">
</td>

	</tr>
	<tr bgcolor = "<%=bgColor%>" >
		<td  align = "right" class = "body" colspan = "3">
			The<b><font color="#3D8635">Form</font>Tool</b> Discount Price:
$<input  class = "positive" name="CouponPrice(<%=rowcount%>)" value= "<%=CouponPrice(rowcount)%>" size = "8" />
	
	<script type="text/javascript">
	
	$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
	
	</script>
	
	
		</td>
		<td  class = "body" colspan = "3">
			&nbsp;&nbsp;&nbsp;&nbsp;Min Quantity for Discount Price:
			<select size="1" name="CouponMinQTY(<%=rowcount%>)">
					<% if len(CouponMinQTY(rowcount)) < 1 then %>
					<option value="" selected></option>
				<% else %>
					<option value="<%=CouponMinQTY(rowcount)%>" selected><%=CouponMinQTY(rowcount)%></option>
				<% end if %>
                    <option value="0">0</option>
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

	<tr><td colspan = "6" bgcolor = "black" height = "1"><img src = "images/px.gif" height = "1" width = "1"></td></tr>



<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" >
<tr>
		<td  valign = "middle">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" >
			</form>
		</td>

</tr>
</table>

<br><br>


<!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>