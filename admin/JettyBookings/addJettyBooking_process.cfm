<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>
<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

<!---Check to see that vessel hasn't already been booked during this time--->
<!--- 25 October 2005: This query now only looks at the jetties bookings --->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VNID, Bookings.BRID, Name, Bookings.StartDate, Bookings.EndDate
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
				INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE 	Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
	AND
	<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates
		of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day
		bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than
		a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that
		fall within a booking that is more than one day.--->
			(
				(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR  (	(Bookings.StartDate = Bookings.EndDate OR <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />) AND Bookings.StartDate <> <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND
						((	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate)
					OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate)
					OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)))
			)
	AND		Bookings.Deleted = 0
	<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
		AND Jetties.NorthJetty = 1
	<cfelse>
		AND Jetties.SouthJetty = 1
	</cfif>

</cfquery>


<!--- 25 October 2005: The next two queries have been modified to only get results from the jetties bookings --->
<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID, Vessels.Name, Bookings.StartDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
				INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
	WHERE	(StartDate = <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> OR EndDate = <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" />)
				AND Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
				AND Bookings.Deleted = 0
			<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
				AND Jetties.NorthJetty = 1
			<cfelse>
				AND Jetties.SouthJetty = 1
			</cfif>
</cfquery>

<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID, Vessels.Name, Bookings.EndDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
				INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
	WHERE	(EndDate = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> OR StartDate = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />)
				AND Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
				AND Bookings.Deleted = 0
			<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
				AND Jetties.NorthJetty = 1
			<cfelse>
				AND Jetties.SouthJetty = 1
			</cfif>
</cfquery>


<cfparam name="Form.Jetty" default="off">
<cfparam name="Form.confirmed" default="off">

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif DateCompare(PacificNow, Form.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "The Start Date cannot be in the past.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif isDefined("checkDblBooking.VNID") AND checkDblBooking.VNID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumStartDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# already has a booking for #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumEndDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# already has a booking for #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Form.StartDate GT Form.EndDate>
	<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<cfif IsDefined("Form.Status") EQ False>
	<cfset Form.Status = 'PT'>
</cfif>
<cfif Proceed_OK EQ "No">

	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.compID = Form.compID>
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
	<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
	<cfset Session.Return_Structure.VNID = Form.VNID>
	<cfset Session.Return_Structure.UID = Form.UID>
	<cfset Session.Return_Structure.Jetty = Form.Jetty>
	<cfset Session.Return_Structure.Status = Form.Status>
	<cfset Session.Return_Structure.Errors = Errors>

<cfif form.submitForm NEQ 'override'>
 	<cflocation url="addJettyBooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addToken="no">
</cfif>
</cfif>


<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
<cfparam name = "Variables.NorthJetty" default = "0">
<cfparam name = "Variables.SouthJetty" default = "0">
<cfparam name = "Variables.Status" default="PT">

<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
	<cfset Variables.NorthJetty = 1>
</cfif>
<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "south">
	<cfset Variables.SouthJetty = 1>
</cfif>
<cfif IsDefined("Form.status")>
	<cfset Variables.Status = Form.Status>
</cfif>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	Companies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name, Length
	FROM	Vessels
	WHERE	Vessels.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	firstname + ' ' + lastname AS Name
	FROM	Users
	WHERE	Users.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking</title>">
	<cfset request.title = "Add Jetty Booking">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Add Jetty Booking
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

	<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
	<!--- ---------------------------------------------------------------------------------------------------------------- --->


<!---Check to see if jetty has already reached capacity (304m for NLW and 301m for South Jetty)--->
<CFIF Variables.NorthJetty>
  <CFSET error=0>
  <CFSET tempDate = #Variables.StartDate#>
  <!---Loop through each day of the booking to check for capacity--->
  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #Variables.EndDate#">
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
	  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#getVessel.Length#) GT 304 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#<br />
		  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #getVessel.Length#m</p>
		<table class="basic smallFont">
		<tr>
		  <th id="Dates" align="left">Docking Dates</th>
		  <th id="Vessel" align="left">Vessel</th>
		  <th align=left>Length</th>
		</tr>
		<CFSET errorDate = #tempDate#>
		<CFELSEIF #getVessel.Length# GT 304 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #getVessel.Length#m</p>
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
  <CFELSEIF Variables.SouthJetty>
  <CFSET error=0>
  <CFSET tempDate = #Variables.StartDate#>
  <!---Loop through each day of the booking to check for capacity--->
  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #Variables.EndDate#">
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
	  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#getVessel.Length#) GT 301 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #getVessel.Length#m</p>
		<table class="basic smallFont">
		<tr>
		  <th id="Dates" align="left">Docking Dates</th>
		  <th id="Vessel" align="left">Vessel</th>
		  <th align=left>Length</th>
		</tr>
		<CFSET errorDate = #tempDate#>
		<CFELSEIF #getVessel.Length# GT 301 AND NOT #error#>
		<CFSET error=1>
		<div class="critical">
		<p>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
		Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #getVessel.Length#m</p>
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


	<!-- Gets all Bookings that would be affected by the requested booking -->
	<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
	<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>

	<p>Please confirm the following information.</p>
	<cfoutput>
	<form action="addJettyBooking_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post" id="bookingreq" preservedata="Yes">


<div class="module-info widemod">
	<h2>Booking Details</h2>
	<ul>
		<b>Company:</b> <input type="hidden" name="company" value="#form.CID#" /> #getCompany.Name#<br/>
		<b>Vessel:</b> <input type="hidden" name="vessel" value="#form.VNID#" /> #getVessel.Name#<br/>
		<b>Agent:</b> <input type="hidden" name="agent" value="#form.UID#" /> #getAgent.Name#<br/>
		<b>Start Date:</b> <input type="hidden" name="StartDate" value="#Variables.StartDate#" />#DateFormat(Variables.StartDate, 'mmm d, yyyy')#<br/>
		<b>End Date:</b> <input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput><br/>
		<b>Booking Time:</b> <input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
      <input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
      #DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#<br/>
		<b>Status:</b> <input type="hidden" name="Status" value="<cfoutput>#Variables.Status#</cfoutput>" /><cfif Variables.Status EQ "PT">Pending<cfelseif Variables.Status EQ "T">Tentative</cfif><br/>
		<b>Section:</b> <input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>" />
		    <input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>" />
		    <cfif Variables.NorthJetty EQ 1>
		      North Landing Wharf
		    <cfelseif Variables.SouthJetty EQ 1>
		      South Jetty
		    </cfif><br/>
	</ul>
</div>

	<br />

		<input type="submit" value="Submit" class="button button-accent" />
		<br />
		<cfoutput><a href="jettyBookingManage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" style="padding-right: 10px">Cancel</a></cfoutput>
		<cfoutput><a href="addJettyBooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Back</a></cfoutput>
			
	</form>
	</cfoutput>


		
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
