<cfoutput>
<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>">
	<cfset request.title ="Edit Maintenance Block">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Edit Maintenance Block
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<!--- ---------------------------------------------------------------------------------------------------------------- --->
<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
<cfparam name = "Variables.Section1" default = "0">
<cfparam name = "Variables.Section2" default = "0">
<cfparam name = "Variables.Section3" default = "0">
<cfparam name = "Variables.BRID" default = "#Form.BRID#">

<cfif IsDefined("Form.Section1")>
	<cfset Variables.Section1 = 1>
</cfif>
<cfif IsDefined("Form.Section2")>
	<cfset Variables.Section2 = 1>
</cfif>
<cfif IsDefined("Form.Section3")>
	<cfset Variables.Section3 = 1>
</cfif>

<cfif Variables.StartDate EQ "">
	<cflocation addtoken="no" url="editBooking.cfm?lang=#lang#">
</cfif>

<!--- <cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)> --->

<cfif IsDefined("Session.Return_Structure")>
	#StructDelete(Session, "Return_Structure")#
</cfif>


<!---Do a check on Double Maintenance Bookings--->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Section1, Section2, Section3, StartDate, EndDate
	FROM 	Bookings, Docks
	WHERE 	Docks.BRID = Bookings.BRID
	AND		Bookings.BRID != <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	AND		Status = 'M'
	AND		Deleted = '0'
	AND 	(
				(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
			)
	AND		(
				(	Section1 = '1' AND <cfqueryparam value="#Variables.Section1#" cfsqltype="cf_sql_bit" /> = '1')
			OR	( 	Section2 = '1' AND <cfqueryparam value="#Variables.Section2#" cfsqltype="cf_sql_bit" /> = '1')
			OR	( 	Section3 = '1' AND <cfqueryparam value="#Variables.Section3#" cfsqltype="cf_sql_bit" /> = '1')
			)
</cfquery>


<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyy')>
<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyy')>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif (NOT isDefined("Form.Section1")) AND (NOT isDefined("Form.Section2")) AND (NOT isDefined("Form.Section3"))>
	#ArrayAppend(Errors, "You must choose at least one section of the dock for confirmed bookings.")#
	no sections
	<cfset Proceed_OK = "No">
</cfif>

<cfif checkDblBooking.RecordCount GT 0>
	<cfif checkDblBooking.section1 AND checkDblBooking.section2 AND checkDblBooking.section3>
		#ArrayAppend(Errors, "There is already a maintenance booking for all sections of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	<cfelseif checkDblBooking.section1 AND checkDblBooking.section2>
		#ArrayAppend(Errors, "There is already a maintenance booking for sections 1 and 2 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	<cfelseif checkDblBooking.section3 AND checkDblBooking.section2>
		#ArrayAppend(Errors, "There is already a maintenance booking for sections 2 and 3 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	<cfelseif checkDblBooking.section3>
		#ArrayAppend(Errors, "There is already a maintenance booking for section 3 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	<cfelseif checkDblBooking.section2>
		#ArrayAppend(Errors, "There is already a maintenance booking for section 2 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	<cfelseif checkDblBooking.section1>
		#ArrayAppend(Errors, "There is already a maintenance booking for section 1 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#
	</cfif>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Variables.StartDate GT Variables.EndDate>
	#ArrayAppend(Errors, "The Start Date must be before the End Date.")#
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
	#ArrayAppend(Errors, "The minimum booking time is 1 day.")#
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1 AND DateCompare(PacificNow, Variables.EndDate, 'd') EQ 1>
	#ArrayAppend(Errors, "This maintenance period has ended. Please create a new block.")#
	<cfset Proceed_OK = "No">
<!--- <cfelseif checkDblBooking.RecordCound GT 0>
	#ArrayAppend(Errors, "There are section already been booked for maintenance during this time.")#
	<cfset Proceed_OK = "No"> --->
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Variables.StartDate>
	<cfset Session.Return_Structure.EndDate = Variables.EndDate>
	<cfset Session.Return_Structure.Section1 = Variables.Section1>
	<cfset Session.Return_Structure.Section2 = Variables.Section2>
	<cfset Session.Return_Structure.Section3 = Variables.Section3>

	<cfset Session.Return_Structure.Errors = Errors>

	<cflocation url="editMaintBlock.cfm?#urltoken#" addToken="no">
</cfif>

<!-- Gets all Bookings that would be affected by the maintenance block --->
<cfquery name="checkConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Section1, Section2, Section3, StartDate, EndDate, V.Name AS VesselName, C.Name AS CompanyName
	FROM	Bookings B INNER JOIN Docks D ON B.BRID = D.BRID
				INNER JOIN Vessels V ON V.VNID = B.VNID
				INNER JOIN Companies C ON C.CID = V.CID
	WHERE	Status = 'c'
		AND	B.Deleted = '0'
		AND	V.Deleted = '0'
		AND	EndDate >= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date">
		AND StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date">
		AND	(<CFIF Variables.Section1>Section1 = '1'</CFIF>
		<CFIF Variables.Section2><CFIF Variables.Section1>OR	</CFIF>Section2 = '1'</CFIF>
		<CFIF Variables.Section3><CFIF Variables.Section1 OR Variables.Section2>OR</CFIF>	Section3 = '1'</CFIF>)
</cfquery>


<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>

<CFIF checkConflicts.RecordCount GT 0>

	<p>The requested date range for the maintenance block <strong class="red">conflicts</strong> with the following bookings:</p>

	<table class="table-condensed">
	<tr align="left" valign="top">
		<th>Period</th>
		<th>Vessel</th>
		<th>Company</th>
		<th style="width:15%;">Sections</th>
	</tr>

	<cfset counter = 0>
	<cfloop query="checkConflicts">
		<CFIF counter mod 2 eq 1>
			<CFSET rowClass = "highlight">
		<CFELSE>
			<CFSET rowClass = "">
		</CFIF>
		<tr class="#rowClass#" valign="top">
			<td>#LSdateformat(startDate, 'mmm d')#<CFIF Year(StartDate) neq Year(EndDate)>, #DateFormat(startDate, 'yyyy')#</CFIF> - #LSdateformat(endDate, 'mmm d, yyyy')#</td>
			<td>#VesselName#</td>
			<td>#CompanyName#</td>
			<td align="center">
				<cfif Section1 EQ 1>1 </cfif>
				<cfif Section2 EQ 1>2 </cfif>
				<cfif Section3 EQ 1>3 </cfif>
			</td>
		</tr>
		<cfset counter = counter + 1>
</cfloop>	
	</table>

	<p>If you would like to go ahead and book the maintenance block, please <strong class="red">confirm</strong> the following information, or <strong class="red">go back</strong> to change the information.</p>

<CFELSE>
	<p>Please confirm the following maintenance block information.</p>
</CFIF>

<form action="editMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
<input type="hidden" name="BRID" value="#Variables.BRID#" />

<div class="module-info widemod">
	<h2>Booking Details</h2>
	<ul>
		<b>Start Date:</b> <input type="hidden" name="StartDate" value="#Variables.StartDate#" />#DateFormat(Variables.StartDate, 'mmm d, yyyy')#<br/>
		<b>End Date:</b> <input type="hidden" name="EndDate" value="#Variables.EndDate#" />#DateFormat(Variables.EndDate, 'mmm d, yyyy')#<br/>
		<b>Sections:</b> 
			<input type="hidden" name="Section1" value="#Variables.Section1#" />
			<input type="hidden" name="Section2" value="#Variables.Section2#" />
			<input type="hidden" name="Section3" value="#Variables.Section3#" />
			<cfif Variables.Section1 EQ 1>
				Section 1
			</cfif>
			<cfif Variables.Section2 EQ 1>
				<cfif Variables.Section1 EQ 1>
					&amp;
				</cfif>
				Section 2
			</cfif>
			<cfif Variables.Section3 EQ 1>
				<cfif Variables.Section1  EQ 1 OR Variables.Section2 EQ 1>
					&amp;
				</cfif>
				Section 3
			</cfif><br/>
	</ul>
</div>
<br/>
	<input type="submit" value="Submit" class="button button-accent" />
	<a href="editMaintBlock.cfm?#urltoken#" class="textbutton">Back</a>
	<a href="bookingManage.cfm?#urltoken#">Cancel</a>
</form>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
