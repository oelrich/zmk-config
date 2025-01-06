let corne = open corne.jsonl | from json --objects
let padding_template = $corne | first
let row_template = $corne | get 1
let thumb_template = $corne | last
# https://www.keyboard-layout-editor.com
def create_desc [out_file base_file] {
let base = open $base_file | from json --objects

$"[\n[($padding_template | to json --raw)," | save -f $out_file
$row_template | each {|elt|
  if ($elt | describe) == int {
    $"\"\\n\\n\\n\\n\\n\\n\\n\\n\\n($base | get 0 | get $elt)\""
  } else {
    $elt | to json --raw
  }
} | str join "," | save --append $out_file
"],\n[" | save --append $out_file

$row_template | each {|elt|
  if ($elt | describe) == int {
    $"\"\\n\\n\\n\\n\\n\\n\\n\\n\\n($base | get 1 | get $elt)\""
  } else {
    $elt | to json --raw
  }
} | str join "," | save --append $out_file
"],\n[" | save --append $out_file

$row_template | each {|elt|
  if ($elt | describe) == int {
    $"\"\\n\\n\\n\\n\\n\\n\\n\\n\\n($base | get 2 | get $elt)\""
  } else {
    $elt | to json --raw
  }
} | str join "," | save --append $out_file
"],\n[" | save --append $out_file

$thumb_template | each {|elt|
  if ($elt | describe) == int {
    let thumb_key = ($base | get 3 | get $elt)
    if ($thumb_key | describe) == string {
      $"\"\\n\\n\\n\\n\\n\\n\\n\\n\\n($thumb_key)\""
    } else {
      $"\"\\n($thumb_key | get hold)\\n\\n\\n\\n\\n\\n\\n\\n($thumb_key | get tap)\""
    }
  } else {
    $elt | to json --raw
  }
} | str join "," | save --append $out_file
"]\n]" | save --append $out_file
}

create_desc "00_BASE.json" "00_BASE.jsonl"
create_desc "01_SYMB.json" "01_SYMB.jsonl"
create_desc "02_NUMB.json" "02_NUMB.jsonl"
create_desc "03_MOVE.json" "03_MOVE.jsonl"