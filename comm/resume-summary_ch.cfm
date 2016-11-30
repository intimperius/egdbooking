<cfoutput>

<cfif lang EQ "eng">
	<cfset language.bookingsSummary = "Bookings Summary">
  <cfset language.ScreenMessage = '<p>To start from the first booking record, clear the <em>From Date</em> field.  To end after the last booking record, clear the <em>To Date</em> field.  To see all records, clear both fields.</p>'>
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
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

<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.ScreenMessage = "<p>Pour d&eacute;buter au premier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de d&eacute;but&nbsp;&raquo;. Pour terminer apr&egrave;s le dernier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de fin&nbsp;&raquo;. Pour voir tous les dossiers, vider les deux champs.</p>">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
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
	<cfset language.calendar = "calendrier">
	<cfset language.clear = "effacer">
  
</cfif>

<cfsavecontent variable="js">
	<meta name="dcterms.title" content="#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#Language.masterKeywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.description" content="#language.description#" />
	<meta name="dcterms.subject" title="gccore" content="#Language.masterSubjects#" />
	<title>#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = language.bookingsSummary />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

				<h1 id="wb-cont">#language.bookingsSummary#</h1>

        <cfparam name="Variables.startDate1" default="#PacificNow#">
        <cfparam name="Variables.endDate1" default="#PacificNow#">

				<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<cfinclude template="#RootDir#includes/admin_menu.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/user_menu.cfm">
				</cfif>

        <cfif isDefined("Session.Return_Structure")>
          <cfinclude template="#RootDir#includes/getStructure.cfm">
        </cfif>
		
        	<form action="resume-summary.cfm?lang=#lang#" method="post" id="bookSumm">
					
					<fieldset><legend>#language.bookingsSummary#</legend> 
           <div>
              <label for="startDate1">#language.fromDate# <br>
			  <small><abbr title="#language.dateformexplanation#">#language.dateform# </abbr></small>
			  <br>
			  <cfif Variables.startDate1 neq "" and not isDate(Variables.startDate1)>
				<cfset Variables.startDate1 = #PacificNow# />
				<cfoutput><span class="uglyred">#language.invalidStartError#</span></cfoutput>
				</cfif>
			  </label>
              <input type="date" id="startDate1" name="startDate1" value="#DateFormat(variables.startDate1, 'yyyy-mm-dd')#">
            </div>
            <div>
              <label for="endDate1">#language.toDate# <br /><span class="datepicker-format">
			  <small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></span>
			   <br>
			  <cfif Variables.endDate1 neq "" and not isDate(Variables.endDate1)>
				<cfset Variables.endDate1 = #PacificNow# />
				<cfoutput><span class="uglyred">#language.invalidEndError#</span></cfoutput>
				</cfif>
				</label>
              <input type="date" id="endDate1" name="endDate1" value="#DateFormat(variables.endDate1, 'yyyy-mm-dd')#">
            </div>
            <div>
              <input type="submit" class="button button-accent" value="#language.submit#" />
            </div>
					</fieldset>
				</form>
				

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
