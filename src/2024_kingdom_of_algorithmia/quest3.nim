# https://everybody.codes/event/2024/quests/3

import std/sequtils

type
  HeightMap = object
    width, height: int
    data: seq[int]

func get(map: HeightMap, x, y: int): int {.inline.} =
  map.data[y * map.width + x]

func inBounds(map: HeightMap, x, y: int): bool {.inline.} =
  x in 0 ..< map.width and y in 0 ..< map.height

proc set(map: var HeightMap, x, y, val: int) {.inline.} =
  map.data[y * map.width + x] = val

proc diff(map: HeightMap, x1, y1, x2, y2: int): int =
    if not map.inBounds(x1, y1) or not map.inBounds(x2, y2): return 0
    return abs(map.get(x1, y1) - map.get(x2, y2))

proc populate(lines: openArray[string]): HeightMap =
  result.width = lines[0].len
  for line in lines:
    inc result.height
    for ch in line:
      result.data.add if ch == '#': 1 else: 0

proc parseInputFile(filename: string): HeightMap =
  result = populate(filename.lines.toSeq)
  
func part1(inputMap: HeightMap): int =
  var
    finished = false
    maps = [inputMap, inputMap]
    mapIdx = 0
    nextMapIdx = 1
  
  while not finished:
    finished = true
    swap(mapIdx, nextMapIdx)
    for y in 0 ..< inputMap.height:
      for x in 0 ..< inputMap.width:
        let here = maps[mapIdx].get(x,y)
        if here > 0:
          let
            leftDiff    = maps[mapIdx].diff(x - 1, y, x, y)
            rightDiff   = maps[mapIdx].diff(x + 1, y, x, y)
            topDiff     = maps[mapIdx].diff(x, y - 1, x, y)
            bottomDiff  = maps[mapIdx].diff(x, y + 1, x, y)
          if leftDiff == 0 and rightDiff == 0 and topDiff == 0 and bottomDiff == 0:
            maps[nextMapIdx].set(x, y, here + 1)
            finished = false
          else:
            maps[nextMapIdx].set(x, y, here)
          
  result = foldl(maps[mapIdx].data, a + b)

var map = populate([
             "..........",
             "..###.##..",
             "...####...",
             "..######..",
             "..######..",
             "...####...",
             ".........."])
echo part1(map) # example, output is 35
echo part1(parseInputFile("../input/everybody_codes_e2024_q03_p1.txt"))