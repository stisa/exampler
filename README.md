Exampler
========

Simple utility that combines `.nim` files and `.html` templates to generate examples docs.  
Supports the following identifiers:  

In `templ_index.html`:
  - project -> name of the project
  - li -> item to put in the list of index

In `templ_li.html`:
  - title -> title of the example

In `templ_entry.html`:
  - project -> name of the project
  - title -> title of the example
  - code -> code of the example
  
Example
-------

Have a look at [exampler](https://stisa.space/exampler) example output, or compile  
`exampler.nim` and run it inside [/test](test), with default args you will find output
in `test/docs/`.

Usage
-----

`exampler [src dir of examples] [template dir] [output dir]`

Defaults:
  - `src_dir` -> `examples`
  - `template_dir` -> `templates`
  - `output_dir` -> `docs` ( note that examples are nested in `output_dir/src_dir`, only the `index.html` resides in `output_dir` )