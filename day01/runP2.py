import math
lines = []
with open('input.txt') as f:
    lines = f.readlines()

count = 0
lastSum = math.inf # the first one has no previous sum, so to get around that just set this to infinity
currentSet = []
for line in lines:
    currentSet.append(int(line))
    if (len(currentSet) == 3):
        currentSum = sum(currentSet)

        if (currentSum > lastSum):
            count += 1

        lastSum = currentSum
        currentSet.pop(0) # in the next set we only need the last 2 items out of the 3 item set

print(count)