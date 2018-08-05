<cfscript>
	
	function reward_cal (arr, nor, spe) {
		var output = "";
		var win_num = nor+spe;
		var length = ArrayLen(arr);
		var Cn = length - win_num;
		var Cm = 6 - win_num;
		var a = 1;
		var b = 1;
		var c = 1;
		var tickets = "";
		for (i=0;i<Cn;i++) {
			a *= (Cn - i);
		}

		for (i=0;i<Cm;i++) {
			b *= (Cm - i);
		}

		for (i=0;i<(Cn-Cm);i++) {
			c *= ((Cn - Cm) - i);
		}

		if (a*b*c neq 0) {
			tickets = a/(b*c);
		} else {
			tickets = 0;
		}


		if (nor eq 6) {
			output = "-----DIVISION 1----- X #tickets#";
		} else if (nor eq 5 AND (spe eq 1 OR spe eq 2)) {
			output = "-----DIVISION 2----- X #tickets#";
		} else if (nor eq 5) {
			output = "-----DIVISION 3----- X #tickets#";
		} else if (nor eq 4) {
			output = "-----DIVISION 4----- X #tickets#";
		} else if (nor eq 3 AND (spe eq 1 OR spe eq 2)) {
			output = "-----DIVISION 5----- X #tickets#";
		} else if ((nor eq 2 OR nor eq 1) AND spe eq 2) {
			output = "-----DIVISION 6----- X #tickets#";
		} else {
			output = "no reward";
		}
		// output &= " Cm: #Cm#, Cn: #Cn# abc: #a#, #b#, #c#";
		return output;
	}

</cfscript>