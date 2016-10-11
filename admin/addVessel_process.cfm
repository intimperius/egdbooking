<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />
	AND Deleted = 0
	AND CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getVessel.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A vessel with that name already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addVessel.cfm?CID=#form.CID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Vessel"" />
	<meta name=""keywords"" content=""Add Vessel"" />
	<meta name=""description"" content=""Allows user to create a new vessel in the Esquimalt Graving Dock booking website."" />
	<meta name=""dcterms.description"" content=""Allows user to create a new vessel in the Esquimalt Graving Dock booking website."" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Vessel</title>">
<cfset request.title ="Add New Vessel">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Add New Vessel
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CID, Companies.Name AS CompanyName
	FROM  	Companies
	WHERE 	CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	AND		Deleted = '0'
</cfquery>

<cfif getCompany.recordCount EQ 0>
	<cflocation addtoken="no" url="booking.cfm?lang=#lang#&CID=#url.CID#">
</cfif>

<cfset Variables.CID = getCompany.CID>
<cfset Variables.CompanyName = getCompany.CompanyName>
<cfset Variables.Name = Form.Name>
<cfset Variables.Length = Form.Length>
<cfset Variables.Width = Form.Width>
<cfset Variables.BlockSetupTime = Form.BlockSetupTime>
<cfset Variables.BlockTearDownTime = Form.BlockTearDownTime>
<cfset Variables.LloydsID = Form.LloydsID>
<cfset Variables.Tonnage = Form.Tonnage>
<cfparam name="Variables.Anonymous" default="0">
<cfif IsDefined("Form.Anonymous")>
	<cfset Variables.Anonymous = 1>
</cfif>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

Please confirm the following information: <br/><br/>
<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
	<div id="actionErrors">Note: The ship measurements exceed the maximum dimensions of the dock (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</div>
</cfif>
<cfoutput>
<form id="addVessel" action="addVessel_action.cfm?lang=#lang#" method="post">
	<div class="module-info widemod">
		<h2>Vessel Profile</h2>
		<ul>
			<b>Company Name:</b> <input type="hidden" name="CID" value="#Variables.CID#" />#Variables.CompanyName#<br/>
			<b>Name:</b> <input type="hidden" name="name" value="#Variables.Name#" />#Variables.name#<br/>
			<b>Lloyds ID:</b> <input type="hidden" name="LloydsID" value="#Variables.LloydsID#" />#Variables.LloydsID#<br/>
			<b>Length:</b> <input type="hidden" name="length" value="#Variables.Length#" />#Variables.Length#<br/>
			<b>Width:</b> <input type="hidden" name="width" value="#Variables.Width#" />#Variables.Width#<br/>
			<b>Block Setup Time:</b> <input type="hidden" name="blocksetuptime" value="#Variables.BlockSetuptime#" />#Variables.BlockSetuptime#<br/>
			<b>Block Teardown Time:</b> <input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#" />#Variables.Blockteardowntime#<br/>
			<b>Tonnage:</b> <input type="hidden" name="tonnage" value="#Variables.Tonnage#" />#Variables.Tonnage#<br/>
			<b>Anonymous</b> <input type="hidden" name="Anonymous" value="#Variables.Anonymous#" /><cfif Variables.Anonymous EQ 1>Yes<cfelse>No</cfif><br/>
		</ul>
	</div>
	<br/>

	<input type="submit" value="Submit" class="button-accent button" />
	<br />
	<a href="addVessel.cfm?lang=#lang#" style="padding-right: 5px">Back</a>
	<a href="menu.cfm?lang=#lang#">Cancel</a>
							
	</form>
	</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
