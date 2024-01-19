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

drop_ext() {
  rev | cut -d'.' -f1 --complement | rev
}

kebab_to_space() {
  sed 's/-/ /g'
}

# Posts, sorted for latest at the top.
for post in *.html.part; do
  dest="$(echo "$post" | drop_ext)"

  TITLE="$(echo "$dest" | without_date | drop_ext | kebab_to_space)"
  export TITLE
  CONTENT="$(cat "$post")"
  export CONTENT

  < ../site.html.template \
    envsubst \
    > "$dest"

  posts="$posts\n$dest"
done

export TITLE='Cat Writes a Blog'
CONTENT="$(echo "$posts" | sort -r | awk 'NF { print("<p><a href=\""$1"\">"$1"</a></p>") }')"
export CONTENT

< ../site.html.template \
  envsubst \
  > index.html
