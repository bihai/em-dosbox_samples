
'just some simple code for drawing beziers.
#Define Dist(p1, p2) (Sqr((p1.x-p2.x)^2 + (p1.y-p2.y)^2))

'you can play with this variable to adjust the additional accuracy.
'minus values = more speed, less accurate.
'positive values =less speed, more accurate.
'Values beyond 2 have no effect.
Const ACCURACY_OVERKILL = -0.3

Type TPoint
    x As Single
    y As Single
End Type

Sub DrawDot(Byval x As Single, Byval y As Single, radius As Single, r As Ubyte, g As Ubyte, b As Ubyte, a As Ubyte)
    Dim d As Single
    Dim As Single px,py
    Dim As Single rad2
    Dim As Single cr
    Dim As Single x1,y1,x2,y2
    'Print y
    
    If a > 255 Then a = 255
    
    cr=(radius/1.5)
    x1 = Int(x-radius-ACCURACY_OVERKILL)
    y1 = Int(y-radius-ACCURACY_OVERKILL)
    x2 = Int(x+radius+ACCURACY_OVERKILL)
    y2 = Int(y+radius+ACCURACY_OVERKILL)
    
    For py= y1 To y2
        For px = x1 To x2
            d = Sqr(((px-x)^2)+((py-y)^2))
            d = d / radius
            If d < 1 Then
                d ^= cr
                Line(px, py)-(px, py),RGBA(r,g,b,a*(1-d)),BF
            End If
        Next
    Next
End Sub

'this is an adaptive algorithm that I discovered myself.
'TODO: make it smarter when working with widths.
Sub RenderBezier (p1 As TPoint, p2 As TPoint, p3 As TPoint, p4 As TPoint, lwidth As Single, r As Ubyte, g As Ubyte, b As Ubyte, alpha As Ubyte)
    Dim t As Single = 1 'the most important value in the whole procedure
    Dim vert As Single = 0
    Dim binc As Single
    Dim bdist As Single
    Dim cp As TPoint
    Dim lp As TPoint
    Dim c As Integer=0
    'calculate the base increment (binc) using the base distance (bdist).
    'I'm too lazy to conjure up a direct algorithm to do this.
    'I just use a converging loop.
    binc = 0.3
    For i As Integer = 1 To 10 'don't do an infinite loop if it doesn't seem to converge.
        t = binc
        cp.x = p1.x*(1-t)^3 + 3*p2.x*((1-t)^2)*t + 3*p3.x*(1-t)*(t^2) + p4.x*(t^3)
        cp.y = p1.y*(1-t)^3 + 3*p2.y*((1-t)^2)*t + 3*p3.y*(1-t)*(t^2) + p4.y*(t^3)
        bdist = Dist(cp, p1)
        binc /= bdist
        If (1 > (bdist - 0.02)) And (1 < (bdist + 0.02)) Then Exit For 'converged. yay!
    Next i
    
    'Now, just go up the curve, adjusting the base increment whenever necessary.
    t = 0
    Do Until (t > 1)
        vert = 1-t
        cp.x = p1.x*vert^3 + 3*p2.x*vert*vert*t + 3*p3.x*vert*t*t + p4.x*(t^3)
        cp.y = p1.y*vert^3 + 3*p2.y*vert*vert*t + 3*p3.y*vert*t*t + p4.y*(t^3)
        
        bdist = Dist(cp, lp)
        binc /= bdist

        If (lwidth <= 1.5) Or (c=0) Then DrawDot (cp.x, cp.y, lwidth, r, g, b, 2*alpha/lwidth)
        lp.x = cp.x
        lp.y = cp.y
        t += binc
        c = 1-c
    Loop
End Sub


'ScreenRes 600,600, 32, 1, &H40
'ScreenRes 800,600, 32, 1, &H40
ScreenRes 640,480, 32, 1, &H40

Randomize Timer

Line (0,0)-(600,600),RGBA(255,255,255,255),BF

RenderBezier (type<TPoint>(100,100), type<TPoint>(300,100), type<TPoint>(300,300), type<TPoint>(500,300), _
                    1.1, 0,0,0,255)
Dim As Single cx, cy, lx, ly, ctx, cty, ltx, lty, tim

Print "Press any key to draw a continuous curve"
Sleep
Line (0,0)-(600,600),RGBA(255,255,255,255),BF
tim = Timer
For i As Integer = 0 To 10
    cy = 600 * Rnd
    cx = 600 * Rnd
    ctx = (200 * Rnd) - 100
    cty = (200 * Rnd) - 100
    RenderBezier (type<TPoint>(lx,ly), type<TPoint>(lx-ltx,ly-lty), type<TPoint>(cx+ctx,cy+cty), type<TPoint>(cx,cy), _
                    1.4, 0,0,0,255)
    ltx = ctx: lty = cty
    lx = cx: ly = cy
Next i
Print "Time: " & Timer - tim

Print "Press any key to draw 50 antialiased bezier curves of various widths, colors, and alphas."
Sleep
Line (0,0)-(600,600),RGBA(255,255,255,255),BF
For i As Integer = 0 To 20
    RenderBezier (type<TPoint>(600*Rnd,600*Rnd), type<TPoint>(600*Rnd,600*Rnd), type<TPoint>(600*Rnd,600*Rnd), type<TPoint>(600*Rnd,600*Rnd), _
                    1+(2*Rnd), 255*Rnd, 255*Rnd, 255*Rnd, 155+(100*Rnd))
Next i
Sleep