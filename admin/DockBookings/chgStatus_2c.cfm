<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>">
	<cfset request.title ="Change Booking Status">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/DockBookings/editBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>
<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Confirm Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<!--- -------------------------------------------------------------------------------------------- --->
<cfparam name="Variables.BRID" default="">
<cfparam name="Variables.Section1" default="false">
<cfparam name="Variables.Section2" default="false">
<cfparam name="Variables.Section3" default="false">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
<cfelseif IsDefined("Form.BRID")>
	<cfset Variables.BRID = Form.BRID>
<cfelse>
	<cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
</cfif>

<cfinclude template="includes/getConflicts.cfm">
<cfset conflictArray = getConflicts_Conf(Variables.BRID)>
<cfif ArrayLen(conflictArray) GT 0>
	<cfset Variables.waitListText = "The following vessels are on the wait list ahead of this booking.  The companies/agents should be given 24 hours notice to submit a downpayment.">
	<cfinclude template="includes/displayWaitList.cfm">
</cfif>

<cfinclude template="includes/getOverlaps.cfm">
<cfset overlapQuery = getOverlaps_Conf(Variables.BRID)>
<cfif overlapQuery.RecordCount GT 0>
<div class="critical">
	<p>This vessel has other overlapping bookings listed below:</p>
	<table class="table-condensed">
		<tr>
			<th id="Booked" align="left">Booked</th>
			<th id="Vessel" align="left">Vessel</th>
			<th id="Dates" align="left">Docking Dates</th>
			<th align=left>Status</th>
		</tr>
		<cfloop query="overlapQuery">
		<cfoutput>
		<tr valign="top">
			<td headers="Booked" valign="top">#DateFormat(overlapQuery.BookingTime, 'mmm dd, yyyy')#<br />at #TimeFormat(overlapQuery.BookingTime, 'H:mm')#</td>
			<td headers="Vessel" valign="top">#trim(overlapQuery.Name)#</td>
			<td headers="Dates" valign="top">#DateFormat(overlapQuery.StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(overlapQuery.StartDate, ", yyyy")#</CFIF> -<br />#DateFormat(overlapQuery.EndDate, "mmm d, yyyy")#</td>
			<td headers="Vessel" valign="top">
			<cfif #trim(overlapQuery.Status)# EQ "C">Confirmed
			<cfelseif #trim(overlapQuery.Status)# EQ "T">Tentative
			<cfelseif #trim(overlapQuery.Status)# EQ "PT">Pending
			<cfelse>Cancelling
			</cfif>
			</td>
		</tr>
		</cfoutput>
</cfloop>
	</table>
</div>
</cfif>

<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	BRID, StartDate, EndDate, Vessels.VNID, Vessels.Length, Vessels.Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, BookingTime
	FROM	Bookings, Vessels, Companies
	WHERE	Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
	AND		Vessels.VNID = Bookings.VNID
	AND		Companies.CID = Vessels.CID
</cfquery>

<cfset Variables.VNID = theBooking.VNID>
<cfset Variables.VesselName = theBooking.VesselName>
<cfset Variables.CompanyName = theBooking.CompanyName>
<cfset Variables.Start = CreateODBCDate(theBooking.StartDate)>
<cfset Variables.End = CreateODBCDate(theBooking.EndDate)>

<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
	<cfset Variables.Start = CreateODBCDate(form.StartDate)>
	<cfset Variables.End = CreateODBCDate(form.EndDate)>
</cfif>

<cfinclude template="includes/towerCheck.cfm">

<cfset Variables.reOrder = BookingTower.ReorderTower()>
<cfif NOT Variables.reOrder> <!--- Check if the booking can be slotted in without problems --->
	<cflock scope="session" type="exclusive" timeout="30">
		<cfset Session.PassStructure.reOrder = false>
	</cflock>
	<p>The submitted booking request conflicts with other bookings.  Would you like to add the booking anyway?</p>

<cfelse>
	<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
		<cfset Session.PassStructure = StructNew()>
		<cfset Session.PassStructure.Tower = BookingTower.getTower()>
		<cfset Session.PassStructure.reOrder = true>
	</cflock>

	<p>Please confirm the following information.</p>
</cfif>
			<!--- -------------------------------------------------------------------------------------------- --->
<cfoutput>
<form id="BookingConfirm" action="chgStatus_2c_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post">
<input type="hidden" name="BRID" value="#Variables.BRID#" />
<div class="module-info widemod">
	<h2>Booking Details</h2>
	<ul>
		<b>Vessel:</b><input type="hidden" name="VNID" value="<cfoutput>#Variables.VNID#</cfoutput>" /><cfoutput>#Variables.VesselName#</cfoutput><br/>
		<b>Company:</b><cfoutput>#Variables.CompanyName#</cfoutput><br/>
		<b>Start Date:</b><cfoutput>#DateFormat(Variables.Start,"mmm dd, yyyy")#</cfoutput><br/>
		<b>End Date:</b><cfoutput>#DateFormat(Variables.End,"mmm dd, yyyy")#</cfoutput><br/>
	</ul>
</div>
<br/>	
Please choose the sections of the dock that you wish to book.<br/>
<div class="form-checkbox">	
	<label for="Section1">Section 1
		<input type="checkbox" id="Section1" name="Section1" <CFIF Section1>checked="true"</CFIF> />
	</label>
		<label for="Section2">Section 2
		<input type="checkbox" id="Section2" name="Section2" <CFIF Section2>checked="true"</CFIF> />
	</label>
		<label for="Section3">Section 3
		<input type="checkbox" id="Section3" name="Section3" <CFIF Section3>checked="true"</CFIF> />
	</label>
</div>
<br/>
<input type="submit" value="Confirm" class="button button-accent" />
		<cfoutput><a href="#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Variables.BRID###id#Variables.BRID#">Cancel</a></cfoutput>
	
<cfif NOT Variables.reOrder>
	<cfinclude template="#RootDir#includes/showConflicts.cfm">
</cfif>

</form>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
