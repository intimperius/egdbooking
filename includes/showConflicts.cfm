<cfquery name="currentBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.*, Docks.*, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM	Bookings INNER JOIN Docks ON Bookings.BRID = Docks.BRID 
			INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID 
			INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE	Status = 'C' AND
			(
			(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
		OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
		OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)
			)
	AND		Vessels.Deleted = '0'
	AND		Companies.Deleted = '0'
	AND		Bookings.Deleted = '0'
</cfquery>
<cfquery name="currentMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.*, Docks.*
	FROM	Bookings INNER JOIN Docks ON Bookings.BRID = Docks.BRID 
	WHERE	Status = 'M' AND
			(
			(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
		OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
		OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)
			)
	AND		Deleted = '0'
</cfquery>

<cfif lang EQ "eng">
	<cfset language.bookings = "Booking(s) in Conflict">
	<cfset language.maintenance = "Maintenance Block(s) in Conflict">
	<cfset language.period = "Period">
	<cfset language.vessel = "Vessel">
	<cfset language.company = "Company">
	<cfset language.sections = "Sections">
<cfelse>
	<cfset language.bookings = "R&eacute;servation(s) conflictuelle(s):">
	<cfset language.maintenance = "P&eacute;riode(s) de maintenance conflictuelle(s):">
	<cfset language.period = "P&eacute;riode">
	<cfset language.vessel = "Navire">
	<cfset language.company = "Entreprise">
	<cfset language.sections = "Sections">
</cfif>

<cfif currentBookings.RecordCount GT 0>
	<cfoutput>
	<h2 class="conflict">#language.Bookings#:</h2>
	<table class="basic smallFont">
	<tr>
		<th align="left">#language.Period#</th>
		<th align="left">#language.Vessel#</th>
		<th align="left">#language.Company#</th>
		<th align="left">#language.Sections#</th>
	</tr>
	</cfoutput>
	<cfset counter = 0>
	<cfoutput query="currentBookings">
		<CFIF counter mod 2 eq 1>
			<CFSET rowClass = "highlight">
		<CFELSE>
			<CFSET rowClass = "">
		</CFIF>
		<tr class="#rowClass#">
			<td valign="top">#myDateFormat(startDate, request.datemask)# - #myDateFormat(endDate, request.datemask)#</td>
			<td>#VesselName#</td>
			<td>#CompanyName#</td>
			<td align="center">
				<cfif Section1 EQ 1>1 </cfif>
				<cfif Section2 EQ 1>2 </cfif>
				<cfif Section3 EQ 1>3 </cfif>
			</td>
		</tr>
		<cfset counter = counter + 1>
	</cfoutput>
	</table>
</cfif>
<cfif currentMaintenance.RecordCount GT 0>
	<cfoutput>
	<h2 class="conflict">#language.Maintenance#:</h2>
	<cfset counter = 0>
	<table class="basic smallFont">
	<tr>
		<th align="left">#language.Period#</th>
		<th align="left">#language.Sections#</th>
	</tr>
	</cfoutput>
	<cfoutput query="currentMaintenance">
		<cfif counter mod 2 EQ 1>
			<cfset rowClass = "highlight">
		<cfelse>
			<cfset rowClass = "">
		</cfif>
		<tr class="rowClass">
			<td valign="top">#myDateFormat(startDate, request.datemask)# - #myDateFormat(endDate, request.datemask)#</td>
			<td align="center">
				<cfif Section1 EQ 1>1 </cfif>
				<cfif Section2 EQ 1>2 </cfif>
				<cfif Section3 EQ 1>3 </cfif>
			</td>
		</tr>
	</cfoutput>
	</table>
	<br />
</cfif>
