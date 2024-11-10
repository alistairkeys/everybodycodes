# https://everybody.codes/event/2024/quests/2

import std/[strutils, unicode]

type
  Stuff = object
    input: seq[string]
    words: seq[string]

proc parseInputFile(filename: string): Stuff =
  var f = open(filename, fmRead)
  defer: f.close
  result.words = f.readLine.split(":")[1].split(",")
  discard f.readLine
  while not f.endOfFile:
    result.input.add f.readLine

func part1(stuff: Stuff): int =
  for w in stuff.words:
    result += stuff.input[0].count(w)

func part2(stuff: Stuff): int =
  template countSymbols(line, word: string) =
    block:
      var idx = 0
      while idx >= 0:
        idx = line.find(word, idx)
        if idx >= 0:
          for n in idx ..< idx + word.len:
            s.incl n.byte
          inc idx

  for line in stuff.input:
    var s: set[byte]
    for w in stuff.words:
      countSymbols(line, w)
      countSymbols(line, w.reversed)
    result += s.card

func part3(stuff: Stuff): int =
  0 # TODO: implement this

when isMainModule:
  echo part1(Stuff(
    input: @["AWAKEN THE POWER ADORNED WITH THE FLAMES BRIGHT IRE"], 
    words: "HE,OWE,MES,ROD,HER".split(',')
  )) # example, answer is 4

  echo part1(parseInputFile("../input/everybody_codes_e2024_q2_p1.txt"))

  echo part2(Stuff(
    input: @[
      "AWAKEN THE POWE ADORNED WITH THE FLAMES BRIGHT IRE",
      "THE FLAME SHIELDED THE HEART OF THE KINGS",
      "POWE PO WER P OWE R",
      "THERE IS THE END"
    ],
    words: "THE,OWE,MES,ROD,HER".split(",")
  )) # example, answer is 37

  echo part2(parseInputFile("../input/everybody_codes_e2024_q2_p2.txt"))

  echo part3(Stuff(
    input: @[
      "HELWORLT",
      "ENIGWDXL",
      "TRODEOAL"],
    words: "THE,OWE,MES,ROD,RODEO".split(",")
  )) # example, answer is 10

  # echo part3(parseInputFile("../input/everybody_codes_e2024_q2_p3.txt"))