#!/bin/bash
##########################################################################################
#                             QZ Tray Linux KeyGen Utility                               #
##########################################################################################
#  Description:                                                                          #
#    1. Creates a self-signed Java Keystore for jetty wss://localhost or [hostname]      #
#    2. Exports public certificate from Java Keystore                                    #
#                                                                                        #
#       Note:  If [trustedcert] and [trustedkey] are specified, import to browser/OS is  #
#              omitted.                                                                  #
#                                                                                        #
#  Depends:                                                                              #
#    java                                                                                #
#                                                                                        #
#  Optional:                                                                             #
#    openssl - Required if providing [trustedcert], [trustedkey] parameters              #
#                                                                                        #
#  Usage:                                                                                #
#    $ ./linux-keygen.sh [hostname] [trustedcert] [trustedkey]                           #
#                                                                                        #
##########################################################################################

# Handle CN=localhost override
cnoverride="$1"

# Handle trusted ssl certificate
if [[ -n $2 && -n $3 ]]; then
    trustedcertpath="$2"
    trustedkeypath="$3"
fi

# Random password hash
password=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 10 | head -n 1)

# Check for IPv4 address
function ip4 {
    if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    fi
    return 1
}

# Replace all install-time variables
function replace_vars {
    # TODO: OpenSUSE as well as some others don't have keytool in $PATH
    cmd=$(echo "$1" | sed -e "s|\"keytool\"|keytool|g")

    # Handle CN=localhost override
    if [ -n "$cnoverride" ]; then
        cmd=$(echo "$cmd" | sed -e "s|CN=localhost,|CN=$cnoverride,|g")
        if ip4 "$cnoverride"; then
            cmd=$(echo "$cmd" | sed -e "s|san=dns:localhost,|san=ip:$cnoverride,|g")
        else
            cmd=$(echo "$cmd" | sed -e "s|san=dns:localhost,|san=dns:$cnoverride,|g")
        fi
        # Remove dangling san
        cmd=$(echo "$cmd" | sed -e "s|,dns:localhost.qz.io||g")
    fi

    cmd=$(echo "$cmd" | sed -e "s|\!install|/opt/qz-tray|g")
    cmd=$(echo "$cmd" | sed -e "s|\!storepass|$password|g")
    cmd=$(echo "$cmd" | sed -e "s|\!keypass|$password|g")
    cmd=$(echo "$cmd" | sed -e "s|\!sslcert|$trustedcertpath|g")
    cmd=$(echo "$cmd" | sed -e "s|\!sslkey|$trustedkeypath|g")

    echo "$cmd"
    return 0
}

# Handle "community" mode, custom signing auth cert
if [ -n "" ]; then
    authcertpath=$(echo "!install/override.crt" | sed -e "s|\!install|/opt/qz-tray|g")
fi

# Write out the secure websocket properties file
function write_properties {
    propspath=$(echo "$1" | sed -e "s|\!install|/opt/qz-tray|g")
    keystorepath=$(echo "!install/auth/qz-tray.jks" | sed -e "s|\!install|/opt/qz-tray|g")
    echo "wss.alias=qz-tray" > "$propspath"
    echo "wss.keystore=$keystorepath" >> "$propspath"
    echo "wss.keypass=$password" >> "$propspath"
    echo "wss.storepass=$password" >> "$propspath"
    echo "wss.host=0.0.0.0" >> "$propspath"
    if [ -n "$authcertpath" ]; then
        echo "authcert.override=$authcertpath" >> "$propspath"
    fi
    echo "" >> "$propspath"
    check_exists "$propspath"
    return $?
}

# Delete a file if exists
function delete_file {
    testfile=$(echo "$1" | sed -e "s|\!install|/opt/qz-tray|g")
    rm -f "$testfile" > /dev/null 2>&1
    return 0
}

# Check to see if file exists with optional message
function check_exists {
    testfile=$(echo "$1" | sed -e "s|\!install|/opt/qz-tray|g")
    if [ -e "$testfile" ]; then
        if [ -n "$2" ]; then
            echo -e "   [\e[1;32msuccess\033[0m] $2 $testfile"
        else
            echo -e "   [\e[1;32msuccess\033[0m] $testfile"
        fi
        return 0
    fi
    echo -e "   [\e[1;31mfailure\033[0m] $testfile"
    return 1
}

# Runs a steps, optionally checks for a file
# e.g: run_step "Description" "ls -al *.txt > ./out" "./out"
function run_step {
    if eval "$(replace_vars "$2") > /dev/null 2>&1"; then
        if [ -z "$3" ]; then
            echo -e "   [\e[1;32msuccess\033[0m] $1"
            return 0
        elif check_exists "$3" "$1"; then
            return 0
        else
            return 1
        fi
    fi
    echo -e "   [\e[1;31mfailure\033[0m]\n"
    return 1
}

# Delete old files if exist
delete_file "!install/auth/qz-tray.jks"
delete_file "!install/auth/qz-tray.crt"

# Handle trusted ssl certificate, if specified
if [ -n "$trustedcertpath" ]; then
    echo -e "\nCreating keystore for secure websockets..."
    run_step "\nConverting to PKCS12 keypair" "openssl pkcs12 -export -in \"!sslcert\" -inkey \"!sslkey\" -out \"!install/auth/qz-tray.p12\" -name qz-tray -passout pass:!keypass" "!install/auth/qz-tray.p12"
    run_step "\nConverting to jks format" "\"keytool\" -importkeystore -deststorepass !storepass -destkeypass !keypass -destkeystore \"!install/auth/qz-tray.jks\" -srckeystore \"!install/auth/qz-tray.p12\" -srcstoretype PKCS12 -srcstorepass !storepass -alias qz-tray" "!install/auth/qz-tray.jks"
    write_properties "!install/qz-tray.properties" || exit 1
    echo -e "\n[Finished linux-keygen.sh]\n"
    exit 0
fi

# Handle self-signed certificate
echo -e "\nCreating keystore for secure websockets..."
# Delete old files if exist
delete_file "!install/auth/root-ca.jks"
delete_file "!install/auth/root-ca.crt"
delete_file "!install/auth/qz-tray.csr"

run_step "Creating a CA keypair" "\"keytool\" -genkeypair -noprompt -alias root-ca -keyalg RSA -keysize 2048 -dname \"CN=localhost, EMAILADDRESS=support@qz.io, OU=QZ Industries\\, LLC, O=QZ Industries\\, LLC, L=Canastota, S=NY, C=US\" -validity 7305 -keystore \"!install/auth/root-ca.jks\" -keypass !keypass -storepass !storepass -ext ku:critical=cRLSign,keyCertSign -ext bc:critical=ca:true,pathlen:1" "!install/auth/root-ca.jks" || exit 1
run_step "Exporting CA certificate" "\"keytool\" -exportcert -alias root-ca -keystore \"!install/auth/root-ca.jks\" -keypass !keypass -storepass !storepass -file \"!install/auth/root-ca.crt\" -rfc -ext ku:critical=cRLSign,keyCertSign -ext bc:critical=ca:true,pathlen:1" "!install/auth/root-ca.crt" || exit 1
run_step "Creating an SSL keypair" "\"keytool\" -genkeypair -noprompt -alias qz-tray -keyalg RSA -keysize 2048 -dname \"CN=localhost, EMAILADDRESS=support@qz.io, OU=QZ Industries\\, LLC, O=QZ Industries\\, LLC, L=Canastota, S=NY, C=US\" -validity 7305 -keystore \"!install/auth/qz-tray.jks\" -storepass !storepass -keypass !keypass -ext ku:critical=digitalSignature,keyEncipherment -ext eku=serverAuth,clientAuth -ext san=dns:localhost,dns:localhost.qz.io -ext bc:critical=ca:false" "!install/auth/qz-tray.jks" || exit 1
run_step "Creating an SSL CSR" "\"keytool\" -certreq -keyalg RSA -alias qz-tray -file \"!install/auth/qz-tray.csr\" -keystore \"!install/auth/qz-tray.jks\" -keypass !keypass -storepass !storepass" "!install/auth/qz-tray.csr" || exit 1
run_step "Issuing SSL certificate from CA" "\"keytool\" -keypass !keypass -storepass !storepass -validity 7305 -keystore \"!install/auth/root-ca.jks\" -gencert -alias root-ca -infile \"!install/auth/qz-tray.csr\" -ext ku:critical=digitalSignature,keyEncipherment -ext eku=serverAuth,clientAuth -ext san=dns:localhost,dns:localhost.qz.io -ext bc:critical=ca:false -rfc -outfile \"!install/auth/qz-tray.crt\"" "!install/auth/qz-tray.crt" || exit 1
run_step "Importing CA certificate into SSL keypair" "\"keytool\" -noprompt -import -trustcacerts -alias root-ca -file \"!install/auth/root-ca.crt\" -keystore \"!install/auth/qz-tray.jks\" -keypass !keypass -storepass !storepass" "" || exit 1
run_step "Importing chained SSL certificate into SSL keypair" "\"keytool\" -noprompt -import -trustcacerts -alias qz-tray -file \"!install/auth/qz-tray.crt\" -keystore \"!install/auth/qz-tray.jks\" -keypass !keypass -storepass !storepass" "" || exit 1

echo -e "\nWriting properties file..."
write_properties "!install/qz-tray.properties" || exit 1

echo -e "\nCleaning up..."
delete_file "!install/auth/root-ca.jks"
delete_file "!install/auth/qz-tray.csr"
delete_file "!install/auth/qz-tray.crt"

echo -e "\n[Finished linux-keygen.sh]\n"
exit 0
