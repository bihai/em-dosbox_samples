'' examples/manual/variable/shared.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgShared
'' --------

'' Compile with -lang qb or fblite

'$lang: "qb"

Declare Sub MySub
Dim Shared x As Integer
Dim y As Integer

x = 10
y = 5

MySub

Sub MySub
	Print "x is "; x 'this will report 10 as it is shared
	Print "y is "; y 'this will not report 5 because it is not shared
End Sub
