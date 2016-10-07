<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Company</title>">
	<cfset request.title ="Delete Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
	FROM Companies
	WHERE Approved = 1 AND Deleted = 0
	ORDER BY Name
	</cfquery>
</cflock>

<!---
<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT CID, Name
		FROM Companies
		WHERE NOT EXISTS (SELECT CID
							FROM UserCompanies
							WHERE UserCompanies.CID = Companies.CID
							AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
							AND UserCompanies.UID = #session.UID#)
		AND Companies.Deleted = 0
		ORDER BY Name
	</cfquery>
</cflock>
--->

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("form.CID")>
	<cfset variables.CID = #form.CID#>
<cfelse>
	<cfset variables.CID = 0>
</cfif>

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Delete Company
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
	</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<div>
	<cfoutput>
	<form action="delCompany_confirm.cfm?lang=#lang#" method="post" id="delCompanyForm">
		<select name="CID"value="CID" display="name" selected="#variables.CID#">
			<cfloop query="getcompanyList">
				<option value="#getcompanyList.CID#">#getcompanyList.Name#</option>
			</cfloop>
		</select>
		<br />
		<input type="submit" name="submitForm" class="button-accent button" value="Delete" />
		<br />
		<a href="#RootDir#admin/menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
	</form>
	</cfoutput>
</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
