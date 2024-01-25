// kernel.c
void main() {
    // Video memory address for the top-left corner
    char* video_memory = (char*) 0xb8000;

    // Write 'X' to the top-left corner of the screen
    *video_memory = 'X';
}