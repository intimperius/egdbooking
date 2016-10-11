<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking</title>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = "Create New Jetty Booking">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
	FROM Companies
	WHERE Deleted = 0 AND Approved = 1
	ORDER BY Name
</cfquery>


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
	Create New Jetty Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfparam name="form.compID" default="">
<cfparam name="Variables.compID" default="#form.compID#">
<cfparam name="Variables.VNID" default="">
<cfparam name="Variables.UID" default="">
<cfparam name="form.StartDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="form.EndDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.StartDate" default="#form.StartDate#">
<cfparam name="Variables.EndDate" default="#form.endDate#">
<cfparam name="Variables.NorthJetty" default="0">
<cfparam name="Variables.SouthJetty" default="0">
<cfparam name="Variables.Status" default="PT">
<cfparam name="Variables.TheBookingDate" default="#CreateODBCDate(PacificNow)#">
<cfparam name="Variables.TheBookingTime" default="#CreateODBCTime(PacificNow)#">
	<cfset override="0">
<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
	<cfset override="1">
</cfif>
<cfif NOT IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.VNID")>
		<cfset Variables.compID = #form.compID#>
		<cfset Variables.VNID = #form.VNID#>
		<cfset Variables.UID = #form.UID#>
		<cfset Variables.StartDate = #form.startDate#>
		<cfset Variables.EndDate = #form.endDate#>
		<cfset Variables.TheBookingDate = #Form.bookingDate#>
		<cfset Variables.TheBookingTime = #Form.bookingTime#>
		<cfif isDefined("form.status")><cfset Variables.Status = form.status></cfif>
		<cfif isDefined("form.jetty") AND form.jetty EQ "north">
			<cfset Variables.NorthJetty = "1">
			<cfset Variables.SouthJetty = "0">
		<cfelseif isDefined("form.jetty") AND form.jetty EQ "south">
			<cfset Variables.SouthJetty = "1">
			<cfset Variables.NorthJetty = "0">
		</cfif>
	</cfif>
</cfif>


<cfoutput>
<form action="addJettyBooking.cfm?#urltoken#" method="post" id="chooseUserForm">
	<label for="selectCompany">Select Company:</label> <select query="getCompanies" id="selectCompany" name="compID" value="CID" display="Name" selected="#Variables.compID#"><cfloop query="getCompanies"><option value="#getCompanies.CID#">#getCompanies.Name#</option></cfloop></select>
	&nbsp;&nbsp;&nbsp;
	<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Submit</a-->
	<br />
	<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
	<br />
	<cfoutput><a href="jettyBookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
</form>
</cfoutput>

<cfif Variables.compID NEQ "">

	<cflock timeout=20 scope="Session" type="Exclusive">
		<cfset Session.Company = "#form.compID#">
	</cflock>

	<cfoutput>
	<form action="addJettyBooking_process.cfm?#urltoken#" method="post" id="addBookingForm">

	<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT VNID, Name
		FROM Vessels
		WHERE CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" /> AND Deleted = 0
		ORDER BY Name
	</cfquery>

	<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Users.UID, lastname + ', ' + firstname AS UserName
		FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
				INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	Companies.CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" /> AND Users.Deleted = 0
				AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
		ORDER BY lastname, firstname
	</cfquery>

	
	<cfquery name="getCompanyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Name
		FROM Companies
		WHERE CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" />
	</cfquery>

	<h2>#getCompanyName.Name#</h2><br/>

	<input type="hidden" name="CID" value="#variables.compID#" />
	<label for="VNID">Vessel:</label>
		<cfif getVessels.recordCount GE 1>
			<td headers="Vessel"><select name="VNID" query="getVessels" display="Name" value="VNID" selected="#Variables.VNID#"><cfloop query="getVessels"><option value="#getVessels.VNID#">#getVessels.Name#</option></cfloop></select></td>
		<cfelse>
			<td headers="Vessel">No ships currently registered.</td>
		</cfif>
		
	<cfif getVessels.recordCount GE 1>
		<label for="UID">Agent:</label>
			<cfif getAgents.recordCount GE 1>
				<select name="UID" query="getAgents" display="UserName" value="UID" selected="#Variables.UID#"><cfloop query="getAgents"><option value="#getAgents.UID#">#getAgents.UserName#</option></cfloop></select>
			<cfelse>
				No agents currently registered.
			</cfif>
	</cfif>
		<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>	
			<label for="startDate">Start Date:</label>		
			<cfoutput>
				<input type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="datepicker startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
			</cfoutput>
			<label for="endDate">End Date:</label>
				<cfoutput>
					<input type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="datepicker endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
				</cfoutput>
			<label for="bookingDate">Booking Date:</label>
				<cfoutput>
					<input name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" class="datepicker" /> <abbr title="#language.dateformexplanation#">(MM/DD/YYYY)</abbr>
  				</cfoutput>
			<label for="bookingTime">Booking Time:</label>
 		 		<cfoutput>
						<input name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" /> (HH:MM)
				</cfoutput>
			<div class="module-note module-simplify">
				<b>Note:</b> Booking dates are inclusive;<br/>
			 	i.e. a three day booking is denoted as from May 1 to May 3.
			</div>	
			<br/>	
			Please set the status of the booking:<br/>
			<div class="form-radio">
				<label for="pending">Pending
				<input type="radio" name="Status" id="pending" value="PT"  checked="checked"<cfif Variables.Status EQ "PT">selected="selected"</cfif>/></label>
				<label for="tentative">Tentative
				<input type="radio" name="Status" id="tentative" value="T" <cfif Variables.Status EQ "T">selected="selected"</cfif>/></label>
				<label for="confirmed">Confirmed
				<input type="radio" name="Status" id="confirmed" value="C" <cfif Variables.Status EQ "C">selected="selected"</cfif>/></label>
			</div>
			<br/>
			Please select the jetty that you wish to book:
			<div class="form-radio">
				<label for="northJetty">North Landing Wharf<input type="radio" name="Jetty" id="northJetty" value="north" <cfif Variables.NorthJetty EQ 1 OR Variables.SOuthJetty EQ 0>checked="true"</cfif> /></label>
				<label for="southJetty">South Jetty<input type="radio" name="Jetty" id="southJetty" value="south" <cfif Variables.SouthJetty EQ 1>checked="checeked"</cfif> /></label>
			</div>			
		</cfif>
				<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
				<!--a href="javascript:document.addBookingForm.submitForm.click();" class="textbutton">Submit</a-->
					<input type="hidden" name="compID" value="#Variables.compID#" />
					<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
					<cfif override EQ "1">
					<input type="submit" name="submitForm" class="button button-accent" value="Override" />
					</cfif>
				</cfif>
				<br />
				<cfoutput><a href="jettyBookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
	</form>
	</cfoutput>
</cfif>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
