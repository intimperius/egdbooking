<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"">
<meta name=""keywords"" lang=""eng"" content=""Edit Vessel Profile"">
<meta name=""description"" lang=""eng"" content=""Allows user to edit the details of a vessel."">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfif isDefined("form.companyID")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>

<CFIF IsDefined('url.companyID')>
	<CFSET form.companyID = url.companyID>
</CFIF>
<CFIF IsDefined('url.vesselID')>
	<CFSET form.vesselID = url.vesselID>
</CFIF>

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("form.companyID")>
	<cfset companyDefault = #form.companyID#>
<cfelse>
	<cfset companyDefault = 0>
</cfif>
<cfif isDefined("form.vesselID")>
	<cfset vesselDefault = #form.vesselID#>
<cfelse>
	<cfset vesselDefault = 0>
</cfif>

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Edit Vessel
</div>

<cfparam name="form.vesselID" default="">

<!---<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VesselID, Name
	FROM 	Vessels
	WHERE 	Deleted = 0
	ORDER BY Name
</cfquery>--->

<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT vesselID, vessels.Name AS VesselName, companies.companyID, companies.Name AS CompanyName
	FROM Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE Vessels.Deleted = 0 AND Companies.Deleted = 0 AND Companies.Approved = 1
	ORDER BY Companies.Name, Vessels.Name
</cfquery>

<div class="main">
<H1>Edit Vessel</H1>
<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
<cfinclude template="#RootDir#includes/getStructure.cfm"><br>

<cfform action="editVessel.cfm?lang=#lang#" method="post" name="chooseVesselForm">
<table width="100%">
	<!---<cfselect name="vesselID" query="getVessels" display="name" value="vesselID" selected="#form.vesselID#" />--->
	<tr>
		<td valign="baseline">Company:</td>
		<td>
			<CF_TwoSelectsRelated 
				QUERY="companyVessels" 
				NAME1="CompanyID" 
				NAME2="VesselID" 
				DISPLAY1="CompanyName" 
				DISPLAY2="VesselName" 
				VALUE1="companyID" 
				VALUE2="vesselID"  
				SIZE1="1" 
				SIZE2="1" 
				HTMLBETWEEN="</td></tr><tr><td>Vessel:</td><td>" 
				AUTOSELECTFIRST="Yes" 
				EMPTYTEXT1="(choose a company)" 
				EMPTYTEXT2="(choose a vessel)"
				DEFAULT1 ="#companyDefault#"
				DEFAULT2 ="#vesselDefault#" 
				FORMNAME="chooseVesselForm">
		</td>
	</tr>
	<tr><td colspan="2" align="right">
		<input type="submit" name="submitForm" class="textbutton" value="Edit">
		<cfoutput><input type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#';" class="textbutton"></cfoutput>
	</td></tr>
</table>
</cfform>
<br>

<cfif form.vesselID NEQ "">

	<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName
		FROM	Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
		WHERE	VesselID = '#Form.VesselID#'
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
	
	<!--- 	<CFQUERY name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName, Users.FirstName + ' ' + Users.LastName AS UserName, Users.userID
			FROM  Vessels INNER JOIN
				Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
				UserCompanies ON Companies.CompanyID = UserCompanies.CompanyID INNER JOIN 
				Users ON UserCompanies.UserID = Users.UserID
			WHERE VesselID = #form.VesselID#
			AND Vessels.Deleted = 0
		</CFQUERY> --->
	
	<cfif getVesselDetail.recordCount EQ 0>
		<cflocation addtoken="no" url="menu.cfm?lang=#lang#">
	</cfif>

	<cfform name="editVessel" action="EditVessel_process.cfm?lang=#lang#" method="post">
	<table align="center">
		<tr>
			<td id="Company_Header" width="42%">Company Name:</td>
			<td headers="Company_Header"><cfoutput>#getVesselDetail.companyName#</cfoutput></td>
			<!---<td><cfselect name="companyID" query="getCompanies" display="Name" value="companyID" selected="#getVesselDetail.companyID#" /></td>--->
		</tr>
		<tr>
			<td id="name_Header"><label for="name">Name:</label></td>
			<td headers="name_Header"><cfinput id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" required="yes" CLASS="textField" message="Please enter the vessel name."></td>
		</tr>
		<tr>
			<td id="LloydsID_Header"><label for="LloydsID">International Maritime Organization (IMO) Number:</label></td>
			<td headers="LloydsID_Header"><cfinput id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" required="no" CLASS="textField" message="Please enter the International Maritime Organization (I.M.O.) number."></td>
		</tr>
		<tr>
			<td id="length_Header"><label for="length">Length (m):</label></td>
			<td headers="length_Header"><cfinput id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="Please enter the length in metres.">  <span style="font-size: 9pt; color: red">Max: <cfoutput>#Variables.MaxLength#</cfoutput>m</span></td>
		</tr>
		<tr>
			<td id="width_Header"><label for="width">Width (m):</label></td>
			<td headers="width_Header"><cfinput id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="Please enter the width in metres.">  <span style="font-size: 9pt; color: red">Max: <cfoutput>#Variables.MaxWidth#</cfoutput>m</span></td>
		</tr>
		<tr>
			<td id="blocksetuptime_Header"><label for="blocksetuptime">Block Setup Time (days):</label></td>
			<td headers="blocksetuptime_Header"><cfinput id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="Please enter the block setup time in days."></td>
		</tr>
		<tr>
			<td id="blockteardowntime_Header"><label for="blockteardowntime">Block Teardown Time (days):</label></td>
			<td headers="blockteardowntime_Header"><cfinput id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="Please enter the block teardown time in days."></td>
		</tr>
		<tr>
			<td id="tonnage_Header"><label for="tonnage">Tonnage:</label></td>
			<td headers="tonnage_Header"><cfinput id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="Please enter the tonnage."></td>
		</tr>
		<tr>
			<td id="Anonymous_Header"><label for="Anonymous">Keep this vessel anonymous:</label></td>
			<td headers="Anonymous_Header"><input id="Anonymous" type="checkbox" name="Anonymous"<cfif variables.Anonymous EQ 1> checked</cfif> value="Yes"></td>
		</tr><!---
		<tr>
			<td id="Highlight_Header"><label for="Anonymous">Highlight for this many days:</label></td>
			<td headers="Highlight_Header">
			<cfif variables.EndHighlight NEQ "">
			<cfset datediffhighlight = DateDiff("d", Now(), variables.EndHighlight)>
			<cfset datediffhighlight = datediffhighlight+"1">
			<cfif datediffhighlight LTE "0"><cfset datediffhighlight = "0"></cfif>
			<cfelse>
			<cfset datediffhighlight = "0">
			</cfif>
			<cfinput id="EndHighlight" name="EndHighlight" type="text" value="#datediffhighlight#" size="8" maxlength="8" required="yes" CLASS="textField" message="Please enter an End Highlight Date."></td>
		</tr>--->
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<!--a href="javascript:document.editVessel.submitForm.click();" class="textbutton">Submit</a>
				<a href="javascript:history.go(-1);" class="textbutton">Cancel</a>
				<br-->
				<input type="hidden" name="vesselID" value="<cfoutput>#form.vesselID#</cfoutput>">
				<input type="hidden" name="companyID" value="<cfoutput>#form.companyID#</cfoutput>">
				<input type="Submit" value="Submit" class="textbutton">
				<cfoutput><input type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton"></cfoutput>
			</td>
		</tr>
	</table>
	</cfform>
</cfif>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">