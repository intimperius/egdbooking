<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company</title>">
	<cfset request.title ="Confirm Delete Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.CID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Companies
	WHERE Companies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<!---get a list of companies besides the one to be deleted,
so the users who belong to that current company can choose another company--->
<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
	FROM Companies
	WHERE CID <> <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	AND Deleted = 0
	ORDER BY Name
</cfquery>

<!---get the user list from the company to be deleted--->
<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Users.UID, LastName + ', ' + FirstName AS UserName
	FROM Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE UserCompanies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Users.Deleted = 0
	AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
	AND	Companies.Deleted = 0 AND Companies.Approved = 1
	AND (SELECT COUNT(*) AS MatchFui
				FROM UserCompanies
				WHERE UID = Users.UID) = 1
</cfquery>

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BRID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VNID = Bookings.VNID
			INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Docks.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" />
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BRID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VNID = Bookings.VNID
			INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Jetties.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" />
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name
	FROM	Companies INNER JOIN Vessels ON Companies.CID = Vessels.CID
	WHERE	Companies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Vessels.Deleted = 0
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
	Confirm Delete Company
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
	</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0 OR getVessels.recordCount GT 0 OR getCompanyUsers.recordCount GT 0>
	<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0>
	<cfoutput>
		<strong>#getCompany.Name#</strong> cannot be deleted as it has the following confirmed bookings:
		<cfif getDockBookings.recordCount GT 0>
			<h2 class="color-dark">Drydock</h2>
			<table class="table-condensed">
			<tr><th id="drydock" align="left">Vessel</th><th>Date</th></tr>
				<cfloop query="getDockBookings">
					<cfif getDockBookings.Status EQ "C">
						<tr>
							<td headers="drydock">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
						</tr>
					</cfif>
				</cfloop>
			</table>
		</cfif>
		<cfif getJettyBookings.recordCount GT 0>
			<h2 class="color-dark">Jetties</h2>
			<table class="table-condensed">
			<tr><th id="jetties" align="left">Jetties</th><th>Date</th></tr>
				<cfloop query="getJettyBookings">
					<cfif getJettyBookings.Status EQ "C">
						<tr>
							<td headers="jetties">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
						</tr>
					</cfif>
				</cfloop>
			</table>
		<br />
		</cfif>
		All confirmed bookings must be cancelled before #getCompany.Name# can be deleted.<br /><br />
	</cfoutput>
	</cfif>

	<cfif getVessels.recordCount GT 0>
		<cfoutput>
		<strong>#getCompany.Name#</strong> cannot be deleted as it is currently responsible for the following vessel(s):
		<br /><br />
		<div class="module-attention widemod module-simplify">
			<h2 class="color-dark">Vessels</h2>
			<ul class="column-3">
			<cfloop query="getVessels">
					#name#<br/>
			</cfloop>
			</ul>
		</div>
		<br />All vessels must be deleted before #getCompany.Name# can be deleted.<br /><br />
	</cfoutput>
	</cfif>

	<cfif getCompanyUsers.recordCount GT 0>
		<cfoutput>
		<strong>#getCompany.Name#</strong> cannot be deleted as it is currently the only company responsible for the following user(s):
		<br /><br />
		<div class="module-attention widemod module-simplify">
			<h2 class="color-dark">Users</h2>
			<ul class="column-3">
			<cfloop query="getCompanyUsers">
				&nbsp;&nbsp;#userName#<br/>
			</cfloop>
			</ul>
		</div>
		<br />All users that are associated with only #getCompany.name# must be deleted before #getCompany.Name# can be deleted.<br /><br />
	</cfoutput>
	</cfif>

	<cfoutput>
	<div style="text-align:center;">
		<a href="delCompany.cfm?lang=#lang#" class="textbutton">Back</a>
		<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
	</div>
	</cfoutput>

<cfelse>
<cfoutput>
<form action="delCompany_action.cfm?lang=#lang#" method="post" id="delCompanyConfirmForm">
	Are you sure you want to delete <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?
	<input type="hidden" name="CID" value="<cfoutput>#form.CID#</cfoutput>" />
	<br/><br/>
	<cfoutput>
	<div class="module-info widemod">
		<h2>Company Profile:</h2>
		<ul>
			<b>Name:</b> #getCompany.Name#<br/>
			<b>Address 1:</b> #getCompany.address1#<br/>
			<b>Address 2:</b> #getCompany.address2#<br/>
			<b>City:</b> #getCompany.city#<br/>
			<b>Province:</b> #getCompany.province#<br/>
			<b>Country:</b> #getCompany.country#<br/>
			<b>Postal Code:</b> #getCompany.zip#<br/>
			<b>Phone:</b> #getCompany.phone#
		</ul>
	</div>
	<cfoutput>

	<p><div>
	<!--a href="javascript:EditSubmit('delCompanyConfirmForm');" class="textbutton">Submit</a>
	<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a-->
	<input type="submit" name="submitForm" class="button-accent button" value="Submit" />
	<a href="delCompany.cfm?lang=#lang#" class="textbutton">Back</a>
	<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
	</div></p>
	</cfoutput>
	</cfoutput>

</form>
</cfoutput>
</cfif>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
