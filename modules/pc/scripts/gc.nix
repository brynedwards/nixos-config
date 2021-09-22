{ pkgs, ... }:
pkgs.writeScriptBin "gc" ''
  #!${pkgs.stdenv.shell}
  awk_cmd='{n=split($3, a, "."); printf("%s.%s/%s/%s", a[n-1], a[n], $4, $5)}'

  url="$1"
  if [ -z "$url" ]; then
  	# Take from clipboard
  	url="$(wl-paste)"
  	if [ -z "$url" ]; then
  		echo "Specify a git URL"
  		exit 1
  	fi
  fi

  outdir=$(awk -F/ "$awk_cmd" <<<"$url" | tr '[:upper:]' '[:lower:]')
  git clone "$url" "$outdir"
''
