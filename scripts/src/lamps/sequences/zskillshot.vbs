
Dim lSeqSkillshot: Set lSeqSkillshot = new LightSeqItem
lSeqSkillshot.Name = "lSeqSkillshot"
lSeqSkillshot.Image = "pal_yellow"
lSeqSkillshot.Sequence = Array(Array(lsPop1, lsBet1, lsBet2, lsBet3, lsCenterRamp, lsRace6), Array(lsCombo3, lsRace3, lsBonus2, lsCyber3),Array(lsResearch2, lsCyber4, lsRace1, lsBonus1, lsRightRamp, lsCombo4),Array(lsPop1Off, lsBet1Off, lsBet2Off, lsBet3Off, lsCenterRampOff, lsRace6Off, lsAug1, lsRaceWizard),Array(lsCombo3Off, lsRace3Off, lsBonus1Off, lsCyber4Off, lsAug4, lsAug7, lsBonus3, lsRace2, lsRace5, lsSpinner2, lsPop2),Array(lsCyber3Off, lsResearch2Off, lsBonus2Off, lsRace1Off, lsRightRampOff, lsCombo4Off, lSeqFinish, lsShortcut),Array(lsAug1Off, lsRaceWizardOff, lsHyperJump5, lsHyperJump4, lsHoldAug, lsShortcut1, lsAug2, lsSpinner1),Array(lsAug4Off, lsAug7Off, lsBonus3Off, lsRace2Off, lsRace5Off, lsSpinner2Off, lsPop2Off, lsCombo2, lsCyber2, lsRace4, lsPlayfield2, lsCaptive1, lsCaptive4, lsShortcut2, lsAug5),Array(lSeqFinishOff, lsShortcutOff, lsHyperJump5Off, lsLeftRamp, lsHyperJump3, lsCaptive2, lsCaptive3, lsAug8),Array(lsHyperJump4Off, lsHoldAugOff, lsShortcut1Off, lsAug2Off, lsSpinner1Off, lsPlayfield3, lsPop3, lsShortcut3),Array(lsCombo2Off, lsCyber2Off, lsRace4Off, lsPlayfield2Off, lsCaptive1Off, lsCaptive4Off, lsShortcut2Off, lsAug5Off, lsHyperJump2, lsAug3, lsAug6),Array(lsLeftRampOff, lsHyperJump3Off, lsCaptive2Off, lsCaptive3Off, lsAug8Off, lsHyperJump1, lsLightLock, lsAug9, lsCyber5),Array(lsPlayfield3Off, lsPop3Off, lsShortcut3Off, lsExtraBall, lsPlayfield1, lsCombo5, lsResearch3, lsLane3),Array(lsHyperJump2Off, lsAug3Off, lsAug6Off, lsResearch1, lsRightOrbit),Array(lsHyperJump1Off, lsLightLockOff, lsAug9Off, lsCyber5Off, lsResearchReady, lsCyber1),Array(lsExtraBallOff, lsPlayfield1Off, lsCombo5Off, lsResearch3Off, lsLane3Off, lsCombo1, lsLane4, olr1a, olr2a, olr3a, olr4a, olr5a, olr6a, olr7a, olr8a, olr9a),Array(lsResearch1Off, lsRightOrbitOff, lsLeftOrbit, olr1b, olr2b, olr3b, olr4b, olr5b, olr6b, olr7b, olr8b, olr9b),Array(lsResearchReadyOff, lsCyber1Off),Array(lsCombo1Off, lsLane4Off, olr1aOff, olr2aOff, olr3aOff, olr4aOff, olr5aOff, olr6aOff, olr7aOff, olr8aOff, olr9aOff, lsLane2),Array(lsLeftOrbitOff, olr1bOff, olr2bOff, olr3bOff, olr4bOff, olr5bOff, olr6bOff, olr7bOff, olr8bOff, olr9bOff),Array(lsLane2Off, oll1b, oll2b, oll3b, oll4b, oll5b, oll6b, oll7b, oll8b, oll9b),Array(lsLane1, oll1a, oll2a, oll3a, oll4a, oll5a, oll6a, oll7a, oll8a, oll9a),Array(oll1bOff, oll2bOff, oll3bOff, oll4bOff, oll5bOff, oll6bOff, oll7bOff, oll8bOff, oll9bOff),Array(lsLane1Off, oll1aOff, oll2aOff, oll3aOff, oll4aOff, oll5aOff, oll6aOff, oll7aOff, oll8aOff, oll9aOff))
lSeqSkillshot.UpdateInterval = 10

Dim lSeqLightsOverride: Set lSeqLightsOverride = new LightSeq
lSeqLightsOverride.Name = "lSeqLightsOverride"


'lSeqSkillshot.Sequence = Array(
'    Array(lsPop1, lsBet1, lsBet2, lsBet3, lsCenterRamp, lsRace6), 
'    Array(lsCombo3, lsRace3, lsBonus2, lsCyber3),
'    Array(lsResearch2, lsCyber4, lsRace1, lsBonus1, lsRightRamp, lsCombo4),
'    Array(lsPop1Off, lsBet1Off, lsBet2Off, lsBet3Off, lsCenterRampOff, lsRace6Off, lsAug1, lsRaceWizard),
'    Array(lsCombo3Off, lsRace3Off, lsBonus1Off, lsCyber4Off, lsAug4, lsAug7, lsBonus3, lsRace2, lsRace5, lsSpinner2, lsPop2),
'    Array(lsCyber3Off, lsResearch2Off, lsBonus2Off, lsRace1Off, lsRightRampOff, lsCombo4Off, lSeqFinish, lsShortcut),
'    Array(lsAug1Off, lsRaceWizardOff, lsHyperJump5, lsHyperJump4, lsHoldAug, lsShortcut1, lsAug2, lsSpinner1),
'    Array(lsAug4Off, lsAug7Off, lsBonus3Off, lsRace2Off, lsRace5Off, lsSpinner2Off, lsPop2Off, lsCombo2, lsCyber2, lsRace4, lsPlayfield2, lsCaptive1, lsCaptive4, lsShortcut2, lsAug5),
'    Array(lSeqFinishOff, lsShortcutOff, lsHyperJump5Off, lsLeftRamp, lsHyperJump3, lsCaptive2, lsCaptive3, lsAug8),
'    Array(lsHyperJump4Off, lsHoldAugOff, lsShortcut1Off, lsAug2Off, lsSpinner1Off, lsPlayfield3, lsPop3, lsShortcut3),
'    Array(lsCombo2Off, lsCyber2Off, lsRace4Off, lsPlayfield2Off, lsCaptive1Off, lsCaptive4Off, lsShortcut2Off, lsAug5Off, lsHyperJump2, lsAug3, lsAug6),
'    Array(lsLeftRampOff, lsHyperJump3Off, lsCaptive2Off, lsCaptive3Off, lsAug8Off, lsHyperJump1, lsLightLock, lsAug9, lsCyber5),
'    Array(lsPlayfield3Off, lsPop3Off, lsShortcut3Off, lsExtraBall, lsPlayfield1, lsCombo5, lsResearch3, lsLane3),
'    Array(lsHyperJump2Off, lsAug3Off, lsAug6Off, lsResearch1, lsRightOrbit),
'    Array(lsHyperJump1Off, lsLightLockOff, lsAug9Off, lsCyber5Off, lsResearchReady, lsCyber1),
'    Array(lsExtraBallOff, lsPlayfield1Off, lsCombo5Off, lsResearch3Off, lsLane3Off, lsCombo1, lsLane4, olr1a, olr2a, olr3a, olr4a, olr5a, olr6a, olr7a, olr8a, olr9a),
'    Array(lsResearch1Off, lsRightOrbitOff, lsLeftOrbit, olr1b, olr2b, olr3b, olr4b, olr5b, olr6b, olr7b, olr8b, olr9b),
'    Array(lsResearchReadyOff, lsCyber1Off),
'    Array(lsCombo1Off, lsLane4Off, olr1aOff, olr2aOff, olr3aOff, olr4aOff, olr5aOff, olr6aOff, olr7aOff, olr8aOff, olr9aOff, lsLane2),
'    Array(lsLeftOrbitOff, olr1bOff, olr2bOff, olr3bOff, olr4bOff, olr5bOff, olr6bOff, olr7bOff, olr8bOff, olr9bOff),
'    Array(lsLane2Off, oll1b, oll2b, oll3b, oll4b, oll5b, oll6b, oll7b, oll8b, oll9b),
'    Array(lsLane1, oll1a, oll2a, oll3a, oll4a, oll5a, oll6a, oll7a, oll8a, oll9a),
'    Array(oll1bOff, oll2bOff, oll3bOff, oll4bOff, oll5bOff, oll6bOff, oll7bOff, oll8bOff, oll9bOff),
'    Array(lsLane1Off, oll1aOff, oll2aOff, oll3aOff, oll4aOff, oll5aOff, oll6aOff, oll7aOff, oll8aOff, oll9aOff))