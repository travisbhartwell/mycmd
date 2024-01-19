#!/bin/sh

export TITLE='Cat Writes'
export CONTENT='
<p>Meow mew <a href="blog">blog</a> meow.</p>
<p>にゃん</p>'
export ROOT='.'
export BLOG='blog'

# Homepage
< site.html.template \
  envsubst \
  > index.html

cd blog || exit 1
export ROOT='..'
export BLOG='./'

posts=''

without_date() {
  cut -d'-' -f1,2,3 --complement
}

get_date() {
  cut -d'-' -f1,2,3
}

drop_ext() {
  rev | cut -d'.' -f1 --complement | rev
}

add_ext() {
  xargs printf "%s.$1"
}

kebab_to_space() {
  sed 's/-/ /g'
}

# Posts, sorted for latest at the top.
for post in *.md.part; do
  dest="$(echo "$post" | drop_ext | drop_ext | add_ext html)"
  date="$(echo "$post" | get_date)"

  TITLE="$(echo "$dest" | without_date | drop_ext | kebab_to_space)"
  export TITLE
  CONTENT="$(pandoc --from commonmark --to html5 "$post")"
  export CONTENT

  < ../site.html.template \
    envsubst \
    > "$dest"

  posts="$posts\n$dest $date $TITLE"
done

export TITLE='Cat Writes a Blog'
CONTENT="$(echo "$posts" | sort -r | awk 'NF { print("<p><a href=\""$1"\">"$2,$3"</a></p>") }')"
export CONTENT

< ../site.html.template \
  envsubst \
  > index.html
