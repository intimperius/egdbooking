<cfif isDefined("form.VNID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif NOT isDefined("Form.CID") OR form.CID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("Form.VNID") OR form.VNID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a user to delete.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.CID = Form.CID>
	<cfset Session.Return_Structure.UID = Form.VNID>

	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="delVessel.cfm?lang=#lang#" addToken="no">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel</title>">
	<cfset request.title ="Confirm Delete Vessel">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.VNID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.Name AS companyName
	FROM Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE Vessels.VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
</cfquery>

<!-- 2005-09-27: Added new resriction on the following two queries, Deleted must be 0 -->
<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
			INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
</cfquery>

<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
			INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
</cfquery>


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Confirm Delete Vessel
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif getVesselDockBookings.recordCount EQ 0 AND getVesselJettyBookings.recordCount EQ 0>
	<cfform action="delVessel_action.cfm?lang=#lang#" method="post" id="delVesselConfirmForm">
		Are you sure you want to delete <cfoutput><strong>#getVessel.Name#</strong></cfoutput>?
		<input type="hidden" name="VNID" value="<cfoutput>#form.VNID#</cfoutput>" />
		<br /><br />
		<cfoutput query="getVessel">
			<div class="module-info widemod">
				<h2>Vessel Profile</h2>
				<ul>
				<b>Name:</b> #Name#<br/>
				<b>Company:</b> #companyName#<br/>
				<b>Length:</b> #length# m<br/>
				<b>Width:</b> #width# m<br/>
				<b>Block Setup Time:</b> #blockSetupTime#<br/>
				<b>Block Teardown Time:</b> #blockteardowntime#<br/>
				<b>International Maritime Organization (I.M.O.) number:</b> #lloydsID#<br/>
				<b>Tonnage:</b> #tonnage#
				</ul>
			</div><br/><br/>
			<div>
				<input type="submit" class="button-accent button" value="Submit" />
				<a href="delVessel.cfm?lang=#lang#" class="textbutton">Back</a>
				<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
			</div>
		</cfoutput>
	</cfform>
<cfelse>

		<cfoutput><strong>#getVessel.name#</strong></cfoutput> cannot be deleted as it is booked for the following dates:<br />

		<cfif getVesselDockBookings.recordCount GT 0>
			<h2 class="color-dark">Drydock</h2>
			<table class="table-condensed">
			<tr>
				<th id="start" style="width:25%;"><strong>Start Date</strong></th>
				<th id="end" style="width:60%;"><strong>End Date</strong></th>
				<th id="status" style="width:15%;"><strong>Status</strong></th>
			</tr>
				<cfoutput query="getVesselDockBookings">
					<tr>
						<td headers="start" valign="top">#dateformat(startDate, "mmm d, yyyy")#</td>
						<td headers="end" valign="top">#dateformat(endDate, "mmm d, yyyy")#</td>
						<td headers="status" valign="top">
							<cfif status EQ 'p'><i>pending</i>
							<cfelseif status EQ 't'><i>tentative</i>
							<cfelse><i>confirmed</i></cfif>
						</td>
					</tr>
				</cfoutput>	
			</table>
		</cfif>

		<cfif getVesselJettyBookings.recordCount GT 0>
			<h2 class="color-dark">Jetties</h2>
			<table class="table-condensed">
				<tr>
					<th id="start" style="width:25%;"><strong>Start Date</strong></th>
					<th id="end" style="width:25%;"><strong>End Date</strong></th>
					<th id="jetty" style="width:35%;"><strong>Jetty</strong></th>
					<th id="status" style="width:15%;"><strong>Status</strong></th>
				</tr>
				<cfoutput query="getVesselJettyBookings">
					<tr>
						<td headers="start" valign="top">#dateformat(startDate, "mmm d, yyyy")#</td>
						<td headers="end" valign="top">#dateformat(endDate, "mmm d, yyyy")#</td>
						<td headers="jetty" valign="top">
							<cfif getVesselJettyBookings.NorthJetty EQ 1>
								North Landing Wharf
							<cfelseif getVesselJettyBookings.SouthJetty EQ 1>
								South Jetty
							</cfif>
						</td>
						<td headers="status" valign="top">
							<cfif status EQ 'p'><i>pending</i>
							<cfelse><i>confirmed</i></cfif>
						</td>
					</tr>
				</cfoutput>
			</table>
		</cfif>

		<div>
			<a href="delVessel.cfm?lang=<cfoutput>#lang#</cfoutput>" class="textbutton">Back</a>
			<a href="menu.cfm?lang=<cfoutput>#lang#</cfoutput>" class="textbutton">Return to Administrative Functions</a>
		</div>
</cfif>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
