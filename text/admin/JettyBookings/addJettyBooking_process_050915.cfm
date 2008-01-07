<!---
EDIT 050915 1118
ANDREW LEUNG

ATTEMPT TO VARIABLE INCONSISTANCY

When adding a Jetty Booking (admin), these error messages were displayed:
"Element ENDDATE is undefined in VARIABLES."
"Element STARTDATE is undefined in VARIABLES."
There were variable naming inconsistancies in this particular file.
Variables.StartDate and Variables.EndDate were referenced but only
Variables.Start and Variables.End were declared.

Fix: Changed all Variables.Start to Variables.StartDate
Fix: Changed all Variables.End to Variables.EndDate
--->
<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfset Variables.Start = CreateODBCDate(Form.StartDate)>
<cfset Variables.End = CreateODBCDate(Form.EndDate)>

<!---Check to see that vessel hasn't already been booked during this time--->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VesselID, Name, StartDate, EndDate
	FROM 	Bookings, Vessels
	WHERE 	Bookings.VesselID = '#Form.VesselID#'
	AND		Vessels.VesselID = Bookings.VesselID
	AND 	
	<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates 
		of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day 
		bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than 
		a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that 
		fall within a booking that is more than one day.--->
			(
				(	Bookings.StartDate <= #Variables.Start# AND #Variables.Start# < Bookings.EndDate AND #Variables.Start# <> #Variables.End# AND Bookings.StartDate <> Bookings.EndDate)
			OR 	(	Bookings.StartDate < #Variables.End# AND #Variables.End# <= Bookings.EndDate AND #Variables.Start# <> #Variables.End# AND Bookings.StartDate <> Bookings.EndDate)
			OR	(	Bookings.StartDate >= #Variables.Start# AND #Variables.End# >= Bookings.EndDate AND #Variables.Start# <> #Variables.End# AND Bookings.StartDate <> Bookings.EndDate)
			OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.Start# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.Start# AND Bookings.EndDate <> #Variables.End# AND 
						((	Bookings.StartDate <= #Variables.Start# AND #Variables.Start# < Bookings.EndDate)
					OR 	(	Bookings.StartDate < #Variables.End# AND #Variables.End# <= Bookings.EndDate)
					OR	(	Bookings.StartDate >= #Variables.Start# AND #Variables.End# >= Bookings.EndDate)))
			)
	AND		Bookings.Deleted = 0
</cfquery>

<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	BookingID, Vessels.Name, StartDate
	FROM	Bookings, Vessels
	WHERE	(StartDate = #Variables.StartDate# OR EndDate = #Variables.StartDate#) AND Bookings.VesselID = '#Form.VesselID#'
	AND		Vessels.VesselID = Bookings.VesselID
</cfquery>

<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	BookingID, Vessels.Name, EndDate
	FROM	Bookings, Vessels
	WHERE	(EndDate = #Variables.EndDate# OR StartDate = #Variables.EndDate#) AND Bookings.VesselID = '#Form.VesselID#'
	AND		Vessels.VesselID = Bookings.VesselID
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
<cfelseif getNumStartDateBookings.recordCount GTE 2>
	<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# already has two bookings for #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumEndDateBookings.recordCount GTE 2>
	<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# already has two bookings for #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
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
	<cfset Session.Return_Structure.VesselID = Form.vesselID>
	<cfset Session.Return_Structure.userID = Form.userID>
	<cfset Session.Return_Structure.Jetty = Form.Jetty>
	<cfif Form.confirmed EQ "on">
		<cfset Session.Return_Structure.confirmed = "true">
	<cfelse>
		<cfset Session.Return_Structure.confirmed = "false">
	</cfif>
		
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="addJettybooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addToken="no">
</cfif>


<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
<cfparam name = "Variables.NorthJetty" default = "0">
<cfparam name = "Variables.SouthJetty" default = "0">
<cfparam name = "Variables.Status" default="pending">
<cfparam name = "Variables.confirmed" default="P">

<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
	<cfset Variables.NorthJetty = 1>
</cfif>
<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "south">
	<cfset Variables.SouthJetty = 1>
</cfif>
<cfif IsDefined("Form.confirmed") AND form.confirmed EQ "on">
	<cfset Variables.Status = "confirmed">
	<cfset Variables.confirmed = "C">
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


<cfinclude template="#RootDir#includes/header-#lang#.cfm">
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking</title>">

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}
//-->
</script>
<!-- End JavaScript Block -->

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
		<A href="jettyBookingmanage.cfm?lang=#lang#">Jetty Management</A> &gt;
	</CFOUTPUT>
	Add Jetty Booking
</div>

<div class="main">
<H1>Add Jetty Booking</H1>
<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
<!--- ---------------------------------------------------------------------------------------------------------------- --->


<!-- Gets all Bookings that would be affected by the requested booking --->
<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>

<p>Please confirm the following maintenance block information.</p>
<cfform action="addJettyBooking_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
<div style="font-size:10pt;font-weight:bold;">Booking:</div>
<table width="100%" align="center" style="font-size:10pt;">	
	<tr>
		<td align="left" width="20%">Company:</td>
		<td><input type="hidden" name="company" value="<cfoutput>#form.companyID#</cfoutput>"><cfoutput>#getCompany.name#</cfoutput></td>
	</tr>
	<tr>
		<td align="left">Vessel:</td>
		<td><input type="hidden" name="vessel" value="<cfoutput>#form.vesselID#</cfoutput>"><cfoutput>#getVessel.name#</cfoutput></td>
	</tr>	
	<tr>
		<td align="left">Agent:</td>
		<td><input type="hidden" name="agent" value="<cfoutput>#form.userID#</cfoutput>"><cfoutput>#getAgent.name#</cfoutput></td>
	</tr>	
	<tr>
		<td align="left">Start Date:</td>
		<td><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>"><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td align="left">End Date:</td>
		<td><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>"><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td align="left">Status:</td>
		<td><input type="hidden" name="confirmed" value="<cfoutput>#Variables.confirmed#</cfoutput>"><cfoutput>#Variables.Status#</cfoutput></td>
	</tr>
	<tr>
		<td align="left">Section:</td>
		<td>
			<input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>">
			<input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>">
			<cfif Variables.NorthJetty EQ 1>
				North Landing Wharf
			<cfelseif Variables.SouthJetty EQ 1>
				South Jetty
			</cfif>
		</td>
	</tr>
</table>

<br>
<table width="100%" cellspacing="0" cellpadding="1" border="0" align="center" style="font-size:10pt;">
	<tr>
		<td colspan="2" align="center">
			<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
			<a href="javascript:history.go(-1);" class="textbutton">Back</a>
			<cfoutput><a href="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Cancel</a></cfoutput>
			<BR--->
			<input type="Submit" value="Submit" class="textbutton">
			<CFOUTPUT><input type="button" value="Back" class="textbutton" onClick="self.location.href='addJettyBooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#'"></CFOUTPUT>
			<CFOUTPUT><input type="button" value="Cancel" class="textbutton" onClick="self.location.href='jettybookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#';"></CFOUTPUT>
		</td>
	</tr>
</table>

</cfform>
</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
