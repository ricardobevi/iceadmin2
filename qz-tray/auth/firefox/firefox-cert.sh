#!/bin/bash
###############################################################################
#           QZ Tray Linux / Unix Firefox Certificate Utility                  #
###############################################################################
#  Description:                                                               #
#   INSTALL:                                                                  #
#     1. Searches for Firefox installation path                               #
#     2. Parses defaults/pref for potential Firefox AutoConfig conflicts      #
#     3. Imports certificate into Firefox web browser using AutoConfig file   #
#                                                                             #
#   UNINSTALL:                                                                #
#     1. Deletes certificate from Firefox web browser using AutoConfig file   #
#                                                                             #
#  Depends:                                                                   #
#    - lsregister (Apple-only, provided by launch services)                   #
#    - perl (standard with most modern Linux/Unix systems)                    #
#                                                                             #
#  Usage:                                                                     #
#    $ ./firefox-cert.sh "install" [hostname]                                 #
#    $ ./firefox-cert.sh "uninstall" [hostname]                               #
#                                                                             #
###############################################################################

# Array of possible Firefox application names.
appnames=("IceWeasel" "Firefox")	# "Firefox" "IceWeasel", etc

# Array of possible pref tag conflicts
conflicts=("general.config.filename")

mask=755

#
# Uses "which" and "readlink" to locate firefox on Linux, etc
#
function get_ffdir()
{
	for i in "${appnames[@]}"; do
		ffdirtemp=$("$locationdir/locator.sh" $i)
		if [ $? == 0 ]; then
			ffdir="$ffdirtemp"
			return 0
		fi
	done
	return 1
}

echo "Searching for Firefox..."

ffdir=""
if [[ "$OSTYPE" == "darwin"* ]]; then
	# Mac OSX
	locationdir=$(cd "$(dirname "$0")"; pwd)
	get_ffdir

	bindir="$ffdir/Contents/Resources/"
	prefdir="$ffdir/Contents/Resources/defaults/pref"
	installdir="${apple.installdir}"
	trayapp="$installdir"  # use .app package
else
	# Linux, etc
	location=$(readlink -f "$0")
	locationdir=$(dirname "$location")
	get_ffdir

	bindir="$ffdir"
	prefdir="$ffdir/defaults/pref"
	installdir="/opt/qz-tray"
	trayapp=""  # skip
fi

# Firefox was not found, skip Firefox certificate installation
if [ -z "$ffdir" ] || [ "$ffdir" = "/" ]; then
	echo -e "   [\e[1;33mskipped\033[0m] Firefox not found"
	exit 0
else
    echo -e "   [\e[1;32msuccess\033[0m] $ffdir"
fi

# Handle CN=localhost override
cname="localhost"
if [ -n "$2" ]; then
    cname="$2"
fi

# Perform substitutions
dercertpath=$(echo "!install/auth/root-ca.crt" | sed -e "s|\!install|$installdir|g")
prefspath=$(echo "!install/auth/firefox/firefox-prefs.js" | sed -e "s|\!install|$installdir|g")
configpath=$(echo "!install/auth/firefox/firefox-config.cfg" | sed -e "s|\!install|$installdir|g")

#
# Uninstall mode
#
if [ "$1" == "uninstall" ]; then
    echo -e "\nSearching for QZ Tray AutoConfig..."
    if [ -f "$bindir/firefox-config.cfg" ]; then
        echo -e "   [\e[1;32msuccess\033[0m] Check Firefox config exists"
        cp "$configpath" "$bindir/firefox-config.cfg"
        chmod $mask "$bindir/firefox-config.cfg"
        # Replace ${certData} with the blank string
        perl -pi -e "s#\\\$\{certData\}##g" "$bindir/firefox-config.cfg"
        ret1=$?
        perl -pi -e "s#\\\$\{uninstall\}#true#g" "$bindir/firefox-config.cfg"
        ret2=$?
        perl -pi -e "s#\\\$\{timestamp\}#-1#g" "$bindir/firefox-config.cfg"
        ret3=$?
        perl -pi -e "s#\\\$\{commonName\}#$cname#g" "$bindir/firefox-config.cfg"
        ret4=$?
        perl -pi -e "s#\\\$\{trayApp\}##g" "$bindir/firefox-config.cfg"
        ret5=$?
        if [ $ret1 -eq 0 ] && [ $ret2 -eq 0 ] && [ $ret3 -eq 0 ] && [ $ret4 -eq 0 ] && [ $ret5 -eq 0 ]; then
            echo -e "   [\e[1;32msuccess\033[0m] Certificate removed successfully"
        else
            echo -e "   [\e[1;31mfailure\033[0m] QZ Tray Certificate removal failed"
            exit 1
        fi
    else
        echo -e "   [\e[1;33mskipped\033[0m] QZ Tray AutoConfig not found"
    fi
    echo -e "\n[Finished firefox-cert.sh]\n"
    exit 0
fi

#
# Install mode (default)
#
echo -e "\nSearching for Firefox AutoConfig conflicts..."

# Iterate over each preference file looking for conflicts
for i in $prefdir/*; do
	if [ "$i" == "$prefdir/firefox-prefs.js" ]; then
		# skip, QZ Tray preferences
		echo -e "   [\e[1;33mskipped\033[0m] Ignoring QZ Tray preference file \"firefox-prefs.js\""
		continue
	fi
	for j in "${conflicts[@]}"; do
		grep '"$j"' $i &>/dev/null
		ret1=$?
		grep "'$j'" $i &>/dev/null
		ret2=$?
		if [ $ret1 -eq 0 ] || [ $ret2 -eq 0 ]; then
		   echo -e "   [\e[1;31mfailure\033[0m] Conflict found while looking for \"$j\"\n\tin $i"
		   exit 1
		fi
	done
done

echo -e "   [\e[1;32msuccess\033[0m] No conflicts found"



echo -e "\nRegistering with Firefox..."
cp "$prefspath" "$prefdir/firefox-prefs.js"
cp "$configpath" "$bindir/firefox-config.cfg"
chmod $mask "$prefdir/firefox-prefs.js"
chmod $mask "$bindir/firefox-config.cfg"

bcert="-----BEGIN CERTIFICATE-----"
ecert="-----END CERTIFICATE-----"
blank=""

# Read certificate, stripping newlines
certdata=$(cat "$dercertpath" |tr -d '\n'|tr -d '\r')

# Strip all non-base64 data
certdata=$(echo "$certdata" | sed -e "s|$bcert|$blank|g")
certdata=$(echo "$certdata" | sed -e "s|$ecert|$blank|g")
timestamp=$(date +%s)

if [ -f "$bindir/firefox-config.cfg" ]; then
	echo -e "   [\e[1;32msuccess\033[0m] Check QZ Tray AutoConfig exists"
	# Replace ${certData} with the base64 string
    perl -pi -e "s#\\\$\{certData\}#$certdata#g" "$bindir/firefox-config.cfg"
    ret1=$?
    perl -pi -e "s#\\\$\{uninstall\}#false#g" "$bindir/firefox-config.cfg"
    ret2=$?
    perl -pi -e "s#\\\$\{timestamp\}#$timestamp#g" "$bindir/firefox-config.cfg"
    ret3=$?
    perl -pi -e "s#\\\$\{commonName\}#$cname#g" "$bindir/firefox-config.cfg"
    ret4=$?
    perl -pi -e "s#\\\$\{trayApp\}#$trayapp#g" "$bindir/firefox-config.cfg"
    ret5=$?
    if [ $ret1 -eq 0 ] && [ $ret2 -eq 0 ] && [ $ret3 -eq 0 ] && [ $ret4 -eq 0 ] && [ $ret5 -eq 0 ]; then
        echo -e "   [\e[1;32msuccess\033[0m] Certificate installed"
    else
        echo -e "   [\e[1;31mfailure\033[0m] Certificate installation failed"
    fi
else
	echo -e "   [\e[1;31mfailure\033[0m] Cannot locate QZ Tray AutoConfig"
	exit 1
fi

echo -e "\n[Finished firefox-cert.sh]\n"
exit 0

