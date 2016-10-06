<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFIF IsDefined('Form.BRID')>
	<CFSET Variables.BRID = Form.BRID>
<CFELSEIF IsDefined('URL.BRID')>
	<CFSET Variables.BRID = URL.BRID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
</CFIF>

<CFPARAM name="url.referrer" default="Jetty Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>


<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*,
			Users.LastName + ', ' + Users.FirstName AS UserName,
			Companies.Name AS CompanyName, Jetties.NorthJetty, Jetties.SouthJetty,
			Jetties.Status
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
			INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Users ON Bookings.UID = Users.UID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.action = "Cancel">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.action = "Delete">
</cfif>

<cfset request.title = "Confirm #variables.actionCap# Booking">
<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Booking</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">		
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	<cfoutput>Confirm #variables.actionCap# Booking</cfoutput>
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">


<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfform action="deleteJettyBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" id="delBookingConfirm">
	Are you sure you want to <cfoutput>#variables.action#</cfoutput> the following booking?<br/><br/>
	<input type="hidden" name="BRID" value="<cfoutput>#variables.BRID#</cfoutput>" />
	<cfoutput query="getBooking">
	
	<div class="module-info widemod">
		<h2>Booking Details</h2>
		<ul>
			<b>Vessel:</b> #vesselName#<br/>
			<b>Company:</b> #companyName#<br/>
			<b>Agent:</b> #UserName#<br/>
			<b>Start Date:</b> #dateformat(startDate, "mmm d, yyyy")#<br/>
			<b>End Date:</b> #dateformat(endDate, "mmm d, yyyy")#<br/>
			<b>## of Days:</b> #datediff('d', startDate, endDate) + 1#<br/>
			<b>Jetty:</b> <CFIF NorthJetty>North Landing Wharf
				<CFELSE>South Jetty
				</CFIF><br/>
			<b>Status:</b> <cfif status EQ 'c'>
					Confirmed
				<cfelse>
					Pending
				</cfif>
		</ul>
	</div>
	</cfoutput>
	<br />
	<div>
		<input type="submit" name="submitForm" class="button button-accent" value="<cfoutput>#variables.action#</cfoutput> Booking" />
		<br />
		<cfoutput><a href="#returnTo#?#urltoken#&BRID=#variables.BRID##variables.dateValue####variables.BRID#">Back</a></cfoutput>
	</div>

</cfform>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
