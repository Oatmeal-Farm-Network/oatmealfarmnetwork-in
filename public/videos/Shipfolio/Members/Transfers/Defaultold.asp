<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Transfer an Alpaca</title>
       <link rel="stylesheet" type="text/css" href="/Administration/Transfers/style.css">


</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<!--#Include virtual="/Administration/Transfers/GlobalVariables.asp"--> 
		<!--#Include virtual="/Administration/Transfers/TransfersHeader.asp"--> 

		<!--#Include virtual="/Administration/Transfers/adminDetailDBInclude.asp"--> 
		<!--#Include virtual="/Administration/Transfers/Dimensions.asp"-->

<% 
Message= Request.QueryString("Message") 

If Trim(Message) = "changesmade" Then
	Message = "Your Changes Have Been Made"
End If 
%>
<h1><font color = "brown"><%=Message %></font></h1>
<%
If Len(ID) > 0 then
		
%>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
			 sql2 = "select * from Photos where ID = " &  ID & ";" 
			'response.write(sql2)
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
			 If rs2.eof Then

					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
		

		DataConnection.Close
		Set DataConnection = Nothing 
	End If 
End if

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	
	sql2 = "select Animals.ID, Animals.FullName from Animals where custID = " & session("custid") & " order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing


 %>
 <table width = "760" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>

		
<td class = "body" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "760" bgcolor = "antiquewhite" align = "center">
	<tr>
		<td align = "center" bgcolor = "tan"><h1><center>Transfer Animals to Alpaca Infinity</center></h1>
		</td>
	</tr>
	<tr>
		<td class = "body">
			<a name="Add"></a><br>
			<H2>
			Transfer / Update An Alpaca with Alpaca Infinity</H2>
			 Select an alpaca below to have their information copied over to Alpaca Infinity. <b>If it's an existing animal on Alpaca Infinity it will be overwritten.</b><br><br>
		
			<form  action="Transferalpaca.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your alpacas:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Transfer" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
<br>
</td>
</tr>
</table>

<% 

Dim prodIDArray(1000)
Dim Prodname(10000)
Dim AdType(10000)
Dim ProductID(10000)

  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select distinct * from sfProducts  where custID = " & session("custid") & " order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		prodIDArray(acounter) = rs2("prodID")
		Prodname(acounter) = rs2("Prodname")
		ProductID(acounter) = rs2("ProductID")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = Nothing

		

	Databasepath2 = "../../../../../../virtual/milkyway/alpacainfinity.com/DB/Alpaca_Infinity_Animals.mdb"


		
Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryID(100)
Dim SubCatName(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath2) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from SFCategories  order by Catname " 

	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CatName(CatCounter,0) = rs("CatName")
		'response.write(CatName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 
	
	sql = "select * from SFSubCategories where CategoryID = '" & CategoryID(CatCounter,0) & "' Order by SubcategoryName"
		'	response.write(sql)


	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	Varieties =  Varieties  & " ["" Sub Categories "", "
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("subcatId") 
		CatName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryID(SubCatCounter2) = rs("subcatId") 
		SubCatName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  
		
		rs.movenext
			If Not(rs.eof) Then 
				Varieties  = Varieties  &  """ , " 
			 End If 
	Wend
	Varieties  = Varieties & """ ]," & vbCrLf
	Else
	Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
	End If 
wend

FinalSubCatCounter2 = SubCatCounter2
   		FinalSubCatCounter = CatCounter

Varietielen  = Len(Varieties)
'response.write(Varietielen)
Varieties = Left(Varieties, (Varietielen-3))

'response.write(Varieties)

%>





 <script type="text/javascript">
<!--
var varieties=[<%=Varieties%>];

function Box2IDpick(box2pick) {
var f=document.myform;
f.box2ID.value=null;

f.box2ID.value = box2pick
}


 //-->
</script>




<script type="text/javascript">
var varieties=[<%=Varieties%>];

function Box2(idx) {
var f=document.myform;
f.box2.options.length=null;
for(i=0; i<varieties[idx].length; i++) {
    f.box2.options[i]=new Option(varieties[idx][i], i); 
    }    
}

onload=function() {Box2(0);};
</script>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "760" bgcolor = "antiquewhite" align = "center">
	<tr>
		<td align = "center" bgcolor = "tan"><h1><center>Transfer Products to Alpaca Infinity</center></h1>
		</td>
	</tr>
	<tr>
		<td class = "body">
			<a name="Add"></a><br>
			<H2>
			Transfer / Update A Product Listed with Alpaca Infinity</H2>
			 Select a product below to have it's information copied over to Alpaca Infinity. <b>If it's an existing product on Alpaca Infinity it will be overwritten.</b> <br><br>
		
			<form  action="Transferproduct.asp" method = "post" name="myform">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your products:
				<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=prodIDArray(count)%>">
							<%=ProductID(count)%> -  <%=Prodname(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			
				</td>
			  </tr>
		    </table>
			<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "600">

	<tr>
			<td  class = "body" align = "right" >
			Category:
		</td>
		<td width = "570">
			<div>

<div>
<select name="box1" onchange="Box2(this.selectedIndex)">
    <% 
	CatCounter = 0
		While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter,0)%>"><%=CatName(CatCounter,0)%></option>
	<% Wend %>
</select>

<select name="box2" onchange="Box2IDpick(this.selectedIndex)"></select>
</div>
	<input name="box2ID" size = "30" value = "0" type = "hidden">
</div>
<tr>
		<td  colspan = "2" align = "center" valign = "middle" class = "body" >
			<br>
				<input name="Subject" value = "<%=Subject%>" type = "hidden">
			<input type=submit value = "Transfer ->"  size = "310" class = "body" >
			</form>
		</td>
</tr>
</table>
  </td>

  </tr>
 </table>
		  </form>
<br>
</td>
</tr>
</table>


</td>
	</tr>
</table>


<br><br><br>
<!--#Include virtual="/Administration/Transfers/Footer.asp"-->

 </Body>
</HTML>
