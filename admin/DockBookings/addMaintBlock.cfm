<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = "Create Maintenance Block">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Create Maintenance Block
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

	<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

	<!--- -------------------------------------------------------------------------------------------- --->
	<cfparam name="Variables.BRID" default="">
	<cfparam name="Variables.Section1" default="false">
	<cfparam name="Variables.Section2" default="false">
	<cfparam name="Variables.Section3" default="false">
	<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, PacificNow)#">
	<cfparam name="Variables.EndDate" default="#DateAdd('d', 1, PacificNow)#">

	<cfif IsDefined("Session.Return_Structure")>
		<cfinclude template="#RootDir#includes/getStructure.cfm">
		<cfif Variables.Section1 EQ 1>
			<cfset Variables.Section1 = true>
		<cfelse>
			<cfset Variables.Section1 = false>
		</cfif>
		<cfif Variables.Section2 EQ 1>
			<cfset Variables.Section2 = true>
		<cfelse>
			<cfset Variables.Section2 = false>
		</cfif>
		<cfif Variables.Section3 EQ 1>
			<cfset Variables.Section3 = true>
		<cfelse>
			<cfset Variables.Section3 = false>
		</cfif>
	</cfif>
	<cfif IsDefined("Session.form_Structure")>
		<cfinclude template="#RootDir#includes/restore_params.cfm">
		<cfif isDefined("form.startDate")>
			<cfset Variables.StartDate = #form.startDate#>
			<cfset Variables.EndDate = #form.endDate#>
			<cfif isDefined("form.section1")><cfset Variables.Section1 = true></cfif>
			<cfif isDefined("form.section2")><cfset Variables.Section2 = true></cfif>
			<cfif isDefined("form.section3")><cfset Variables.Section3 = true></cfif>
		</cfif>
	</cfif>


	<!--- -------------------------------------------------------------------------------------------- --->

<cfoutput>
	<form id="AddMaintBlock" action="addMaintBlock_process.cfm?#urltoken#" method="post">
		<input type="hidden" name="BRID" value="#Variables.BRID#" />
		<label for="startDate">Start Date:<br /><small>#language.dateform#</small></label>
		    <input type="text" id="startDate" name="startDate" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
		<label for="endDate">End Date:<br /><small>#language.dateform#</small></label>
		    <input type="text" id="endDate" name="endDate" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
		<br/>
		Please choose the sections of the dock that you wish to book for maintenance.
		<br/>
		<div class="form-checkbox">
			<label for="Section1">Section 1
			<input type="checkbox" id="Section1" name="Section1" checked="#Variables.Section1#" /></label>
			<label for="Section2">Section 2
			<input type="checkbox" id="Section2" name="Section2" checked="#Variables.Section2#" /></label>
			<label for="Section3">Section 3
			<input type="checkbox" id="Section3" name="Section3" checked="#Variables.Section3#" /></label>
		</div>
		<br/>
		<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
		<br />
		<a href="bookingManage.cfm?#urltoken#">Cancel</a>
	</form>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
