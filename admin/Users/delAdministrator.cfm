<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator</title>">
	<cfset request.title ="Remove Administrator">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getAdminList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UID, LastName + ', ' + FirstName AS UserName
		FROM Users, Administrators
		WHERE Users.UID <> <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND Users.UID = Administrators.UID
				AND Deleted = 0
		ORDER BY LastName
	</cfquery>
</cflock>

		

				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Remove Administrator
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfparam name="variables.UID" default="0">
<cfif IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.UID")>
		<cfset Variables.UID = #form.UID#>
	</cfif>
</cfif>

<div >
	<cfform action="delAdministrator_confirm.cfm?lang=#lang#" method="post" id="delAdministratorForm">
		<cfselect name="UID" query="getAdminList" value="UID" display="UserName" selected="#variables.UID#" />
		<input type="submit" value="Remove" class="button-accent button" />
		<cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
	</cfform>
</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
