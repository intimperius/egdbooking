<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking</title>">
	<cfset request.title = "Edit Jetty Booking Information">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

		
		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Jetty Booking Information
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- Error Validation ------------------------------------------------------------------------------------------------->
				<cfset Errors = ArrayNew(1)>
				<cfset Proceed_OK = "Yes">

				<cfparam name = "Form.StartDate" default="">
				<cfparam name = "Form.EndDate" default="">
				<cfparam name = "Variables.BRID" default="#Form.BRID#">
				<cfparam name = "Variables.StartDate" default = "#Form.StartDate#">
				<cfparam name = "Variables.EndDate" default = "#Form.EndDate#">
				<cfparam name = "Form.VNID" default="">
				<cfparam name = "Form.UID" default="">
				<cfparam name = "Variables.UID" default = "#Form.UID#">

				<cfset Variables.Jetty = Form.Jetty>

				<cfif (NOT IsDefined("Form.BRID") OR Form.BRID eq '') AND (NOT IsDefined("URL.BRID") OR URL.BRID eq '')>
					<cflocation addtoken="no" url="#RootDir#admin/DockBookings/bookingManage.cfm?#urltoken#">
				</cfif>

				<cfif Variables.StartDate EQ "">
					<cfoutput>#ArrayAppend(Errors, "The Start Date has not been entered in.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
				<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>

				<cfif IsDefined("Session.Return_Structure")>
					<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
				</cfif>

				<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Vessels.VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, Jetties.Status
					FROM 	Vessels, Companies, Bookings, Jetties
					WHERE 	Vessels.VNID = Bookings.VNID
					AND		Bookings.BRID = <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
					AND		Jetties.BRID = Bookings.BRID
					AND		Companies.CID = Vessels.CID
					AND 	Vessels.Deleted = 0
					AND		Companies.Deleted = 0
				</cfquery>
				<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	lastname + ', ' + firstname AS UserName
					FROM 	Users
					WHERE 	UID = <cfqueryparam value="#Variables.UID#" cfsqltype="cf_sql_integer" />
				</cfquery>
				<cfset Variables.VNID = getData.VNID>

				<!---Check to see that vessel hasn't already been booked during this time--->
				<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.VNID, Name, StartDate, EndDate
					FROM 	Bookings
								INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
								INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE 	Bookings.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
					AND 	Bookings.BRID != <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
					AND 	(
								(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
							OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
							OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)
							)
					AND		Bookings.Deleted = 0
					<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
						AND 	Jetties.NorthJetty = 1
					<cfelse>
						AND 	Jetties.SouthJetty = 1
					</cfif>
				</cfquery>

				<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyyy')>
				<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyyy')>
				<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
				<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

				<!--- Validate the form data --->
				<cfif Variables.StartDate GT Variables.EndDate>
					<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
					<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif checkDblBooking.RecordCount GT 0>
					<!---<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>--->
					<cfoutput><div style="border: 1px solid ##1F1FC9; border-style:dashed; background: ##F5F5F5; padding:25px;">#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.</div></cfoutput>
					<cfset Proceed_OK = "Yes">
				</cfif>

				<cfif getData.Width GTE Variables.MaxWidth OR getData.Length GTE Variables.MaxLength>
					<cfoutput>#ArrayAppend(Errors, "The vessel, #getData.VesselName#, is too large for the drydock.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif Proceed_OK EQ "No">
					<!--- Save the form data in a session structure so it can be sent back to the form page --->
					<cfset Session.Return_Structure.StartDate = Form.StartDate>
					<cfset Session.Return_Structure.EndDate = Form.EndDate>
					<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
					<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
					<cfset Session.Return_Structure.BRID = Form.BRID>
					<cfset Session.Return_Structure.VNID = Form.VNID>
					<cfset Session.Return_Structure.UID = Form.UID>
					<cfif Form.Jetty EQ "north">
						<cfset Session.Return_Structure.NorthJetty = 1>
						<cfset Session.Return_Structure.SouthJetty = 0>
					<cfelse>
						<cfset Session.Return_Structure.NorthJetty = 0>
						<cfset Session.Return_Structure.SouthJetty = 1>
					</cfif>

					<cfset Session.Return_Structure.Submitted = Form.Submitted>
					<cfset Session.Return_Structure.Errors = Errors>
					<cfif #Form.submitForm# neq 'overwrite'>
					<cflocation url="editJettyBooking.cfm?#urltoken##variables.dateValue#" addToken="no">
					</cfif>
				</cfif>

				<!---------------------------------------------------------------------------------------------------------------------->

				<p>Please confirm the following information.</p>
				<cfoutput>
				<form action="editJettyBooking_action.cfm?#urltoken#&BRID=#form.BRID#&editStart=#form.startDate#&editEnd=#form.endDate#&jetty=#form.jetty#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" id="bookingreq" preservedata="Yes">
				<cfoutput><input type="hidden" name="BRID" value="#Variables.BRID#" /></cfoutput>
				<div class="module-info widemod">
          <h2>Booking Details</h2>
					<ul>
            <b>Vessel:</b> <cfoutput>#getData.VesselName#</cfoutput><br/>
            <b>Company:</b> <cfoutput>#getData.CompanyName#</cfoutput><br/>
            <b>Agent:</b> <input type="hidden" name="UID" value="<cfoutput>#Variables.UID#</cfoutput>" /><cfoutput>#getAgent.UserName#</cfoutput><br/>
            <b>Start Date:</b> <input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput><br/>
            <b>End Date:</b> <input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput><br/>
            <b>Booking Time:</b> <cfoutput>
                <input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
                <input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
                #DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#
              </cfoutput><br/>
            <b>Length:</b> <cfoutput>#getData.Length# m</cfoutput><br/>
            <b>Width:</b> <cfoutput>#getData.Width# m</cfoutput><br/>
            <b>Sections:</b>
							<cfif Variables.Jetty EQ "north">
								North Landing Wharf
							<cfelseif Variables.Jetty EQ "south">
								South Jetty
							</cfif>
						</ul>
				</div>

				<br />
				<div style="text-align:center;">
						<input type="submit" value="Confirm" class="button button-accent" />
						<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='editJettyBooking.cfm?#urltoken#&BRID=#form.BRID##variables.dateValue#';" /></cfoutput>
						<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='#returnTo#?#urltoken#&BRID=#form.BRID##variables.dateValue####form.BRID#';" /></cfoutput>
				</div>
				</form>
				</cfoutput>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
