<cfscript>
	function checkFileType (fileType) {
		//fileType = FilegetMimeType(file);
		imageAllow = ["image/jpeg", "image/png", "image/gif"];
		zipAllow = ["application/zip"];
		if (arrayContains(imageAllow, fileType)) {
			return "image";
		} else if (arrayContains(zipAllow, fileType)) {
			return "zip";
		} else {
			return false;
		}
	}

	function imageSizeCheck (width, height) {
		var ratio = width/height;
		//check height and width
		if ((width gte 150 AND width lte 1500) AND 
				(height gte 150 AND height lte 1500) AND 
				(ratio gte 0.6 AND ratio lte 1.6)) {
			// 600 >= height&width <= 900
			return true; //can be true/false for two situations
		} else {
			// 200 <= height&width <= 600
			return false; //specify the action according to situations
		}	
	}

	function checkOutOneImage (directory, name, ext, names, serverPath) {
		logInfo = StructNew("ordered", "text", "asc"); //output value
		var message = []; //output value include in logInfo
		var str = {};
		var log = "";
		var action = "";
		var extAllow = ["jpg", "jpeg", "png", "gif"];
		var oldext = "";
		var filePath = directory & "/" & name & "." & ext;
		var oldfilePath = "";
  	if (arrayContains(names, name)) {
			if (checkFileType(FilegetMimeType(filePath)) EQ "image") {
				if (not arrayContains(extAllow, LCase(ext))) {
					str = {error = "Invalid_Ext", file = "#name#.#ext#", detail = "#name#.#ext# has invalid extension"};
					arrayAppend(message, str);
					action = "delete";
				} else {
					var imgRead = imageRead(filePath);
	  			var imgInfo = getFileInfo(filePath);
		  		imageScaleTofit(imgRead, 500, 625);
	  			var width = imgRead.width;
	  			var height = imgRead.height;
	  			var ratio = width/height;
		  		if (imageSizeCheck(width, height)) {
		  			var newImageName = serverPath & "/" & name & "." & ext;
						var newTnName = serverPath & "/tn_" & name & "." & ext;
		  			var imgMaxSize = (50*1024);
	  				var tnMaxSize = (5*1024);
	  				var imageQuality = 0.99;
	  				while (true) {
	  					// if (imageQuality lt 0 and getFileInfo(newImageName).size gte imgMaxSize) {
	  						
	  					// }
	  					cfimage(source="#imgRead#", action="write", destination="#newImageName#", quality="#imageQuality#", overwrite="yes");
	  					if (getFileInfo(#newImageName#).size gte imgMaxSize) {
	  							imageQuality -= 0.01;
	  					} else {
	  						imageScaleTofit(imgRead, 100, 125);
	  						cfimage(source="#imgRead#", action="write", destination="#newTnName#", overwrite="yes");
	  						log = "Student ID : " & name & "." & ext & " is uploaded and resized to less than 50kb, and thumbnail is created and resized to less than 5kb.";
								str = {error = "Success", file = "#name#.#ext#", detail = "#log#"};
								arrayAppend(message, str);
								break;
	  					}
	  				}
		  		} else {
						action = "delete";
		  			log = "Image is oversize (must between):<br />
									<ol>
										<li>width: "& width & " (150~1500)</li>
										<li>height: " & height & " (200~2000)</li>
										<li>width/height: " & ratio & " (0.6~1.6)</li>
									</ol>
		  			";
						str = {error = "Oversize", file = "#name#.#ext#", detail = "#log#"};
						arrayAppend(message, str);
		  		}
		  	}
			} else {
				action = "delete";
				log = "#name#.#ext# is not a valid image file.";
				str = {error = "Not_Image", file = "#name#.#ext#", detail = "#log#"};
				arrayAppend(message, str);
			}
		} else {
			action = "delete";
			log = "Student ID : " & name & " is not in database.";
			str = {error = "Invalid_ID", file = "#name#.#ext#", detail = "#log#"};
			arrayAppend(message, str);
		}
		if (action eq "delete") {
			fileDelete(#filePath#);
		}
		if (oldfilePath neq "") {
			fileDelete(#oldfilePath#);
		}
		return message;
	}


</cfscript>

		<!--- access these elements on page bulk image upload --->

		<!--- <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

		<br /> --->
		<!--- REQUEST.kernel.getController("sysadmin")
		<!--- <cfdump var="#REQUEST.kernel.getController('sysadmin')#" ><br /> --->
		REQUEST.kernel.getController("studadmin")
		<!--- <cfdump var="#REQUEST.kernel.getController('studadmin')#" ><br /> --->
		ATTRIBUTES:<br />
		<!--- <cfdump var="#CGI.ATTRIBUTES.forImport#" ><br /> --->
		REQUEST.user.checkPermsList():<br />
		<!--- <cfdump var="#REQUEST.user.checkPermsList('')#" ><br /> --->
		REQUEST.user.checkPermsList("PARACCDT"):<br />
		<!--- <cfdump var="#REQUEST.user.checkPermsList('PARACCDT')#" ><br /> --->
		REQUEST.user.checkPermsList("ADMBANUP"):<br />
		<!--- <cfdump var="#REQUEST.user.checkPermsList('ADMBANUP')#" ><br /> --->
		REQUEST.User.checkPermsList("GLJOURUP"):<br />
		<!--- <cfdump var="#REQUEST.user.checkPermsList('GLJOURUP')#" ><br /> --->
		REQUEST.user:<br />
		<!--- <cfdump var="#REQUEST.user#" ><br /> --->
		server.kernel.getControllers:<br />
		<!--- <cfdump var="#server.kernel.getControllers#" ><br /> --->
		server.kernel.getController("sysadmin"):<br />
		<!--- <cfdump var="#server.kernel.getController("sysadmin")#" ><br /> --->
		server.kernel.getPageTools():<br />
		<!--- <cfdump var="#server.kernel.getPageTools()#" ><br /> --->
		KERNEL:<br />
		<!--- <cfdump var="#server.kernel#" ><br /> --->
		get finance function returns structure:<br />
		<!--- <cfdump var="#server.kernel.getFinance()#" ><br /> --->
		system admin function returns structure:<br />
		<!--- <cfdump var="#server.kernel.getsysadmin()#" ><br /> --->
		URL:<br />
		<!--- <cfdump var="#URL#" ><br /> --->
		CGI:<br />
		<!--- <cfdump var="#CGI#" ><br /> --->
		jourAdmin:<br />
		<!--- <cfdump var="#jourAdmin#" ><br /> --->
		entityPerms:<br />
		<!--- <cfdump var="#entityPerms#" ><br /> --->
		server content:<br />
		<!--- <cfdump var="#server#" ><br /> --->
		SESSION content:<br />
		<!--- <cfdump var="#SESSION#" ><br /> --->
		REQUEST content:<br />
		<!--- <cfdump var="#REQUEST#" ><br /> --->
		strAdmin content:<br />
		<!--- <cfdump var="#strAdmin#" ><br /> ---> --->