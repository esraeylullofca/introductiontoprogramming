#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height;

    // Prompt the user for a height between 1 and 8
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);

    // Print each row of the double pyramid
    for (int row = 1; row <= height; row++)
    {
        // Print leading spaces
        for (int space = 0; space < height - row; space++)
        {
            printf(" ");
        }

        // Print hashes for the LEFT pyramid
        for (int hash = 0; hash < row; hash++)
        {
            printf("#");
        }

        // Print the gap between pyramids
        printf("  ");

        // Print hashes for the RIGHT pyramid
        for (int hash = 0; hash < row; hash++)
        {
            printf("#");
        }

        // Move to the next line
        printf("\n");
    }

    return 0;
}
