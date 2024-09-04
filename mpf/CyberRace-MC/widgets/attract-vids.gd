extends VideoStreamPlayer

var video_paths = [
    "res://videos/HSBackground1.ogv",
    "res://videos/HSBackground2.ogv",
    "res://videos/HSBackground3.ogv"
]

var current_video_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    self.finished.connect(self._on_video_finished)
    
    # Start playing the first video
    _play_video(current_video_index)
    
func _play_video(index):
    self.stream = load(video_paths[index])
    self.play()
    
func _on_video_finished():
    # Move to the next video
    current_video_index += 1
    
    if current_video_index >= video_paths.size():
        current_video_index = 0
        
    _play_video(current_video_index)
