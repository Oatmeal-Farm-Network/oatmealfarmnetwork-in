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
      alert('Please enter your first name.') 
      form.FName.focus(); 
      return false; 
   } 
 
   if(IsEmpty(form.LName)) 
   { 
      alert('Please enter your last name.') 
      form.LName.focus(); 
      return false; 
   } 
  
   if(IsEmpty(form.Email)) 
   { 
      alert('Please enter an E-mail address.') 
      form.Email.focus(); 
      return false; 
   } 
    
 
return true;
}
</script>

<FORM NAME="ContestForm" ACTION="ContestConfirmation.asp" Method="post" onsubmit="javascript:return ValidForm(this)">	
	<input name="_recipients" type="hidden" value="johna@webartists.biz">
    	<input name="_subjectField" type="hidden" value="name">
	<input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
    	<input name="_replyToField" type="hidden" value="Email">
	<input name="_requiredFields" type="hidden" value= 
		"FName, LName, Email, CurrentlyOwn">
		
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "600"border = "0">
		<tr> 
                  	<td colspan="4" align="left"  class = "body"> 

                    		<H2>Enter Our Drawing</H2>
							Enter our drawing for your chance to win The Alpaca Field Manual 2nd Edition by C. Norm Evans, DVM, (retail value $110). The next
drawing will be 8/31/08. All you need to do is fill out the form below:<br>
<center>( &quot;*&quot; indicates required field) </center>
						</td>
                	</tr>
			<tr> 
				
			</tr>
                  	</td>
                	</tr>
			<tr> 
				<td width="80" height="20" class = "body">First Name:</td>
				<td width="200" height="20" class = "body">
				<INPUT TYPE="TEXT" NAME="FName" size="20">
				<b>*</b></font></td>
				</td>
			
				<td width="100" height="20" class = "body">Last Name:</td>
				<td width="200" height="20" class = "body">
				<INPUT TYPE="TEXT" NAME="LName" size="20">
				 <b>*</b> </font></td>
				</td>
			</tr>
			
			<tr> 
				<td  class = "body">Farm Name:</td>
                		<td  class = "body"> 
                    		<INPUT TYPE="TEXT" NAME="BizName" size="20 ">
				</td>
                		</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
            		<tr> 
                		<td  class = "body">Address:</td>
                		<td  class = "body">
                    		<INPUT TYPE="TEXT" NAME="Address1" size="20">
                		</td>
            		
                		<td  class = "body">City:</td>
                		<td  class = "body">
                    		<INPUT TYPE="TEXT" NAME="City" size="20">
                		</td>
            		</tr>
            		<tr> 
                		<td  class = "body">State/Province:</td>
                		<td  class = "body">
                    		<INPUT TYPE="TEXT" NAME="State" size="5">
                		</td>
            		
                		<td  class = "body">Postal Code:</td>
                		<td  class = "body"> 
                		<INPUT TYPE="TEXT" NAME="Zipcode" size="20">
                		</td>
            		</tr>
			<tr> 
                		<td class = "body">Country:</td>
                		<td  class = "body">
                		<INPUT TYPE="TEXT" NAME="Country" size="20">
                		</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
            		</tr>
					<tr> 
						<td width="80" height="20" class = "body">Email:</td>
						<td width="200" height="20" class = "body">
						<INPUT TYPE="TEXT" NAME="Email" size="20">
						<b>*</b></font></td>
				</td>
                  		 
                		<td  class = "body">Telephone:</td>
                		<td  class = "body">
                    		<INPUT TYPE="TEXT" NAME="Phone" size="20">
                    		</td>
                		</td>
            		</tr>
			<tr> 
                  		<td colspan="8 "  class = "body">Do you currently own alpacas? <b>*</b>
	
	&nbsp; Yes: 
                		<INPUT TYPE="RADIO" NAME="CurrentlyOwn" value="yes" >
                			&nbsp; No: 
                     		<INPUT TYPE="RADIO" NAME="CurrentlyOwn" value="no">
                		</td>
       			</tr>
				<tr> 
                  		<td colspan="8 "  class = "body">If No, do you plan to own alpacas within 1-2 years?	
					&nbsp; Yes: 
                		<INPUT TYPE="RADIO" NAME="PlanToOwn" value="yes" >
                			&nbsp; No: 
                     		<INPUT TYPE="RADIO" NAME="PlanToOwn" value="no">
                		</td>
       			</tr>
			<tr> 
                  		<td colspan="4" class = "body"><br>Please enter any comments and/or questions here</td>
                	</tr>
            		<tr> 
                		<td colspan="4" height="1" > 
                    		<TEXTAREA NAME="CommentText" cols="75" rows="4" wrap="VIRTUAL"></textarea>
                		</td>
            		</tr>
            		<tr> 
                		<td align="center" colspan="4" >    
                    		<input type="submit" value="Submit">
                    		<input type="reset" value="Reset">
                		</td>
           		</tr>
		</table>
		</form>
<font class = "body">Note: One entry per family per drawing period. </font><br>
</td>
		</tr>
	</table>
