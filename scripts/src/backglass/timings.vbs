'***********************************************************************************************************************
'*****    Backglass PUP / FlexDMD                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const TIMINGS_START_AUG_RESEARCH = "Timings Start Aug Research"
Const TIMINGS_COLLECT_AUGMENTATION = "Timings Collect Augmentation"
Const TIMINGS_BALL_LOCKED = "Timings Ball Locked"
Const TIMINGS_START_MULTIBALL = "Timings Smart Multiball"

Dim pupTimings: Set pupTimings=CreateObject("Scripting.Dictionary")
Dim dmdTimings: Set dmdTimings=CreateObject("Scripting.Dictionary")

pupTimings.Add TIMINGS_START_AUG_RESEARCH, 7000
dmdTimings.Add TIMINGS_START_AUG_RESEARCH, 1000

pupTimings.Add TIMINGS_COLLECT_AUGMENTATION, 10500
dmdTimings.Add TIMINGS_COLLECT_AUGMENTATION, 1000

pupTimings.Add TIMINGS_BALL_LOCKED, 3000
pupTimings.Add TIMINGS_START_MULTIBALL, 5000


Function Timings(tcode)
    If usePup = True Then
        Timings = pupTimings(tcode)
    Else
        Timings = dmdTimings(tcode)
    End If
End Function