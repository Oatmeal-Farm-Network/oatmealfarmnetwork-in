<%
'*******************************************************************************************************
' ASPJSON - JSON parser & generator for Classic ASP, (c) 2011-2012 by A. V. Zelenov
' Forked and modified by Jan T. S.
'
' This library provides a way to parse JSON strings into VBScript objects (dictionaries and arrays) and
' to generate JSON strings from VBScript objects.
'
' Usage:
' To parse:
'   Dim oJSON
'   Set oJSON = New JSON
'   oJSON.loadJSON(jsonString)
'
' To generate:
'   Dim oJSON
'   Set oJSON = New JSON
'   oJSON.add("key", "value")
'   Response.Write(oJSON.toJSON())
'
'*******************************************************************************************************

Class JSON
	Private fso, regEx
	Private val  ' <--- This declaration should be inside the class

	Private Sub Class_Initialize()
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set regEx = new RegExp
		regEx.IgnoreCase = True
		Set val = CreateObject("Scripting.Dictionary")
	End Sub
	Private Sub Class_Terminate()
		Set fso = Nothing
		Set regEx = Nothing
	End Sub
	


    Public Function toJSON()
    toJSON = jsonEnc(Me.val)
End Function

Public Function loadJSON(str)
    Dim parser
    Set parser = New aspJSON       ' create the JSON parser
    parser.loadJSON(str)           ' The aspJSON subroutine populates parser.data
    Set Me.val = parser.data       ' Correctly assign the parsed data to the class's val property
    Set loadJSON = Me.val          ' Return a reference to the main data object
End Function
	
' Corrected function name to avoid VBScript reserved word 'get'
Public Function getItem(key)
	If Me.val.Exists(key) Then
		Set getItem = Me.val.Item(key)
	Else
		Set getItem = Nothing
	End If
End Function
	
	Public Sub add(key, val)
		Me.val.Add key, val
	End Sub
	

	
	' Public properties as convenience methods
	Public Default Property Get Item(key)
		Set Item = Me.val.Item(key)
	End Property
	Public  Property Let Item(key, val)
		Me.val.Item(key) = val
	End Property
	
	Public Function hasKey(key)
		hasKey = Me.val.Exists(key)
	End Function
	
	Public Function keys()
		keys = Me.val.Keys
	End Function

	Public Function Count()
		Count = Me.val.Count
	End Function
	
    Public Function toVBS()
    toVBS = jsonToVBS(Me.val)
End Function
	
	' Static methods
	
	' JSON decoder
	Private Function jsonDec(str)
		regEx.Global = True
		regEx.Pattern = """(?:\\.|[^""])*"""
		str = regEx.Replace(str, "__JSON_STRING__")
		
		regEx.Pattern = "\[|\]|\{|\}|,"
		If regEx.Test(str) Then
			Set jsonDec = jsonDecR(str)
		Else
			jsonDec = str
		End If
	End Function
	
	Private Function jsonDecR(str)
		Dim tempDict
		Set tempDict = CreateObject("Scripting.Dictionary")
		Dim tempArr
		tempArr = Array()
		
		' Find the first { or [
		regEx.Pattern = "\[|\{"
		Dim match
		Set match = regEx.Execute(str)(0)
		
		Dim startChar, endChar
		startChar = Mid(str, match.firstIndex + 1, 1)
		If startChar = "[" Then
			endChar = "]"
			Set jsonDecR = New JSONarray
		Else
			endChar = "}"
			Set jsonDecR = New JSONobject
		End If
		
		Dim p, i, c, nesting, key, val, str_content
		p = 0
		i = match.firstIndex + 1
		c = ""
		nesting = 0
		str_content = ""
		
		Do Until i > Len(str)
			c = Mid(str, i, 1)
			
			If c = startChar Then nesting = nesting + 1
			If c = endChar Then
				If nesting > 0 Then
					nesting = nesting - 1
				Else
					Exit Do
				End If
			End If
			
			str_content = str_content & c
			i = i + 1
		Loop
		
		' Parse content
		
		' This is a simple parser, it will not handle all JSON structures
		' For the WeatherAPI data, this works, as it is a simple object
		regEx.Pattern = "(?:""(.+?)""\s*:\s*)?(.+?)(?:$|,)"
		Set match = regEx.Execute(str_content)
		
		If startChar = "{" Then ' object
			For Each p In match
				key = p.SubMatches(0)
				val = p.SubMatches(1)
				Set val = jsonDec(val)
				jsonDecR.add key, val
			Next
		Else ' array
			For Each p In match
				val = p.SubMatches(1)
				Set val = jsonDec(val)
				jsonDecR.add UBound(tempArr) + 1, val
			Next
		End If
	End Function

End Class

' Helper classes for the JSON object
Class JSONobject
	Private val_
	Private Sub Class_Initialize()
		Set val_ = CreateObject("Scripting.Dictionary")
	End Sub
	Public Default Property Get Item(key)
		Set Item = val_.Item(key)
	End Property
	Public Property Let Item(key, val)
		val_.Item(key) = val
	End Property
	Public Function add(key, val)
		val_.Add key, val
	End Function
End Class

Class JSONarray
	Private val_
	Private Sub Class_Initialize()
		val_ = Array()
	End Sub
	Public Default Property Get Item(key)
		Set Item = val_(key)
	End Property
	Public Property Let Item(key, val)
		ReDim Preserve val_(key)
		val_(key) = val
	End Property
	Public Function add(key, val)
		ReDim Preserve val_(UBound(val_)+1)
		val_(UBound(val_)) = val
	End Function
End Class %>