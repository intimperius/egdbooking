<cfoutput>

<cfif structKeyExists(URL,'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Docks.Section1, Docks.Section2, Docks.Section3
	FROM 	Bookings INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE	Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
	<cfset request.title ="Confirm #variables.actionCap# Maintenance Block">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.BRID = Form.BRID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.Section1 = getBooking.Section1>
<cfset Variables.Section2 = getBooking.Section2>
<cfset Variables.Section3 = getBooking.Section3>

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
	Confirm #variables.actionCap# Maintenance Block
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
	</h1>

<cfinclude template="#RootDir#includes/admin_menu.cfm">

<cfif DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1>
	<cfinclude template="includes/getConflicts.cfm">
	<cfset conflictArray = getConflicts_remConf(Variables.BRID)>
	<cfif ArrayLen(conflictArray) GT 0>
		<cfset Variables.waitListText = "The booking slot that this maintenance block held is now available for the following tentative bookings. The companies/agents should be given 24 hours notice to claim this slot.">
		<cfinclude template="includes/displayWaitList.cfm">
	</cfif>
</cfif>


Please confirm the following maintenance block information.<br/><br/>
<form action="deleteMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
<input type="hidden" name="BRID" value="#Variables.BRID#" />

<div class="module-info widemod">
	<h2>Block Details</h2>
	<ul>
		<b>Start Date:</b> #DateFormat(Variables.Start, 'mmm d, yyyy')#<br/>
		<b>End Date:</b> #DateFormat(Variables.End, 'mmm d, yyyy')#<br/>
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


<br />
<div>
	<input type="submit" value="Delete" class="button button-accent" />
	<a href="bookingManage.cfm?#urltoken#">Cancel</a>
</div>

</form>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
