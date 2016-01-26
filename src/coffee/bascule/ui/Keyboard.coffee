# keyCode
class Keybord

  @NUM_0  : 48
  @NUM_1  : 49
  @NUM_2  : 50
  @NUM_3  : 51
  @NUM_4  : 52
  @NUM_5  : 53
  @NUM_6  : 54
  @NUM_7  : 55
  @NUM_8  : 56
  @NUM_9  : 57

  @A      : 65
  @B      : 66
  @C      : 67
  @D      : 68
  @E      : 69
  @F      : 70
  @G      : 71
  @H      : 72
  @I      : 73
  @J      : 74
  @K      : 75
  @L      : 76
  @M      : 77
  @N      : 78
  @O      : 79
  @P      : 80
  @Q      : 81
  @R      : 82
  @S      : 83
  @T      : 84
  @U      : 85
  @V      : 86
  @W      : 87
  @X      : 88
  @Y      : 89
  @Z      : 90

  @SPACE  : 32


  # keyCode を文字に変換
  @getChar:( keyCode )->
    return String.fromCharCode( keyCode )

module.exports = Keybord