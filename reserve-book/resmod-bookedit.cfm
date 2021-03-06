<cfif lang EQ "eng">
	<cfset language.title = "Edit Booking">
	<cfset language.keywords = language.masterKeywords & ", Edit Booking">
	<cfset language.description = "Refers user to contact the administration for editing a booking.">
	<cfset language.subjects = language.masterSubjects & "">
  <cfset language.explanation = "Bookings cannot be edited online.  If you wish to edit your booking request details, please inform the Esquimalt Graving Dock via phone, fax or email, and fax a hard copy of the <em>Tentative Vessel and Booking Change Form</em>.  To receive a copy of the <em>Tentative Vessel and Booking Change Form</em>, contact the booking clerk:">
<cfelse>
	<cfset language.title = "Modification de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Modification de r&eacute;servation">
	<cfset language.description = "Invite l'utilisateur &agrave; communiquer avec l'administration pour modifier une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
  <cfset language.explanation = "Les r&eacute;servations ne peuvent &ecirc;tre modifi&eacute;es en ligne. Si vous voulez modifier les renseignements de votre demande de r&eacute;servation, veuillez en aviser la Cale s&egrave;che d'Esquimalt par t&eacute;l&eacute;phone, fax ou courriel, puis faites parvenir par fax une copie papier du <em>formulaire de modification d'une r&eacute;servation</em>.  Pour recevoir une copie du <em>formulaire de modification d'une r&eacute;servation</em>, communiquer avec le greffier de r&eacute;servation&nbsp;:">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
	<cfset request.title = language.title />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="#language.bookingHome#">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&amp;date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BRID = Docks.BRID
			LEFT JOIN	Jetties ON Bookings.BRID = Jetties.BRID
			INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN	Companies ON Vessels.CID = Companies.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" />
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

				<h1 id="wb-cont"><cfoutput>#language.title#</cfoutput></h1>

				<cfinclude template="#RootDir#includes/user_menu.cfm">
				<!------------------------------------------------------------------------------------------------------------>
				<cfoutput>
				<p>#language.explanation#</p>
				<cfset emailSubject = "#getbooking.CompanyName# editing booking for #trim(getbooking.VesselName)# from #myDateFormat(getbooking.StartDate, request.datemask)# to #myDateFormat(getbooking.EndDate, request.datemask)#">
				<p>
        #language.phone#<cfif lang eq "fra">&nbsp;</cfif>: 250-363-3879  #language.or#  250-363-8056<br />
					#language.fax#<cfif lang eq "fra">&nbsp;</cfif>: 250-363-8059<br />
					#language.emailAddress#<cfif lang eq "fra">&nbsp;</cfif>: 
         <a href="mailto:#variables.adminemail#?subject=#emailSubject#">
           #variables.adminemail#
         </a>
        </p>
				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

