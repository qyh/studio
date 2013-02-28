#!/bin/sh 
# filename: generate_album.sh 
# description: uses pictures under current directory to create album

echo "creating album..."
mkdir -p thumbs
cat << EOF > index.html
<html>
<head>
<style>
body
{
    width: 470px;
    margin: auto;
    border: 1px dashed grey;
    padding: 10px;
}
img
{
    margin: 5px;
    border: 1px, solid black;
}
</style>
</head>
<body>
<center><h1> #Album title </h1></center>
<p>
EOF

for img in `find . -regextype egrep -type f -name '*' | sed -n '/\.gif/p;/\.jpg/p;/\.png/p'`; do
    img=${img#*/}
    toimg=${img##*/}
    convert -resize "100x100" "$img" "thumbs/$img"
    echo "<a href=\"$img\"><img src=\"thumbs/$img\" title=\"$toimg\"/>\
    </a>">> index.html
done

cat <<END >> index.html
</p>
</body>
</html>
END

echo "Album generated to index.html"


