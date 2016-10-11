<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New User</title>">
	<cfset request.title = "Create New User">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CID, Name
	FROM 	Companies
	WHERE	Deleted = '0'
	ORDER BY CID
</cfquery>


<cfparam name="variables.FirstName" default="">
<cfparam name="variables.LastName" default="">
<cfparam name="variables.email" default="">
<cfparam name="variables.CID" default="#getCompanies.CID#">

<cfif isDefined("url.info")>
	<cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(URLDecode(url.info))), "boingfoip")>
	<cfset Variables.firstname = ListGetAt(userInfo, 1)>
	<cfset Variables.lastname = ListGetAt(userInfo, 2)>
	<cfset Variables.email = ListGetAt(userInfo, 3)>
</cfif>


<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Create New User
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfif isDefined("url.companies")>
					<cfset Variables.action = "addNewUserCompany.cfm?lang=#lang#&companies=#url.companies#">
<cfelse>
	<cfset Variables.action = "addNewUserCompany.cfm?lang=#lang#">
</cfif>

<cfoutput>
<form action="#Variables.action#" id="addUserForm" method="post">

		<label for="firstname">First Name:</label><input name="firstname" id="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" message="Please enter a first name." />
		<label for="lastname">Last Name:</label><input name="lastname" id="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" message="Please enter a last name." />
		<label for="password1">Password:</label><input id="password1" type="password" name="password1" required="yes" size="25" message="Please enter a password."><span class="smallFont" />(*min. 8 characters)</span>
		<label for="password2">Repeat Password:</label><input id="password2" type="password" name="password2" required="yes" size="25" message="Please repeat the password for verification." />
		<label for="email">Email:</label><input name="email" id="email" type="text" value="#variables.email#" size="40" maxlength="100" required="yes" message="Please enter an email address." />
		<br/>
				<!--a href="javascript:document.addUserForm.submitForm.click();" class="textbutton">Submit</a-->
				<input type="submit" name="submitForm" value="Continue" class="button button-accent" />
				<cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
			
</form>
</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
