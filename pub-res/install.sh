
pubresdir="$(cd "$(dirname "${0}")" && pwd)"


cd "${1}" || exit
curdirec="$(pwd)"


# Identify the project type
projtype='cmd'
if [ -f "proj-info/project-type.txt" ]; then
  projtype="$(cat proj-info/project-type.txt)"
else
  if [ -f "proj-info/proj-name.txt" ]; then
    echo cmd > proj-info/project-type.txt
  else
    (
      echo
      echo "PLEASE CREATE: ${curdirec}/proj-info/project-type.txt"
      echo
    ) 1>&2
    exit 8
  fi
fi



if [ -f "proj-info/proj-name.txt" ]; then
  fildesnom="$(cat "proj-info/proj-name.txt")"
  echo "Project Identified: ${fildesnom}:"
else
  (
    echo
    echo PROJECT NAME NOT FOUND
    echo "$(pwd)/proj-info/proj-name.txt"
    echo
  ) 1>&2
  exit 3
fi


rm -rf tmp
mkdir -p tmp

rm -rf tmp/checkret.txt
perl "${pubresdir}/ins-pl/checkbefore.pl"
if [ -f "tmp/checkret.txt" ]; then
  (
    echo "Failed to install from: ${curdirec}:"
  ) 1>&2
  exit "$(cat tmp/checkret.txt)"
fi


if [ -f "Makefile" ]; then
  make build/all || exit
  # Central target is 'build/all' rather than 'all' so that (if need-be)
  # the file can actually be -created- without being tracked.
fi


(
  echo "#! $(which perl)"
  echo "use strict;"
  echo "my \$resloc = \"${curdirec}\";"
  echo "# line 1 \"${pubresdir}/outer-wrap.qpl-then\""
  cat "${pubresdir}/outer-wrap.qpl"
) > tmp/${fildesnom}
chmod 755 tmp/${fildesnom}
perl -c tmp/${fildesnom} || exit 2


# Find the default location
destina='x'
onetype='cmd'
if [ $projtype = $onetype ]; then
  destina="${HOME}/bin"
fi
onetype='scrip-tll'
if [ $projtype = $onetype ]; then
  destina="${HOME}/scriptools"
fi

onetype='x'
if [ $destina = $onetype ]; then
  (
    echo
    echo "Could not find project-type: ${projtype}:"
    echo
  ) 1>&2
fi


# Allow overriding of default:
if [ -f "ins-opt-code/dir-of-install.txt" ]; then
  destina="$(cat ins-opt-code/dir-of-install.txt)"
fi

cp "tmp/${fildesnom}" "${destina}/."
chmod 755 "${destina}/${fildesnom}"

if [ -f "after-install.sh" ]; then
  exec sh after-install.sh
fi

# Prepare environment for extra compilation instructions:

MY_DESTINA_BIN="${destina}"
export MY_DESTINA_BIN

if [ -f "extra-install.sh" ]; then
  exec sh extra-install.sh
fi





