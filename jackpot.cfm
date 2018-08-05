<cfinclude template="balls_func.cfm" >
<head>
	<link rel="stylesheet" type="text/css" href="css/balls_style.css" >
	<title>Lorttery Simulator</title>
	<cfsilent>
		<!--- Get 8 random numbers and divided into 6 nor + 2 spe --->
			<cfset strArr = [] />
			<cfloop from="1" to="45" index="i">
				<cfset arrayAppend(strArr, i) >
			</cfloop>
			<cfset strList = arrayToList(strArr) />

		<!--- Build 8 arrays of numbers: --->
			<cfset arr1 = [1, 6, 8, 16, 18, 29, 30] >
			<cfset arr2 = [3, 5, 6, 27, 36, 37, 45] >
			<cfset arr3 = [13, 14, 27, 30, 32, 33, 34] >
			<cfset arr4 = [9, 13, 23, 26, 29, 35, 38] >
			<cfset arr5 = [4, 10, 22, 26, 32, 40, 44] >
			<cfset arr6 = [8, 16, 19, 20, 28, 33, 42] >
			<cfset arr7 = [8, 16, 19, 28, 29, 31, 42] >
			<cfset arr8 = [1, 9, 13, 14, 22, 37, 44] >
			<cfset arr9 = [2, 4, 10, 12, 15, 18, 25, 32, 39, 41, 44] >
			<cfset my_num = [arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8, arr9] >

	</cfsilent>
</head>

<body style="background-color: #fde7f9">

	<div class="header">
		<div class="logo">
			<img src="photos/dices.png" width="120" height="90">
			<h1>Gold Lott Matches</h1>
		</div>
		<div class="nav_menu">
			<ul>
				<li><a href="#chosen">Your Numbers</a></li>
				<li><a href="#result">Winning Numbers</a></li>
				<li><a href="#play">Rules</a></li>
			</ul>
		</div>
	</div>

	<!--- <div class="spacer">&nbsp;</div> --->
	<div class="content">
		<div id="play">
			<h2>How to PLAY:</h2>
			LOTT choose numbers from: <br />
			<!--- Choose numbers from 1 ~ 45 --->
			<cfoutput>
				<cfloop array="#strArr#" index="i" >
					#i#
				</cfloop>
			</cfoutput>
		</div>

		<div id="result">
			<h2>M/W (6+2) Lotto Draw:</h2>
			<cfset win_numbers ="" >
			
			<cfset objSelections = {} />

			<cfloop condition="(StructCount( objSelections ) LT 8)">
			    <cfset intIndex = RandRange( 1, ListLen( strList ) ) />
			    <cfset objSelections[ ListGetAt( strList, intIndex ) ] = true />
			</cfloop>
				<br /><br />
				<cfset n = 1 >
				<cfloop collection="#objSelections#" item="i">
				</cfloop>

				<cfset winStr = structNew() >
				win_numbers array:
				<cfset win_numbers = structKeyArray(objSelections) />
				<!--- <cfset win_numbers = [2, 15, 6, 18, 9, 40, 32, 10] /> --->
				<cfset winList = arrayToList(win_numbers) />
				<!--- <cfdump var="#win_numbers#" /> --->
				<cfset n = 0 >
				<cfset nor = 1 >
				<cfset spe = 1 >
				<cfloop array="#win_numbers#" index="i">
					<cfif n++ lt 6>
						<cfset winStr.normal[nor++] = #i# >
					<cfelse>
						<cfset winStr.special[spe++] = #i# >
					</cfif>
				</cfloop>
				<!--- <cfdump var="#winStr#" /> --->

				<cfset win_numbers_nor = []>
				<cfset win_numbers_spe = []>

			<cfoutput>
				<cfloop from="1" to="#arrayLen(win_numbers)#" index="i">
					<div class="container">
						<div class="balls" >
							<cfif i lt 7>
								<cfset arrayAppend(win_numbers_nor, win_numbers[i]) >
								<cfif win_numbers[i] lt 10>
									<p class="single normal">#win_numbers[i]#</p>
								<cfelse>
									<p class="double normal">#win_numbers[i]#</p>
								</cfif>
							<cfelse>
								<cfset arrayAppend(win_numbers_spe, win_numbers[i]) >
								<cfif win_numbers[i] lt 10>
									<p class="single special">#win_numbers[i]#</p>
								<cfelse>
									<p class="double special">#win_numbers[i]#</p>
								</cfif>
							</cfif>
						</div>
					</div>
				</cfloop>
			</cfoutput>
		</div>

		<div id="chosen">
			<h2>Numbers Chosen</h2>

			<cfoutput>
				<cfloop from="1" to="#arrayLen(my_num)#" index="i">

				<cfset num_nor = 0 >
				<cfset num_spe = 0 >
					<!--- <cfdump var="#my_num[i]#" /> --->
					<div class="row_container">
						<br />#i# :
						<cfloop array="#my_num[i]#" index="j">
							<div class="container">
								<div class="balls" >
									<cfif arrayContains(win_numbers_nor, j)>
										<cfset num_nor++ >
										<cfif j lt 10>
											<p class="single normal">#j#</p>
										<cfelse>
											<p class="double normal">#j#</p>
										</cfif>
									<cfelseif arrayContains(win_numbers_spe, j)>
										<cfset num_spe++ >
										<cfif j lt 10>
											<p class="single special">#j#</p>
										<cfelse>
											<p class="double special">#j#</p>
										</cfif>
									<cfelse>
										<cfif j lt 10>
											<p class="single">#j#</p>
										<cfelse>
											<p class="double">#j#</p>
										</cfif>
									</cfif>
								</div>
							</div>
						</cfloop>

						&nbsp;&nbsp;&nbsp;Prize:&nbsp;(#num_nor#&nbsp;+&nbsp;#num_spe#)&nbsp;#reward_cal(my_num[i], num_nor, num_spe)#
					</div>
				</cfloop>
			</cfoutput>
		</div>

		<div>
			<h2>Tue OZ Lotto Draw (70 Million Dollars!):</h2>
			<p>this is a long content</p>
			<p>this is a long content</p>
			<p>this is a long content</p>
			<p>this is a long content</p>
			<p>this is a long content</p>
			<p>this is a long content</p>
			<p>this is a long content</p>
		</div>
	</div>
</body>

<div class="footer">
	This is a footer.
</div>