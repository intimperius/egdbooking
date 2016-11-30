<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""Create New Company - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#"" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>Create New Company - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title ="Create New Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFIF NOT IsDefined('url.UID')>
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
</CFIF>

		
		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<cfparam name="Variables.name" default="">
				<cfparam name="Variables.abbrev" default="">
				<cfparam name="Variables.address1" default="">
				<cfparam name="Variables.address2" default="">
				<cfparam name="Variables.city" default="">
				<cfparam name="Variables.province" default="">
				<cfparam name="Variables.country" default="">
				<cfparam name="Variables.zip" default="">
				<cfparam name="Variables.phone" default="">
				<cfparam name="Variables.fax" default="">

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfset Variables.onLoad = "javascript:document.addCompanyForm.name.focus();">

				<cfoutput>
				<form action="editUser_addCompany_action.cfm?lang=#lang#&UID=#url.UID#" id="addCompanyForm" method="post">
					<div>
						<label for="name">Company Name:</label>
						<input name="name" value="#variables.name#" id="name" type="text" size="40" maxlength="75" required="yes" message="Please enter the company name." /><br />
						<label for="abbrev">Abbreviation:</label>
						<input name="abbrev" id="abbrev" type="text" size="5" maxlength="3" value="#variables.abbrev#" required="yes" message="Please enter the company abbreviation." /><br />
            <label for="address1">Address 1:</label>
						<input name="address1" value="#variables.address1#" id="address1" type="text" size="40" maxlength="75" required="yes" message="Please enter the address." /><br />
						<label for="address2">Address 2 (optional):</label>
						<input name="address2" value="#variables.address2#" id="address2" type="text" size="40" maxlength="75" /><br />
            <label for="city">City:</label>
						<input name="city" value="#variables.city#" id="city" type="text" size="25" maxlength="40" required="yes" message="Please enter the city." /><br />
						<label for="province">Province / State:</label>
						<input name="province" value="#variables.province#" id="province" type="text" size="25" maxlength="40" required="no" message="Please enter the province." /><br />
						<label for="country">Country:</label>
						<input name="country" value="#variables.country#" id="country" type="text" size="25" maxlength="40" required="yes" message="Please enter the country." /><br />
						<label for="zip">Postal / Zip Code:</label>
						<input name="zip" value="#variables.zip#" id="zip" type="text" size="12" maxlength="10" required="no" message="Please enter the postal code or zip code." /><br />
						<label for="phone">Phone:</label>
						<input name="phone" value="#variables.phone#" id="phone" type="text" size="25" maxlength="32" required="yes" message="Please check that the phone number is valid." /><br />
						<label for="fax">Fax (optional):</label>
						<input name="fax" value="#variables.fax#" id="fax" type="text" size="25" maxlength="32" /><br />
            <input type="submit" class="button-accent button" value="Submit" />
            <a href="editUser.cfm?lang=#lang#&UID=#url.UID#" class="textbutton">Cancel</a>
					</div>
				</form>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
