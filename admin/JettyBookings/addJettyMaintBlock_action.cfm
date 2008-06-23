<cftransaction>
	<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	INSERT INTO	Bookings ( StartDate, EndDate, BookingTime, UserID)
	VALUES	(
			<cfqueryparam value="#CreateODBCDate(Form.StartDate)#" cfsqltype="cf_sql_date">,
			<cfqueryparam value="#CreateODBCDate(Form.EndDate)#" cfsqltype="cf_sql_date">,
			<cfqueryparam value="#CreateODBCDateTime(PacificNow)#" cfsqltype="cf_sql_timestamp">, 
			'#Session.UserID#'
			)
	</cfquery>
	<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	DISTINCT @@IDENTITY AS BookingID
	FROM	Bookings
	</cfquery>
	<cfquery name="insertDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	INSERT INTO Jetties (BookingID, Status, NorthJetty, SouthJetty)
	VALUES		('#getID.BookingID#', 'M',
			<cfif Form.NorthJetty EQ 1>'1',<cfelse>'0',</cfif>
			<cfif Form.SouthJetty EQ 1>'1'<cfelse>'0'</cfif>) <!--- M for Maintenance --->
	</cfquery>
</cftransaction>

<!--- URL tokens set-up.  Do not edit unless you KNOW something is wrong.
	Lois Chan, July 2007 --->
<CFSET variables.urltoken = "lang=#lang#">
<CFIF IsDefined('variables.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#variables.startDate#">
<CFELSEIF IsDefined('url.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#url.startDate#">
</CFIF>
<CFIF IsDefined('variables.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#variables.endDate#">
<CFELSEIF IsDefined('url.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#url.endDate#">
</CFIF>
<CFIF IsDefined('variables.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
<CFELSEIF IsDefined('url.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
</CFIF>

<!--- create structure for sending to mothership/success page. --->
<cfset Session.Success.Breadcrumb = "<A href='../admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#'>Jetty Management</A> &gt; Add Maintenance Block">
<cfset Session.Success.Title = "Create New Maintenance Block">
<cfset Session.Success.Message = "A new maintenance block has been created from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')#.">
<cfset Session.Success.Back = "Back to Jetty Bookings Management">
<cfset Session.Success.Link = "#RootDir#text/admin/JettyBookings/jettybookingmanage.cfm?#urltoken#">
<cflocation addtoken="no" url="#RootDir#text/comm/success.cfm?lang=#lang#">

<cflocation addtoken="no" url="jettyBookingManage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#">