#include <stdint.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BUFFER_ADDRESS 0xB8000
#define VGA_INDEX(row, col) ((row) * VGA_WIDTH + (col))
#define VGA_ENTRY(character, color) ((uint16_t)((color << 8) | character))
#define VGA_COLOR_BLACK 0
#define VGA_COLOR_WHITE 15

volatile uint16_t* videomem = (uint16_t*)VGA_BUFFER_ADDRESS;
int cursor_row = 0;
int cursor_col = 0;

void clear_screen() {
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; ++i) {
        videomem[i] = VGA_ENTRY(' ', VGA_COLOR_BLACK);
    }
}

void print_char(char character, int row, int col, uint8_t color) {
    int index = VGA_INDEX(row, col);
    videomem[index] = VGA_ENTRY(character, color);
}

void kernel_print(const char* message) {
    while (*message) {
        if (*message == '\n') {
            cursor_row++;
            cursor_col = 0;
        } else {
            print_char(*message, cursor_row, cursor_col++, VGA_COLOR_WHITE);
        }
        if (cursor_col >= VGA_WIDTH) {
            cursor_row++;
            cursor_col = 0;
        }
        if (cursor_row >= VGA_HEIGHT) {
            for (int row = 1; row < VGA_HEIGHT; ++row) {
                for (int col = 0; col < VGA_WIDTH; ++col) {
                    videomem[VGA_INDEX(row - 1, col)] = videomem[VGA_INDEX(row, col)];
                }
            }
            for (int col = 0; col < VGA_WIDTH; ++col) {
                videomem[VGA_INDEX(VGA_HEIGHT - 1, col)] = VGA_ENTRY(' ', VGA_COLOR_BLACK);
            }
            cursor_row = VGA_HEIGHT - 1;
            cursor_col = 0;
        }
        message++;
    }
}

void kernel_main() {
    clear_screen();
    kernel_print("Welcome to CoreX!\ndevbuild-v.1.0.0");

    // Additional kernel functionalities can be added here

    while (1) {}
}