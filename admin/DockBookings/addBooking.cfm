<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="pwgsc - esquimalt graving dock - Add Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Booking</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 2;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title ="Create New Dock Booking">
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
	Create New Dock Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfparam name="form.compID" default="">
<cfparam name="Variables.compID" default="#form.compID#">
<cfparam name="Variables.VNID" default="">
<cfparam name="Variables.UID" default="">
<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.EndDate" default="#DateAdd('d', 3, PacificNow)#">
<cfparam name="Variables.Status" default="PT">
<cfparam name="Variables.TheBookingDate" default="#CreateODBCDate(PacificNow)#">
<cfparam name="Variables.TheBookingTime" default="#CreateODBCTime(PacificNow)#">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>
<cfif NOT IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.startDate")>
		<cfset Variables.compID = #form.compID#>
		<cfset Variables.VNID = #form.VNID#>
		<cfset Variables.UID = #form.UID#>
		<cfset Variables.StartDate = #form.startDate#>
		<cfset Variables.EndDate = #form.endDate#>
		<cfset Variables.TheBookingDate = #Form.bookingDate#>
		<cfset Variables.TheBookingTime = #Form.bookingTime#>
		<cfset Variables.Status = form.status>
	</cfif>
</cfif>

<cfform action="addBooking.cfm?#urltoken#" method="post" id="chooseUserForm">
	<p><label for="selectCompany">Select Company:</label> <cfselect query="getCompanies" id="selectCompany" name="compID" value="CID" display="Name" selected="#Variables.compID#" />
	&nbsp;&nbsp;&nbsp;
	<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Submit</a-->
	<br />
	<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
	<br />
	<cfoutput><a href="bookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
</cfform>

<cfif Variables.compID NEQ "">

	<cflock timeout=20 scope="Session" type="Exclusive">
		<cfset Session.Company = "#form.compID#">
	</cflock>

	<cfform action="addBooking_process.cfm?#urltoken#" method="post" id="addBookingForm">
	<cfoutput>

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

	<h2> #getCompanyName.Name#</h2><br/>
	<label for="VNID">Vessel:</label>
	<cfif getVessels.recordCount GE 1>
		<cfselect name="VNID" query="getVessels" display="Name" value="VNID" selected="#Variables.VNID#" />
	<cfelse>
		No ships currently registered.
	</cfif>
	<br/>
	<cfif getVessels.recordCount GE 1>
	<label for="UID">Agent:</label>
		<cfif getAgents.recordCount GE 1>
			<cfselect name="UID" query="getAgents" display="UserName" value="UID" selected="#Variables.UID#" />
		<cfelse>
			No agents currently registered.
		</cfif>
	</cfif>
	<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
		<label for="startDate">Start Date:</label>
			<cfoutput>
				<cfinput id="startDate" type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
			</cfoutput>
		<label for="endDate">End Date:</label>
			<cfoutput>
				<cfinput id="endDate" type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
			</cfoutput>
		<label for="bookingDate">Booking Date:</label>
			<cfoutput>
				<cfinput id="bookingDate" name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" class="datepicker" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" /> #language.dateform#
			</cfoutput>
		<label for="bookingTime">Booking Time:</label>
			<cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" /> (HH:MM)


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
	</cfif>
	<br/>
	<div style="clear:both;">
		<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
			<input type="hidden" name="compID" value="#Variables.compID#" />
			<input type="submit" name="submitForm" class="button button-accent" value="Submit" />
		</cfif>
		<cfoutput><a href="bookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
	</div>
	</cfoutput>
	</cfform>
</cfif>


<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
