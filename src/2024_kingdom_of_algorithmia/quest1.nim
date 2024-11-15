# https://everybody.codes/event/2024/quests/1

import std/sequtils

func letterWeight(ch: char): int =
  case ch
    of 'B': 1
    of 'C': 3
    of 'D': 5
    else: 0

func part1(input: string): int =
  for ch in input:
    inc result, letterWeight(ch)

func part2(input: string): int =
  var idx = 0
  while idx < input.len:
    let first  = input[idx]
    let second = input[idx+1]
    if first != 'x' and second != 'x':
      inc result, 2
    result += letterWeight(first) + letterWeight(second)
    inc idx, 2

func part3(input: string): int64 =
  func calculateExtraPotions(xCount: int): int =
    case xCount
      of 0: 6
      of 1: 2
      else: 0

  var idx = 0
  while idx < input.len:
    let letters = input[idx..idx+2]
    let extra = calculateExtraPotions(letters.countIt(it == 'x'))
    result += extra +
              letterWeight(letters[0]) +  
              letterWeight(letters[1]) +
              letterWeight(letters[2])
    inc idx, 3

when isMainModule:
  echo part1("ABBAC") # example, answer is 5
  echo part1(readFile "../input/everybody_codes_e2024_q1_p1.txt")

  echo part2("AxBCDDCAxD") # example, answer is 28
  echo part2(readFile "../input/everybody_codes_e2024_q1_p2.txt")

  echo part3("xBxAAABCDxCC") # example, answer is 30
  echo part3(readFile "../input/everybody_codes_e2024_q1_p3.txt")