<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>
<cfif structKeyExists(form, 'm-m')>
	<cfset url['m-m'] = form['m-m'] />
</cfif>
<cfif structKeyExists(form, 'a-y')>
	<cfset url['a-y'] = form['a-y'] />
</cfif>
<cfif lang EQ "eng">
	<cfset language.description = "Allows user to view all bookings in the jetties in a given month.">
	<cfset language.keywords = "Calendar, one month view, 1 month view, drydock side">

<cfelse>
	<cfset language.description = "Permet &agrave; l'utilisateur de voir toutes les r&eacute;servations concernant les jet&eacute;es pour un mois donn&eacute;.">
	<cfset language.keywords = "Calendrier,  visualisation d'un mois, visualisation de 3 mois, secteur de la jet&eacute;e">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.jettyCalendar# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#Language.masterSubjects#"" />
	<title>#language.jettyCalendar# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.jettyCalendar>
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

				<h1 id="wb-cont"><cfoutput>#language.jettyCalendar#</cfoutput></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>

				<CFINCLUDE template="includes/calendar_variables.cfm">
				<cfset firstdayofbunch = CreateDate(url['a-y'], url['m-m'], 1)>
				<cfset lastdayofbunch = CreateDate(url['a-y'], url['m-m'], DaysInMonth(firstdayofbunch))>
				<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.BRID, Status,
						StartDate, EndDate,
						NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
						Vessels.Name AS VesselName, Vessels.VNID,
						Vessels.Anonymous
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
						INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
					WHERE	StartDate <= <cfqueryparam value="#lastdayofbunch#" cfsqltype="cf_sql_date" />
						AND EndDate >= <cfqueryparam value="#firstdayofbunch#" cfsqltype="cf_sql_date" />
						AND	Bookings.Deleted = '0'
						AND	Vessels.Deleted = '0'
			        ORDER BY 
			        CASE Status
			        	WHEN 'P' THEN 4
			            WHEN 'PT' THEN 4
			            WHEN 'PC' THEN 4
			            WHEN 'T' THEN 3
			            ELSE
			              CASE NorthJetty WHEN 1 THEN 1 ELSE
			                CASE SouthJetty WHEN 1 THEN 2 END
			              END
			          END
				</cfquery>

				<CFIF url['m-m'] eq 1>
					<CFSET prevmonth = 12>
					<CFSET prevyear = url['a-y'] - 1>
				<CFELSE>
					<CFSET prevmonth = url['m-m'] - 1>
					<CFSET prevyear = url['a-y']>
				</CFIF>

				<CFIF url['m-m'] eq 12>
					<CFSET nextmonth = 1>
					<CFSET nextyear = url['a-y'] + 1>
				<CFELSE>
					<CFSET nextmonth = url['m-m'] + 1>
					<CFSET nextyear = url['a-y']>
				</CFIF>

				<CFINCLUDE template="includes/calendar_core.cfm">

			<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
