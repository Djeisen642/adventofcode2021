const fs = require('fs');
const readline = require('readline');

/**
 * Get lines from file
 * Processes lines by adding zeroes to zeroes array and ones to ones array
 * 
 * @param {string} fileName 
 * @returns {string[]} lines
 */
 async function getLines(fileName) {
    const lines = [];
    const stream = fs.createReadStream(fileName);
    const rl = readline.createInterface({
        input: stream,
        crlfDelay: Infinity
    });
    for await (const line of rl) {
        lines.push(line);
    }
    return lines;
}

/**
 * Filter lines for rating
 * 
 * @param {string[]} lines
 * @param {number} index
 * @param {boolean} isO2
 * @returns remaining lines
 */
function filterForRating(lines, index, isO2) {
    if (lines.length === 1) return lines;
    let ones = 0;
    let zeroes = 0;
    const onesLines = [];
    const zeroesLines = [];
    for (const line of lines) {
        if (line[index] === '0') {
            zeroes ++;
            zeroesLines.push(line);
        } else {
            ones ++;
            onesLines.push(line);
        }
    }
    if (isO2) {
        return ones >= zeroes ? onesLines : zeroesLines;
    }
    return zeroes <= ones ? zeroesLines : onesLines;
}

/**
 * Main functionality for Day 3 Part 2
 */
async function part2() {
    const inputFileName = 'input.txt';
    const lines = await getLines(inputFileName);
    let o2 = lines.slice(0);
    let co2 = lines.slice(0);
    for (let index = 0; index < lines[0].length; index++) {
        o2 = filterForRating(o2, index, true);
        co2 = filterForRating(co2, index, false);
    }
    const o2Rating = parseInt(o2[0], 2);
    const co2Rating = parseInt(co2[0], 2);
    console.log(o2, o2Rating, co2, co2Rating, o2Rating * co2Rating);
}

part2()
.then(() => {
    process.exit(0);
}, (error) => {
    console.log(error);
    process.exit(1);
})