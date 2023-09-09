Sub AddScore(v)
    'TODO Apply Any Multipliers
    SetPlayerState SCORE, GetPlayerState(SCORE) + v
End Sub

Sub AwardJackpot()
    SetPlayerState SCORE, GetPlayerState(SCORE) + GetPlayerState(JACKPOT_VALUE)
End Sub