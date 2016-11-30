<cfset request.title = "Change Booking Status">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/JettyBookings/editJettyBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Jetties.Status, Bookings.BRID, StartDate, EndDate,
			Vessels.Name AS VesselName, Companies.Name AS CompanyName,
			Jetties.NorthJetty, Jetties.SouthJetty
	FROM	Jetties, Bookings, Vessels, Companies
	WHERE	Bookings.BRID = Jetties.BRID
	AND		Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	AND		Vessels.VNID = Bookings.VNID
	AND		Companies.CID = Vessels.CID
</cfquery>

<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
	<cfset Variables.Start = CreateODBCDate(form.StartDate)>
	<cfset Variables.End = CreateODBCDate(form.EndDate)>
<cfelse>
	<cfset Variables.Start = CreateODBCDate(getBooking.StartDate)>
	<cfset Variables.End = CreateODBCDate(getBooking.EndDate)>
</cfif>
<cfset Variables.Jetty = "North Landing Wharf">
<cfif getBooking.NorthJetty EQ 0>
	<cfset Variables.Jetty = "South Jetty">
</cfif>

		
		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Booking Status
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<p>Are you sure you want to deny the confirmation and change this booking's status to tentative?</p>
				<cfoutput>
				<form action="deny_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" id="deny">

					<input type="hidden" name="BRID" value="#Form.BRID#" />
					<div class="module-info widemod">
          <h2>Booking Details:</h2>
          <ul>
            <b>Vessel:</b> #getBooking.VesselName#<br/>
            <b>Company:</b> #getBooking.CompanyName#<br/>
            <b>Start Date</b> #DateFormat(Variables.Start, "mmm d, yyyy")#<br/>
            <b>End Date:</b> #DateFormat(Variables.End, "mmm d, yyyy")#<br/>
						<b>Jetty:</b> <cfoutput>#Variables.Jetty#</cfoutput>
            
          </ul>
					</div><br />

					<div>
					<input type="submit" value="Submit" class="button button-accent" />
					<br />
					<cfoutput><a href="#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#getBooking.BRID###id#getBooking.BRID#">Cancel</a></cfoutput>
					</div>
				</form>
				</cfoutput>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
