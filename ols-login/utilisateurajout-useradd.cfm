<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.createUser = "Register an account">
	<cfset language.description = "Submit the following information to create an account to be able to book space at the Esquimalt Graving Dock.">
	<cfset language.passwordLabel = "Password">
	<cfset language.repeatPasswordLabel = "Confirm password">
	<cfset language.firstNameLabel = "First Name">
	<cfset language.lastNameLabel = "Last Name">
	<cfset language.emailLabel = "Email address (yourname@domain.com)">
	<cfset language.firstNameError = "Please enter your first name.">
	<cfset language.lastNameError = "Please enter your last name.">
	<cfset language.password1Error = "Please enter your password.">
	<cfset language.password2Error = "Please repeat your password for verification.">
	<cfset language.emailError = "Please enter your email address.">
	<cfset language.characters = "characters">
	<cfset language.casesensitive = "This field is case sensitive">
<cfelse>
	<cfset language.createUser = "Inscription pour les comptes">
	<cfset language.description = "TBD">
	<cfset language.passwordLabel = "Mot de passe&nbsp;">
	<cfset language.repeatPasswordLabel = "Retaper le mot de passe&nbsp;">
	<cfset language.firstNameLabel = "Pr&eacute;nom&nbsp;">
	<cfset language.lastNameLabel = "Nom de famille&nbsp;">
	<cfset language.emailLabel = "Adresse de courriel&nbsp;(tonnom@domain.com)">
	<cfset language.firstNameError = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.lastNameError = "Veuillez entrer votre nom de famille.">
	<cfset language.password1Error = "Veuillez entrer votre mot de passe.">
	<cfset language.password2Error = "Veuillez entrer de nouveau votre mot de passe aux fins de v&eacute;rification.">
	<cfset language.emailError = "Veuillez entrer votre adresse de courriel.">
	<cfset language.characters = "caract&egrave;res">
	<cfset language.casesensitive = "TBD">
</cfif>

<!--- <cfset Variables.onLoad = "javascript:document.addUserForm.firstname.focus();">
 --->
<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT CID, Name FROM Companies WHERE Deleted = 0 ORDER BY CID
</cfquery>
<cfparam name="variables.FirstName" default="">
<cfparam name="variables.LastName" default="">
<cfparam name="variables.email" default="">
<cfparam name="variables.CID" default="#getCompanies.CID#">
<cfparam name="err_newfname" default="">
<cfparam name="err_newlname" default="">
<cfparam name="err_newpass1" default="">
<cfparam name="err_newpass2" default="">
<cfparam name="err_newemail" default="">

<cfif isDefined("url.info")>
	<cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(URLDecode(url.info))), "boingfoip")>
	<cfset Variables.firstname = ListGetAt(userInfo, 1)>
	<cfset Variables.lastname = ListGetAt(userInfo, 2)>
	<cfset Variables.email = ListGetAt(userInfo, 3)>
</cfif>

<cfif not error("firstName") EQ "">
  <cfset err_newfname = "form-alert" />
</cfif>
<cfif not error("lastname") EQ "">
  <cfset err_newlname = "form-alert" />
</cfif>
<cfif not error("password1") EQ "">
  <cfset err_newpass1 = "form-alert" />
</cfif>
<cfif not error("password2") EQ "">
  <cfset err_newpass2 = "form-alert" />
</cfif>
<cfif not error("email") EQ "">
  <cfset err_newemail = "form-alert" />
</cfif>


<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
				<h2 id="wb-cont"><cfoutput>#language.CreateUser#</cfoutput></h2>

				<cfoutput>

					<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>
					<cfif isDefined("url.companies")>
						<cfset Variables.action = "entrpdemande-comprequest.cfm?lang=#lang#&companies=#url.companies#">
						<cfelse>
						<cfset Variables.action = "entrpdemande-comprequest.cfm?lang=#lang#">
					</cfif>
					<form action="#Variables.action#" id="addUserForm" method="post">
            <fieldset>
              <legend>#language.CreateUser#</legend>
              <p>#language.description#</p>

              <div class="#err_newfname#">
                <label for="firstname">
                  <strong><span class="required">*</span>&nbsp;#language.FirstNameLabel#&nbsp;<span class="required">(#language.required#)</span></strong><span class="form-text">#error('firstname')#</span>
                </label>
                <input name="firstname" type="text" value="#variables.firstName#" size="23" maxlength="40" id="firstname" />

              </div>

              <div class="#err_newlname#">
                <label for="lastname">
                  <strong><span class="required">*</span>&nbsp;#language.LastNameLabel#&nbsp;<span class="required">(#language.required#)</span></strong><span class="form-text">#error('lastname')#</span>
                </label>
                <input name="lastname" type="text" value="#variables.lastName#" size="23" maxlength="40" id="lastname" />
              </div>

              <div class="#err_newpass1#">
                <label for="password1">
                  <strong><span class="required">*</span>&nbsp;#language.PasswordLabel#&nbsp;<span class="required">(#language.required#)</span></strong>&nbsp;(8 #language.characters# minimum)<br />
                  <span>(#language.casesensitive#)</span>
                  <span class="form-text">#error('password1')#</span>
                </label>
                <input type="password" name="password1" id="password1" size="23" />
                
              </div>

              <div class="#err_newpass2#">
                <label for="password2">
                  <strong><span class="required">*</span>&nbsp;#language.RepeatPasswordLabel#&nbsp;<span class="required">(#language.required#)</span></strong><br />
                  <span>(#language.casesensitive#)</span>
                  <span class="form-text">#error('password2')#</span>
                </label>
                <input type="password" name="password2" id="password2"  size="23" />
                
              </div>

              <div class="#err_newemail#">
                <label for="email">
                  <strong><span class="required">*</span>&nbsp;#language.EmailLabel#&nbsp;<span class="required">(#language.required#)</span></strong><span class="form-text">#error('email')#</span>
                </label>
                <input name="email" type="text" value="#variables.email#" size="40" maxlength="100" id="email" />
                
              </div>

              <input type="submit" value="#language.Submit#" class="button button-accent" />
            </fieldset>
					</form>
				</cfoutput>