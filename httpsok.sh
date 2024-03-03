#!/usr/bin/env bash

# WIKI: https://fposter.cn/doc
# This script only supports bash, do not support posix sh.
# If you have the problem like Syntax error: "(" unexpected (expecting "fi"),
# Try to run "bash -version" to check the version.
# Try to visit WIKI to find a solution.

VER=1.8.0

PROJECT_NAME="httpsok"
PROJECT_ENTRY="httpsok.sh"

PROJECT_HOME="$HOME/.httpsok"
PROJECT_ENTRY_BIN="$PROJECT_HOME/$PROJECT_ENTRY"

PROJECT_TOKEN_FILE="$PROJECT_HOME/token"
PROJECT_LOG_FILE="$PROJECT_HOME/$PROJECT_NAME.log"
HTTPSOK_TOKEN=""

HTTPSOK_HOME_URL="https://fposter.cn/"
BASE_API_URL="https://fposter.cn/v1/nginx/"
SCRIPT_URL="https://fposter.cn/httpsok.sh"

latest_code=""
preparse=""
OS=""
NGINX_VERSION=""
NGINX_CONFIG=""
NGINX_CONFIG_HOME=""
TRACE_ID=""

_upper_case() {
  tr '[a-z]' '[A-Z]'
}

_lower_case() {
  tr '[A-Z]' '[a-z]'
}

_startswith() {
  _str="$1"
  _sub="$2"
  echo "$_str" | grep -- "^$_sub" >/dev/null 2>&1
}

_endswith() {
  _str="$1"
  _sub="$2"
  echo "$_str" | grep -- "$_sub\$" >/dev/null 2>&1
}

_contains() {
  _str="$1"
  _sub="$2"
  echo "$_str" | grep -- "$_sub" >/dev/null 2>&1
}

_time() {
  date -u "+%s"
}

_math() {
  _m_opts="$@"
  printf "%s" "$(($_m_opts))"
}

_err() {
  echo -e "\033[31m$(date +"%F %T") $@\033[0m"  1>&2
}

_info() {
  echo -e "$(date +"%F %T") $@"  1>&2
}

_suc() {
  echo -e "\033[32m$(date +"%F %T") $@\033[0m"  1>&2
}

_random_md5() {
  head -c 32 /dev/urandom | md5sum | awk '{print $1}'
}

TRACE_ID=$(_random_md5)

_exists() {
  cmd="$1"
  if [ -z "$cmd" ]; then
    _usage "Usage: _exists cmd"
    return 1
  fi

  if eval type type >/dev/null 2>&1; then
    eval type "$cmd" >/dev/null 2>&1
  elif command >/dev/null 2>&1; then
    command -v "$cmd" >/dev/null 2>&1
  else
    which "$cmd" >/dev/null 2>&1
  fi
  ret="$?"
  return $ret
}

showWelcome() {
  echo
  echo -e "\033[1;36mHttpsok make SSL easy.     $HTTPSOK_HOME_URL \033[0m"
  echo -e "\033[1;36mversion: $VER\033[0m"
  echo -e "\033[1;36mTraceID: $TRACE_ID\033[0m"
  echo "home: $PROJECT_HOME"
  echo
}

_mkdirs() {
  _dir="$1"
  if [ ! "$_dir" = "" ]; then
    if [ ! -d "$_dir" ]; then
      mkdir -p "$_dir" && _suc "Create directory $_dir success."
    fi
  fi
}

_initpath() {
  _mkdirs "$PROJECT_HOME"
}

_initparams() {

  if [ "$OS" != "" ]; then
      return 0
  fi

  if [ -f /etc/os-release ]; then
#      source /etc/os-release
#      OS=$PRETTY_NAME
      OS=$(grep 'PRETTY_NAME' /etc/os-release | awk -F '=' '{print $2}' | tr -d '"')
  elif [ -f /etc/redhat-release ]; then
      OS=$(cat /etc/redhat-release)
  elif [ -f /etc/alpine-release ]; then
      OS="alpine"
  else
      _err "Unsupported operating system"
      exit 1
  fi

  nginx_bin=nginx
  $nginx_bin -V > /dev/null 2>&1
  if [ $? -ne 0 ]; then
      echo "no nginx in PATH, find the nginx"
      pid=$(ps -e | grep nginx | grep -v 'grep' | head -n 1 | awk '{print $1}')
      if [ -n "$pid" ]; then
          nginx_bin=$(readlink -f /proc/"$pid"/exe)
          echo "Nginx executable path: $nginx_bin"
      fi
  fi

  NGINX_VERSION=$($nginx_bin -v 2>&1 | awk -F ': ' '{print $2}' | head -c 20)

  # Use a running nginx first
  NGINX_CONFIG=$(ps -eo pid,cmd | grep nginx | grep master | grep '\-c' | awk -F '-c' '{print $2}' | sed 's/ //g')
  if [ -z "$NGINX_CONFIG" ]; then
    NGINX_CONFIG=$($nginx_bin -t 2>&1 | grep 'configuration' | head -n 1 | awk -F 'file' '{print $2}' | awk '{print $1}' )
  fi
  NGINX_CONFIG_HOME=$(dirname "$NGINX_CONFIG")

  _info "os-name: $OS"
  _info "version: $NGINX_VERSION"
  _info "nginx-config: $NGINX_CONFIG"
  _info "nginx-config-home: $NGINX_CONFIG_HOME"
  showWelcome
}

_inithttp() {
  _H0="Content-Type: text/plain"
  _H1="httpsok-token: $HTTPSOK_TOKEN"
  _H2="httpsok-version: $VER"
  _H3="os-name: $OS"
  _H4="nginx-version: $NGINX_VERSION"
  _H5="nginx-config-home: $NGINX_CONFIG_HOME"
  _H6="nginx-config: $NGINX_CONFIG"
  _H7="trace-id: $TRACE_ID"
}

_post() {
  _inithttp
  url="${BASE_API_URL}$1"
  body="$2"
  curl -s -X POST -H "$_H0" -H "$_H1" -H "$_H2" -H "$_H3" -H "$_H4" -H "$_H5" -H "$_H6" -H "$_H7" --data-binary "$body" "$url"
}

_get() {
  _inithttp
  url="${BASE_API_URL}$1"
  curl -s -H "$_H0" -H "$_H1" -H "$_H2" -H "$_H3" -H "$_H4" -H "$_H5" -H "$_H6" -H "$_H7" "$url"
}

_upload() {
  _inithttp
  url="${BASE_API_URL}/upload?code=$1"
  _F1="cert=@\"$2\""
  _F2="certKey=@\"$3\""
  curl -s -X POST -H "Content-Type: multipart/form-data" -H "$_H1" -H "$_H2" -H "$_H3" -H "$_H4" -H "$_H5" -H "$_H6" -H "$_H7" -F $_F1 -F $_F2 "$url" 2>&1
}

_put() {
  _inithttp
  url="${BASE_API_URL}$1"
  body="$2"
  curl -s -X PUT -H "$_H0" -H "$_H1" -H "$_H2" -H "$_H3" -H "$_H4" -H "$_H5" -H "$_H6" -H "$_H7" --data-binary "$body" "$url"
}

_remote_log() {
  type="$1"
  code="$2"
  msg="$3"
  _put "/log/$type?code=$code" "$msg"
}

_create_file() {
  local file_path="$1"
  if [ ! -e "$file_path" ]; then
    dir_path=$(dirname "$file_path")
    mkdir -p "$dir_path"
    touch "$file_path"
    _info "File created: $file_path"
  fi
}

_check() {
  depth=$1
  code=$2
  cert_file=$3
  cert_key_file=$4
  url="/check?code=$code"

  if [ $depth -le 0 ]; then
    _err "The maximum number of attempts exceeded"
  else
    resp=$(_get "$url")
    status=$(echo "$resp" | head -n 1)
    case $status in
      "1")
        _suc "$code $cert_file The new certificate has been updated"
        md5_line=$(echo "$resp" | awk 'NR==2')

        cert_file_md5=$(echo $md5_line | awk -F ',' '{print $1}')
        cert_key_file_md5=$(echo $md5_line | awk -F ',' '{print $2}')

        tmp_cert_file="/tmp/$code.cer"
        tmp_cert_key_file="/tmp/$code.key"

        _get "/cert/$code.cer" > "$tmp_cert_file" && _get "/cert/$code.key" > "$tmp_cert_key_file"

        # md5 check
        tmp_cert_md5=$(md5sum "$tmp_cert_file" | awk '{print $1}')
        tmp_cert_key_md5=$(md5sum "$tmp_cert_key_file" | awk '{print $1}')
        if [ "$cert_file_md5" = "$tmp_cert_md5" ] && [ "$cert_key_file_md5" = "$tmp_cert_key_md5" ]; then
          # if local_cert_file not here. need to create the file
          _create_file "$cert_file" && _create_file "$cert_key_file"
          mv "$tmp_cert_file" "$cert_file" && mv "$tmp_cert_key_file" "$cert_key_file"
          _suc "$code $cert_file New cert updated"
          _remote_log "cert-updated-success" "$code" "New cert updated"
          echo "latest_code $code"
        else
          _err "$code $cert_file New cert update failed (md5 not match)"
          _remote_log "cert-updated-failed" "$code" "New cert update failed (md5 not match): cert_file_md5=$cert_file_md5,tmp_cert_md5=$tmp_cert_md5,cert_key_file_md5=$cert_key_file_md5,tmp_cert_key_md5=$tmp_cert_key_md5"
        fi
        ;;
      "2")
        _info "$code $cert_file Processing, please just wait..."
        sleep 10
        _check $((depth - 1)) "$code" "$cert_file" "$cert_key_file"
        ;;
      "3")
        _suc "$code $cert_file Cert valid"
        ;;
      "12")
        _err "$code $cert_file DNS CNAME invalid"
        ;;
      "13")
        _err "$code $cert_file code invalid"
        ;;
      *)
        _err "$code $cert_file $resp"
        ;;
    esac
  fi
}

_save_token() {
  _token="$1"
  _check_token "$_token"
  _initpath
  if [ ! "$_token" = "" ]; then
    echo "$_token" > "$PROJECT_TOKEN_FILE"
    _suc "save token $_token to $PROJECT_TOKEN_FILE"
  fi
}

_load_token() {
  if [ "$HTTPSOK_TOKEN" = "" ]; then
    HTTPSOK_TOKEN=$(cat "$PROJECT_TOKEN_FILE")
  fi
}

_check_token() {
  _token="$1"
  if [ ! "$_token" = "" ]; then
    HTTPSOK_TOKEN="$_token"
  fi
  if [ "$HTTPSOK_TOKEN" = "" ]; then
    _err "httpsok's token can not empty"
    exit 4
  fi
  status=$(_get "/status")
  if [ "$status" != "ok" ]; then
    _err "Invalid token: $HTTPSOK_TOKEN Please copy your token from '$HTTPSOK_HOME_URL' "
    _err "$status"
    exit 4
  fi
  return 0
}


# Limit the maximum nesting level
_include_max_calls=5
_include_global_count=0


__process_include() {

  if [ $_include_global_count -ge $_include_max_calls ]; then
      # echo "Maximum recursion limit reached."
      cat /dev/stdin
      return 0
  else
      # Recursive call, degree incremented by one
      ((global_count++))
  fi

  tmp=$(cat /dev/stdin | awk -v NGINX_CONFIG=">$NGINX_CONFIG:" -v NGINX_CONFIG_HOME="$NGINX_CONFIG_HOME" '{

      original = $0

      # Remove leading and trailing whitespace characters from each line
      gsub(/^[[:space:]]+|[[:space:]]+$/, "")

      # Ignore the lines at the beginning of the file
      if ($0 ~ /^>/) {
        print original
        next
      }

      # Determines if it starts with #, and if it does, ignores it
      if ($0 ~ /^#/) {

        # Replace the include in the comment
        # gsub("include", "import")

        print original
        next
      }

      # Determine whether include is included
      if ($0 ~ /^include /) {

        # Ignore mime.types
        if($0 ~ /mime\.types;/){
          print "# " original
          next
        }

        # print "#import " $2
        print "#import " original

        # system("cat " $2)
        # print ">>  "

        # ls /etc/nginx/conf.d/*.conf | xargs -I {} sed  "s|^|{}:|" {}
        # system("ls " $2 " | xargs -I {} sed  \"s|^|{}:|\" {}")

        # /etc/nginx/conf.d/*.conf;
        # Replace ;
        gsub(/;/, "")

        # /etc/nginx/conf.d/*.conf
        # Resolved to an include file
        # print $2

        # Deal with relative path issues
        if (substr($2, 1, 1) != "/") {
          $2 = NGINX_CONFIG_HOME "/" $2
        }

        # print "# " original

        # The second way
        # find . -maxdepth 1 -print0 | xargs -0 command
        # system("find " $2 " -maxdepth 1 -print0  | xargs  -0 -I {} sed \"s|^|>{}:|\" {}")

        # just backup
        # system("ls -1 " $2 " | xargs -I {} sed \"s|^|>{}:|\" {}")

        # If the last line of the file is not newline, the file will not be parsed correctly
        # system("ls -1 " $2 " 2>/dev/null | xargs -I {} cat {} ")

        # Using sh has security implications deprecated
        # system("ls -1 " $2 " 2>/dev/null | xargs -I {} sh -c \"cat {} && echo\" ")

        #
        # system("ls -1 " $2 " 2>/dev/null | xargs -I {} sed -n \"$p\" {} ")

        # xargs -I {} awk -v FP="{}"  "BEGIN{ print \"# include \" FP } {print} END{print ""} " {}
        #system("ls -1 " $2 " 2>/dev/null | xargs -I {} awk \" {print} END {print \"\" } \" {} ")
        #
        # cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk \" {print} END {print \"\\\"\"\n\"\\\"\" } \" {} "

        # cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk \"BEGIN {print \"\"{}\"\" } {print} END {print \n } \" {} "

        # OK Add a newline character to the end of the file
        # cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk \" {print} END {print \"\\n\" } \" {} "

        # OK Add a newline character to the end of the file
        # cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk '\'' {print} '\'' {} "

        # OK add config file path
        #cmd = "ls -1 " $2 " 2>/dev/null | xargs -I GG awk '\'' BEGIN {print \"#included GG;\" } {print} '\'' GG "
        #cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk '\'' BEGIN {print \"#included {};\" } {print} '\'' {} "


        cmd = "ls -1 " $2 " 2>/dev/null | xargs -I {} awk '\'' BEGIN {print \"#included-begin {};\" } {print}  END{ print \"#included-end {};\"  } '\'' {} "

        # print cmd
        system(cmd)

        print ""

        next
      }

      print original

    }'

  )


  if echo "$tmp" | grep -v '#' | grep -q "include"; then
    # Perform a recursive call
    echo "$tmp" | __process_include
  else
    # End the recursive call
    echo "$tmp"
  fi
}

__process_format(){
  cat /dev/stdin | awk -v NGINX_CONFIG="$NGINX_CONFIG:" '{
      # gsub("import", "include")
      # print NGINX_CONFIG $0
      print $0
  }'
}

_preparse() {
  _initparams

  config_text=$(cat $NGINX_CONFIG | __process_include | __process_format)
  # exit
  # config_text=$(grep -E "ssl|server_name|server|include|listen" -r "$NGINX_CONFIG_HOME" "/www/server/panel/vhost/nginx" "/usr/local/*/vhost/" "/home/wwwroot/*/vhost/" "/home/wwwroot/*/etc/" | cat | grep -v 'SERVER_')
  preparse=$(_post "/preparse" "$config_text")
  if [ "$preparse" = "" ]; then
    return 4
  fi
  return 0
}

_upload_certs() {
  while read row
  do
    if [ "$row" = "" ]; then
      continue
    fi
    code=$(echo $row | awk -F ',' '{print $1}')
    cert_file=$(echo $row | awk -F ',' '{print $2}')
    cert_key_file=$(echo $row | awk -F ',' '{print $3}')
    up_status=$(_upload "$code" "$cert_file" "$cert_key_file")
    if [ "$up_status" != "ok" ]; then
      continue
    fi
  done <<EOF
  $preparse
EOF
}

_check_certs() {
  while read row
  do
    if [ "$row" = "" ]; then
      continue
    fi
    code=$(echo $row | awk -F ',' '{print $1}')
    cert_file=$(echo $row | awk -F ',' '{print $2}')
    cert_key_file=$(echo $row | awk -F ',' '{print $3}')
    check_reposne=$(_check 60 "$code" "$cert_file" "$cert_key_file")
    _code=$(echo "$check_reposne" | grep 'latest_code' | awk '{print $2}')
    if [ -n "$_code" ]; then
      latest_code="$_code"
    fi
#  done < <( echo "$preparse" )
  done <<EOF
  $preparse
EOF
}


_check_dns() {
  codes=$(echo "$preparse" | awk -F ',' '{print $1}' | tr '\n' ',' )
  url="/checkDns?codes=$codes"
  resp=$(_get "$url")
  status=$(echo "$resp" | head -n 1)
  case $status in
    "3")
      _suc "DNS check pass"
      ;;
    "13")
      _err "code invalid"
      ;;
    *)
      _err "$resp"
      ;;
  esac
}

_reload_nginx() {

    if [ "$latest_code" = "" ]; then
      echo
      _info "Nginx reload needless."
      return 0
    fi

    msg=$($nginx_bin -t 2>&1)
    if [ $? != 0 ]; then
      _remote_log "nginx-test-failed" "$latest_code" "$msg"
      echo
      _err "Nginx test failed."
    else
      msg=$($nginx_bin -s reload 2>&1)
      if [ "$msg" = "" ]; then
        _remote_log "nginx-reload-success" "$latest_code" "Nginx reload success."
        echo
        _suc "Nginx reload success."
      else
        _remote_log "nginx-reload-failed" "$latest_code" "$msg"
        echo
        _err "Nginx reload failed."
      fi
    fi
}

version() {
  echo "$PROJECT_ENTRY v$VER"
}

# Detect profile file if not specified as environment variable
_detect_profile() {
  if [ -n "$PROFILE" -a -f "$PROFILE" ]; then
    echo "$PROFILE"
    return
  fi

  DETECTED_PROFILE=''
  SHELLTYPE="$(basename "/$SHELL")"

  if [ "$SHELLTYPE" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      DETECTED_PROFILE="$HOME/.bash_profile"
    fi
  elif [ "$SHELLTYPE" = "zsh" ]; then
    DETECTED_PROFILE="$HOME/.zshrc"
  fi

  if [ -z "$DETECTED_PROFILE" ]; then
    if [ -f "$HOME/.profile" ]; then
      DETECTED_PROFILE="$HOME/.profile"
    elif [ -f "$HOME/.bashrc" ]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      DETECTED_PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.zshrc" ]; then
      DETECTED_PROFILE="$HOME/.zshrc"
    fi
  fi

  if [ -z "$DETECTED_PROFILE" ]; then
    if [ -f "/etc/profile" ]; then
      DETECTED_PROFILE="/etc/profile"
    fi
  fi
  echo "$DETECTED_PROFILE"
}

_tail_c() {
  tail -c "$1" 2>/dev/null || tail -"$1"c
}

_setopt() {
  __conf="$1"
  __opt="$2"
  __sep="$3"
  __val="$4"
  __end="$5"
  if [ -z "$__opt" ]; then
    _usage usage: _setopt '"file"  "opt"  "="  "value" [";"]'
    return
  fi
  if [ ! -f "$__conf" ]; then
    touch "$__conf"
  fi
  if [ -n "$(_tail_c 1 <"$__conf")" ]; then
    echo >>"$__conf"
  fi

  if grep -n "^$__opt$__sep" "$__conf" >/dev/null; then
    if _contains "$__val" "&"; then
      __val="$(echo "$__val" | sed 's/&/\\&/g')"
    fi
    if _contains "$__val" "|"; then
      __val="$(echo "$__val" | sed 's/|/\\|/g')"
    fi
    text="$(cat "$__conf")"
    printf -- "%s\n" "$text" | sed "s|^$__opt$__sep.*$|$__opt$__sep$__val$__end|" >"$__conf"

  elif grep -n "^#$__opt$__sep" "$__conf" >/dev/null; then
    if _contains "$__val" "&"; then
      __val="$(echo "$__val" | sed 's/&/\\&/g')"
    fi
    if _contains "$__val" "|"; then
      __val="$(echo "$__val" | sed 's/|/\\|/g')"
    fi
    text="$(cat "$__conf")"
    printf -- "%s\n" "$text" | sed "s|^#$__opt$__sep.*$|$__opt$__sep$__val$__end|" >"$__conf"

  else
    echo "$__opt$__sep$__val$__end" >>"$__conf"
  fi
}

_install() {
  _info "Installing $PROJECT_NAME."
  _initpath
  curl -s "$SCRIPT_URL" > "$PROJECT_ENTRY_BIN" && chmod +x "$PROJECT_ENTRY_BIN"
  if [ -x "$PROJECT_ENTRY_BIN" ] ; then
    _suc "Install $PROJECT_NAME complete."
  else
    _err "Install $PROJECT_NAME failed."
    exit 4
  fi
  installcronjob
  installAlais
}

installcronjob() {
  _CRONTAB="crontab"

  _t=$(_time)
  random_minute=$(_math $_t % 60)
  random_hour=$(_math $_t % 9 + 9 )  # 9 ~ 17

  if ! _exists "$_CRONTAB" ; then
    _err "$_CRONTAB not exits"
    return 4
  fi

  if ! $_CRONTAB -l | grep "$PROJECT_ENTRY" > /dev/null; then
    _info "Installing cron job."
    if _exists uname && uname -a | grep SunOS >/dev/null; then
      _CRONTAB_STDIN="$_CRONTAB --"
    else
      _CRONTAB_STDIN="$_CRONTAB -"
    fi
    $_CRONTAB -l | {
      cat
      echo "$random_minute $random_hour * * * '$PROJECT_ENTRY_BIN' -r >> '$PROJECT_LOG_FILE' 2>&1"
    } | $_CRONTAB_STDIN
    _suc "Install cron job complete."
  fi
  if [ "$?" != "0" ]; then
    _err "Install cron job failed. You can add cronjob by yourself."
    _err "Or you can add cronjob by yourself:"
    _err "$random_minute $random_hour * * * '$PROJECT_ENTRY_BIN' -r >> '$PROJECT_LOG_FILE' 2>&1"
    return 1
  fi
}

installAlais() {

  _envfile="$PROJECT_ENTRY_BIN.env"
  echo "alias $PROJECT_ENTRY=\"$PROJECT_ENTRY_BIN\"" > "$_envfile"

  _info "Installing alias"
  _profile="$(_detect_profile)"
  if [ "$_profile" ]; then
    _info "Found profile: $_profile"
    _info "Installing alias to '$_profile'"
    _setopt "$_profile" ". \"$_envfile\""
    _suc "OK, Close and reopen your terminal to start using $PROJECT_NAME"
  else
    _err "No profile is found, you will need to go into $PROJECT_HOME to use $PROJECT_NAME"
  fi
}

_uninstall() {
  _info "Uninstalling httpsok."
  uninstallcronjob
  _uninstallalias
  if [ -d "$PROJECT_HOME" ]; then
    _info "Removing directory $PROJECT_HOME"
    rm -rf "$PROJECT_HOME"
  fi
  _suc "Uninstall httpsok complete."
  showWelcome
  echo "If your need install httpsok agian. Please see $HTTPSOK_HOME_URL .

curl -s $SCRIPT_URL | bash -s 'your token'

"
}

_uninstallalias() {
  _envfile="$PROJECT_ENTRY_BIN.env"
  _profile="$(_detect_profile)"
  if [ "$_profile" ]; then
    _info "Uninstalling alias from: '$_profile'"
    text="$(cat "$_profile")"
    echo "$text" | sed "s|^.*\"$_envfile\"$||" >"$_profile"
  fi
}

uninstallcronjob() {
  _CRONTAB="crontab"
  if ! _exists "$_CRONTAB" ; then
    _err "$_CRONTAB not exits"
    return 4
  fi
  cr="$($_CRONTAB -l | grep "$PROJECT_ENTRY")"
  if [ "$cr" ]; then
    _info "Removing cron job"
    if _exists uname && uname -a | grep SunOS >/dev/null; then
      $_CRONTAB -l | sed "/$PROJECT_ENTRY/d" | $_CRONTAB --
    else
      $_CRONTAB -l | sed "/$PROJECT_ENTRY/d" | $_CRONTAB -
    fi
    _suc "Remove cron job complete."
  fi
}

_run() {
  _load_token
  _check_token
  if ! _preparse ; then
    _err "未检测到SSL证书。\n "
    _info "请您先进行基本配置，配置请参考 https://fposter.cn/doc/reference/nginx-config.html "
    echo ""
    return 4
  fi
  _upload_certs
  _check_dns
  _check_certs
  _reload_nginx
  echo ""
}

_process() {
  while [ ${#} -gt 0 ]; do
    case "${1}" in
      --help | -h)
        showhelp
        return
        ;;
      --version | -v)
        version
        return
        ;;
      --install | -i)
        _install
        return
        ;;
      --uninstall | -u)
        _uninstall
        return
        ;;
      --token | -t)
        _save_token "$2"
        shift 1
        ;;
      --run | -r)
        _run
        ;;
      --setup | -s)
        _save_token "$2"
        _install
        _run
        shift 1
        ;;
      *)
        echo "Unknown parameter : $1 $2"
        return 1
        ;;
    esac
    shift 1
  done
}


showhelp() {
  echo "Usage: $PROJECT_ENTRY <command> ... [parameters ...]
Commands:
  -h, --help               Show this help message.
  -v, --version            Show version info.
  -i, --install            Install $PROJECT_NAME to your system.
  -u, --uninstall          Uninstall $PROJECT_NAME in your system.
  -t, --token              Set the token.
  -r, --run                Run the $PROJECT_NAME
  -s, --setup              Install and run (Recommend first time use it).
"
  showWelcome
}

main() {
  [ -z "$1" ] && showhelp && return
  if _startswith "$1" '-'; then _process "$@"; else _process --setup "$@"; fi
}

main "$@"