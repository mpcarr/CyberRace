extends SubViewport

var shared_memory : SharedMemory
# Define the name and size for shared memory
const SHARED_MEMORY_NAME = "my_shared_memory"
const FRAME_WIDTH = 800
const FRAME_HEIGHT = 600
const FRAME_SIZE = FRAME_WIDTH * FRAME_HEIGHT * 4
const DOUBLE_BUFFER_SIZE = FRAME_SIZE * 2

var framesCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
    # Initialize the shared memory instance
    shared_memory = SharedMemory.new()
    
    # Open the shared memory with the defined name and size
    shared_memory.open_shared_memory("Local\\" + SHARED_MEMORY_NAME, DOUBLE_BUFFER_SIZE + 4)  # Additional 4 bytes for active buffer flag
    print("Shared memory opened with double buffering support.")
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    #if framesCount > 2:
        #return
    # Capture the current viewport image as raw pixel data
    var viewport_texture = get_viewport().get_texture()
    var image = viewport_texture.get_image()
    image.convert(Image.FORMAT_RGBA8)  # Ensure RGBA format with 8 bits per channel
    var frame_data = image.get_data()  # Get raw pixel data in PackedByteArray
    print("First pixel bytes in Godot:")
    for i in range(4):
        print("Byte", i, ":", frame_data[i])
    # Read the current active buffer from shared memory
    var active_buffer_data = shared_memory.read_data(0, 4)
    var active_buffer = 0
    if active_buffer_data.size() == 4:
        active_buffer = active_buffer_data[0]  # Read active buffer index (0 or 1)

    # Determine the inactive buffer to write to
    var inactive_buffer = (active_buffer + 1) % 2
    var offset = 4 + (inactive_buffer * FRAME_SIZE)  # Offset in shared memory for inactive buffer

    # Write frame data to the inactive buffer in shared memory
    shared_memory.write_data(offset, frame_data)

    # Toggle the active buffer index
    var new_active_buffer_data = PackedByteArray([inactive_buffer])
    shared_memory.write_data(0, new_active_buffer_data)
