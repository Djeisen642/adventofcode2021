import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

int checkEntries(List<int> setToCheck, List<int> numbersToCheck) {
  int maxIndex = 0;
  for (var element in setToCheck) {
    maxIndex = max(numbersToCheck.indexOf(element), maxIndex);
  }
  return maxIndex;
}

void main() async {
  try {
    final input = File('input.txt');
    Stream<String> lines =
        input.openRead().transform(utf8.decoder).transform(LineSplitter());
    List<int> numbersToCheck = [];
    bool firstLine = true;
    const int numItemsInRow = 5;
    List<List<int>> columns = [];
    List<List<int>> rows = List.empty(growable: true);
    bool isFirstGroup = true;
    List<List<int>>? currentMinGroup;
    int currentMinIndex = 0;
    await for (String line in lines) {
      if (firstLine) {
        firstLine = false;
        numbersToCheck = line.split(',').map((e) => int.parse(e)).toList();
        continue;
      }
      if (line != '') {
        List<int> numsInRow =
            line.trim().split(RegExp(r"\s+")).map((e) => int.parse(e)).toList();

        for (var i = 0; i < numsInRow.length; i++) {
          if (columns.length < i + 1) columns.add([]);
          columns[i].add(numsInRow[i]);
        }
        rows.add(numsInRow);
        if (rows.length == numItemsInRow) {
          List<List<int>> groupToCheck = rows + columns;
          for (var setToCheck in groupToCheck) {
            int value = checkEntries(setToCheck, numbersToCheck);
            if (currentMinIndex == 0 || value < currentMinIndex) {
              currentMinIndex = value;
              currentMinGroup = groupToCheck;
            }
          }
          if (isFirstGroup) {
            isFirstGroup = false;
            currentMinIndex = 0;
          }
          columns = [];
          rows = List.empty(growable: true);
        }
      }
    }
    List<int> numsUsed = numbersToCheck.sublist(
        0, currentMinIndex + 1); // one more than the index
    if (currentMinGroup == null) throw Exception('No min group');
    List<List<int>> rowsOfGroupToCheck =
        currentMinGroup.sublist(0, numItemsInRow);
    int sum = 0;
    for (var row in rowsOfGroupToCheck) {
      for (var el in row) {
        if (!numsUsed.contains(el)) sum += el;
      }
    }
    int lastNumCalled = numsUsed.last;
    print(
        'result: ${sum * lastNumCalled}, sum: $sum, numCalled: $lastNumCalled');
  } catch (e) {
    print('Error: $e');
  }
}
