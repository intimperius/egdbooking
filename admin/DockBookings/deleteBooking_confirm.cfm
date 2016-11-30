<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFIF IsDefined('Form.BRID')>
	<CFSET Variables.BRID = Form.BRID>
<CFELSEIF IsDefined('URL.BRID')>
	<CFSET Variables.BRID = URL.BRID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
</CFIF>

<CFPARAM name="url.referrer" default="Drydock Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>


<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*,
			Users.LastName + ', ' + Users.FirstName AS UserName,
			Companies.Name AS CompanyName, Docks.Section1, Docks.Section2, Docks.Section3,
			Docks.Status
	FROM 	Bookings INNER JOIN Docks ON Bookings.BRID = Docks.BRID
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

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Booking</title>">
<cfset request.title ="Confirm Cancel Booking">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	<cfoutput>Confirm #variables.actionCap# Booking</cfoutput>
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif getBooking.Status EQ 'c' AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1>
	<cfinclude template="includes/getConflicts.cfm">
	<cfset conflictArray = getConflicts_remConf(Variables.BRID)>
	<cfif ArrayLen(conflictArray) GT 0>
		<cfset Variables.waitListText = "The booking slot that this vessel held is now available for the following tentative bookings. The companies/agents should be given 24 hours notice to claim this slot.">
		<cfinclude template="includes/displayWaitList.cfm">
	</cfif>
</cfif>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfoutput query="getBooking">
<form action="deleteBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" id="delBookingConfirm">
	Are you sure you want to <b>Delete</b> the following booking?<br/><br/>
	<input type="hidden" name="BRID" value="<cfoutput>#Variables.BRID#</cfoutput>" />
	

	<div class="module-info widemod">
		<h2>Booking Details</h2>
	<ul>
		<b>Company:</b> #companyName#<br/>
		<b>Agent:</b> #UserName#<br/>
		<b>Vessel:</b> #vesselName#<br/>
		<b>Start Date:</b> #dateformat(startDate, "mmm d, yyyy")#<br/>
		<b>End Date:</b> #dateformat(endDate, "mmm d, yyyy")#<br/>
		<b>## of Days:</b> #datediff('d', startDate, endDate) + 1#<br/>
		<b>Section(s):</b> <CFIF Section1>Section 1</CFIF>
			<CFIF Section2><CFIF Section1> &amp; </CFIF>Section 2</CFIF>
			<CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>Section 3</CFIF>
			<CFIF NOT Section1 AND NOT Section2 AND NOT Section3>Unassigned</CFIF><br/>
		<b>Status:</b> <cfif status EQ 'c'>
				Confirmed
			<cfelseif status EQ 't'>
				Tentative
			<cfelse>
				Pending
			</cfif><br/>
	</ul>
	</div>
<br/>
	<div>
		<input type="submit" name="submitForm" class="button button-accent" value="Delete" />
		<br />
		<a href="#returnTo#?#urltoken#&BRID=#variables.BRID##variables.dateValue###id#variables.BRID#">Cancel</a>
	</div>

</form>
</cfoutput>


<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
