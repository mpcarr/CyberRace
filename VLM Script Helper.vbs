' ===============================================================
' ZVLM       Virtual Pinball X Light Mapper generated code
'
' This file provide default implementation and template to add bakemap
' & lightmap synchronization for position and lighting.
'


' ===============================================================
' The following code can be copy/pasted if using Lampz fading system
' It links each Lampz lamp/flasher to the corresponding light and lightmap

Sub UpdateLightMap(lightmap, intensity, ByVal aLvl)
   if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
   lightmap.Opacity = aLvl * intensity
End Sub

Sub LampzHelper
	' Sync on l_bet2 ' VLM.Lampz;Inserts-l_bet2
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_bet2, 100.00, " ' VLM.Lampz;Inserts-l_bet2
	' Sync on l_bet3 ' VLM.Lampz;Inserts-l_bet3
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_bet3, 100.00, " ' VLM.Lampz;Inserts-l_bet3
	' Sync on l_cyber1 ' VLM.Lampz;Inserts-l_cyber1
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_cyber1, 100.00, " ' VLM.Lampz;Inserts-l_cyber1
	' Sync on l_cyber2 ' VLM.Lampz;Inserts-l_cyber2
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_cyber2, 100.00, " ' VLM.Lampz;Inserts-l_cyber2
	' Sync on l_cyber3 ' VLM.Lampz;Inserts-l_cyber3
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_cyber3, 100.00, " ' VLM.Lampz;Inserts-l_cyber3
	' Sync on l_cyber4 ' VLM.Lampz;Inserts-l_cyber4
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_cyber4, 100.00, " ' VLM.Lampz;Inserts-l_cyber4
	' Sync on l_cyber5 ' VLM.Lampz;Inserts-l_cyber5
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_cyber5, 100.00, " ' VLM.Lampz;Inserts-l_cyber5
	' Sync on l_holdaug ' VLM.Lampz;Inserts-l_holdaug
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_holdaug, 100.00, " ' VLM.Lampz;Inserts-l_holdaug
	' Sync on l_leftOrbit ' VLM.Lampz;Inserts-l_leftOrbit
	Lampz.Callback(0) = "UpdateLightMap Layer_2_LM_Inserts_l_leftOrbit, 100.00, " ' VLM.Lampz;Inserts-l_leftOrbit
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_leftOrbi, 100.00, " ' VLM.Lampz;Inserts-l_leftOrbit
	' Sync on l_leftRamp ' VLM.Lampz;Inserts-l_leftRamp
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_leftRamp, 100.00, " ' VLM.Lampz;Inserts-l_leftRamp
	' Sync on l_centerRamp ' VLM.Lampz;Inserts-l_centerRamp
	Lampz.Callback(0) = "UpdateLightMap swLeftReturn_LM_Inserts_l_cente, 100.00, " ' VLM.Lampz;Inserts-l_centerRamp
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_centerRa, 100.00, " ' VLM.Lampz;Inserts-l_centerRamp
	' Sync on l_rightRamp ' VLM.Lampz;Inserts-l_rightRamp
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_rightRam, 100.00, " ' VLM.Lampz;Inserts-l_rightRamp
	' Sync on l_rightOrbit ' VLM.Lampz;Inserts-l_rightOrbit
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_rightOrb, 100.00, " ' VLM.Lampz;Inserts-l_rightOrbit
	' Sync on l_shortcutReady ' VLM.Lampz;Inserts-l_shortcutReady
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_shortcut, 100.00, " ' VLM.Lampz;Inserts-l_shortcutReady
	' Sync on l_bet1 ' VLM.Lampz;Inserts-l_bet1
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_bet1, 100.00, " ' VLM.Lampz;Inserts-l_bet1
	' Sync on l_extraball ' VLM.Lampz;Inserts-l_extraball
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_extrabal, 100.00, " ' VLM.Lampz;Inserts-l_extraball
	' Sync on l_lock ' VLM.Lampz;Inserts-l_lock
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_Inserts_l_lock, 100.00, " ' VLM.Lampz;Inserts-l_lock
	' Sync on LA055 ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Layer_2_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Bumper1_Ring_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Bumper2_Ring_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Bumper3_Ring_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Flipper_3_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Flipper_3_002_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap RPin_prim_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap sw58_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swLeftInlane_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swLeftOutlane_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swLeftRamp_Wire_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swLeftReturn_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swRightInlane_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swRightOutlane_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swRightRamp_Wire_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swRightRampBallLock_Wire_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap swShortcut_LM_GI, 100.00, " ' VLM.Lampz;GI
	Lampz.Callback(0) = "UpdateLightMap Playfield_LM_GI, 100.00, " ' VLM.Lampz;GI
End Sub


' ===============================================================
' The following code can serve as a base for movable position synchronization.
' You will need to adapt the part of the transform you want to synchronize
' and the source on which you want it to be synchronized.

Sub MovableHelper
End Sub


' ===============================================================
' The following code can be copy/pasted to disable baked lights
' Lights are not removed on export since they are needed for ball
' reflections and may be used for lightmap synchronisation.

Sub HideLightHelper
	Gi14.Visible = False
	Gi2.Visible = False
	Gi4.Visible = False
	Gi6.Visible = False
	LA001.Visible = False
	LA002.Visible = False
	LA003.Visible = False
	LA004.Visible = False
	LA005.Visible = False
	LA006.Visible = False
	LA008.Visible = False
	LA016.Visible = False
	LA025.Visible = False
	LA029.Visible = False
	LA031.Visible = False
	LA033.Visible = False
	LA035.Visible = False
	LA037.Visible = False
	LA039.Visible = False
	LA041.Visible = False
	LA043.Visible = False
	LA045.Visible = False
	LA047.Visible = False
	LA049.Visible = False
	LA051.Visible = False
	LA053.Visible = False
	LA055.Visible = False
	LA057.Visible = False
	LA059.Visible = False
	LA061.Visible = False
	LA063.Visible = False
	LA065.Visible = False
	giinlane1.Visible = False
	l_bet1.Visible = False
	l_bet2.Visible = False
	l_bet3.Visible = False
	l_centerRamp.Visible = False
	l_cyber1.Visible = False
	l_cyber2.Visible = False
	l_cyber3.Visible = False
	l_cyber4.Visible = False
	l_cyber5.Visible = False
	l_extraball.Visible = False
	l_holdaug.Visible = False
	l_leftOrbit.Visible = False
	l_leftRamp.Visible = False
	l_lock.Visible = False
	l_rightOrbit.Visible = False
	l_rightRamp.Visible = False
	l_shortcutReady.Visible = False
End Sub


' ===============================================================
' The following provides a basic synchronization mechanism were
' lightmaps are synchronized to corresponding VPX light or flasher,
' using a simple realtime timer called VLMTimer. This works great
' as a starting point but Lampz direct lightmap fading shoudl be prefered.

Sub VLMTimer_Timer
	UpdateLightMapFromLight l_bet2, Playfield_LM_Inserts_l_bet2, 100.00, False
	UpdateLightMapFromLight l_bet3, Playfield_LM_Inserts_l_bet3, 100.00, False
	UpdateLightMapFromLight l_cyber1, Playfield_LM_Inserts_l_cyber1, 100.00, False
	UpdateLightMapFromLight l_cyber2, Playfield_LM_Inserts_l_cyber2, 100.00, False
	UpdateLightMapFromLight l_cyber3, Playfield_LM_Inserts_l_cyber3, 100.00, False
	UpdateLightMapFromLight l_cyber4, Playfield_LM_Inserts_l_cyber4, 100.00, False
	UpdateLightMapFromLight l_cyber5, Playfield_LM_Inserts_l_cyber5, 100.00, False
	UpdateLightMapFromLight l_holdaug, Playfield_LM_Inserts_l_holdaug, 100.00, False
	UpdateLightMapFromLight l_leftOrbit, Layer_2_LM_Inserts_l_leftOrbit, 100.00, False
	UpdateLightMapFromLight l_leftOrbit, Playfield_LM_Inserts_l_leftOrbi, 100.00, False
	Playfield_LM_Inserts_l_leftRamp.Visible = False ' 100.00 HDR scaling
	UpdateLightMapFromLight l_centerRamp, swLeftReturn_LM_Inserts_l_cente, 100.00, False
	UpdateLightMapFromLight l_centerRamp, Playfield_LM_Inserts_l_centerRa, 100.00, False
	UpdateLightMapFromLight l_rightRamp, Playfield_LM_Inserts_l_rightRam, 100.00, False
	UpdateLightMapFromLight l_rightOrbit, Playfield_LM_Inserts_l_rightOrb, 100.00, False
	UpdateLightMapFromLight l_shortcutReady, Playfield_LM_Inserts_l_shortcut, 100.00, False
	UpdateLightMapFromLight l_bet1, Playfield_LM_Inserts_l_bet1, 100.00, False
	UpdateLightMapFromLight l_extraball, Playfield_LM_Inserts_l_extrabal, 100.00, False
	UpdateLightMapFromLight l_lock, Playfield_LM_Inserts_l_lock, 100.00, False
	UpdateLightMapFromLight LA055, Layer_2_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Bumper1_Ring_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Bumper2_Ring_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Bumper3_Ring_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Flipper_3_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Flipper_3_002_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, RPin_prim_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, sw58_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swLeftInlane_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swLeftOutlane_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swLeftRamp_Wire_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swLeftReturn_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swRightInlane_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swRightOutlane_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swRightRamp_Wire_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swRightRampBallLock_Wire_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, swShortcut_LM_GI, 100.00, False
	UpdateLightMapFromLight LA055, Playfield_LM_GI, 100.00, False
End Sub

Function LightFade(light, is_on, percent)
	If is_on Then
		LightFade = percent*percent*(3 - 2*percent) ' Smoothstep
	Else
		LightFade = 1 - Sqr(1 - percent*percent) ' 
	End If
End Function

Sub UpdateLightMapFromFlasher(flasher, lightmap, intensity_scale, sync_color)
	If flasher.Visible Then
		If sync_color Then lightmap.Color = flasher.Color
		lightmap.Opacity = intensity_scale * flasher.IntensityScale * flasher.Opacity / 1000.0
	Else
		lightmap.Opacity = 0
	End If
End Sub

Sub UpdateLightMapFromLight(light, lightmap, intensity_scale, sync_color)
	light.FadeSpeedUp = light.Intensity / 50 '100
	light.FadeSpeedDown = light.Intensity / 200
	If sync_color Then lightmap.Color = light.Colorfull
	Dim t: t = LightFade(light, light.GetInPlayStateBool(), light.GetInPlayIntensity() / (light.Intensity * light.IntensityScale))
	lightmap.Opacity = intensity_scale * light.IntensityScale * t
End Sub
