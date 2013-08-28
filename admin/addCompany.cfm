<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Company"" />
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Company</title>">
	<cfset request.title ="Create New Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfinclude template="#RootDir#includes/checkFilledIn_js.cfm">

<cfparam name="variables.name" default="">
<cfparam name="Variables.abbrev" default="">
<cfparam name="variables.address1" default="">
<cfparam name="variables.address2" default="">
<cfparam name="variables.city" default="">
<cfparam name="variables.province" default="">
<cfparam name="variables.country" default="">
<cfparam name="variables.zip" default="">
<cfparam name="variables.phone" default="">
<cfparam name="variables.fax" default="">


<cfif NOT IsDefined("Session.form_Structure") OR NOT IsDefined("form.name")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
		<cfif isDefined("form.CID")>
		<cfset variables.name="#form.name#">
		<cfset Variables.abbrev="#form.abbrev#">
		<cfset variables.address1="#form.address1#">
		<cfset variables.address2="#form.address2#">
		<cfset variables.city="#form.city#">
		<cfset variables.province="#form.province#">
		<cfset variables.country="#form.country#">
		<cfset variables.zip="#form.zip#">
		<cfset variables.phone="#form.phone#">
		<cfset variables.fax="#form.fax#">
	</cfif>
</cfif>

<!--- <cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("session.form_structure")>
	<cfset variables.name="#form.name#">
	<cfset Variables.abbrev="#form.abbrev#">
	<cfset variables.address1="#form.address1#">
	<cfset variables.address2="#form.address2#">
	<cfset variables.city="#form.city#">
	<cfset variables.province="#form.province#">
	<cfset variables.country="#form.country#">
	<cfset variables.zip="#form.zip#">
	<cfset variables.phone="#form.phone#">
	<cfset variables.fax="#form.fax#">
</cfif> --->

		
		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfoutput>
				<cfform action="addCompany_action.cfm?lang=#lang#" id="addCompanyForm" method="post" onsubmit="if(!checkFilledIn('addCompanyForm')) { return false;}">
					<div>
						<label for="name">Company Name:</label>
						<cfinput name="name" id="name" type="text" size="40" maxlength="75" value="#variables.name#" required="yes" message="Please enter the company name." />

						<label for="abbrev">Abbreviation:</label>
						<cfinput name="abbrev" id="abbrev" type="text" size="5" maxlength="3" value="#variables.abbrev#" required="yes" message="Please enter the company abbreviation." />

						<label for="address1">Address 1:</label>
						<cfinput name="address1" id="address1" type="text" size="40" maxlength="75" value="#variables.address1#" required="yes" message="Please enter the address." />
							
						<label for="address2">Address 2 (optional):</label>
						<cfinput name="address2" id="address2" type="text" size="40" maxlength="75" value="#variables.address2#" />

						<label for="city">City:</label>
						<cfinput name="city" id="city" type="text" size="25" maxlength="40" value="#variables.city#" required="yes" message="Please enter the city." />

						<label for="province">Province / State:</label>
						<cfinput name="province" id="province" type="text" size="25" maxlength="40" value="#variables.province#" required="no" message="Please enter the province or state." />

						<label for="country">Country:</label>
						<cfinput name="country" id="country" type="text" size="25" maxlength="40" value="#variables.country#" required="yes" message="Please enter the country." />

						<label for="zip">Postal / Zip Code:</label>
						<cfinput name="zip" id="zip" type="text" size="12" maxlength="10" value="#variables.zip#" required="no" message="Please enter the postal code or zip code." />

						<label for="phone">Phone:</label>
						<cfinput name="phone" id="phone" type="text" size="25" maxlength="32" value="#variables.phone#" required="yes" message="Please check that the phone number is valid." />

						<label for="fax">Fax (optional):</label>
						<cfinput name="fax" id="fax" type="text" size="25" maxlength="32" value="#variables.fax#" />
					</div>
					<div>&nbsp;</div>
					<div>
						<input type="submit" name="submitForm" class="button-accent button" value="Submit" />
						<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
					</div>	
				</cfform>
				</cfoutput>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
