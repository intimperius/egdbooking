<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking</title>">
	<cfset request.title ="Create New Dock Booking">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Create New Dock Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>


<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">


<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!---<cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput>--->

<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#Form.StartDate#">
<cfparam name = "Variables.EndDate" default = "#Form.EndDate#">
<cfparam name = "Form.VNID" default="">
<cfparam name = "Variables.VNID" default = "#Form.VNID#">
<cfparam name = "Form.UID" default="">
<cfparam name = "Variables.UID" default = "#Form.UID#">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif Variables.StartDate EQ "">
	<cflocation addtoken="no" url="addBooking.cfm?#urltoken#">
</cfif>

<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>
<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyy')>
<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyy')>

<!--- Validate the form data --->
<cfif Variables.StartDate GT Variables.EndDate>
	<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Variables.StartDate>
	<cfset Session.Return_Structure.EndDate = Variables.EndDate>
	<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
	<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
	<cfset Session.Return_Structure.VNID = Variables.VNID>
	<cfset Session.Return_Structure.UID = Variables.UID>
	<cfset Session.Return_Structure.compId = Form.compID>
	<cfset Session.Return_Structure.Status = Form.Status>
	<cfset Session.Return_Structure.Errors = Errors>

	<cflocation url="addBooking.cfm?#urltoken#" addToken="no">
</CFIF>


<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM 	Vessels, Companies
	WHERE 	VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
	AND		Companies.CID = Vessels.CID
	AND 	Vessels.Deleted = 0
	AND		Companies.Deleted = 0
</cfquery>

<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	lastname + ', ' + firstname AS UserName
	FROM 	Users
	WHERE 	UID = <cfqueryparam value="#Variables.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

 <!--- Gets all Bookings that would be affected by the requested booking --->
<cfset theBooking.width = getVessel.width>
<cfset theBooking.length = getVessel.length>
<cfset theBooking.BRID = -1>
<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>
<cfinclude template="includes/towerCheck.cfm">

<cfset Variables.reOrder = BookingTower.ReorderTower()>
<cfif NOT Variables.reOrder> <!--- Check if the booking can be slotted in without problems --->
	<cflock scope="session" type="exclusive" timeout="30">
		<cfset Session.PassStructure.reOrder = false>
	</cflock>
	<p>The submitted booking request <strong>conflicts</strong> with other bookings.  Would you like to add the booking anyway?</p>

<cfelse>
	<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
		<cfset Session.PassStructure = StructNew()>
		<cfset Session.PassStructure.Tower = BookingTower.getTower()>
		<cfset Session.PassStructure.reOrder = true>
	</cflock>

	<cfif form.Status EQ "C">
		<cfinclude template="includes/getConflicts.cfm">
		<cfset conflictArray = getConflicts_Conf(theBooking.BRID)>
		<cfif ArrayLen(conflictArray) GT 0>
			<cfset Variables.waitListText = "The following vessels are on the wait list ahead of this booking.  The companies/agents should be given 24 hours notice to submit a downpayment.">
			<cfinclude template="includes/displayWaitList.cfm">
		</cfif>
	</cfif>

</cfif>

<form action="addBooking_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
<br />
<div class="module-info widemod">
	<h2>New Booking</h2>
	<ul>
		<b>Vessel:</b> <input type="hidden" name="VNID" value="<cfoutput>#Variables.VNID#</cfoutput>" /><cfoutput>#getVessel.VesselName#</cfoutput><br/>
		<b>Company:</b> <cfoutput>#getVessel.CompanyName#</cfoutput><br/>
		<b>Agent:</b> <input type="hidden" name="UID" value="<cfoutput>#Variables.UID#</cfoutput>" /><cfoutput>#getAgent.UserName#</cfoutput><br/>
		<b>Start Date:</b> <input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput><br/>
		<b>End Date:</b> <input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput><br/>
		<b>Booking Time:</b> <cfoutput>
				<input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
				<input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
				#DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#
			</cfoutput><br/>
		<b>Length:</b> <cfoutput>#getVessel.Length# m</cfoutput><br/>

		<cfif form.Status EQ 'C' AND Variables.reOrder>
			<b>Section(s):</b> <CFIF Variables.BlockStructure.Section1>Section 1</CFIF>
			<CFIF Variables.BlockStructure.Section2><CFIF Variables.BlockStructure.Section1> &amp; </CFIF>Section 2</CFIF>
			<CFIF Variables.BlockStructure.Section3><CFIF Variables.BlockStructure.Section1 OR Variables.BlockStructure.Section2> &amp; </CFIF>Section 3</CFIF>
			<input type="hidden" name="Section1A" value="<cfoutput>#Variables.BlockStructure.Section1#</cfoutput>" />
			<input type="hidden" name="Section2A" value="<cfoutput>#Variables.BlockStructure.Section2#</cfoutput>" />
			<input type="hidden" name="Section3A" value="<cfoutput>#Variables.BlockStructure.Section3#</cfoutput>" /><br/>
		</cfif>

		<b>Status:</b> <cfif form.Status EQ 'PT'>Pending
			<cfelseif form.Status EQ 'T'>Tentative
			<cfelseif form.Status EQ 'C'>Confirmed
			</cfif>
	</ul>
</div>

<br />
<cfif NOT Variables.reOrder>
	<cfif Form.Status EQ "C">
		This booking conflicts with other bookings. Please choose the sections of the dock that you wish to book:<br/><br/>
		<div class="form-checkbox">
			<label for="Section1">Section 1
			<input type="checkbox" name="Section1B" id="Section1" /></label>
			<label for="Section2">Section 2
			<td headers="header2"><cfinput type="checkbox" name="Section2B" id="Section2" /></label>
			<label for="Section3">Section 3
			<td headers="header3"><cfinput type="checkbox" name="Section3B" id="Section3" /></label>
		</div>
	</cfif>
	<cfinclude template="#RootDir#includes/showConflicts.cfm">
</cfif>
<br />
<input type="hidden" value="<cfoutput>#Form.Status#</cfoutput>" name="Status" />
<input type="submit" value="Submit" class="button button-accent" />
<br />
<cfoutput><a href="bookingManage.cfm?#urltoken#" style="padding-right: 10px" />Cancel</a></cfoutput>
<cfoutput><a href="addBooking.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>


</form>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
