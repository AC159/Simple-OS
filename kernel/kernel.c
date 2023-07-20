
void main()
{
    // Create a pointer to a char and oitn it to the first text cell of
    // video memory which is the top left of the screen
    char* videoMemory = (char*) 0xb8000;

    // Let's display the character 'X' at the top left of the screen
    *videoMemory = 'X';
}
