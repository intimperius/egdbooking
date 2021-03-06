<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.address = "The email address">
	<cfset language.notReg = "is not registered">
	<cfset language.enterInfoError = "Please enter your login information.">
<cfelse>
	<cfset language.address = "L'adresse de courriel">
	<cfset language.notReg = "n'est pas enregistr&eacute;e">
	<cfset language.enterInfoError = "Veuillez entrer les renseignements dont vous avez besoin pour ouvrir une session.">
</cfif>

<!-- If a cookie is present on the system, bypass the login and go right into the system -->
<cfif IsDefined("Cookie.email")>
	<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	*
		FROM	Users
		WHERE	email = <cfqueryparam value="#Cookie.email#" cfsqltype="cf_sql_varchar" />
	</cfquery>
<cfelse>
	<cfquery name="getPassHash" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT TOP 1 Password
	FROM Users
	WHERE email = <cfqueryparam value="#Form.email#" cfsqltype="cf_sql_varchar" />
	AND Deleted = '0'
	</cfquery>
	<cfif getPassHash.getRowCount() GT 0>
		<cfscript>
			jbClass = ArrayNew(1);
			jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
      javaloader = createObject('component','lib.javaloader.JavaLoader');
			javaloader.init(jbClass);

			bcrypt = javaloader.create("BCrypt");
			match = bcrypt.checkpw(form.password, getPassHash.Password);
		</cfscript>
	</cfif>

	<cfquery name="IsValidLogin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Count(*) AS Login_Match
		FROM	Users
		WHERE	email = <cfqueryparam value="#Form.email#" cfsqltype="cf_sql_varchar" />
		AND 	Deleted = '0'
		AND	EXISTS (SELECT	*
					FROM	UserCompanies
					WHERE	UserCompanies.UID = Users.UID 
					AND 	Approved = 1
					AND		Deleted = 0)
	</cfquery>

	<cfif IsValidLogin.Login_Match IS "0" OR match EQ "NO">
		<cfset Variables.Errors = ArrayNew(1)>
		
		<cfquery name="checkEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Count(*) AS NumFound
			FROM	Users
			WHERE	email = <cfqueryparam value="#Form.email#" cfsqltype="cf_sql_varchar" />
			AND 	Deleted = '0'
		</cfquery>

		<cfquery name="notApproved" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Count(*) AS NumFound
			FROM	Users
			WHERE	email = <cfqueryparam value="#Form.email#" cfsqltype="cf_sql_varchar" />
			AND 	Deleted = '0'
			AND	NOT EXISTS (SELECT	*
							FROM	UserCompanies
							WHERE	UserCompanies.UID = Users.UID
							AND 	Approved = 1
							AND		Deleted = 0)
		</cfquery>

		<cfif checkEmail.NumFound EQ 0>
      <cfset session['errors']['email'] = language.incorrectPasswordError />
      <cfset session['errors']['password'] = language.incorrectPasswordError />
		<cfelseif match EQ "NO">
      <cfset session['errors']['email'] = language.incorrectPasswordError />
      <cfset session['errors']['password'] = language.incorrectPasswordError />
		</cfif>

    <cfif form.email EQ ''>
      <cfset session['errors']['email'] = language.enterInfoError />
		<cfelseif NOT REFindNoCase("^([a-zA-Z_\.\-\']*[a-zA-Z0-9_\.\-\'])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$", trim(Form.Email))>
      <cfset session['errors']['email'] = language.invalidEmailError />
		<cfelseif notApproved.NumFound GT 0 AND checkEmail.NumFound GT 0>
      <cfset session['errors']['email'] = language.unapprovedEmailError />
    </cfif>


		<cfinclude template="#RootDir#includes/build_return_struct.cfm">
		<cflocation url="ols-login.cfm?lang=#lang#" addtoken="no">
		
	<!---Otherwise send them to the home page of the application --->
	<cfelse>
		<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	*
			FROM	Users 
			WHERE	email = <cfqueryparam value="#Form.email#" cfsqltype="cf_sql_varchar" />
			AND     Deleted = 0
		</cfquery>
	</cfif>
</cfif>

<CFCOOKIE NAME="LoggedIn" value="Yes" PATH="/EGD" DOMAIN="cse-egd.tpsgc-pwgsc.gc.ca">

<CFIF IsDefined('form.remember')>
	<!---SET COOKIE--->
	<cfoutput>
	<CFLOCK timeout="60" throwontimeout="No" type="READONLY" scope="SESSION">
		<CFCOOKIE NAME="login" value="#Form.email#" EXPIRES="Never">
	</CFLOCK>
	</cfoutput>
<CFELSE>
	<!---DELETE COOKIE--->
	<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
		<CFCOOKIE NAME="login" value="empty" EXPIRES="Now">
	</cflock>
</CFIF>

<!--- Set the session variables for the session --->
<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<CFSCRIPT>
	Session.UID = Trim(GetUser.UID);
	Session.FirstName = Trim(GetUser.Firstname);
	Session.LastName = Trim(GetUser.LastName);
	Session.EMail = Trim(GetUser.EMail);
	</CFSCRIPT>
</cflock>

<cfquery name="CheckAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Count(UID) AS NumFound
	FROM	Administrators
	WHERE	UID = <cfqueryparam value="#GetUser.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif CheckAdmin.NumFound GT 0>
	<CFLOCK TIMEOUT="60" THROWONTIMEOUT="No" TYPE="EXCLUSIVE" SCOPE="SESSION"> 
		<CFSET Session.AdminLoggedIn = "1">
		<CFSET Session.AdminEmail = "egd-cse@pwgsc-tpsgc.gc.ca">
	</CFLOCK>
	<CFheadER STATUSCODE="302" STATUSTEXT="Object Temporarily Moved">
	<CFheadER NAME="location" value="#RootDir#admin/menu.cfm?lang=#lang#">
<cfelse>
	<CFLOCK TIMEOUT="60" THROWONTIMEOUT="No" TYPE="EXCLUSIVE" SCOPE="SESSION"> 
		<CFSET Session.LoggedIn = "1">
	</CFLOCK>
	<CFheadER STATUSCODE="302" STATUSTEXT="Object Temporarily Moved">
	<CFheadER NAME="location" value="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>


<!--- Jump right to the main menu page --->
