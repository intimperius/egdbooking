<cfset request.title ="Change Booking Status">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

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

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Status, Bookings.BRID, StartDate, EndDate,
			Vessels.Name AS VesselName, Companies.Name AS CompanyName,
			Section1, Section2, Section3
	FROM	Docks, Bookings, Vessels, Companies
	WHERE	Bookings.BRID = Docks.BRID
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
	
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Change Booking Status
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfif getBooking.Status EQ "C">
	<cfinclude template="includes/getConflicts.cfm">
	<cfset conflictArray = getConflicts_remConf(Form.BRID)>
	<cfif ArrayLen(conflictArray) GT 0>
		<cfset Variables.waitListText = "The booking slot that this vessel held is now available for the following tentative bookings.  The companies/agents should be given 24 hours notice to submit a downpayment.">
		<cfinclude template="includes/displayWaitList.cfm">
		
	</cfif>
</cfif>
<cfoutput>			
<form action="chgStatus_2t_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" name="change2tentative">
Are you sure you want to change this booking's status to tentative?
<br /><br />
<cfoutput>
<input type="hidden" name="BRID" value="#Form.BRID#" />

<div class="module-info widemod">
	<h2>Booking Details</h2>
	<ul>
		<b>Vessel:</b>#getBooking.VesselName#<br/>
		<b>Company:</b>#getBooking.CompanyName#<br/>
		<cfif getBooking.Status EQ "C">
			<b>Section(s):</b><CFIF getBooking.Section1>Section 1</CFIF>
			<CFIF getBooking.Section2><CFIF getBooking.Section1> &amp; </CFIF>Section 2</CFIF>
			<CFIF getBooking.Section3><CFIF getBooking.Section1 OR getBooking.Section2> &amp; </CFIF>Section 3</CFIF><br/>
		</cfif>	
		<b>Start Date:</b>#DateFormat(Variables.Start, "mmm d, yyyy")#<br/>
		<b>End Date:</b>#DateFormat(Variables.End, "mmm d, yyyy")#<br/>
	</ul>
</div>
</cfoutput>
<br/>
	<div>
		<!--a href="javascript:EditSubmit('change2tentative');" class="textbutton">Submit</a-->
		<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
		<cfoutput>
		<a href="#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#getBooking.BRID###id#getBooking.BRID#" class="textbutton">Cancel</a>
		</cfoutput>
	</div>
</form>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
