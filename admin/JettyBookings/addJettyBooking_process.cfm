<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>
<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

<!---Check to see that vessel hasn't already been booked during this time--->
<!--- 25 October 2005: This query now only looks at the jetties bookings --->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VesselID, Bookings.BookingID, Name, Bookings.StartDate, Bookings.EndDate
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE 	Bookings.VesselID = '#Form.VesselID#'
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
	<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
		AND Jetties.NorthJetty = 1
	<cfelse>
		AND Jetties.SouthJetty = 1
	</cfif>

</cfquery>


<!--- 25 October 2005: The next two queries have been modified to only get results from the jetties bookings --->
<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.StartDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	(StartDate = #Variables.StartDate# OR EndDate = #Variables.StartDate#)
				AND Bookings.VesselID = '#Form.VesselID#'
				AND Bookings.Deleted = 0
			<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
				AND Jetties.NorthJetty = 1
			<cfelse>
				AND Jetties.SouthJetty = 1
			</cfif>
</cfquery>

<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.EndDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	(EndDate = #Variables.EndDate# OR StartDate = #Variables.EndDate#)
				AND Bookings.VesselID = '#Form.VesselID#'
				AND Bookings.Deleted = 0
			<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
				AND Jetties.NorthJetty = 1
			<cfelse>
				AND Jetties.SouthJetty = 1
			</cfif>
</cfquery>


<cfparam name="Form.Jetty" default="off">
<cfparam name="Form.confirmed" default="off">

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif DateCompare(PacificNow, Form.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "The Start Date cannot be in the past.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif isDefined("checkDblBooking.VesselID") AND checkDblBooking.VesselID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumStartDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# already has a booking for #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumEndDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# already has a booking for #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Form.StartDate GT Form.EndDate>
	<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">

	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.compID = Form.compID>
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
	<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
	<cfset Session.Return_Structure.VesselID = Form.vesselID>
	<cfset Session.Return_Structure.userID = Form.userID>
	<cfset Session.Return_Structure.Jetty = Form.Jetty>
	<cfset Session.Return_Structure.Status = Form.Status>
	<cfset Session.Return_Structure.Errors = Errors>

<cfif form.submitForm NEQ 'override'>
 	<cflocation url="addJettyBooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addToken="no">
</cfif>
</cfif>


<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
<cfparam name = "Variables.NorthJetty" default = "0">
<cfparam name = "Variables.SouthJetty" default = "0">
<cfparam name = "Variables.Status" default="pending">

<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
	<cfset Variables.NorthJetty = 1>
</cfif>
<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "south">
	<cfset Variables.SouthJetty = 1>
</cfif>
<cfif IsDefined("Form.status")>
	<cfset Variables.Status = Form.Status>
</cfif>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	Companies.CompanyID = #form.CompanyID#
</cfquery>
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Vessels
	WHERE	Vessels.VesselID = #form.VesselID#
</cfquery>
<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	firstname + ' ' + lastname AS Name
	FROM	Users
	WHERE	Users.UserID = #form.UserID#
</cfquery>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Add Jetty Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add Jetty Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<!--- ---------------------------------------------------------------------------------------------------------------- --->


				<!-- Gets all Bookings that would be affected by the requested booking --->
				<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
				<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>

				<p>Please confirm the following maintenance block information.</p>
				<cfform action="addJettyBooking_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post" id="bookingreq" preservedata="Yes">
				<div style="font-weight:bold;">Booking:</div>
				<table style="width:100%;" align="center">
					<tr>
						<td align="left" style="width:20%;">Company:</td>
						<td><input type="hidden" name="company" value="<cfoutput>#form.companyID#</cfoutput>" />
					</tr>
					<tr>
						<td align="left">Vessel:</td>
						<td><input type="hidden" name="vessel" value="<cfoutput>#form.vesselID#</cfoutput>" />
					</tr>
					<tr>
						<td align="left">Agent:</td>
						<td><input type="hidden" name="agent" value="<cfoutput>#form.userID#</cfoutput>" />
					</tr>
					<tr>
						<td align="left">Start Date:</td>
						<td><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td align="left">End Date:</td>
						<td><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td id="bookingDate" align="left">Booking Time:</td>
						<td headers="bookingDate">
							<cfoutput>
								<input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
								<input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
								#DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td align="left">Status:</td>
						<td><input type="hidden" name="Status" value="<cfoutput>#Variables.Status#</cfoutput>"><cfif Variables.Status EQ "P">Pending<cfelseif Variables.Status EQ "T" />
					</tr>
					<tr>
						<td align="left">Section:</td>
						<td>
							<input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>" />
							<input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>" />
							<cfif Variables.NorthJetty EQ 1>
								North Landing Wharf
							<cfelseif Variables.SouthJetty EQ 1>
								South Jetty
							</cfif>
						</td>
					</tr>
				</table>

				<br />
				<table style="width:100%;" cellspacing="0" cellpadding="1" border="0">
					<tr>
						<td colspan="2" align="center">
							<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
							<a href="javascript:history.go(-1);" class="textbutton">Back</a>
							<cfoutput><a href="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Cancel</a></cfoutput>
							<br--->
							<input type="submit" value="submit" class="textbutton" />
							<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='addJettyBooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#'" /></cfoutput>
							<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='jettybookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#';" /></cfoutput>
						</td>
					</tr>
				</table>

				</cfform>
				</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
