#include <math.h>
#include "helpers.h"

// Grayscale
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

// Reflect (horizontal)
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            RGBTRIPLE temp = image[i][j];
            image[i][j] = image[i][width - j - 1];
            image[i][width - j - 1] = temp;
        }
    }
}

// Blur
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }

    int di[3] = {-1, 0, 1};

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int red = 0, green = 0, blue = 0;
            int count = 0;

            for (int dii = 0; dii < 3; dii++)
            {
                for (int djj = 0; djj < 3; djj++)
                {
                    int ni = i + di[dii];
                    int nj = j + di[djj];

                    if (ni >= 0 && ni < height && nj >= 0 && nj < width)
                    {
                        red += copy[ni][nj].rgbtRed;
                        green += copy[ni][nj].rgbtGreen;
                        blue += copy[ni][nj].rgbtBlue;
                        count++;
                    }
                }
            }

            image[i][j].rgbtRed = round((float) red / count);
            image[i][j].rgbtGreen = round((float) green / count);
            image[i][j].rgbtBlue = round((float) blue / count);
        }
    }
}

// Edges (Sobel Operator) 🔥
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }

    int Gx[3][3] = {
        {-1, 0, 1},
        {-2, 0, 2},
        {-1, 0, 1}
    };

    int Gy[3][3] = {
        {-1, -2, -1},
        { 0,  0,  0},
        { 1,  2,  1}
    };

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int sumRx = 0, sumGx = 0, sumBx = 0;
            int sumRy = 0, sumGy = 0, sumBy = 0;

            for (int di = -1; di <= 1; di++)
            {
                for (int dj = -1; dj <= 1; dj++)
                {
                    int ni = i + di;
                    int nj = j + dj;

                    if (ni >= 0 && ni < height && nj >= 0 && nj < width)
                    {
                        RGBTRIPLE pixel = copy[ni][nj];

                        int weightX = Gx[di + 1][dj + 1];
                        int weightY = Gy[di + 1][dj + 1];

                        sumRx += pixel.rgbtRed * weightX;
                        sumGx += pixel.rgbtGreen * weightX;
                        sumBx += pixel.rgbtBlue * weightX;

                        sumRy += pixel.rgbtRed * weightY;
                        sumGy += pixel.rgbtGreen * weightY;
                        sumBy += pixel.rgbtBlue * weightY;
                    }
                }
            }

            int r = round(sqrt(sumRx * sumRx + sumRy * sumRy));
            int g = round(sqrt(sumGx * sumGx + sumGy * sumGy));
            int b = round(sqrt(sumBx * sumBx + sumBy * sumBy));

            if (r > 255) r = 255;
            if (g > 255) g = 255;
            if (b > 255) b = 255;

            image[i][j].rgbtRed = r;
            image[i][j].rgbtGreen = g;
            image[i][j].rgbtBlue = b;
        }
    }
}
