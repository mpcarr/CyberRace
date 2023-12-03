
Dim AdvDebug
Sub InitDebugger()
    Set AdvDebug = CreateObject("vpx_adv_debugger.VPXAdvDebugger")
    AdvDebug.Connect()
End Sub