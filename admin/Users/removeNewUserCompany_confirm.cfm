<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company</title>">
	<cfset request.title ="Confirm Remove Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

		<div class="colLayout">

			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Remove Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfform action="removeNewUserCompany_action.cfm?info=#url.info#&companies=#url.companies#" method="post" id="remCompanyConfirmForm" name="remCompanyConfirmForm">
					<div style="text-align:center;">Are you sure you want to remove <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>

					<p><div style="text-align:center;">
						<input type="button" value="Remove" onclick="document.remCompanyConfirmForm.submit();" class="button-accent button" />
						<cfoutput><a href="addNewUserCompany.cfm?info=#url.info#&companies=#url.companies#" class="textbutton">Cancel</a></cfoutput>
					<cfoutput><input type="hidden" name="CID" value="#form.CID#" /></cfoutput>
					<cfif isDefined("URL.UID")>
					<cfoutput><input type="hidden" name="UID" value="#url.UID#" /></cfoutput>
					</cfif>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
