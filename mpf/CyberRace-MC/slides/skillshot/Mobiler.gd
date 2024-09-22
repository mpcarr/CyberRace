extends Sprite2D

var speed = 3000
var movingRight = true
var hitArea = 300
var isInCenter = false
var hitRegistered = false
var timeElapsed = 0.0
var hitSuccess = false

@onready var videoPlayer: VideoStreamPlayer = $"../../VideoStreamPlayer"
@onready var container: BoxContainer = $"../../BoxContainer"
# Called when the node enters the scene tree for the first time.
func _ready():
    position.x = -312
    timeElapsed = 0.0
    videoPlayer.finished.connect(_on_video_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    timeElapsed += delta
    if movingRight:
        position.x += speed * delta
    else:
        position.x -= speed * delta

    var screen_center = get_viewport_rect().size.x / 2
    if abs(position.x - screen_center) < hitArea / 2:
        modulate = Color(1,0,0)
        isInCenter = true
    else:
        modulate = Color(1,1,1)
        isInCenter = false
        
    if position.x > get_viewport_rect().size.x + 312:
        movingRight = false
        flip_h = true
    elif position.x < -312:
        movingRight = true
        flip_h = false

func checkHit(payload: Dictionary):
    if not hitRegistered:
        hitRegistered = true
        print(timeElapsed)
        if isInCenter:
            hitSuccess = true
            videoPlayer.stream = load("res://slides/skillshot/assets/SkillshotHit.ogv")
        else:
            videoPlayer.stream = load("res://slides/skillshot/assets/SkillshotMissed.ogv")
            #MPF.server.send_event("skillhot_miss")
        container.visible = false
        videoPlayer.play()
func _on_video_finished():
    if hitSuccess:
        MPF.server.send_event("skillshot_hit")
    else:
        MPF.server.send_event("skillshot_miss")
    
