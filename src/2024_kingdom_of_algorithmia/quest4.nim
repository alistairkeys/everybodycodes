# https://everybody.codes/event/2024/quests/3

import std/[algorithm, sequtils, strutils]

proc parseInputFile(filename: string): seq[int] =
  result = filename.lines.toSeq.mapIt(parseInt it)
  result.sort

func part1(sizes: openArray[int]): int =
  let min = min(sizes)
  return foldl(sizes, a + b - min, 0)

func part2(sizes: openArray[int]): int =
  part1(sizes)

func part3(sizes: openArray[int]): int =
  let avg = sizes[sizes.len div 2]
  return foldl(sizes, a + abs(b - avg), 0)

echo part1([3,4,7,8]) # example, output is 10
echo part1(parseInputFile "../input/everybody_codes_e2024_q04_p1.txt")

echo part2(parseInputFile "../input/everybody_codes_e2024_q04_p2.txt")

echo part3(@[2,4,5,6,8]) # example, output is 8
echo part3(parseInputFile "../input/everybody_codes_e2024_q04_p3.txt")