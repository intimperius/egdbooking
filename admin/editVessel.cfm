<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"" />
	<meta name=""keywords"" content=""Edit Vessel Profile"" />
	<meta name=""description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dcterms.description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">
	<cfset request.title ="Edit Vessel">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.CID")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>

<CFIF IsDefined('url.CID')>
	<CFSET form.CID = url.CID>
</CFIF>
<CFIF IsDefined('url.VNID')>
	<CFSET form.VNID = url.VNID>
</CFIF>

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("form.CID")>
	<cfset companyDefault = #form.CID#>
<cfelse>
	<cfset companyDefault = 0>
</cfif>
<cfif isDefined("form.VNID")>
	<cfset vesselDefault = #form.VNID#>
<cfelse>
	<cfset vesselDefault = 0>
</cfif>

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Edit Vessel
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<cfparam name="form.VNID" default="">

<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT VNID, vessels.Name AS VesselName, companies.CID, companies.Name AS CompanyName
	FROM Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE Vessels.Deleted = 0 AND Companies.Deleted = 0 AND Companies.Approved = 1
	ORDER BY Companies.Name, Vessels.Name
</cfquery>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfinclude template="#RootDir#includes/getStructure.cfm">

<cfoutput>
<form action="editVessel.cfm?lang=#lang#" method="post" id="chooseVesselForm">
<div>
	Company:<br/>
	<CF_TwoSelectsRelated
		QUERY="companyVessels"
		id1="CID"
		id2="VNID"
		DISPLAY1="CompanyName"
		DISPLAY2="VesselName"
		VALUE1="CID"
		VALUE2="VNID"
		SIZE1="1"
		SIZE2="1"
		htmlBETWEEN="<br/>Vessel<br/>"
		AUTOSELECTFIRST="Yes"
		EMPTYTEXT1="(choose a company)"
		EMPTYTEXT2="(choose a vessel)"
		DEFAULT1 ="#companyDefault#"
		DEFAULT2 ="#vesselDefault#"
		FORMNAME="chooseVesselForm">
</div>
	<div >
		<input type="submit" name="submitForm" class="button-accent button" value="Edit" />
		<cfoutput><a href="menu.cfm?lang=#lang#">Cancel</a></cfoutput>
	</div>

</form>
</cfoutput>


<cfif form.VNID NEQ "">
	<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.*, Companies.CID, Companies.Name AS CompanyName
		FROM	Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
		WHERE	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
			AND	Vessels.Deleted = 0
	</cfquery>

	<cfif isDefined("session.form_structure") AND isDefined("form.name")>
		<!---<cfset variables.EndHighlight = "#form.EndHighlight#">--->
		<cfset variables.name = "#form.name#">
		<cfset variables.LloydsID = "#form.LloydsID#">
		<cfset variables.length = "#form.length#">
		<cfset variables.width = "#form.width#">
		<cfset variables.blocksetuptime = "#form.blocksetuptime#">
		<cfset variables.blockteardowntime = "#form.blockteardowntime#">
		<cfset variables.tonnage = "#form.tonnage#">
		<cfif isDefined("form.Anonymous")><cfset variables.Anonymous = 1><cfelse><cfset variables.Anonymous = 0></cfif>
	<cfelse>
		<!---<cfset variables.EndHighlight = "#getVesselDetail.EndHighlight#">--->
		<cfset variables.name = "#getVesselDetail.name#">
		<cfset variables.LloydsID = "#getVesselDetail.LloydsID#">
		<cfset variables.length = "#getVesselDetail.length#">
		<cfset variables.width = "#getVesselDetail.width#">
		<cfset variables.blocksetuptime = "#getVesselDetail.blocksetuptime#">
		<cfset variables.blockteardowntime = "#getVesselDetail.blockteardowntime#">
		<cfset variables.tonnage = "#getVesselDetail.tonnage#">
		<cfset variables.Anonymous = "#getVesselDetail.Anonymous#">
	</cfif>

	<cfif getVesselDetail.recordCount EQ 0>
		<cflocation addtoken="no" url="menu.cfm?lang=#lang#">
	</cfif>

	<cfoutput>
	<form id="editVessel" action="EditVessel_process.cfm?lang=#lang#" method="post">
	<h2>Edit <cfoutput>#variables.Name#</cfoutput></h2>
		
	Company Name: 
	<cfoutput>#getVesselDetail.companyName#</cfoutput>

	<label for="name">Name:</label>
	<input id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" required="yes" message="Please enter the vessel name." />

	<label for="LloydsID">International Maritime Organization (IMO) Number:</label>
	<input id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" required="no" message="Please enter the International Maritime Organization (I.M.O.) number."/>
		
	<label for="length">Length (m):</label>
	<input id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the length in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxLength#</cfoutput>m</span>

	<label for="width">Width (m):</label>
	<input id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the width in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxWidth#</cfoutput>m</span>

	<label for="blocksetuptime">Block Setup Time (days):</label>
	<input id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" message="Please enter the block setup time in days." />

	<label for="blockteardowntime">Block Teardown Time (days):</label>
	<input id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" message="Please enter the block teardown time in days." />

	<label for="tonnage">Tonnage:</label>
	<input id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the tonnage." />

	<label for="Anonymous">Keep this vessel anonymous:</label>
	<input id="Anonymous" type="checkbox" name="Anonymous"<cfif variables.Anonymous EQ 1> checked="true"</cfif> value="Yes" />

	<br/><br/>
	
		<input type="hidden" name="VNID" value="<cfoutput>#form.VNID#</cfoutput>" />
		<input type="hidden" name="CID" value="<cfoutput>#form.CID#</cfoutput>" />
		<input type="submit" value="Submit" class="button-accent button" />
		<cfoutput><a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
	
		
	</table>
	</form>
	</cfoutput>
</cfif>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
