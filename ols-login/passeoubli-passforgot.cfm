<cfif lang EQ "eng">
	<cfset language.forgot = "Forgot your password">
	<cfset language.description = "If you have forgotten your password, submit your email address. You will receive an email with a new password.">
	<cfset language.description2 = "If you no longer have access to this email, please contact the system administrator.">
	<cfset language.enterEmail = "Please enter the e-mail address you use to log in.">
	<cfset language.getPassword = "Your password will be emailed to you.">
	<cfset language.emailLabel = "Email Address (yourname@domain.com)">
	<cfset language.emailError ="Please enter a valid email address.">
<cfelse>
	<cfset language.forgot = "Oubli du mot de passe">
	<cfset language.description = "TBD">
	<cfset language.description2 = "TBD">
	<cfset language.enterEmail = "Veuillez entrer l'adresse de courriel que vous utilisez pour ouvrir une session.">
	<cfset language.getPassword = "Votre mot de passe vous a &eacute;t&eacute; transmis par courriel.">
	<cfset language.emailLabel = "Adresse de courriel (tonnom@domain.com)">
	<cfset language.emailError ="Veuillez v&eacute;rifier la validit&eacute; de votre addresse de courriel.">
</cfif>

<cfparam name="err_email" default="">

<!--- <cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();"> --->

				<h2 id="wb-cont"><cfoutput>#language.forgot#</cfoutput></h2>

				<cfif not error("email") EQ "">
  						<cfset err_email = "form-alert" />
				</cfif>

				<cfoutput>

					<cfif IsDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>

					<form action="passeoubli-passforgot_action.cfm?lang=#lang#" id="forgotForm" method="post">
            <fieldset>
              <legend>#language.getPassword#</legend>
              <p>#language.description#</p>
              <p>#language.description2#</p>

              <div class="#err_email#">
                <label for="email">
                  <strong><span class="required">*</span>&nbsp;#language.EmailLabel#&nbsp;<span class="required">(#language.required#)</span></strong>
                  <span class="form-text">#error('email')#</span>
                </label>
                <input name="email" type="text" size="40" maxlength="100" id="email" />
                
              </div>
              
              

              <input type="submit" value="#language.Submit#" class="button button-accent" />
            </fieldset>
					</form>

				</cfoutput>

