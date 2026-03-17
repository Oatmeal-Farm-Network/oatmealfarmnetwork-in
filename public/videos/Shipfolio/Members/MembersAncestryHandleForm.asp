<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<!--#Include file="MembersGlobalVariables.asp"--> 
 <base target="_self" />
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt
rowcount = 1
ID=Request.Form("ID") 
ShowwithDam=Request.Form("ShowwithDam")
ShowwithSire=Request.Form("ShowwithSire")
Dam=Request.Form("Dam")
Dam2=Request.Form("Dam2")
response.write("Dam2=" & Dam2)
DamColor=Request.Form("DamColor") 
DamAri=Request.Form("DamAri") 
DamLink=Request.Form("DamLink") 

str1 = lcase(DamLink )
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamLink = Replace(str1, str2, "")
End If

str1 = lcase(DamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamLink = Replace(str1, str2, "")
End If

str1 = lcase(DamLink )
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamLink = Replace(str1, str2, "")
End If


DamCLAA=Request.Form("DamCLAA") 
DamDam=Request.Form("DamDam")
DamDam2=Request.Form("DamDam2")  
DamDamColor=Request.Form("DamDamColor") 
DamDamAri=Request.Form("DamDamAri") 
DamDamLink=Request.Form("DamDamLink") 

str1 = lcase(DamDamLink )
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamLink )
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamDamLink= Replace(str1, str2, "")
End If



DamDamCLAA=Request.Form("DamDamCLAA") 
DamDamDam=Request.Form("DamDamDam") 
DamDamDam2=Request.Form("DamDamDam2") 
DamDamDamColor=Request.Form("DamDamDamColor") 
DamDamDamAri=Request.Form("DamDamDamAri") 
DamDamDamLink=Request.Form("DamDamDamLink") 

response.write("DamDamDamLink=" & DamDamDamLink )
str1 = lcase(DamDamDamLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamDamLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamDamDamLink= Replace(str1, str2, "")
End If

DamDamDamCLAA=Request.Form("DamDamDamCLAA") 
DamDamSire=Request.Form("DamDamSire") 
DamDamSire2=Request.Form("DamDamSire2") 
DamDamSireColor=Request.Form("DamDamSireColor") 
DamDamSireAri=Request.Form("DamDamSireAri") 
DamDamSireLink=Request.Form("DamDamSireLink") 

str1 = lcase(DamDamSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamSireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamDamSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamDamSireLink= Replace(str1, str2, "")
End If


DamDamSireCLAA=Request.Form("DamDamSireCLAA") 
DamSire=Request.Form("DamSire")
DamSire2=Request.Form("DamSire2") 
DamSireColor=Request.Form("DamSireColor") 
DamSireAri=Request.Form("DamSireAri") 
DamSireLink=Request.Form("DamSireLink") 
str1 = lcase(DamSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamSireLink= Replace(str1, str2, "")
End If

DamSireCLAA=Request.Form("DamSireCLAA") 
DamSireDam=Request.Form("DamSireDam") 
DamSireDam2=Request.Form("DamSireDam2") 
DamSireDamColor=Request.Form("DamSireDamColor") 
DamSireDamAri=Request.Form("DamSireDamAri") 
DamSireDamLink=Request.Form("DamSireDamLink") 

str1 = lcase(DamSireDamLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamSireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamSireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamSireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireDamLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamSireDamLink= Replace(str1, str2, "")
End If

DamSireDamCLAA=Request.Form("DamSireDamCLAA") 
DamSireSire=Request.Form("DamSireSire") 
DamSireSire2=Request.Form("DamSireSire2") 
DamSireSireColor=Request.Form("DamSireSireColor") 
DamSireSireAri=Request.Form("DamSireSireAri") 
DamSireSireLink=Request.Form("DamSireSireLink") 

str1 = lcase(DamSireSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamSireSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireSireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
DamSireSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamSireSireLink= Replace(str1, str2, "")
End If

str1 = lcase(DamSireSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamSireSireLink= Replace(str1, str2, "")
End If

DamSireSireCLAA=Request.Form("DamSireSireCLAA") 
Sire=Request.Form("Sire")
Sire2=Request.Form("Sire2")
SireColor=Request.Form("SireColor")
SireAri=Request.Form("SireAri")
SireLink=Request.Form("SireLink")

str1 = lcase(SireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireLink= Replace(str1, str2, "")
End If

SireComment=Request.Form("SireComment")
SireCLAA=Request.Form("SireCLAA")
SireDam=Request.Form("SireDam")
SireDam2=Request.Form("SireDam2")
SireDamColor=Request.Form("SireDamColor")
SireDamAri=Request.Form("SireDamAri")
SireDamLink=Request.Form("SireDamLink")
str1 = lcase(SireDamLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireDamLink= Replace(str1, str2, "")
End If

SireDamCLAA=Request.Form("SireDamCLAA")
SireDamDam=Request.Form("SireDamDam") 
SireDamDam2=Request.Form("SireDamDam2") 
SireDamDamColor=Request.Form("SireDamDamColor") 
SireDamDamAri=Request.Form("SireDamDamAri") 
SireDamDamLink=Request.Form("SireDamDamLink") 
str1 = lcase(SireDamDamLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireDamDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamDamLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireDamDamLink= Replace(str1, str2, "")
End If

SireDamDamCLAA=Request.Form("SireDamDamCLAA") 
SireDamSire=Request.Form("SireDamSire") 
SireDamSire2=Request.Form("SireDamSire2")
SireDamSireColor=Request.Form("SireDamSireColor") 
SireDamSireAri=Request.Form("SireDamSireAri") 
SireDamSireLink=Request.Form("SireDamSireLink") 
str1 = lcase(SireDamSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamSireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireDamSireLink =Replace(str1, str2, "")
End If

str1 = lcase(SireDamSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireDamSireLink= Replace(str1, str2, "")
End If

SireDamSireCLAA=Request.Form("SireDamSireCLAA") 
SireSire=Request.Form("SireSire")
SireSire2=Request.Form("SireSire2")
SireSireColor=Request.Form("SireSireColor")
SireSireAri=Request.Form("SireSireAri")
SireSireLink=Request.Form("SireSireLink")

str1 = lcase(SireSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireSireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireDamSireLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireDamSireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireSireLink=Replace(str1, str2, "")
End If

str1 = lcase(SireDamSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireDamSireLink= Replace(str1, str2, "")
End If
SireSireCLAA=Request.Form("SireSireCLAA")

SireSireDam=Request.Form("SireSireDam") 
SireSireDam2=Request.Form("SireSireDam2") 
SireSireDamColor=Request.Form("SireSireDamColor") 
SireSireDamAri=Request.Form("SireSireDamAri") 
SireSireDamLink=Request.Form("SireSireDamLink") 
str1 = lcase(SireSireDamLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireSireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireSireDamLink)
str2 = "http;//"
If InStr(str1,str2) > 0 Then
SireSireDamLink= Replace(str1, str2, "")
End If

str1 = lcase(SireSireDamLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireSireDamLink=Replace(str1, str2, "")
End If

str1 = lcase(SireSireDamLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireSireDamLink= Replace(str1, str2, "")
End If

SireSireDamCLAA=Request.Form("SireSireDamCLAA") 
SireSireSire=Request.Form("SireSireSire") 
SireSireSire2=Request.Form("SireSireSire2") 
SireSireSireColor=Request.Form("SireSireSireColor") 
SireSireSireAri=Request.Form("SireSireSireAri") 
SireSireSireLink=Request.Form("SireSireSireLink") 
str1 = lcase(SireSireSireLink)
str2 = "http://"
If InStr(str1,str2) > 0 Then
SireSireSireLink= Replace(str1, str2, "")
End If

str1 = lcase(SireSireSireLink)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
SireSireSireLink=Replace(str1, str2, "")
End If

str1 = lcase(SireSireSireLink)
str2 = "http:"
If InStr(str1,str2) > 0 Then
SireSireSireLink= Replace(str1, str2, "")
End If


SireSireSireCLAA=Request.Form("SireSireSireCLAA") 

If len(DamDamDam2) > 0 then
   DamDamDam = DamDamDam2 
end if

If len(DamDamSire2) > 0 then
   DamDamSire = DamDamSire2 
end if

If len(DamSireDam2) > 0 then
   DamsireDam = DamSireDam2 
end if

If len(DamSireSire2) > 0 then
   DamSireSire = DamSireSire2 
end if

If len(SireDamDam2) > 0 then
   SireDamDam = SireDamDam2 
end if

If len(SireDamSire2) > 0 then
   SireDamSire = SireDamSire2 
end if

If len(SireSireDam2) > 0 then
   SireSireDam = SireSireDam2 
end if

If len(SireSireSire2) > 0 then
   SireSireSire = SireSireSire2 
end if

Query =  " UPDATE Animals Set ShowWithDam = " &  ShowWithDam & ", " 
Query =  Query & " ShowWithSire= " &  ShowwithSire & ", " 
Query =  Query & " Lastupdated = now() "
Query =  Query & " where ID = " & ID & ";" 
response.write(Query)

Conn.Execute(Query) 


Ancestor = Dam  
Ancestor2 = Dam2  
Ancestorcolor = Damcolor
AncestorARI = DamARI
AncestorCLAA = DamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
Dam   = Ancestor
Dam2   = Ancestor2
 Damcolor = Ancestorcolor
DamARI  = AncestorARI
 DamCLAA = AncestorCLAA

Ancestor = DamDam  
Ancestor2 = DamDam2  
Ancestorcolor = DamDamcolor
AncestorARI = DamDamARI
AncestorCLAA = DamDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamDam   = Ancestor
DamDam2   = Ancestor2
 DamDamcolor = Ancestorcolor
DamDamARI  = AncestorARI
 DamDamCLAA = AncestorCLAA


 Ancestor = DamDamDam  
Ancestor2 = DamDamDam2
Ancestorcolor = DamDamDamcolor
AncestorARI = DamDamDamARI
AncestorCLAA = DamDamDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamDamDam   = Ancestor
DamDamDam2   = Ancestor2
 DamDamDamcolor = Ancestorcolor
DamDamDamARI  = AncestorARI
 DamDamDamCLAA = AncestorCLAA

Ancestor = DamDamSire  
Ancestor2 = DamDamSire2  
Ancestorcolor = DamDamSirecolor
AncestorARI = DamDamSireARI
AncestorCLAA = DamDamSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamDamSire   = Ancestor
DamDamSire2   = Ancestor2
DamDamSirecolor = Ancestorcolor
DamDamSireARI  = AncestorARI
DamDamSireCLAA = AncestorCLAA

Ancestor = DamSire 
Ancestor2 = DamSire2  
Ancestorcolor = DamSirecolor
AncestorARI = DamSireARI
AncestorCLAA = DamSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamSire   = Ancestor
DamSire2   = Ancestor2
DamSirecolor = Ancestorcolor
DamSireARI  = AncestorARI
DamSireCLAA = AncestorCLAA

Ancestor = DamSireDam 
Ancestor2 = DamSireDam2   
Ancestorcolor = DamSireDamcolor
AncestorARI = DamSireDamARI
AncestorCLAA = DamSireDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamSireDam   = Ancestor
DamSireDam2   = Ancestor2
 DamSireDamcolor = Ancestorcolor
DamSireDamARI  = AncestorARI
 DamSireDamCLAA = AncestorCLAA


 Ancestor = DamSireSire  
  Ancestor2 = DamSireSire2 
Ancestorcolor = DamSireSirecolor
AncestorARI = DamSireSireARI
AncestorCLAA = DamSireSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
DamSireSire   = Ancestor
DamSireSire2   = Ancestor2
 DamSireSirecolor = Ancestorcolor
DamSireSireARI  = AncestorARI
 DamSireSireCLAA = AncestorCLAA


 Ancestor = Sire 
 Ancestor2 = Sire2  
Ancestorcolor = Sirecolor
AncestorARI = SireARI
AncestorCLAA = SireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
Sire   = Ancestor
Sire2   = Ancestor2
Sirecolor = Ancestorcolor
SireARI  = AncestorARI
SireCLAA = AncestorCLAA


 Ancestor = SireDam  
 Ancestor2 = SireDam2  
Ancestorcolor =SireDamcolor
AncestorARI = SireDamARI
AncestorCLAA = SireDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireDam   = Ancestor
SireDam2   = Ancestor2
 SireDamcolor = Ancestorcolor
SireDamARI  = AncestorARI
 SireDamCLAA = AncestorCLAA


 Ancestor = SireDamDam 
  Ancestor2 = SireDamDam2   
Ancestorcolor = SireDamDamcolor
AncestorARI = SireDamDamARI
AncestorCLAA = SireDamDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireDamDam   = Ancestor
response.write("SireDamDam=" & SireDamDam )
SireDamDam2  = Ancestor2
 SireDamDamcolor = Ancestorcolor
SireDamDamARI  = AncestorARI
 SireDamDamCLAA = AncestorCLAA


Ancestor = SireDamSire 
Ancestor2 = SireDamSire2 
Ancestorcolor = SireDamSirecolor
AncestorARI = SireDamSireARI
AncestorCLAA = SireDamSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireDamSire   = Ancestor
SireDamSire2   = Ancestor2
SireDamSirecolor = Ancestorcolor
SireDamSireARI  = AncestorARI
SireDamSireCLAA = AncestorCLAA

 Ancestor = SireSire 
 Ancestor2 = SireSire2  
Ancestorcolor = SireSirecolor
AncestorARI = SireSireARI
AncestorCLAA = SireSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireSire   = Ancestor
SireSire2   = Ancestor2
SireSirecolor = Ancestorcolor
SireSireARI  = AncestorARI
SireSireCLAA = AncestorCLAA


 Ancestor = SireSireDam
 Ancestor2 = SireSireDam2  
Ancestorcolor =SireSireDamcolor
AncestorARI = SireSireDamARI
AncestorCLAA = SireSireDamCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireSireDam   = Ancestor
SireSireDam2   = Ancestor2
SireSireDamcolor = Ancestorcolor
SireSireDamARI  = AncestorARI
SireSireDamCLAA = AncestorCLAA


 Ancestor = SireSireSire 
 Ancestor2 = SireSireSire2 
Ancestorcolor = SireSireSirecolor
AncestorARI = SireSireSireARI
AncestorCLAA = SireSireSireCLAA
%>
<!--#Include File="MembersAncestorCheckDataInclude.asp"-->
<%
SireSireSire   = Ancestor
SireSireSire2   = Ancestor2
SireSireSirecolor = Ancestorcolor
SireSireSireARI  = AncestorARI
SireSireSireCLAA = AncestorCLAA



If len(Dam2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & Dam2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 
Dam = Dam2  
if len(DamDam) < 2 then
   DamDam = rs("Dam")
   end if
   if len(DamDamColor) < 2 then
   DamDamColor=rs("DamColor") 
   end if
   if len(DamDamAri) < 2 then
DamDamAri=rs("DamAri") 
end if
   if len(DamDamLink) < 2 then
DamDamLink=rs("DamLink") 
end if
   if len(DamDamCLAA) < 2 then
DamDamCLAA=rs("DamCLAA") 
end if


   if len(DamSire) < 2 then
DamSire = rs("Sire")
   end if 
   if len(DamSireColor) < 2 then
   DamSireColor=rs("SireColor") 
   end if 
   if len(DamSireAri) < 2 then
DamSireAri=rs("SireAri") 
   end if 
   if len(DamSireLink) < 2 then
DamSireLink=rs("SireLink") 
   end if 
   if len(DamSireCLAA) < 2 then
DamSireCLAA=rs("SireCLAA") 
   End If

   if len(DamDamDam) < 2 then
DamDamDam = rs("DamDam")
   end if
   if len(DamDamDamColor) < 2 then 
   DamDamDamColor=rs("DamDamColor") 
   end if
   if len(DamDamDamAri) < 2 then 
DamDamDamAri=rs("DamDamAri")
   end if
   if len(DamDamDamLink) < 2 then  
DamDamDamLink=rs("DamDamLink")
   end if
   if len(DamDamDamCLAA) < 2 then  
DamDamDamCLAA=rs("DamDamCLAA")
   end if 

   if len(DamDamSire) < 2 then 
DamDamSire = rs("DamSire")
   end if
   if len(DamDamSireColor) < 2 then 
   DamDamSireColor=rs("DamSireColor") 
  end if
   if len(DamDamSireColor) < 2 then 
DamDamSireAri=rs("DamSireAri") 
   end if
   if len(DamDamSireLink) < 2 then 
DamDamSireLink=rs("DamSireLink")
end if 
if len(DamDamSireCLAA) < 2 then 
DamDamSireCLAA=rs("DamSireCLAA")
end if

if len(DamSire) < 2 then 
DamSire = rs("Sire")
end if
if len(DamSireColor) < 2 then
   DamSireColor=rs("SireColor") 
end if
if len(DamSireAri) < 2 then
DamSireAri=rs("SireAri")
end if
if len(DamSireLink) < 2 then
 DamSireLink=rs("SireLink") 
end if
if len(DamSireCLAA) < 2 then
DamSireCLAA=rs("SireCLAA") 
end if
  
  
if len(DamSireDam) < 2 then
DamSireDam = rs("SireDam")
end if
if len(DamSireDamColor) < 2 then
   DamSireDamColor=rs("SireDamColor") 
end if
if len(DamSireDamAri) < 2 then
DamSireDamAri=rs("SireDamAri") 
end if
if len(DamSireDamLink) < 2 then
DamSireDamLink=rs("SireDamLink") 
end if
if len(DamSireDamCLAA) < 2 then
DamSireDamCLAA=rs("SireDamCLAA") 
end if


if len(DamSireSire) < 2 then
DamSireSire = rs("SireSire")
end if
if len(DamSireSireColor) < 2 then
   DamSireSireColor=rs("SireSireColor")
end if
if len(DamSireSireAri) < 2 then
 DamSireSireAri=rs("SireSireAri") 
end if
if len(DamSireSireLink) < 2 then
DamSireSireLink=rs("SireSireLink")
end if
if len(DamSireSireCLAA) < 2 then
 DamSireSireCLAA=rs("SireSireCLAA") 
end if


end if



If len(DamDam2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & DamDam2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 response.write(sql)
DamDam = DamDam2  
if len(DamDamDam) < 2 then
   DamDamDam = rs("Dam")
   end if
   if len(DamDamDamColor) < 2 then
   DamDamDamColor=rs("DamColor") 
   end if
   if len(DamDamdamAri) < 2 then
DamDamDamAri=rs("DamAri") 
end if
   if len(DamDamDamLink) < 2 then
DamDamDamLink=rs("DamLink") 
end if
   if len(DamDamDamCLAA) < 2 then
DamDamDamCLAA=rs("DamCLAA") 
end if


   if len(DamDamSire) < 2 then
DamDamSire = rs("Sire")
   end if 
   if len(DamDamSireColor) < 2 then
   DamDamSireColor=rs("SireColor") 
   end if 
   if len(DamDamSireAri) < 2 then
DamDamSireAri=rs("SireAri") 
   end if 
   if len(DamDamSireLink) < 2 then
DamDamSireLink=rs("SireLink") 
   end if 
   if len(DamDamSireCLAA) < 2 then
DamDamSireCLAA=rs("SireCLAA") 
   End If

end if



If len(DamSire2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & DamSire2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 
DamSire = DamSire2  
if len(DamSireDam) < 2 then
   DamSireDam = rs("Dam")
   end if
   if len(DamSireDamColor) < 2 then
   DamSireDamColor=rs("DamColor") 
   end if
   if len(DamSireDamAri) < 2 then
DamSireDamAri=rs("DamAri") 
end if
   if len(DamSireDamLink) < 2 then
DamSireDamLink=rs("DamLink") 
end if
   if len(DamSireDamCLAA) < 2 then
DamSireDamCLAA=rs("DamCLAA") 
end if

   if len(DamSiresire) < 2 then
DamSiresire = rs("Sire")
   end if 
   if len(DamSiresireColor) < 2 then
   DamSiresireColor=rs("SireColor") 
   end if 
   if len(DamSiresireAri) < 2 then
DamSiresireAri=rs("SireAri") 
   end if 
   if len(DamSiresireLink) < 2 then
DamSiresireLink=rs("SireLink") 
   end if 
   if len(DamSiresireCLAA) < 2 then
DamSiresireCLAA=rs("SireCLAA") 
   End If

end if





If len(Sire2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & Sire2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 
Sire = Sire2  
if len(SireDam) < 2 then
   SireDam = rs("Dam")
   end if
   if len(SireDamColor) < 2 then
   SireDamColor=rs("DamColor") 
   end if
   if len(SireDamAri) < 2 then
SireDamAri=rs("DamAri") 
end if
   if len(SireDamLink) < 2 then
SireDamLink=rs("DamLink") 
end if
   if len(SireDamCLAA) < 2 then
SireDamCLAA=rs("DamCLAA") 
end if


   if len(SireSire) < 2 then
SireSire = rs("Sire")
   end if 
   if len(SireSireColor) < 2 then
   SireSireColor=rs("SireColor") 
   end if 
   if len(SireSireAri) < 2 then
SireSireAri=rs("SireAri") 
   end if 
   if len(SireSireLink) < 2 then
SireSireLink=rs("SireLink") 
   end if 
   if len(SireSireCLAA) < 2 then
SireSireCLAA=rs("SireCLAA") 
   End If

   if len(SireDamDam) < 2 then
SireDamDam = rs("DamDam")
   end if
   if len(SireDamDamColor) < 2 then 
   SireDamDamColor=rs("DamDamColor") 
   end if
   if len(SireDamDamAri) < 2 then 
SireDamDamAri=rs("DamDamAri")
   end if
   if len(SireDamDamLink) < 2 then  
SireDamDamLink=rs("DamDamLink")
   end if
   if len(SireDamDamCLAA) < 2 then  
SireDamDamCLAA=rs("DamDamCLAA")
   end if 

   if len(SireDamSire) < 2 then 
SireDamSire = rs("DamSire")
   end if
   if len(SireDamSireColor) < 2 then 
   SireDamSireColor=rs("DamSireColor") 
  end if
   if len(SireDamSireColor) < 2 then 
SireDamSireAri=rs("DamSireAri") 
   end if
   if len(SireDamSireLink) < 2 then 
SireDamSireLink=rs("DamSireLink")
end if 
if len(SireDamSireCLAA) < 2 then 
SireDamSireCLAA=rs("DamSireCLAA")
end if

if len(SireSire) < 2 then 
SireSire = rs("Sire")
end if
if len(SireSireColor) < 2 then
   SireSireColor=rs("SireColor") 
end if
if len(SireSireAri) < 2 then
SireSireAri=rs("SireAri")
end if
if len(SireSireLink) < 2 then
 SireSireLink=rs("SireLink") 
end if
if len(SireSireCLAA) < 2 then
SireSireCLAA=rs("SireCLAA") 
end if
  
  
if len(SireSireDam) < 2 then
SireSireDam = rs("SireDam")
end if
if len(SireSireDamColor) < 2 then
   SireSireDamColor=rs("SireDamColor") 
end if
if len(SireSireDamAri) < 2 then
SireSireDamAri=rs("SireDamAri") 
end if
if len(SireSireDamLink) < 2 then
SireSireDamLink=rs("SireDamLink") 
end if
if len(SireSireDamCLAA) < 2 then
SireSireDamCLAA=rs("SireDamCLAA") 
end if


if len(SireSireSire) < 2 then
SireSireSire = rs("SireSire")
end if
if len(SireSireSireColor) < 2 then
   SireSireSireColor=rs("SireSireColor")
end if
if len(SireSireSireAri) < 2 then
 SireSireSireAri=rs("SireSireAri") 
end if
if len(SireSireSireLink) < 2 then
SireSireSireLink=rs("SireSireLink")
end if
if len(SireSireSireCLAA) < 2 then
 SireSireSireCLAA=rs("SireSireCLAA") 
end if


end if


If len(SireDam2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & SireDam2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 
SireDam = SireDam2  
if len(SireDamDam) < 2 then
   SireDamDam = rs("Dam")



   end if
   if len(SireDamDamColor) < 2 then
   SireDamDamColor=rs("DamColor") 
   end if
   if len(SireDamDamAri) < 2 then
SireDamDamAri=rs("DamAri") 
end if
   if len(SireDamDamLink) < 2 then
SireDamDamLink=rs("DamLink") 
end if
   if len(SireDamDamCLAA) < 2 then
SireDamDamCLAA=rs("DamCLAA") 
end if


   if len(SireDamSire) < 2 then
SireDamSire = rs("Sire")
   end if 
   if len(SireDamSireColor) < 2 then
   SireDamSireColor=rs("SireColor") 
   end if 
   if len(SireDamSireAri) < 2 then
SireDamSireAri=rs("SireAri") 
   end if 
   if len(SireDamSireLink) < 2 then
SireDamSireLink=rs("SireLink") 
   end if 
   if len(SireDamSireCLAA) < 2 then
SireDamSireCLAA=rs("SireCLAA") 
   End If

end if



If len(SireSire2) > 0 then

 sql = "select animals.ID, ancestors.* from animals, Ancestors where animals.ID = Ancestors.ID and FullName =  '" & SireSire2 & "'"
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
 
SireSire = SireSire2  
if len(SireSireDam) < 2 then
   SireSireDam = rs("Dam")
   end if
   if len(SireSireDamColor) < 2 then
   SireSireDamColor=rs("DamColor") 
   end if
   if len(SireSireDamAri) < 2 then
SireSireDamAri=rs("DamAri") 
end if
   if len(SireSireDamLink) < 2 then
SireSireDamLink=rs("DamLink") 
end if
   if len(SireSireDamCLAA) < 2 then
SireSireDamCLAA=rs("DamCLAA") 
end if

   if len(SireSireSire) < 2 then
SireSireSire = rs("Sire")
   end if 
   if len(SireSireSireColor) < 2 then
   SireSireSireColor=rs("SireColor") 
   end if 
   if len(SireSireSireAri) < 2 then
SireSireSireAri=rs("SireAri") 
   end if 
   if len(SireSireSireLink) < 2 then
SireSireSireLink=rs("SireLink") 
   end if 
   if len(SireSireSireCLAA) < 2 then
SireSireSireCLAA=rs("SireCLAA") 
   End If

end if

str1 = Dam
str2 = "'"
If InStr(str1,str2) > 0 Then
	Dam= Replace(str1, "'", "''")
End If

str1 = DamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
DamDam= Replace(str1, "'", "''")
End If

str1 = DamDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
DamDamDam= Replace(str1, "'", "''")
End If

str1 = DamDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
DamDamSire= Replace(str1, "'", "''")
End If

str1 = DamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
DamSire= Replace(str1, "'", "''")
End If

str1 = DamSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
DamSireSire= Replace(str1, "'", "''")
End If

str1 = DamSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
DamSireSire= Replace(str1, "'", "''")
End If




str1 = Sire
str2 = "'"
If InStr(str1,str2) > 0 Then
Sire= Replace(str1, "'", "''")
End If

str1 = SireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
SireDam= Replace(str1, "'", "''")
End If

str1 = SireDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
SireDamDam= Replace(str1, "'", "''")
End If

str1 = SireDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
SireDamSire= Replace(str1, "'", "''")
End If

str1 = SireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
SireSire= Replace(str1, "'", "''")
End If

str1 =SireSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
SireSireSire= Replace(str1, "'", "''")
End If

str1 = SireSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
SireSireSire= Replace(str1, "'", "''")
End If






Query =  " UPDATE Ancestors Set Dam = '" &  Dam & "', " 
Query =  Query & " DamColor = '" &  DamColor & "'," 
Query =  Query & " DamAri = '" &  DamAri & "'," 
 Query =  Query & " DamCLAA = '" &  DamCLAA & "'," 
Query =  Query & " DamLink = '" &  DamLink & "'," 

Query =  Query & " DamDam = '" &   DamDam & "'," 
Query =  Query & " DamDamColor = '" &  DamDamColor & "'," 
Query =  Query & " DamDamAri = '" &  DamDamAri & "'," 
Query =  Query & " DamDamLink = '" &  DamDamLink & "'," 
Query =  Query & " DamDamCLAA = '" &  DamDamCLAA & "'," 

Query =  Query & " DamDamDam = '" &   DamDamDam & "'," 
Query =  Query & " DamDamDamColor = '" &  DamDamDamColor & "'," 
Query =  Query & " DamDamDamAri = '" &  DamDamDamAri & "'," 
Query =  Query & " DamDamDamLink = '" &  DamDamDamLink & "'," 
Query =  Query & " DamDamDamCLAA = '" &  DamDamDamCLAA & "'," 

Query =  Query & " DamDamSire = '" &   DamDamSire & "'," 
Query =  Query & " DamDamSireColor = '" &  DamDamSireColor & "'," 
Query =  Query & " DamDamSireAri = '" &  DamDamSireAri & "'," 
Query =  Query & " DamDamSireLink = '" &  DamDamSireLink & "'," 
Query =  Query & " DamDamSireCLAA = '" &  DamDamSireCLAA & "'," 



Query =  Query & " DamSire = '"  &  DamSire & "'," 
Query =  Query & " DamSireColor = '" &  DamSireColor & "',"
Query =  Query & " DamSireAri = '" &  DamSireAri & "',"
Query =  Query & " DamSireLink  = '" &  DamSireLink & "',"
Query =  Query & " DamSireCLAA = '" &  DamSireCLAA & "',"


Query =  Query & " DamSireDam = '" &   DamSireDam & "'," 
Query =  Query & " DamSireDamColor = '" &  DamSireDamColor & "'," 
Query =  Query & " DamSireDamAri = '" &  DamSireDamAri & "'," 
Query =  Query & " DamSireDamLink = '" &  DamSireDamLink & "'," 
Query =  Query & " DamSireDamCLAA = '" &  DamSireDamCLAA & "'," 

Query =  Query & " DamSireSire = '" &   DamSireSire & "'," 
Query =  Query & " DamSireSireColor = '" &  DamSireSireColor & "'," 
Query =  Query & " DamSireSireAri = '" &  DamSireSireAri & "'," 
Query =  Query & " DamSireSireLink = '" &  DamSireSireLink & "'," 
Query =  Query & " DamSireSireCLAA = '" &  DamSireSireCLAA & "'," 


Query =  Query & " Sire = '" &  Sire & "'," 
Query =  Query & " SireColor = '" &  SireColor & "'," 
Query =  Query & " SireAri = '" &  SireAri & "'," 
Query =  Query & " SireLink = '" &  SireLink & "'," 
Query =  Query & " SireCLAA = '" &  SireCLAA & "'," 

Query =  Query & " SireDam = '" &  SireDam & "',"
Query =  Query & " SireDamColor = '" &  SireDamColor & "',"
Query =  Query & " SireDamAri = '" &  SireDamAri & "',"
Query =  Query & " SireDamLink = '" &  SireDamLink & "',"
Query =  Query & " SireDamCLAA = '" &  SireDamCLAA & "',"

Query =  Query & " SireDamDam = '" &   SireDamDam & "'," 
Query =  Query & " SireDamDamColor = '" &  SireDamDamColor & "'," 
Query =  Query & " SireDamDamAri = '" &  SireDamDamAri & "'," 
Query =  Query & " SireDamDamLink = '" &  SireDamDamLink & "'," 
Query =  Query & " SireDamDamCLAA = '" &  SireDamDamCLAA & "'," 

Query =  Query & " SireDamSire = '" &   SireDamSire & "'," 
Query =  Query & " SireDamSireColor = '" &  SireDamSireColor & "'," 
Query =  Query & " SireDamSireAri = '" &  SireDamSireAri & "'," 
Query =  Query & " SireDamSireLink = '" &  SireDamSireLink & "'," 
Query =  Query & " SireDamSireCLAA = '" &  SireDamSireCLAA & "'," 


Query =  Query & " SireSire = '" &  SireSire & "',"
Query =  Query & " SireSireColor = '" &  SireSireColor & "'," 
Query =  Query & "  SireSireAri = '" &  SireSireAri & "'," 
Query =  Query & " SireSireLink = '" &  SireSireLink & "'," 
Query =  Query & " SireSireCLAA = '" &  SireSireCLAA & "'," 

Query =  Query & " SireSireSire = '" & SireSireSire & "'," 
Query =  Query & " SireSireSireColor = '" &  SireSireSireColor & "'," 
Query =  Query & " SireSireSireAri = '" & SireSireSireAri & "'," 
Query =  Query & " SireSireSireLink= '" &  SireSireSireLink & "'," 
Query =  Query & " SireSireSireCLAA = '" &  SireSireSireCLAA & "'," 

Query =  Query & " SireSireDam = '" &   SireSireDam & "'," 
Query =  Query & " SireSireDamColor = '" &  SireSireDamColor & "'," 
Query =  Query & " SireSireDamAri = '" &  SireSireDamAri & "'," 
Query =  Query & " SireSireDamLink = '" & SireSireDamLink & "'," 
Query =  Query & " SireSireDamCLAA = '" & SireSireDamCLAA & "'" 
Query =  Query & " where ID = " & ID & ";" 
response.write("Query = " &  Query)
Conn.Execute(Query) 
IF DataConnection.Errors.Count <> 0 then
 Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center">

<%

 End If

Conn.Close
Set Conn = Nothing 
dim aID(40000)
dim aName(40000)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" 
sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

While Not rs2.eof  
aID(acounter) = rs2("ID")
aName(acounter) = rs2("FullName")
'response.write (SSName(studcounter))

acounter = acounter +1
rs2.movenext
Wend

rs2.close
set rs2=nothing
set conn = nothing

response.redirect("MembersAncestryFrame.asp?id=" & id & "Speciesid=" & Speciesid  )
%>
 </Body>
</HTML>
