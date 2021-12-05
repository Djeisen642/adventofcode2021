#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

int main() {
    FILE *fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;
    fp = fopen("input.txt", "r");

    if (fp == NULL)
        exit(EXIT_FAILURE);


    int index;
    getline(&line, &len, fp);
    int numDigits = strlen(line) - 1; // remove the new line character
    int zeroes[numDigits];
    int ones[numDigits];
    memset(zeroes, 0, sizeof zeroes);
    memset(ones, 0, sizeof ones);

    for (index = 0; index < numDigits; index = index + 1) {
        if (line[index] == '0') {
            zeroes[index] += 1;
        } else {
            ones[index] += 1;
        }
    }

    while ((read = getline(&line, &len, fp)) != -1) {
        for (index = 0; index < numDigits; index = index + 1) {
            if (line[index] == '0') {
                zeroes[index] += 1;
            } else {
                ones[index] += 1;
            }
        }
        // printf("%c", line[0]);
        // printf("zeroes %d %d %d %d %d\n", zeroes[0], zeroes[1], zeroes[2], zeroes[3], zeroes[4]);
        // printf("ones %d %d %d %d %d\n", ones[0], ones[1], ones[2], ones[3], ones[4]);
    }
    int gamma = 0;
    int epsilon = 0;
    char gammaS[numDigits];
    char epsilonS[numDigits];
    int multiplier = 1;
    for (index = numDigits - 1; index >= 0; index = index - 1) {
        if (zeroes[index] > ones[index]) {
            epsilon += multiplier;
            gammaS[index] = '0';
            epsilonS[index] = '1';
        } else {
            gamma += multiplier;
            gammaS[index] = '1';
            epsilonS[index] = '0';
        }
        // printf("index (%d) zeroes (%d) ones (%d) compare (%d) epsilon (%d) gamma (%d)\n", index, zeroes[index], ones[index], zeroes[index] < ones[index], epsilon, gamma);
        multiplier *= 2;
    }
    printf("gamma (%s) epsilon (%s) result %d ", gammaS, epsilonS, gamma * epsilon);

    fclose(fp);
    if (line)
        free(line);
    
    exit(EXIT_SUCCESS);
}