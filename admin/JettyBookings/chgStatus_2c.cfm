<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")>
  <cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>
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

<cfparam name="Variables.BRID" default="">
<cfif IsDefined("Session.Return_Structure")>
  <cfinclude template="#RootDir#includes/getStructure.cfm">
  <cfelseif IsDefined("Form.BRID")>
  <cfset Variables.BRID = Form.BRID>
  <cfelse>
  <cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
</cfif>

	
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Confirm Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<!--- -------------------------------------------------------------------------------------------- --->
<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT
		Bookings.BRID,
		StartDate,
		EndDate,
		Vessels.VNID,
		Vessels.Length,
		Vessels.Name AS VesselName,
		Companies.Name AS CompanyName,
		NorthJetty,
		SouthJetty
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
<!---Check to see if jetty has already reached capacity (304m for NLW and 301m for South Jetty)--->
<CFIF theBooking.NorthJetty>
  <CFSET error=0>
  <CFSET tempDate = #theBooking.StartDate#>
  <!---Loop through each day of the booking to check for capacity--->
  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #theBooking.EndDate#">
	<cfquery name="checkLength" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	SUM(Vessels.Length) as sumLength
	FROM		Bookings INNER JOIN
	Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
	Vessels ON Bookings.VNID = Vessels.VNID
	WHERE		((Bookings.StartDate <= <cfqueryparam value="#tempDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate >= <cfqueryparam value="#tempDate#" cfsqltype="cf_sql_date" />))
	AND Jetties.NorthJetty = '1'
	AND	Bookings.Deleted = '0'
	AND Jetties.Status = 'C'
	</cfquery>
	<cfoutput>
	  <!---check capacity for that day and see if it's the first error--->
	  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#theBooking.Length#) GT 304 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#<br />
		  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m</p>
		<table class="basic smallFont">
		<tr>
		  <th id="Dates" align="left">Docking Dates</th>
		  <th id="Vessel" align="left">Vessel</th>
		  <th align=left>Length</th>
		</tr>
		<CFSET errorDate = #tempDate#>
		<CFELSEIF #theBooking.Length# GT 304 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m</p>
		<CFSET errorDate = #tempDate#>
	  </CFIF>
	  <CFSET tempDate = DateFormat(DateAdd('d', 1, tempDate))>
	</cfoutput>
  </CFLOOP>
  <!---display table cells which list all boats that are confirmed on that day--->
  <CFIF #error#>
	<cfquery name="getLengthConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.StartDate, Bookings.EndDate, Vessels.Length, Vessels.Name
	FROM		Bookings INNER JOIN
	Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
	Vessels ON Bookings.VNID = Vessels.VNID
	WHERE		((Bookings.StartDate <= <cfqueryparam value="#errorDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate >= <cfqueryparam value="#errorDate#" cfsqltype="cf_sql_date" />))
	AND Jetties.NorthJetty = '1'
	AND	Bookings.Deleted = '0'
	AND Jetties.Status = 'C'
	</cfquery>
	<CFLOOP QUERY="getLengthConflicts">
	  <cfoutput>
		<tr valign="top">
		  <td headers="Dates" valign="top">#DateFormat(getLengthConflicts.StartDate, "mmm d")# - #DateFormat(getLengthConflicts.EndDate, "mmm d")#</td>
		  <td headers="Vessel" valign="top">#trim(getLengthConflicts.Name)#</td>
		  <td headers="Length" valign="top">#trim(getLengthConflicts.Length)#m</td>
		</tr>
	  </cfoutput>
	</CFLOOP>
	</table>
	</div>
  </CFIF>
  <CFELSEIF theBooking.SouthJetty>
  <CFSET error=0>
  <CFSET tempDate = #theBooking.StartDate#>
  <!---Loop through each day of the booking to check for capacity--->
  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #theBooking.EndDate#">
	<cfquery name="checkLength" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	SUM(Vessels.Length) as sumLength
	FROM		Bookings INNER JOIN
	Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
	Vessels ON Bookings.VNID = Vessels.VNID
	WHERE		((Bookings.StartDate <= <cfqueryparam value="#tempDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate >= <cfqueryparam value="#tempDate#" cfsqltype="cf_sql_date" />))
	AND Jetties.SouthJetty = '1'
	AND	Bookings.Deleted = '0'
	AND Jetties.Status = 'C'
	</cfquery>
	<cfoutput>
	  <!---check capacity for that day and see if it's the first error--->
	  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#theBooking.Length#) GT 301 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m</p>
		<table class="basic smallFont">
		<tr>
		  <th id="Dates" align="left">Docking Dates</th>
		  <th id="Vessel" align="left">Vessel</th>
		  <th align=left>Length</th>
		</tr>
		<CFSET errorDate = #tempDate#>
		<CFELSEIF #theBooking.Length# GT 301 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m</p>
		<CFSET errorDate = #tempDate#>
	  </CFIF>
	  <CFSET tempDate = DateFormat(DateAdd('d', 1, tempDate))>
	</cfoutput>
  </CFLOOP>
  <!---display table cells which list all boats that are confirmed on that day--->
  <CFIF #error#>
	<cfquery name="getLengthConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.StartDate, Bookings.EndDate, Vessels.Length, Vessels.Name
	FROM		Bookings INNER JOIN
	Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
	Vessels ON Bookings.VNID = Vessels.VNID
	WHERE		((Bookings.StartDate <= <cfqueryparam value="#errorDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate >= <cfqueryparam value="#errorDate#" cfsqltype="cf_sql_date" />))
	AND Jetties.SouthJetty = '1'
	AND	Bookings.Deleted = '0'
	AND Jetties.Status = 'C'
	</cfquery>
	<CFLOOP QUERY="getLengthConflicts">
	  <cfoutput>
		<tr valign="top">
		  <td headers="Dates" valign="top">#DateFormat(getLengthConflicts.StartDate, "mmm d")# - #DateFormat(getLengthConflicts.EndDate, "mmm d")#</td>
		  <td headers="Vessel" valign="top">#trim(getLengthConflicts.Name)#</td>
		  <td headers="Length" valign="top">#trim(getLengthConflicts.Length)#m</td>
		</tr>
	  </cfoutput>
	</CFLOOP>
	</table>
	</div>
  </CFIF>
</CFIF>
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
<p>Please confirm the following information.</p>
<!--- -------------------------------------------------------------------------------------------- --->
<cfform id="BookingConfirm" action="chgStatus_2c_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post">
  <cfoutput>
	<input type="hidden" name="BRID" value="#Variables.BRID#" />
  
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
	<input type="submit" value="Confirm" class="button-accent button" />
			<br />
		  <a href="#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Variables.BRID###id#Variables.BRID#">Cancel</a>
		</cfoutput>
</cfform>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
