#include <helpers.h>
#include <math.h>

// GRAYSCALE
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int avg = round((image[i][j].rgbtRed +
                             image[i][j].rgbtGreen +
                             image[i][j].rgbtBlue) / 3.0);

            image[i][j].rgbtRed = avg;
            image[i][j].rgbtGreen = avg;
            image[i][j].rgbtBlue = avg;
        }
    }
}

// SEPIA
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int r = image[i][j].rgbtRed;
            int g = image[i][j].rgbtGreen;
            int b = image[i][j].rgbtBlue;

            int sr = round(0.393 * r + 0.769 * g + 0.189 * b);
            int sg = round(0.349 * r + 0.686 * g + 0.168 * b);
            int sb = round(0.272 * r + 0.534 * g + 0.131 * b);

            if (sr > 255) sr = 255;
            if (sg > 255) sg = 255;
            if (sb > 255) sb = 255;

            image[i][j].rgbtRed = sr;
            image[i][j].rgbtGreen = sg;
            image[i][j].rgbtBlue = sb;
        }
    }
}

// REFLECT
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            RGBTRIPLE temp = image[i][j];
            image[i][j] = image[i][width - 1 - j];
            image[i][width - 1 - j] = temp;
        }
    }
}

// BLUR
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];

    // copy image
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }

    // blur
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int totalR = 0, totalG = 0, totalB = 0, count = 0;

            for (int di = -1; di <= 1; di++)
            {
                for (int dj = -1; dj <= 1; dj++)
                {
                    int ni = i + di;
                    int nj = j + dj;

                    if (ni >= 0 && ni < height && nj >= 0 && nj < width)
                    {
                        totalR += copy[ni][nj].rgbtRed;
                        totalG += copy[ni][nj].rgbtGreen;
                        totalB += copy[ni][nj].rgbtBlue;
                        count++;
                    }
                }
            }

            image[i][j].rgbtRed = round((float) totalR / count);
            image[i][j].rgbtGreen = round((float) totalG / count);
            image[i][j].rgbtBlue = round((float) totalB / count);
        }
    }
}
