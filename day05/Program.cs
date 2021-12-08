using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace Day4 {
    class Part1 {
        static void Main(string[] args) {
            string[] lines = System.IO.File.ReadAllLines(@"input.txt");

            var pointCount = new Dictionary<string, int>();
            Regex pattern = new Regex(@"(\d+),(\d+) -> (\d+),(\d+)");
            foreach (string line in lines) {
                var match = pattern.Match(line);
                int pointX1 = int.Parse(match.Groups[1].Value);
                int pointY1 = int.Parse(match.Groups[2].Value);
                int pointX2 = int.Parse(match.Groups[3].Value);
                int pointY2 = int.Parse(match.Groups[4].Value);
                if (pointX1 == pointX2) {
                    int pointX = pointX1;
                    bool y1Bigger = pointY1 > pointY2;
                    int pointY = y1Bigger ? pointY2 : pointY1;
                    int finishY = y1Bigger ? pointY1 : pointY2;
                    while (pointY <= finishY) {
                        string curPoint = pointX.ToString() + "," + pointY.ToString();
                        if (pointCount.ContainsKey(curPoint)) {
                            pointCount[curPoint] ++;
                        } else {
                            pointCount.Add(curPoint, 1);
                        }
                        pointY++;
                    }
                } else if (pointY1 == pointY2) {
                    int pointY = pointY1;
                    bool x1Bigger = pointX1 > pointX2;
                    int pointX = x1Bigger ? pointX2 : pointX1;
                    int finishX = x1Bigger ? pointX1 : pointX2;
                    while (pointX <= finishX) {
                        string curPoint = pointX.ToString() + "," + pointY.ToString();
                        if (pointCount.ContainsKey(curPoint)) {
                            pointCount[curPoint] ++;
                        } else {
                            pointCount.Add(curPoint, 1);
                        }
                        pointX++;
                    }
                }
                // Console.WriteLine($"Captured value: {match.Groups[1].Value}");
            }
            
            int pointWithMoreThanOne = pointCount.Where(i => i.Value > 1).Count();
            Console.WriteLine($"Result {pointWithMoreThanOne.ToString()}");
        }
    }
}