<cfoutput>

<cfif lang EQ "eng">
	<cfset language.bookingsSummaryDateSelection = "Consult the public summary of bookings">
	<cfset language.ScreenMessage = '<p>If you would like to view a public summary of bookings of the Drydock, the North Landing Wharf and the South Jetty facilities at the Esquimalt Graving Dock without signing in or registering an account, first select a facility and then, select a period of time.</p>'>
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
	<cfset language.fromDate = "From Date:">
	<cfset language.toDate = "To Date:">
	<cfset language.InvalidFromDate = "Please enter a valid From Date.">
	<cfset language.InvalidToDate = "Please enter a valid To Date.">
	<cfset language.reset = "reset">
	<cfset language.calendar = "calendar">
	<cfset language.clear = "clear">
	<cfset language.timePeriod = "Select a time period:">
	<cfset language.seeRecords = "To see all records, clear both fields">
<cfelse>
	<cfset language.bookingsSummaryDateSelection = "tbd">
	<cfset language.ScreenMessage = "<p>tbd</p>">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
	<cfset language.fromDate = "Date de d&eacute;but&nbsp;:">
	<cfset language.toDate = "Date de fin&nbsp;:">
	<cfset language.InvalidFromDate = "Veuillez entrer une date de d&eacute;but valide.">
	<cfset language.InvalidToDate = "Veuillez entrer une date de fin valide.">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.calendar = "Calendrier">
	<cfset language.clear = "effacer">
	<cfset language.timePeriod = "tbd:">
	<cfset language.seeRecords = "tbd">

</cfif>
<cfsavecontent variable="js">
	<title>#language.bookingsSummaryDateSelection# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = language.bookingsSummaryDateSelection />

				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingsSummaryDateSelection#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<cfparam name="Variables.startDate" default="#PacificNow#">
				<cfparam name="Variables.endDate" default="12/31/2031">

				<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<cfinclude template="#RootDir#includes/admin_menu.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/user_menu.cfm">
				</cfif>

        <cfif isDefined("Session.Return_Structure")>
          <cfinclude template="#RootDir#includes/getStructure.cfm">
        </cfif>
		
		#Language.ScreenMessage#
		<br />
		<p><strong>#language.timePeriod#</strong><br />
		#language.seeRecords#</p>

				<form action="#RootDir#utils/resume-summary.cfm?lang=#lang#" method="post" id="bookSum">
					<fieldset>
            <legend>#language.bookingsSummary#</legend>
            <div>
              <label for="start">#language.fromDate#<br />
			  <small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
				<br>
				 <cfif Variables.startDate neq "" and not isDate(Variables.startDate)>
				<cfset Variables.startDate = "" />
				<cfoutput><span class="uglyred">#language.invalidStartError#</span></cfoutput>
				</cfif>
				</label>
			  <input type="date" id="start" name="startDate" value="#DateFormat(variables.startDate, 'yyyy-mm-dd')#">
            </div>
            
            <div>
              <label for="end">#language.toDate#<br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
			  <br>
					<cfif Variables.endDate neq "" and not isDate(Variables.endDate)>
					<cfset Variables.endDate = "" />
					<cfoutput><span class="uglyred">#language.invalidEndError#</span></cfoutput>
					</cfif>  
			  </label>
			  <input type="date" id="end" name="endDate" value="#DateFormat(variables.endDate, 'yyyy-mm-dd')#">
            </div>

            <div>
              <input type="submit" class="button button-accent" value="#language.submit#" />
            </div>
					</fieldset>
				</form>
</cfoutput>
