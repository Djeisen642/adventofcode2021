lines = []
with open('input.txt') as f:
    lines = f.readlines()

count = 0
lastLine = int(lines[0])
for line in lines:
    if (int(line) > lastLine):
        count += 1
    lastLine = int(line)

print(count)