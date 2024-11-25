# Hacky way to prevent new lines from being removed on json
IFS=

# jq command filteres all objects with a workspace id of -1 and no class name from the result, we don't need those
jsontiles=$(hyprctl -j clients | jq 'keys_unsorted[] as $k | .[$k] as $value | select($value.workspace["id"] != -1 and $value.class != "") | {digest: $k} + $value | {at, size, "id": .workspace["id"], class}')

# sed command changes the following values in order the following:
# at -> move
# size -> size
# id -> workspace\n
# class -> app\n (mostly for clarity and easier removal of double quotes around the app)
# move\n -> move
# size\n -> ; size
# \n workspace \n -> ; workspace
#  app\n" -> ;
# "\n -> \n;

# Currently, returns things like "org.kde.kate", maybe do some magic based on the pid?
tiles=$(echo -e $jsontiles | sed -z 's/{//g; s/}//g; s/\[//g; s/\]//g; s/ //g; s/"at":/move/g; s/"size":/size/g; s/"id":/workspace\n/g; s/"class":/app\n/g; s/,\n/ /g; s/move\n/move /g; s/\n size\n/; size /g; s/\n workspace\n/; workspace /g; s/ app\n"/; /g; s/"\n/\n/g; s/\n\n/\n/g' | grep -v "^$")
if [[ -n "$tiles" ]]; then
  echo -e $tiles | sed "s/ move/\nmove/g"  > ~/.savedtiles
fi


# 's/{//g; s/}//g; s/\[//g; s/\]//g; s/ //g; s/"at":/move/g; s/"size":/size/g; s/"size":/size/g; s/"workspace"://g; s/"id":/id\n/g; s/"name"://g;  s/"class":/class\n/g; s/,\n/ /g; s/move\n/move /g; s/size\n/size /g;  s/\n id\n/; id /g; s/\n class\n/; class /g; s/\n\n/\n/g'
