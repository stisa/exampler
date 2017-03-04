import os, strutils

# TODO: add an output identifier and template

let programName = paramStr(0)
var arguments = commandLineParams()

type Example = object
  title : string
  code : string

type Project = object
  name: string
  li : seq[Example]
  ex_dir:string
   

proc writeOut(proj:Project,outdir:string="docs",tdir:string="templates") =
  let temp_li = readFile(getCurrentDir()/tdir/"templ_li.html")
  let temp_entry = readFile(getCurrentDir()/tdir/"templ_entry.html")
  let temp_index = readFile(getCurrentDir()/tdir/"templ_index.html")
  
  var compiled : string = ""
  var li : string = ""

  if not existsDir(getCurrentDir()/outdir):
    createDir(getCurrentDir()/outdir)
  
  if not existsDir(getCurrentDir()/outdir/proj.ex_dir):
    createDir(getCurrentDir()/outdir/proj.ex_dir)
    
  for entry in proj.li :
    # Compile example page
    compiled = temp_entry % ["project",proj.name,"title",entry.title,"code",entry.code]
    writeFile(getCurrentDir()/outdir/proj.ex_dir/entry.title&".html",compiled)
    # Compile example listitem
    compiled = temp_li % ["title",entry.title]
    li.add(compiled&"\n")
  
  # Compile index
  compiled = temp_index % ["project",proj.name,"li",li]
  writeFile(getCurrentDir()/outdir/"index.html",compiled)



proc example(exfile:string):Example =
  result.title = extractFilename(exfile).changeFileExt("")
  result.code = readFile(exfile).string

proc project(example_dir:string="examples"):Project =
  result.name = getCurrentDir().splitPath().tail#tailDir(expandFilename("src"))
  result.ex_dir = example_dir
  result.li = @[]
  for kind, path in walkDir(example_dir):
    if kind == pcFile and path.splitfile.ext == ".nim": result.li.add(example(path))

case arguments.len:
of 0:
  let proj = project()
  proj.writeOut()
of 1:
  let proj = project(arguments[0])
  proj.writeOut()
of 2:
  let proj = project(arguments[0])
  proj.writeOut(arguments[1])
of 3:
  let proj = project(arguments[0])
  proj.writeOut(arguments[1],arguments[2])
else:
  echo """
USAGE: exampler [src dir of examples] [template dir] [output dir]
Defaults:
  src dir = examples
  template dir = templates
  output dir = docs
"""
