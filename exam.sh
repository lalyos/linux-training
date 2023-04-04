#!/bin/bash
alias r="source $BASH_SOURCE"

ghub() {
  declare path=$1
  : ${path:? required}
    shift
    curl \
      -H "Authorization: Bearer $GH_TOKEN" \
      https://api.github.com/${path#/} \
     "$@"
}


comment-json() {
  cat <<EOF
{
   "body":"${1:? body required}"
}
EOF
}

comment() {
    set -x
  declare comment=$1 issuenumber=$2
  ${issuenumber:=89}
  : ${comment:? required}   
  #: ${issuenumber:? required} 
  json=$(comment-json "$@")
  
  echo ghub repos/lalyos-trainings/git-wed/issues/"$issuenumber"/comments -d "${json}"
 set +x
}



react-json() {
  cat <<EOF
{
  "issuenumber":"${1:? issuenumber required}"
 
}

EOF
}

react() {
  declare issuenumber=$1 reaction=$2
  json=$(react-json "$@")

  : ${issuenumber:? required} 
    if [[ -z "$reaction" ]]; then
    ghub repos/lalyos-trainings/git-wed/issues/"$issuenumber"/reactions -d "${json}"
    #$(ghub repos/lalyos-trainings/git-wed/issues/"$issuenumber"/reactions -s) | jq .content -r

    fi
  #json=$(issue-json "$@")
  #ghub repos/lalyos-trainings/git-wed/issues -d "${json}"
}









# issue-json() {
#   cat <<EOF
# {
#   "title":"${1:? title required}",
#   "body":"${2:? body required}"
# }
# EOF
# }

# issue() {
#   declare title=$1 body=$2
#   : ${title:? required} ${body:? required}

#   json=$(issue-json "$@")
#   ghub repos/lalyos-trainings/git-wed/issues -d "${json}"
# }