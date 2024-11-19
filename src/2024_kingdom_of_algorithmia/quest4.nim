# https://everybody.codes/event/2024/quests/3

import std/[sequtils, strutils]

proc parseInputFile(filename: string): seq[int] =
  filename.lines.toSeq.mapIt(parseInt it)

func part1(sizes: openArray[int]): int =
  let min = min(sizes)
  return foldl(sizes, a + b - min, 0)

func part2(sizes: openArray[int]): int =
  part1(sizes)

echo part1([3,4,7,8]) # example, output is 10
echo part1(parseInputFile "../input/everybody_codes_e2024_q04_p1.txt") # 82

echo part2(parseInputFile "../input/everybody_codes_e2024_q04_p2.txt")