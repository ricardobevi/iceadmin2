/**
* Optionally used to deploy multiple versions of the applet for mixed
* environments.  Oracle uses document.write(), which puts the applet at the
* top of the page, bumping all HTML content down.
*/
deployQZ();

findPrinter('zebra');

/**
* Deploys different versions of the applet depending on Java version.
* Useful for removing warning dialogs for Java 6.  This function is optional
* however, if used, should replace the <applet> method.  Needed to address 
* MANIFEST.MF TrustedLibrary=true discrepency between JRE6 and JRE7.
*/
function deployQZ() {
    var attributes = {id: "qz", code:'qz.PrintApplet.class', 
        archive:qzPrintAppletLocation, width:1, height:1};
    var parameters = {jnlp_href: qzPrintAppletJNLPLocation, 
        cache_option:'plugin', disable_logging:'false', 
        initial_focus:'false'};
    if (deployJava.versionCheck("1.7+") == true) {}
    else if (deployJava.versionCheck("1.6+") == true) {
        delete parameters['jnlp_href'];
    }
    deployJava.runApplet(attributes, parameters, '1.5');
}

/**
* Automatically gets called when applet has loaded.
*/
function qzReady() {
    // Setup our global qz object
    //alert('applet loaded');
}

/**
* Returns whether or not the applet is not ready to print.
* Displays an alert if not ready.
*/
function notReady() {
    // If applet is not loaded, display an error
    if (!isLoaded()) {
        return true;
    }
    // If a printer hasn't been selected, display a message.
    else if (!qz.getPrinter()) {
        alert('Please select a printer first by using the "Detect Printer" button.');
        return true;
    }
    return false;
}

/**
* Returns is the applet is not loaded properly
*/
function isLoaded() {
    if (!qz) {
        alert('Error:\n\n\tPrint plugin is NOT loaded!');
        return false;
    } else {
        try {
            if (!qz.isActive()) {
                alert('Error:\n\n\tPrint plugin is loaded but NOT active!');
                return false;
            }
        } catch (err) {
            alert('Error:\n\n\tPrint plugin is NOT loaded properly!');
            return false;
        }
    }
    return true;
}

/**
* Automatically gets called when "qz.print()" is finished.
*/
function qzDonePrinting() {
    // Alert error, if any
    if (qz.getException()) {
        alert('Error printing:\n\n\t' + qz.getException().getLocalizedMessage());
        qz.clearException();
        return; 
    }
    
    // Alert success message
    //alert('Successfully sent print data to "' + qz.getPrinter() + '" queue.');
}

/***************************************************************************
* Prototype function for finding the "default printer" on the system
* Usage:
*    qz.findPrinter();
*    window['qzDoneFinding'] = function() { alert(qz.getPrinter()); };
***************************************************************************/
function useDefaultPrinter() {
    if (isLoaded()) {
        // Searches for default printer
        qz.findPrinter();
        
        // Automatically gets called when "qz.findPrinter()" is finished.
        window['qzDoneFinding'] = function() {
            // Alert the printer name to user
            var printer = qz.getPrinter();
            alert(printer !== null ? 'Default printer found: "' + printer + '"':
                'Default printer ' + 'not found');
            
            // Remove reference to this function
            window['qzDoneFinding'] = null;
        };
    }
}


/***************************************************************************
* Prototype function for finding the closest match to a printer name.
* Usage:
*    qz.findPrinter('zebra');
*    window['qzDoneFinding'] = function() { alert(qz.getPrinter()); };
***************************************************************************/
function findPrinter(name) {
    
    if (isLoaded()) {
        // Searches for locally installed printer with specified name
        qz.findPrinter(name);
        
        // Automatically gets called when "qz.findPrinter()" is finished.
        window['qzDoneFinding'] = function() {
            
            var printer = qz.getPrinter();
            
            // Alert the printer name to user
            /*
            alert(printer !== null ? 'Printer found: "' + printer + 
                '" after searching for "' + name + '"' : 'Printer "' + 
                 name + '" not found.');*/
            
            // Remove reference to this function
            window['qzDoneFinding'] = null;
        };
    }
}

/***************************************************************************
* Gets the current url's path, such as http://site.com/example/dist/
***************************************************************************/
function getPath() {
    var path = window.location.href;
    return path.substring(0, path.lastIndexOf("/")) + "/";
}


