VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6390
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   9900
   BeginProperty Font 
      Name            =   "ËÎÌå"
      Size            =   12
      Charset         =   134
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   6390
   ScaleWidth      =   9900
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.ListBox List1 
      Height          =   4380
      Left            =   660
      TabIndex        =   0
      Top             =   1200
      Width           =   7995
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Show
    Refresh
    'Me.AddLog "OK"
    'Me.AddLog "test"
    'Me.AddLog "test OK"
    'Refresh
End Sub
Sub AddLog(sTxt As String)
    List1.AddItem sTxt
    List1.Selected(List1.ListCount - 1) = True
End Sub


