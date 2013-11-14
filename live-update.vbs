rem Author: Mark D. Blackwell
rem Change dates:
rem November 13, 2013 - created
rem
rem Usage:
rem   live-update.vbs
rem Usage example:
rem   live-update.vbs
rem==============
rem References:
rem   http://www.devguru.com/technologies/VBScript/14075
rem   http://rosettacode.org/wiki/Here_document#VBScript
rem   http://wiki.mcneel.com/developer/vbsstatements

Const CreateIfNotExist = True
Const ForWriting = 2
Const FN = "\\HOLMES\D\NowPlaying.xml"
Const OpenAsAscii = 0
Const promptPrefix = "Current Song "

Dim filesys, outputTextStream
Dim n
Dim stringOne, stringTwo, stringThree
Dim artist, title
Dim xmlOutputString

n = Chr(13) & Chr(10)

rem Most of these fields are ignored by the Simple XML parser.

stringOne = _
"<?xml version='1.0' encoding='ISO-8859-1'?>"              & n & _
"<?xml-stylesheet type='text/xsl' href='NowPlaying.xsl'?>" & n & _
"<NowPlaying>"                     & n & _
"<Call>WTMD-FM</Call>"             & n & _
"<Events>"                         & n & _
"<SS32Event pos='0' valid='true'>" & n & _
_
"<CatId>MUS</CatId>"               & n & _
"<CutId>00PB</CutId>"              & n & _
"<Type>SONG</Type>"                & n & _
"<SecondsRemaining>  </SecondsRemaining>"  & n & _
"<Title><![CDATA["

stringTwo = _
"]]></Title>"       & n & _
"<Artist><![CDATA["

stringThree = _
"]]></Artist>"              & n & _
"<Intro>00</Intro>"         & n & _
"<Len>04:57</Len>"          & n & _
"<Raw><![CDATA[ ]]></Raw>"  & n & _
_
"</SS32Event>"              & n & _
"</Events>"                 & n & _
"</NowPlaying>"

WScript.StdOut.Write _
"Website Playlist Manual Update Program." & n & n & _
"Please enter..." & n

WScript.StdOut.Write _
promptPrefix & _
"Title: "
title = WScript.StdIn.ReadLine

WScript.StdOut.Write _
promptPrefix & _
"Artist: "
artist = WScript.StdIn.ReadLine

xmlOutputString = _
stringOne    & title  & _
stringTwo    & artist & _
stringThree  & n

Set filesys = CreateObject("Scripting.FileSystemObject")
Set outputTextStream = filesys.OpenTextFile(FN, ForWriting, CreateIfNotExist, OpenAsAscii)

outputTextStream.Write xmlOutputString

WScript.StdOut.Write "Done"