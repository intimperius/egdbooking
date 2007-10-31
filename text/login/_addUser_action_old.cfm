<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "e">
	<cfset language.unmatchedPasswordsError = "Passwords do not match, please retype.">
<cfelse>
	<cfset language.unmatchedPasswordsError = "">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfquery name="getDeletedUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email
	FROM 	Users
	WHERE 	Email = '#trim(form.Email)#'
	AND 	Deleted = 1
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email
	FROM	Users
	WHERE 	EMail = '#trim(form.Email)#'
	AND		Deleted = '0'
</cfquery>

<cfif getUser.RecordCount GT 0>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.emailExistsError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<cfif Form.Password1 NEQ Form.Password2>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.unmatchedPasswordsError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif NOT REFindNoCase("^([a-zA-Z_\.\-\']*[a-zA-Z0-9_\.\-\'])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$",#trim(Form.Email)#)>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.invalidEmailError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="adduser.cfm?lang=#lang#" addtoken="no">
</cfif>




<cfif getDeletedUser.recordcount GT 0>
		<cfquery name="reviveUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE Users
			SET
				<!---LoginID = '#trim(form.loginID)#',--->
				FirstName = '#trim(form.firstname)#',
				LastName = '#trim(form.lastname)#',
				Password = '#trim(form.password1)#',
				Deleted = 0
			WHERE Email = '#trim(form.Email)#'
		</cfquery>
		
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT 	UserID
			FROM 	Users
			WHERE 	EMail = '#trim(form.Email)#'
		</cfquery>
			
<cfoutput>
	<cfmail to="#Variables.AdminEmail#" from="#form.Email#" subject="Reactivating Account" type="html">
#form.firstname# #form.lastname#, has requested to reactivate his/her account.
	</cfmail>
</cfoutput>

		<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&userID=#getID.UserID#">
	
<cfelseif getUser.recordcount EQ 0>
	<cftransaction>
		<cfquery name="insertNewUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Users
			(
				<!---LoginID,--->
				FirstName,
				LastName,
				Password,
				Email,
				Deleted
			)
			
			VALUES
			(
				<!---'#trim(form.loginID)#',--->
				'#trim(form.firstname)#',
				'#trim(form.lastname)#',
				'#trim(form.password1)#',
				'#trim(form.email)#',
				0
			)
		</cfquery>
		
		<cfquery name="getID2" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT UserID
			FROM Users
			WHERE EMail = '#trim(form.Email)#'
		</cfquery>
	</cftransaction>
	
<cfoutput>
	<cfmail to="#Variables.AdminEmail#" from="#form.Email#" subject="New User" type="html">
A new user, #form.firstname# #form.lastname#, has requested to create an account.
	</cfmail>
</cfoutput>
	
	<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&userID=#getID2.UserID#">
</cfif>