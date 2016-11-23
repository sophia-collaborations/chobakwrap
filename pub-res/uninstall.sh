
pubresdir="$(cd "$(dirname "${0}")" && pwd)"


cd "${1}" || exit
curdirec="$(pwd)"

CHOBAK_INSTALL_PREFIX="${HOME}"
export CHOBAK_INSTALL_PREFIX
CHOBAK_INSTALL_JAIL=""
export CHOBAK_INSTALL_JAIL


rm -rf tmp
mkdir -p tmp

# The following litany is in case any package has it's
# own tests that must be run before install. This feature
# was added so that an administrator could disable
# installations of grunt tools that are installed with
# chorebox in the event that zie has zir own implementation
# installed from elsewhere.
rm -rf tmp/checkret.txt
if [ -f "check-before-install.pl" ]; then
  perl "check-before-install.pl"
  if [ -f "tmp/checkret.txt" ]; then
    (
      echo "Failed to install from: ${curdirec}:"
    ) 1>&2
    exit "$(cat tmp/checkret.txt)"
  fi
fi


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
      echo "PLEASE CREATE:"
      echo "  ${curdirec}/proj-info/project-type.txt"
      echo
      echo "Possible values:"
      echo "  cmd scrip-tll"
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

virtual_curdirec="$(perl "${pubresdir}/ins-pl/virtual-cur-dir.pl" "${curdirec}")"


(
  echo "#! $(which perl)"
  echo "use strict;"
  #echo "my \$resloc = \"${curdirec}\";"
  echo "my \$resloc = \"${virtual_curdirec}\";"
  #echo "# line 1 \"${pubresdir}/outer-wrap.qpl-then\""
  echo "# line 1 \"${pubresdir}/outer-wrap.qpl-then\""
  cat "${pubresdir}/outer-wrap.qpl"
) > tmp/${fildesnom}
chmod 755 tmp/${fildesnom}
perl -c tmp/${fildesnom} || exit 2




# Resolve Jails and Prefixes
foundo="$(perl "${pubresdir}/find-above.pl" ins-opt-code/dir-of-install-jail.txt x install.sh)"
if [ "$foundo" != "x" ]; then
  CHOBAK_INSTALL_JAIL="$(cat "${foundo}")"
  export CHOBAK_INSTALL_JAIL
  CHOBAK_INSTALL_PREFIX="/usr/local"
  export CHOBAK_INSTALL_PREFIX
fi
foundo="$(perl "${pubresdir}/find-above.pl" ins-opt-code/dir-of-install-prefix.txt x install.sh)"
if [ "$foundo" != "x" ]; then
  CHOBAK_INSTALL_PREFIX="$(cat "${foundo}")"
  export CHOBAK_INSTALL_PREFIX
fi


# Find the path-install location
destina='x'
onetype='cmd'
if [ $projtype = $onetype ]; then
  destina="${CHOBAK_INSTALL_PREFIX}/bin"
  # Allow overriding of default:
  #if [ -f "ins-opt-code/dir-of-install.txt" ]; then
  foundo="$(perl "${pubresdir}/find-above.pl" ins-opt-code/dir-of-install.txt x install.sh)"
  if [ "$foundo" != "x" ]; then
    destina="$(cat "${foundo}")"
  fi
fi
onetype='scrip-tll'
if [ $projtype = $onetype ]; then
  destina="${CHOBAK_INSTALL_PREFIX}/scriptools"
  foundo="$(perl "${pubresdir}/find-above.pl" ins-opt-code/dir-of-install-scrip-tll.txt x install.sh)"
  if [ "$foundo" != "x" ]; then
    destina="$(cat "${foundo}")"
  fi
fi

onetype='x'
if [ $destina = $onetype ]; then
  (
    echo
    echo "Could not find project-type: ${projtype}:"
    echo
  ) 1>&2
fi


#perl "${pubresdir}/ins-pl/diffcp.pl" "tmp/${fildesnom}" "${CHOBAK_INSTALL_JAIL}${destina}/."
#chmod 755 "${CHOBAK_INSTALL_JAIL}${destina}/${fildesnom}"
rm -rf "${CHOBAK_INSTALL_JAIL}${destina}/${fildesnom}"



perl "${pubresdir}/man-uninstall.pl" "${pubresdir}"



rm -rf tmp


if [ -f "after-uninstall.sh" ]; then
  exec sh after-uninstall.sh
fi

# Prepare environment for extra compilation instructions:

MY_DESTINA_BIN="${destina}"
export MY_DESTINA_BIN

if [ -f "extra-uninstall.sh" ]; then
  exec sh extra-uninstall.sh
fi





