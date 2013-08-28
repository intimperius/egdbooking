<cfif structKeyExists(URL, 'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfoutput>
<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Jetties.NorthJetty, Jetties.SouthJetty
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE	Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
	<cfset request.title = "Confirm #variables.actionCap# Maintenance Block">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.BRID = Form.BRID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.NorthJetty = getBooking.NorthJetty>
<cfset Variables.SouthJetty = getBooking.SouthJetty>


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Confirm #variables.actionCap# Maintenance Block
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<cfinclude template="#RootDir#includes/admin_menu.cfm">

Please confirm the following maintenance block information.<br/><br/>
<cfform action="deleteJettyMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
<input type="hidden" name="BRID" value="#Variables.BRID#" />

<div class="module-info widemod">
	<h2>Booking Details</h2>
	<ul>
		<b>Start Date:</b> <input type="hidden" name="StartDate" value="#Variables.Start#" />#DateFormat(Variables.Start, 'mmm d, yyyy')#<br/>
		<b>End Date:</b> <input type="hidden" name="EndDate" value="#Variables.End#" />#DateFormat(Variables.End, 'mmm d, yyyy')#<br/>
		<b>Sections:</b> <input type="hidden" name="NorthJetty" value="#Variables.NorthJetty#" />
			<input type="hidden" name="SouthJetty" value="#Variables.SouthJetty#" />
			<cfif Variables.NorthJetty EQ 1>
				North Landing Wharf
			</cfif>
			<cfif Variables.SouthJetty EQ 1>
				<cfif Variables.NorthJetty EQ 1>
					&amp;
				</cfif>
				South Jetty
			</cfif>
	</ul>
</div>

<br />
	<input type="submit" value="#variables.actionCap# Maintenance" class="button button-accent" />
	<a href="jettyBookingManage.cfm?#urltoken#">Back</a>
	
</cfform>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
