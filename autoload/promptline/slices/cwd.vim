fun! promptline#slices#cwd#function_body( options )
  let dir_limit = get(a:options, 'dir_limit', 3)
  let dir_sep = promptline#symbols#get().dir_sep
  let truncation = promptline#symbols#get().truncation
  let lines = [
        \'function __promptline_cwd {',
        \'  local cwd="${PWD/#$HOME/~}"',
        \'  local dir_limit=3',
        \'  local parts',
        \'  local dir_sep="' . dir_sep . '"',
        \'  local truncation="' . truncation . '"',
        \'',
        \'  # get first char of the path, i.e. tilda or slash',
        \'  if [[ -n ${ZSH_VERSION-} ]]; then',
        \'    local root_char=$cwd[1,1]',
        \'  else',
        \'    local root_char=${cwd::1}',
        \'  fi',
        \'',
        \'  # cleanup leading tilda and slash. replace slashes with spaces',
        \'  cwd="${cwd#\~}"',
        \'  cwd="${cwd#\/}"',
        \'  cwd=${cwd//\// }',
        \'',
        \'  if [[ -n ${ZSH_VERSION-} ]]; then',
        \'    parts=($root_char ${=cwd})',
        \'  else',
        \'    parts=($root_char $cwd)',
        \'  fi',
        \'',
        \'  # truncate dirs to the limit',
        \'  local parts_count=${#parts[@]}',
        \'  if [ $parts_count -gt $dir_limit ] && [ $dir_limit -gt -0 ]; then',
        \'    parts=($truncation ${parts[@]:(-3)})',
        \'  fi',
        \'',
        \'  # join the dirs with the separator',
        \'  local formatted_cwd=""',
        \'  for part in "${parts[@]}"; do',
        \'    formatted_cwd="$formatted_cwd$dir_sep$part"',
        \'  done;',
        \'  formatted_cwd="${formatted_cwd#$dir_sep}"',
        \'',
        \'  printf "%s" "$formatted_cwd"',
        \'}']
  return lines
endfun
