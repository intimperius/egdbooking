<cfif isDefined("form.VNID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name, VNID
	FROM Vessels
	WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />
	AND Deleted = 0
	AND VNID != <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
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
	<cflocation url="editVessel.cfm?VNID=#form.VNID#&CID=#form.CID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dcterms.description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">
	<cfset request.title ="Edit Vessel">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Edit Vessel
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.CID, Companies.Name AS CompanyName
	FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
	AND Vessels.Deleted = 0
</cfquery>

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="booking.cfm?lang=#lang#&CID=#url.CID#">
</cfif>

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

<p>Please confirm the following information: </p>
<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
	<div id="actionErrors">Note: The ship measurements exceed the maximum dimensions of the dock (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</div>
</cfif>
<cfoutput>
<form id="editVessel" action="EditVessel_action.cfm?lang=#lang#" method="post">
	<div class="module-info widemod">
		<h2>Vessel Details</h2>
		<ul>
			<b>Company Name:</b> #getVesselDetail.CompanyName#<br/>
			<b>Name:</b> <input type="hidden" name="name" value="#Variables.Name#" />#Variables.Name#<br/>
			<b>International Maritime Organization (I.M.O.) number:</b> <input type="hidden" name="LloydsID" value="#Variables.LloydsID#" />#Variables.LloydsID#<br/>
			<b>Length:</b> <input type="hidden" name="length" value="#Variables.Length#" />#Variables.Length#<br/>
			<b>Width:</b> <input type="hidden" name="width" value="#Variables.Width#" />#Variables.Width#<br/>
			<b>Block Setup Time:</b> <input type="hidden" name="blocksetuptime" value="#Variables.Blocksetuptime#" />#Variables.Blocksetuptime#<br/>
			<b>Block Teardown Time:</b> <input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#" />#Variables.Blockteardowntime#<br/>
			<b>Tonnage:</b> <input type="hidden" name="tonnage" value="#Variables.Tonnage#" />#Variables.Tonnage#<br/>
			<b>Anonymous:</b> <input type="hidden" name="Anonymous" value="#Variables.Anonymous#" /><cfif Variables.Anonymous EQ 1>Yes<cfelse>No</cfif><br/>
		</ul>
	</div>
<br/>
	<input type="hidden" name="VNID" value="<cfoutput>#Form.VNID#</cfoutput>" />
	<input type="hidden" name="CID" value="<cfoutput>#Form.CID#</cfoutput>" />
	<input type="submit" value="Confirm" class="button-accent button" />
	<br />
	<a href="editVessel.cfm?lang=#lang#" class="textbutton">Back</a>
	<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
</form>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
