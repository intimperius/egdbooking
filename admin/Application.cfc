<cfcomponent>
	<cfset this.name = "EGD Booking" />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(2,0,0,0) />
	<cfset this.clientmanagement = false />
	<cfset setEncoding("url","iso-8859-1") />

	<cffunction name="onRequest" access="public" returntype="void">
		<cfargument name="targetPage" type="String" required="true" />

		<cfinclude template="../server_settings.cfm" />
    <cfset this.mappings["/egdbooking"] = FileDir />

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no" />
    </cfif>

    <cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Email
      FROM	Configuration
    </cfquery>

	<!---Pull session information from cookies--->
	<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
		<cfif isDefined("Cookie.UID")><cfset Session.UID = "#Cookie.UID#"></cfif>
		<cfif isDefined("Cookie.FirstName")><cfset Session.FirstName = "#Cookie.FirstName#"></cfif>
		<cfif isDefined("Cookie.LastName")><cfset Session.LastName = "#Cookie.LastName#"></cfif>
		<cfif isDefined("Cookie.EMail")><cfset Session.EMail = "#Cookie.EMail#"></cfif>
		<cfif isDefined("Cookie.LoggedIn")><cfset Session.LoggedIn = "#Cookie.LoggedIn#"></cfif>
		
		<cfif isDefined("Cookie.AdminLoggedIn")><cfset Session.AdminLoggedIn = "#Cookie.AdminLoggedIn#"></cfif>
		<cfif isDefined("Cookie.AdminEmail")><cfset Session.EMail = "#Cookie.AdminEmail#"></cfif>
	</cflock>
	
    <cfif not IsDefined("Session.AdminLoggedIn")>
      <cflocation url="#RootDir#ols-login/ols-login.cfm" addtoken="no">
    </cfif>

    <cfparam name="lang" default="eng">
    <cfset request.datemask = "mmm d, yyyy" />
    <cfset request.longdatemask = "mmmm d, yyyy" />

    <cfset Variables.MaxLength = 347.67>
    <cfset Variables.MaxWidth = 45.40>

    <cfif NOT IsDefined("URL.lang")>
      <cfparam name="url.lang" default="eng">
    </cfif>
    <cfif lcase(url.lang) NEQ "eng">
      <cfparam name="url.lang" default="eng">
    </cfif>

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
    <cfinclude template="#RootDir#includes/helperFunctions.cfm">

    <cfinclude template="#arguments.targetPage#" />
  </cffunction>
</cfcomponent>
