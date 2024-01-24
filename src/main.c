// main.c

void printString(const char* str);

void main() {
    // Print welcome message
    printString("Welcome to CoreX v1.0.0\n");

    // Print prompt
    printString("$ ");
}

// Function to print a null-terminated string
void printString(const char* str) {
    // Address 0xB8000 is the start of video memory in text mode
    volatile char* videoMemory = (volatile char*)0xB8000;

    // Loop through each character in the string
    while (*str != '\0') {
        // Write the character to video memory (character + attribute)
        *videoMemory++ = *str++;
        *videoMemory++ = 0x07;  // Attribute: white on black
    }
}