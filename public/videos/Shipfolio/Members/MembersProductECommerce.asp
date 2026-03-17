<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->



 </head>
<body >
<% Current1="Products"
Current2 = "ProductStatistics" 
Current3 = "Settings" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">
<div>
   <div>

<H1>Store Settings</H1></b>

<% sql = "select * from people where peopleId = " & session("PeopleID")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
peopleEmail = rs("peopleEmail")
Weblink= rs("Weblink")
showtaxes = false
if showtaxes = true then
TaxNexusState= rs("TaxNexusState")
TaxRate= rs("TaxRate")
TaxActive= rs("TaxActive")
end if
If Len(prodPurchasemethod) > 3 Then

else
	prodPurchasemethod ="Contact Me"
End If 

If Len(OtherURL) > 3 Then
else
	OtherURL =Weblink
End If 

If Len(PaypalEmail) > 3 Then
else
	PaypalEmail =custEmail 
End If 
%>
    <% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div>
	<div style="background-color: floralwhite; min-height:60px">
        <br /><b>&nbsp;&nbsp;&nbsp;Your Product Basic Facts Changes Have Been Made.</b><br>
	</div>
</div>
<% end if %>



        <form action= 'membersStoreAccountHandleForm.asp' method = "post">
		
       <br />

		How can people pay for your products?<br />
		<select size="1" name="prodPurchasemethod" class = "formbox" style="width:300px">
			<option value="<%=prodPurchasemethod %>" selected><%=prodPurchasemethod %></option>
			<option value="Contact Me">Contact Me</option>
			<option value="PayPal">PayPal</option>
        <% anotherwbsiteoption = false
        if anotherwbsiteoption = True then %>
			<option value="Send Users to Another Website">Send Users to Another Website</option>
        <% end if %>
		</select><br>
        </div>
    </div>
<%=HSpacer %>
  <div >
    <div  align=left>

	   Email used if your paypal account<br>
		<input name="PaypalEmail"  size = "35" value = "<%=PaypalEmail %>" class = "formbox"><br>
        <% if anotherwebsiteoption = True then %>
    		<b>Other Website (if applicable)</b><br>
			http://<input name="OtherURL" size = "35" value = "<%= OtherURL %>" class = "formbox">
        <% end if %>
        <br /><br />
      </div>
    </div>
    <div>
      <div align = "center"><input type=submit name= "button1" value = "Submit" class = "submitbutton" >
    </form>
          <br /><br />
           <i>Note: The information above applies to all of your products that you list.</i><br /><br />
    </div>
</div>



<% 
showtaxes=false
if showtaxes = true then %>
<div>
    <div align = "left" >
        <H1>Taxes</H1>
    </div>
</div>
<div>
   <div >
     <iframe src="membersProductTaxFrame.asp?ProdID=<%=ProdID %>" height = '270' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>
    </div>
</div>
<% end if %>



<br><br>


<!--#Include file="membersFooter.asp"--> </Body>
</HTML>