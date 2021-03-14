VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3660
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   5940
   LinkTopic       =   "Form1"
   ScaleHeight     =   3660
   ScaleWidth      =   5940
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.CommandButton ÒÆÖ²OrangeFox 
      Caption         =   "ÒÆÖ²OrangeFox"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   1560
      Width           =   1455
   End
   Begin VB.CommandButton ÒÆÖ²TWRP 
      Caption         =   "ÒÆÖ²TWRP"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   960
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":0000
      BeginProperty Font 
         Name            =   "Î¢ÈíÑÅºÚ"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2775
      Left            =   2040
      TabIndex        =   2
      Top             =   240
      Width           =   3495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
a = Shell(App.Path & "\1.bat", vbNormalFocus)
End Sub

Private Sub ÒÆÖ²OrangeFox_Click()
a = Shell(App.Path & "\2.bat", vbNormalFocus)
End Sub
