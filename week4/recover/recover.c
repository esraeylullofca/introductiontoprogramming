// CS50x Week 4 — Recover

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./recover IMAGE\n");
        return 1;
    }

    FILE *card = fopen(argv[1], "rb");
    if (card == NULL)
    {
        printf("Could not open %s.\n", argv[1]);
        return 1;
    }

    BYTE buffer[512];
    int count = 0;
    FILE *img = NULL;
    char filename[8];

    while (fread(buffer, 1, 512, card) == 512)
    {
        // JPEG başlangıcı kontrolü
        if (buffer[0] == 0xff &&
            buffer[1] == 0xd8 &&
            buffer[2] == 0xff &&
            (buffer[3] & 0xf0) == 0xe0)
        {
            // Eğer açık dosya varsa kapat
            if (img != NULL)
            {
                fclose(img);
            }

            // Yeni dosya aç
            sprintf(filename, "%03i.jpg", count);
            img = fopen(filename, "wb");
            count++;
        }

        // Eğer bir JPEG dosyası açık ise yaz
        if (img != NULL)
        {
            fwrite(buffer, 1, 512, img);
        }
    }

    // Açık dosyaları kapat
    if (img != NULL)
    {
        fclose(img);
    }

    fclose(card);
    return 0;
}
