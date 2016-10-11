<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add New Vessel"" />
	<meta name=""keywords"" content=""Add Vessel"" />
	<meta name=""description"" content=""Allows user to create a new vessel in the Esquimalt Graving Dock booking website."" />
	<meta name=""dcterms.description"" content=""Allows user to create a new vessel in the Esquimalt Graving Dock booking website."" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add New Vessel</title>">
	<cfset request.title ="Add New Vessel">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
	FROM Companies
	WHERE Deleted = 0 AND Approved = 1
	ORDER BY Name
</cfquery>

<cfparam name="variables.UID" default="">
<cfparam name="variables.CID" default="">
<cfparam name="variables.name" default="">
<cfparam name="variables.length" default="">
<cfparam name="variables.width" default="">
<cfparam name="variables.blocksetuptime" default="">
<cfparam name="variables.blockteardowntime" default="">
<cfparam name="variables.lloydsid" default="">
<cfparam name="variables.tonnage" default="">
<cfparam name="variables.anonymous" default="false">

<cfif NOT IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.CID")>
		<cfset Variables.CID = "#form.CID#">
		<cfset Variables.name = "#form.name#">
		<cfset Variables.length = "#form.length#">
		<cfset Variables.width = "#form.width#">
		<cfset Variables.blocksetuptime = "#form.blocksetuptime#">
		<cfset Variables.blockteardowntime = "#form.blockteardowntime#">
		<cfset Variables.lloydsid = "#form.lloydsid#">
		<cfset Variables.length = "#form.length#">
		<cfset Variables.tonnage = "#form.tonnage#">
		<cfif isDefined("form.anonymous")><cfset Variables.anonymous = true><cfelse><cfset Variables.anonymous = false></cfif>
	</cfif>
</cfif>
	<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Add New Vessel
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
	</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfinclude template="#RootDir#includes/getStructure.cfm">

<cfoutput>
<form action="addVessel_process.cfm?lang=#lang#" method="post" id="addVessel">
	<div>
		<label for="CID">Company Name:</label>
		<select id="CID" name="CID" display="Name" value="CID" selected="#variables.CID#">
		<cfloop query="GetCompanies">
			<option value="#getCompanies.CID#">#getCompanies.Name#</option> 
		</cfloop>
		</select>
			
		<label for="name">Name:</label>
		<input id="name" name="name" type="text" value="#variables.name#" size="40" maxlength="100" required="yes" message="Please enter the vessel name." />

		<label for="LloydsID">International Maritime Organization (IMO) Number:</label>
		<input id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20"  />

		<label for="length">Length (m):</label>
		<input id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the length in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxLength#</cfoutput></span>

		<label for="width">Width (m):</label>
		<input id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" validate="float" message="Please enter the width in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxWidth#</cfoutput></span>

		<label for="blocksetuptime">Block Setup Time (days):</label>
		<input id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" validate="float" message="Please enter the block setup time in days." />

		<label for="blockteardowntime">Block Teardown Time (days):</label>
		<input id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" validate="float" message="Please enter the block teardown time in days." />

		<label for="tonnage">Tonnage:</label>
		<input id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" validate="float" message="Please enter the tonnage." />

		<label for="Anonymous">Keep this vessel anonymous:</label>
		<input id="Anonymous" type="checkbox" name="Anonymous" value="Yes" <cfif variables.anonymous>checked="true"</cfif> />
	</div>
	<div>&nbsp;</div>
	<div>
		<input type="submit" name="submitForm" value="Submit" class="button-accent button" />
		<br />
		<cfoutput><a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
	</div>
</form>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
