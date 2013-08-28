<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>">
	<cfset request.title = "Change Booking Status">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Jetty Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/JettyBookings/editJettyBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>
		
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Change Booking Status
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<!--- -------------------------------------------------------------------------------------------- --->
<cfparam name="Variables.BRID" default="">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
<cfelseif IsDefined("Form.BRID")>
	<cfset Variables.BRID = Form.BRID>
<cfelse>
	<cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
</cfif>

<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 
		Bookings.BRID, 
		StartDate, 
		EndDate, 
		Vessels.VNID, 
		Vessels.Name AS VesselName, 
		Companies.Name AS CompanyName, 
		NorthJetty
	FROM 
		Bookings INNER JOIN Jetties
			ON Bookings.BRID = Jetties.BRID
		INNER JOIN Vessels
			ON Vessels.VNID = Bookings.VNID
		INNER JOIN Companies 
			ON Companies.CID = Vessels.CID
	WHERE 
		Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
		
</cfquery>

<cfset Variables.VNID = theBooking.VNID>
<cfset Variables.VesselName = theBooking.VesselName>
<cfset Variables.CompanyName = theBooking.CompanyName>
<cfset Variables.Start = CreateODBCDate(theBooking.StartDate)>
<cfset Variables.End = CreateODBCDate(theBooking.EndDate)>
<cfset Variables.Jetty = "North Landing Wharf">
<cfif theBooking.NorthJetty EQ 0>
	<cfset Variables.Jetty = "South Jetty">
</cfif>

<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
	<cfset Variables.Start = CreateODBCDate(form.StartDate)>
	<cfset Variables.End = CreateODBCDate(form.EndDate)>
</cfif>


<cfform action="chgStatus_2p_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" name="change2pending">
	Are you sure you want to change this booking's status to pending?
<br /><br />
	<cfoutput>
	<input type="hidden" name="BRID" value="#Form.BRID#" />
	
	<div class="module-info widemod">
			<h2>Booking Details</h2>
			<ul>
				<b>Vessel:</b> <input type="hidden" name="VNID" value="<cfoutput>#Variables.VNID#</cfoutput>" /><cfoutput>#Variables.VesselName#</cfoutput><br/>
				<b>Company:</b> <cfoutput>#Variables.CompanyName#</cfoutput><br/>
				<b>Jetty:</b> #Variables.Jetty#<br/>
				<b>Start Date:</b> #DateFormat(Variables.Start, "mmm d, yyyy")#<br/>
				<b>End Date:</b> #DateFormat(Variables.End, "mmm d, yyyy")#<br/>
			</ul>
		</div>
	<br/>
	<b>Pending Type:</b>
			<div class="form-radio">
				<label for="pendingType"><input type="radio" name="pendingType" value="PT" checked />Pending T</label>
				<label for="pendingType"><input type="radio" name="pendingType" value="PC" checked />Pending C</label>
				<label for="pendingType"><input type="radio" name="pendingType" value="PX" checked />Pending X</label>
			</div>
	</cfoutput>
<br/>
	<input type="submit" value="Submit" class="button button-accent" />
	<cfoutput><a href="#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Variables.BRID###id#Variables.BRID#">Cancel</a></cfoutput>
		
</cfform>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
