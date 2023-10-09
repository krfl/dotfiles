# function options
#   echo $argv | sed 's|--*|\\'\n'|g' | grep -v '^$'
# end

# function ajour
#     test ! -e ~/.ajour.json && echo '{"entries":[]}' | jq > ~/.ajour.json

#     for i in (options $argv)
#         echo $i | read -l option value

#         switch $option
#             case c
#                 rm ~/.ajour.json
#             case e
#                 hx ~/.ajour.json
#             case l
#              	jq --raw-output '.entries[] | {timestamp: (.timestamp)|tonumber|strftime("%Y-%m-%d"), message: (.message)}|[.timestamp, .message]|@tsv' ~/.ajour.json
#             case _
#                 set foo (echo $argv | string join " ")
#                 test ! -n "$foo" && read -P "  > " foo
#                 test -n "$foo" && jq -c '.entries += [{"timestamp":"'$(date +%s)'","message":"'$foo'"}]' ~/.ajour.json | read bar && echo $bar | jq > ~/.ajour.json
#         end
#     end
# end


set AJOURFILE ~/.ajour.json

# journal
function ajour --description 'keep track of hours, tasks throughout the work day'
    test ! -e $AJOURFILE && echo '{"entries":[]}' | jq > $AJOURFILE
    set foo (echo $argv | string join " ")
    test ! -n "$foo" && read -P "  > " foo
    test -n "$foo" && jq -c '.entries += [{"timestamp":"'$(date +%s)'","message":"'$foo'"}]' $AJOURFILE | read bar && echo $bar | jq > $AJOURFILE
end



# ajour
    # create
    # edit
    # log

function __ajour_create __aj_msg --description 'internal'
    test ! -e $AJOURFILE && echo '{"entries":[]}' | jq > $AJOURFILE
    test ! -n "$__aj_msg" && read -P "  > " __aj_msg
    test -n "$__aj_msg" && jq -c '.entries += [{"timestamp":"'$(date +%s)'","message":"'$__aj_msg'"}]' $AJOURFILE | read __aj_last_entry&& echo $__aj_last_entry | jq > $AJOURFILE
end

function __ajour_edit --description 'internal'
    $EDITOR $AJOURFILE
end

function __ajour_log --description 'internal'
 	jq --raw-output '.entries[] | {timestamp: (.timestamp)|tonumber|strftime("%Y-%m-%d"), message: (.message)}|[.timestamp, .message]|@tsv' $AJOURFILE
end
