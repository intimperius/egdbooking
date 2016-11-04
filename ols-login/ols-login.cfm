<cfif lang EQ "eng">
	<cfset language.title = "Booking Application Sign In">
	<cfset language.description ="Sign In page for the booking application.">
	<cfset language.EmailLabel = "Email address (yourname@domain.com)">
	<cfset language.PasswordLabel = "Password">

  <cfset language.login = "Sign in to book or cancel a space">
  <cfset language.required = "(required)">
  <cfset language.loginButton = "Sign in">
  <cfset language.info = "Any company or individual can book space at the Esquimalt Graving Dock on a first-come, first-served basis.">
  <cfset language.caseSensitive = "(This field is case sensitive)">
  <cfset language.accountRequired = "To book space at the Esquimalt Graving Dock, you must have an account.">
  <cfset language.instructions = "If you have an account, sign in to view current listings, book or cancel a space.">
<cfelse>
	<cfset language.title = "Entrer dans l'application de r&eacute;servation">
	<cfset language.description ="Page d'ouverture de session pour la demande de r&eacute;servation.">
	<cfset language.EmailLabel = "Courriel (tbd@tbd.com)">
	<cfset language.PasswordLabel = "Mot de passe">

  <cfset language.login = "tbd">
  <cfset language.required = "(requis)">
  <cfset language.loginButton = "Entrer">
  <cfset language.info = "Toute entreprise ou individu peut r&eacute;server un espace &agrave; la cale s&egrave;che d'Esquimalt sur un premier arriv&eacute;, premier servi.">
  <cfset language.accountRequired = "tbd">
  <cfset language.instructions = "tbd">
  <cfset language.caseSensitive = "tbd">
</cfif>



<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfif IsDefined("Session.Return_Structure") AND isDefined("url.pass") AND url.pass EQ "true">
	<cfset Variables.onLoad = "javascript:document.login_form.Password.focus();">
<cfelse>
	<cfset Variables.onLoad = "javascript:document.login_form.email.focus();">
</cfif>

<CFIF IsDefined("Cookie.login")>
	<CFSET email = "#Cookie.login#">
<CFELSE>
	<CFSET email = "">
</CFIF>

<cfheader name="Pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">
<cfcookie name="CFID" value="empty" expires="NOW">
<cfcookie name="CFTOKEN" value="empty" expires="NOW">


<cfparam name="err_loginemail" default="">
<cfparam name="err_loginpass" default="">

<cfif not error("email") EQ "">
  <cfset err_loginemail = "form-alert">
</cfif>
<cfif not error("password") EQ "">
  <cfset err_loginpass = "form-alert">
</cfif>

<cfoutput>
  <h1 id="wb-cont">#language.login#</h1>
  <form action="#RootDir#ols-login/ols-login_action.cfm?lang=#lang#" method="post" id="login_form">
    <fieldset>
      <!--- <legend>#language.login#</legend> --->
      <!--- <p>#language.info#</p> --->
      <p><strong>#language.accountRequired#</strong></p>
      <ul><li><a href="ols-login/gestionutilisateur-usermanagement.cfm">#language.addUser#</a></li></ul>
      <br />
      <p><strong>#language.instructions#</strong></p>
      <br />
      <div class="#err_loginemail#">
        <label for="email" style="display:block">
          <strong><span style="color: red">*</span>&nbsp;#language.EmailLabel#&nbsp;<span title="" class="required">#language.required#</span></strong><br />#language.caseSensitive#
          <span class="form-text">#error('email')#</span>
        </label>
        <input type="text" name="email" id="email" size="40" maxlength="100" value="#email#" />
        
      </div>

      <div class="#err_loginpass#">
        <label for="password" style="display:block">
          <strong><span style="color: red">*</span>&nbsp;#language.PasswordLabel#&nbsp;<span class="required">#language.required#</span></strong><br />#language.caseSensitive#
          <span class="form-text">#error('password')#</span>
        </label>
        <input type="password" name="Password" id="password" size="40" maxlength="40" />
        
      </div>

      <div>
        <input name="remember" type="checkbox" id="remember" value="remember" <CFIF IsDefined("Cookie.login")>checked="checked"</CFIF> />

		<label for="remember">#language.Remember#</label>
	  </div>

      <input type="submit" name="submitForm" value="#language.loginButton#" class="button button-accent" />
    </fieldset>
  </form>
  <ul><li><a href="ols-login/gestionutilisateur-usermanagement.cfm##oubli-forgot">#language.Forgot#</a></li></ul>
  <br />
</cfoutput>