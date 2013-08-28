<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfset language.createComp = "Create New Company">
<cfset language.keywords = "Esquimalt Graving Dock, EGD, Booking Request, Add New Company">
<cfset language.description = "Allows user to create a new company.">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Company</title>">
<cfset request.title ="Create New Company">


<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<CFINCLUDE template="#RootDir#includes/checkFilledIn_js.cfm">


<div class="main">
<h1 id="wb-cont">Create New Company</h1>

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

<cfoutput>
<cfform action="addCompany_action.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" id="addCompanyForm" method="post" onsubmit="if(!checkFilledIn('addCompanyForm')) { return false;
	}">
	
		
			<label for="name">Name:</label>
			<cfinput name="name" value="#variables.name#" id="name" type="text" size="40" maxlength="75" required="yes" message="#language.nameError#" />
		
		
			<label for="abbrev">Abbreviation:</label>
			<cfinput name="abbrev" id="abbrev" type="text" size="10" maxlength="3" value="#variables.abbrev#" required="yes" message="#language.abbrevError#" />
		
		
			<label for="address1">Address 1:</label>
			<cfinput name="address1" value="#variables.address1#" id="address1" type="text" size="40" maxlength="75" required="yes" message="#language.addressError#" />
		
		
			<label for="address2">Address 2 (optional):</label>
			<cfinput name="address2" value="#variables.address2#" id="address2" type="text" size="40" maxlength="75" />
		
		
			<label for="city">City:</label>
			<cfinput name="city" value="#variables.city#" id="city" type="text" size="25" maxlength="40" required="yes" message="#language.cityError#" />
		
		
			<label for="province">Province:</label>
			<cfinput name="province" value="#variables.province#" id="province" type="text" size="25" maxlength="40" required="no" message="#language.provinceError#" />
		
		
			<label for="country">Country:</label>
			<cfinput name="country" value="#variables.country#" id="country" type="text" size="25" maxlength="40" required="yes" message="#language.countryError#" />
		
		
			<label for="zip">Postal / Zip Code:</label>
			<cfinput name="zip" value="#variables.zip#" id="zip" type="text" size="12" maxlength="10" required="no" message="#language.zipError#" />
		
		
			<label for="phone">Phone:</label>
			<cfinput name="phone" value="#variables.phone#" id="phone" type="text" size="25" maxlength="32" required="yes" message="#language.phoneError#" />
		
		
			<label for="fax">Fax (optional):</label>
			<cfinput name="fax" value="#variables.fax#" id="fax" type="text" size="25" maxlength="32" />
		
		
			<br/>
				<input type="submit" name="submitForm" value="Submit" class="button-accent button" />
				<a href="addNewUserCompany.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" class="textbutton">Cancel</a>
			
		
	</table>
</cfform>
</cfoutput>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
