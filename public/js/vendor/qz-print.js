/**
* Optionally used to deploy multiple versions of the applet for mixed
* environments.  Oracle uses document.write(), which puts the applet at the
* top of the page, bumping all HTML content down.
*/
deployQZ();

/**
* Deploys different versions of the applet depending on Java version.
* Useful for removing warning dialogs for Java 6.  This function is optional
* however, if used, should replace the <applet> method.  Needed to address 
* MANIFEST.MF TrustedLibrary=true discrepency between JRE6 and JRE7.
*/
function deployQZ() {
    var attributes = {id: "qz", code:'qz.PrintApplet.class', 
        archive:'../qz-print.jar', width:1, height:1};
    var parameters = {jnlp_href: 'qz-print_jnlp.jnlp', 
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
    window["qz"] = document.getElementById('qz');
    var title = document.getElementById("title");
    if (qz) {
        try {
            title.innerHTML = title.innerHTML + " " + qz.getVersion();
            document.getElementById("content").style.background = "#F0F0F0";
        } catch(err) { // LiveConnect error, display a detailed meesage
            document.getElementById("content").style.background = "#F5A9A9";
            alert("ERROR:  \nThe applet did not load correctly.  Communication to the " + 
                "applet has failed, likely caused by Java Security Settings.  \n\n" + 
                "CAUSE:  \nJava 7 update 25 and higher block LiveConnect calls " + 
                "once Oracle has marked that version as outdated, which " + 
                "is likely the cause.  \n\nSOLUTION:  \n  1. Update Java to the latest " + 
                "Java version \n          (or)\n  2. Lower the security " + 
                "settings from the Java Control Panel.");
      }
  }
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
    alert('Successfully sent print data to "' + qz.getPrinter() + '" queue.');
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
    // Get printer name from input box
    var p = document.getElementById('printer');
    if (name) {
        p.value = name;
    }
    
    if (isLoaded()) {
        // Searches for locally installed printer with specified name
        qz.findPrinter(p.value);
        
        // Automatically gets called when "qz.findPrinter()" is finished.
        window['qzDoneFinding'] = function() {
            var p = document.getElementById('printer');
            var printer = qz.getPrinter();
            
            // Alert the printer name to user
            alert(printer !== null ? 'Printer found: "' + printer + 
                '" after searching for "' + p.value + '"' : 'Printer "' + 
                p.value + '" not found.');
            
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

/***************************************************************************
* Prototype function for printing raw ESC/POS commands
* Usage:
*    qz.append('\n\n\nHello world!\n');
*    qz.print();
***************************************************************************/
function printESCP() {
    if (notReady()) { return; }
    
    // Append a png in ESCP format with single pixel density
    //qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "double");
    
    qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "simple");
    
    // Automatically gets called when "qz.appendImage()" is finished.
    window["qzDoneAppending"] = function() {
    
        qz.appendHex("x1Bx40");
    
        qz.appendHex("x48x6Fx6Cx61");
        qz.appendHex("x0Dx0A");
        
        qz.appendHex("x1Bx21x00");
        qz.appendHex("x1Bx21x30"); 
        qz.appendHex("x48x6Fx6Cx61");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
    
        // Tell the apple to print.
        qz.print();
            
        // Remove any reference to this function
        window['qzDoneAppending'] = null;
    };
    

}
