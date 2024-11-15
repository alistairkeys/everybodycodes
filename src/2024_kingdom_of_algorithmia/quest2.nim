# https://everybody.codes/event/2024/quests/2

import std/[math, strutils, sequtils, unicode]

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

  let wordsBothDirections = stuff.words & stuff.words.mapIt(it.reversed)
  for line in stuff.input:
    var s: set[byte]
    for w in wordsBothDirections:
      countSymbols(line, w)
    result += s.card

func part3(stuff: Stuff): int =
  template countSymbols(line, word: string, lineNumber: int) =
    block:
      let lineLength = stuff.input[0].len
      var idx = 0
      while idx >= 0:
        idx = line.find(word, idx)
        if idx >= 0:
          var offset = lineNumber * lineLength
          for n in idx ..< idx + word.len:
            s.incl(offset.uint16 + floorMod((offset.uint16 + n.uint16), lineLength.uint16))
          inc idx

  let wordsBothDirections = stuff.words & stuff.words.mapIt(it.reversed)

  var s: set[uint16]
  for lineNumber, line in stuff.input:
    for w in wordsBothDirections:
      countSymbols(line & line[0..w.high - 1], w, lineNumber)

  for w in wordsBothDirections:
   for x, _ in stuff.input[0]:
      for y in 0 .. stuff.input.high - w.high:
        var foundIt = true
        for idx, ch in w:
          if stuff.input[y + idx][x] != ch:
            foundIt = false
            break
        if foundIt:
          for idx, ch in w:
            s.incl(((y + idx) * stuff.input[0].len + x).uint16)
    
  result = s.card

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

  echo part3(parseInputFile("../input/everybody_codes_e2024_q2_p3.txt"))