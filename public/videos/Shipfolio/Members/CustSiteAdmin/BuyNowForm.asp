<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Auction</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">


<script>
<!--
function filter(imagename,objectsrc){
if (document.images)
document.images[imagename].src=eval(objectsrc+".src")
}
//-->
</script>

<script language="JavaScript">
function IsEmpty(aTextField) {
   if ((aTextField.value.length==0) ||
   (aTextField.value==null)) {
      return true;
   }
   else { return false; }
}


function ValidForm(form)
{
   if(IsEmpty(form.FName)) 
   { 
      alert('You have not entered your first name') 
      form.FName.focus(); 
      return false; 
   } 
 
   if(IsEmpty(form.LName)) 
   { 
      alert('You have not entered your last name') 
      form.LName.focus(); 
      return false; 
   } 

 
   if(IsEmpty(form.Email)) 
   { 
      alert('You have not entered an E-mail address') 
      form.Email.focus(); 
      return false; 
   } 
 
return true;
}
</script>

</HEAD>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!--#Include virtual="/Header.asp"-->
<%

	dim ID
	dim BuyNowPrice
	dim Fullname


	ID=Request.Form("ID") 
	BuyNowPrice=Request.Form("BuyNowPrice") 
	Fullname=Request.Form("Fullname") 
	Owner=Request.Form("Owner") 

	
%>

<table border="0" cellpadding="5" cellspacing="0" width="800"  background = "images/PageBackground.jpg" align = "center">
   <tr>
      <td class = "body" colspan = "3">
       <br><h1 ><i>&nbsp;Confirming Your Order</i><img src = "images/Line.jpg" width = "500" height = "2"></h1>
	   <blockquote>Congratulations on your purchase of <b><%=Fullname%></b>.   Please confirm your purchase by supplying your contact information and pressing the "confirm order" button below. We will contact you to finalize the purchase contract, payment, and transportation. </blockquote>
	</td>
</tr> <tr>
		<td width = "10">&nbsp;</td>
      
<td>


<FORM NAME="ConfirmBidForm" ACTION="OrderConfirm.asp" METHOD="POST" onsubmit="javascript:return ValidForm(this)">	
	<input name="_recipients" type="hidden" value="johna@webartists.biz">
    	<input name="_subjectField" type="hidden" value="name">
	<input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
    	<input name="_replyToField" type="hidden" value="email">
	<input name="_requiredFields" type="hidden" value= 
		"First_Name,Last_Name,Business_Name,Email">
		
	<table  border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500">
		<tr> 
			<td  colspan="2" align="center" height="24" valign="middle">
		                  		<i><small>( &quot;*&quot; indicates required field)</small></i>
              </td>
         </tr>
		<tr> 
			<td  class = "body" width = "100" height = "30">Ranch Name: </td>
			<td  class = "body" ><INPUT TYPE="TEXT" NAME="BizName" size="61 "></td>
		</tr>
		<tr>
			<td  class = "body" height = "30">First Name:*</td>
			<td  class = "body"><INPUT TYPE="TEXT" NAME="FName" size="15">
				MI: <INPUT TYPE="TEXT" NAME="MName" size="1">
				&nbsp;Last Name:*<INPUT TYPE="TEXT" NAME="LName" size="15"> </td>
		</tr>
		<tr>
			<td  class = "body" height = "30">Address: </td>
			<td  class = "body"><INPUT TYPE="TEXT" NAME="Address1" size="61"></td>
			</tr>
		<tr>
			<td  class = "body" height = "30">City: </td>
			<td  class = "body"><INPUT TYPE="TEXT" NAME="City" size="30"> 
			  &nbsp;State/Province: <INPUT TYPE="TEXT" NAME="State" size="7"></td>
		</tr>
		<tr>
			<td  class = "body" height = "30">Country: </td>
			<td  class = "body" ><INPUT TYPE="TEXT" NAME="Country" size="30">
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Postal Code: <INPUT TYPE="TEXT" NAME="Zipcode" size="7"></td>
			</tr>
		<tr>
			<td  class = "body" height = "30">Email:* </td>
			<td  class = "body"><INPUT TYPE="TEXT" NAME="Email" size="30">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Phone: <INPUT TYPE="TEXT" NAME="Phone" size="13"></td>
         </tr>
      	<tr> 
            <td height="30"  class = "body" valign = "top"> Questions or Comments: </td>
				<td  class = "body" height = "30">
                    	<TEXTAREA NAME="CommentText" cols="47" rows="8" wrap="VIRTUAL"></textarea>
                    		
                	</td>
            	</tr>
            	<tr> 
                	<td align=center  class = "body" colspan = "2">   
					<input type = "hidden" name="BuyNowPrice" value= "<%=BuyNowPrice%>" SIZE = "8">
					<input type = "hidden" name="ID" value= "<%=ID%>">
					<input type = "hidden" name="Fullname" value= "<%=FullName%>">
					<input type = "hidden" name="Owner" value= "<%=Owner%>">
				
                    		I  confirm my purchase of <%=Fullname%> for <%=FormatCurrency(BuyNowPrice,0)%><br><input type="submit" value="Confirm Order">
                    		<br>
                	</td>
           	</tr>
	</table>
</form>



               	</td>
				<td class = "body" valign = "top">




  	<% 
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
	
	sql = "SELECT WebView.*, Auction.* FROM WebView, Auction WHERE animals.id = auction.animalid and Animals.ID = " & ID 
' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
	
	
	alpacasPrice= rs("Avalue")

		 photoID = "nophoto"
  
        imagelength = len(rs("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs("ListPageImage")
		end if

               	If photoID = "nophoto" then 
			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  ID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=other>" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0 bordercolordark=#rrggbb width=""111"" >"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  ID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=other>" &_
                            "<input name=Detail type=image bordercolordark=#rrggbb src=""/uploads/ListPage/" & PhotoID &"""  border=0  width=""111"" >"     
                End If

				%> 
				
			<% Category = rs("Category")

			If DetailType = "Dam" Then 
				sex = "Female"
			Else
				sex = "Male"
			End if

				ColorCategory =rs("ColorCategory")

%> <br>
<table  border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
		<td align="center" width = "400" valign = "top" class = "body" >                       
            <table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #6a7d67 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
			  <tr>
			     <td><%=click%></td>
			</tr>
			</table>
	       </td>
		   </tr>
		   <tr>
	      <td class= "body"  valign = "top" width = "400" >
								<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><big><%=Trim(rs("FullName"))%></big></a><br>
								<b>Purchase Price: <%=BuyNowPrice%></b> <br>
										Color: <%=rs("Color")%><br>
								DOB: <%=rs("DOB")%><br>
								Owner: <%=rs("Auction.Owner")%><br>
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



</body>
</html>











