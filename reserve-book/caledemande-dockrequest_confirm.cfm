<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.newBooking = "Submit Drydock Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.to = "to">
	<cfset language.theVessel = "The vessel">
	<cfset language.tooLarge = "is too large for the dry dock">
	<cfset language.bookingConflicts = "The submitted booking request conflicts with other bookings.  The booking will be placed on a wait list if you choose to continue. Please confirm the following information.">
	<cfset language.bookingAvailable = "The requested time is available.  Please confirm the following information.">
	<cfset language.new = "New Booking">
	<cfset language.requestedStatus = "Requested Status">
	<cfset language.tplbookingError = "already has a booking for">
<cfelse>
	<cfset language.newBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.to = "au">
	<cfset language.theVessel = "Les dimensions du navire">
	<cfset language.tooLarge = "sont sup&eacute;rieures &agrave; celles de la cale s&egrave;che.">
	<cfset language.bookingConflicts = "La demande de r&eacute;servation pr&eacute;sent&eacute;e entre en conflit avec d'autres r&eacute;servations. La demande sera inscrite sur une liste d'attente si vous d&eacute;cidez de continuer. Veuillez confirmer les renseignements suivants.">
	<cfset language.bookingAvailable = "La p&eacute;riode demand&eacute;e est libre. Veuillez confirmer les renseignements suivants.">
	<cfset language.new = "Nouvelle r&eacute;servation">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour :">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.newBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.newBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>


				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
				</cfif>

				<cfset Errors = ArrayNew(1)>
				<cfset Success = ArrayNew(1)>
				<cfset Proceed_OK = "Yes">

				<!--- <cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput> --->

				<!--- Validate the form data --->
				<cfif DateCompare(Form.StartDate,Form.EndDate) EQ 1>
					<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfset Variables.VNID = Form.booking_VNID>
				<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
				<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>

				<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
					FROM 	Vessels, Companies
					WHERE 	VNID = '#Form.booking_VNID#'
					AND		Companies.CID = Vessels.CID
					AND 	Vessels.Deleted = 0
					AND		Companies.Deleted = 0
				</cfquery>

				<cfif getVessel.RecordCount EQ 0>
					<cfoutput>#ArrayAppend(Errors, "#language.noVesselError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<!---Check to see that vessel hasn't already been booked during this time--->
				<!--- 25 October 2005: This query now only looks at the drydock bookings --->
				<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.VNID, Vessels.Name, Bookings.StartDate, Bookings.EndDate
					FROM 	Bookings
								INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
								INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					WHERE 	Bookings.VNID = '#Variables.VNID#'
					AND
					<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates
						of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day
						bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than
						a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that
						fall within a booking that is more than one day.--->
							(
								(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.StartDate# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.StartDate# AND Bookings.EndDate <> #Variables.EndDate# AND
										((	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate)
									OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate)
									OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)))
							)
					AND		Bookings.Deleted = 0
					AND Docks.Status = 'C'
				</cfquery>

				<!--- 25 October 2005: The next two queries have been modified to only get results from the drydock bookings --->
				<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BRID, Vessels.Name, Bookings.StartDate
					FROM	Bookings
								INNER JOIN Docks ON Bookings.BRID = Docks.BRID
								INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
					WHERE	StartDate = #Variables.StartDate#
								AND Bookings.VNID = '#Variables.VNID#'
								AND Bookings.Deleted = 0
				</cfquery>

				<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BRID, Vessels.Name, Bookings.EndDate
					FROM	Bookings
								INNER JOIN Docks ON Bookings.BRID = Docks.BRID
								INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
					WHERE	EndDate = #Variables.EndDate#
								AND Bookings.VNID = '#Variables.VNID#'
								AND Bookings.Deleted = 0
				</cfquery>

				<cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
					<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif (isDefined("checkDblBooking.VNID") AND checkDblBooking.VNID NEQ "")>
					<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #LSdateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #LSdateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif getNumStartDateBookings.recordCount GTE 1>
					<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif getNumEndDateBookings.recordCount GTE 1>
					<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
					<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
						<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(CreateODBCDate(Form.StartDate), 'mmm d, yyyy')#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif getVessel.Width GT Variables.MaxWidth OR getVessel.Length GT Variables.MaxLength>
					<cfoutput>#ArrayAppend(Errors, "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif Proceed_OK EQ "No">
					<!--- Save the form data in a session structure so it can be sent back to the form page --->
					<cfset Session.Return_Structure.StartDate = Form.StartDate>
					<cfset Session.Return_Structure.EndDate = Form.EndDate>
					<cfset Session.Return_Structure.VNID = Form.booking_VNID>
					<cfset Session.Return_Structure.CID = Form.booking_CID>
					<cfset Session.Return_Structure.Status = Form.Status>
					<cfset Session.Return_Structure.Errors = Errors>

					<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
				</cfif>


				<!--- Gets all Bookings that would be affected by the requested booking --->
				<cfinclude template="#RootDir#reserve-book/includes/towerCheck.cfm">
				<cfset Variables.spaceFound = findSpace(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#)>
				<cfoutput>
				<p>
					<cfif NOT variables.spaceFound>
						#language.bookingConflicts#
					<cfelse>
						#language.bookingAvailable#
					</cfif>
				</p>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_action.cfm?lang=#lang#" method="post" id="bookingreq" preservedata="Yes">
				<h2>#language.new#:</h2>
					<fieldset>
						<label>#language.vessel#:</label>
						<p>#getVessel.VesselName#</p>
						<input type="hidden" name="VNID" value="#Variables.VNID#" />

						<label>#language.Company#:</label>
						<p>#getVessel.CompanyName#</p>

						<label>#language.StartDate#:</label>
						<input type="hidden" name="StartDate" value="#Variables.StartDate#" />
						<p>#LSDateFormat(Variables.StartDate, 'mmm d, yyyy')#</p>

						<label>#language.EndDate#:</label>
						<input type="hidden" name="EndDate" value="#Variables.EndDate#" />
						<p>#LSDateFormat(Variables.EndDate, 'mmm d, yyyy')#</p>

						<label>#language.requestedStatus#:</label>
						<input type="hidden" name="Status" value="#Form.Status#">
						<p><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></p>
					</fieldset>

					<div class="buttons">
						<input type="submit" value="#language.Submit#" class="textbutton" />
						<input type="button" value="#language.Back#" class="textbutton" onclick="self.location.href='bookingRequest.cfm?lang=#lang#'" />
						<input type="button" value="#language.Cancel#" class="textbutton" onclick="self.location.href='reserve-booking.cfm?lang=<cfoutput>#lang#</cfoutput>';" />
					</div>


				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
