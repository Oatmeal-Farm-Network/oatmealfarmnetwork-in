<table border="0" cellspacing="2" width = "610" align = "center" >
<tr>
					<td  class = "Details"><br><big><b>Ancestry</b></big><br><img src = "/images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "<%=bodywidth%>" height = "2">	</td>
				</tr>
		<tr>
			<td   valign = "top" height = "2" valign = "bottom" background = "/images/Underline.jpg"><img src = "/images/px.gif" height = "2" border = "0"></td>
		</tr>
</table>
<table border="0" cellspacing="2" width = "610"  align = "center" >
				<tr>
					<td align= "center" class = "Details" colspan = "2" width = "50%"   background = "/images/Underline.jpg"><b> Sire</b></td>
					<td  align= "center" class = "Details" colspan = "2"  background = "/images/Underline.jpg"> <b>Dam</b></td>
				</tr>
				<tr>
    					
					<td width="40"  class = "Details"  valign = "top" >
						Name:<br>
						Color:<br>
					</td>
                    			<td    class = "Details" valign = "top" width = "40%">
					<%
Ancestorname = SireName
AncestorColor = SireColor
AncestorARI = SireARI
DetailType = "Sire"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
						
					</td>
					<td width="40"  class = "Details" valign = "top" >
 						Name:<br>
						Color:<br>
					</td>
                    			<td    class = "Details" valign = "top" width = "40%">
			<%
Ancestorname = DamName
AncestorColor = DamColor
AncestorARI = DamARI
DetailType = "Dam"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
					<td>
                		</tr>	
<tr>
					<td colspan = "2" align= "left" class = "Details" valign = "top"><%=SireComment%></td>
					<td colspan = "2" align= "left" class = "Details" valign = "top"><%=DamComment%></td>
				</tr>	
				<tr>
					<td colspan = "2" align= "center" class = "Details"  background = "/images/Underline.jpg"> <b>Grandsire</b></td>
					<td colspan = "2" align= "center" class = "Details"  background = "/images/Underline.jpg"> <b>Grandsire</b></td>
				</tr>	
								<tr>
					<td colspan = "4"  valign = "top" height = "1" background = "/images/ledge.jpg"><img src = "/images/px.gif" height = "0"></td>
				</tr>

				<tr>
    					<td width="40"   class = "Details" valign = "top">
						Name:<br>
						Color:<br>
					</td>
                    			<td     class = "Details" valign = "top">
						<%
Ancestorname = SireSireName
AncestorColor = SireSireColor
AncestorARI = SireSireARI
DetailType = "Sire"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
						
					</td>
					<td width="40"   class = "Details" valign = "top">
 						Name:<br>
						Color:<br>
					</td>
                    			<td     class = "Details" valign = "top" >
												<%
Ancestorname = DamSireName
AncestorColor = DamSireColor
AncestorARI = DamSireARI
DetailType = "Dam"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
						
					<td>
					
                		</tr>	

				<tr>
					<td colspan = "2" align= "center" class = "Details"  background = "/images/Underline.jpg"> <b>Granddam</b></td>
					<td colspan = "2" align= "center" class = "Details"  background = "/images/Underline.jpg"> <b>Granddam</b></td>
				</tr>	
								<tr>
					<td colspan = "4"  valign = "top" height = "1" background = "/images/ledge.jpg"><img src = "/images/px.gif" height = "0"></td>
				</tr>

				<tr>
    					
					<td width="40"   class = "Details" valign = "top">
						Name:<br>
						Color:<br>
					</td>
                    			<td     class = "Details" valign = "top">
																		<%
Ancestorname = SireDamName
AncestorColor = SireDamColor
AncestorARI = SireDamARI
DetailType = "Sire"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
					</td>
					<td width="40"   class = "Details" valign = "top">
 						Name:<br>
						Color:<br>
					</td>
                    			<td     class = "Details" valign = "top">
																		<%
Ancestorname = DamDamName
AncestorColor = DamDamColor
AncestorARI = DamDamARI
DetailType = "Dam"
%>
	<!--#Include virtual="/AncestorDetailsInclude.asp"-->	
		<br><br><br><br>
		</td>
		</tr>
	</table>