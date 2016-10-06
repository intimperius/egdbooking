<cfif lang EQ "eng">
	<cfset language.title = "Booking Application Sign In">
	<cfset language.description ="Sign In page for the booking application.">
	<cfset language.EmailLabel = "Email:">
	<cfset language.PasswordLabel = "Password:">
<cfelse>
	<cfset language.title = "Entrer dans l'application de r&eacute;servation">
	<cfset language.description ="Page d'ouverture de session pour la demande de r&eacute;servation.">
	<cfset language.EmailLabel = "Courriel&nbsp;:">
	<cfset language.PasswordLabel = "Mot de passe&nbsp;:">
</cfif>



<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords# #language.Login#"" />
	<meta name=""description"" content=""#language.description#"" />
  <meta name=""dcterms.description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
  <cfset request.title = language.login />
<cfinclude template="#RootDir#includes/tete-header-loggedout-#lang#.cfm">

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
  <cfset err_loginemail = "form-alert" />
</cfif>
<cfif not error("password") EQ "">
  <cfset err_loginpass = "form-alert" />
</cfif>

<cfoutput>
  <h1 id="wb-cont">#language.login#</h1>
  <form action="ols-login_action.cfm?lang=#lang#" method="post" id="login_form">
    <fieldset>
      <legend>#language.login#</legend>
      <p>#language.requiredFields#</p>
      
      <div class="#err_loginemail#">
        <label for="email">
          <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.EmailLabel#<span class="form-text">#error('email')#</span>
        </label>
        <input type="text" name="email" id="email" size="40" maxlength="100" value="#email#" />
        
      </div>

      <div class="#err_loginpass#">
        <label for="password">
          <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.PasswordLabel#<span class="form-text">#error('password')#</span>
        </label>
        <input type="password" name="Password" id="password" size="25" maxlength="40" />
        
      </div>

      <div>
        <input name="remember" type="checkbox" id="remember" value="remember" <CFIF IsDefined("Cookie.login")>checked="checked"</CFIF> />
		<label for="remember">#language.Remember#</label>
	  </div>

      <input type="submit" name="submitForm" value="#language.Login#" class="button button-accent" />
    </fieldset>
  </form>
  <p><a href="utilisateurajout-useradd.cfm?lang=#lang#">#language.addUser#</a></p>
  <p><a href="passeoubli-passforgot.cfm?lang=#lang#">#language.Forgot#</a></p>
</cfoutput>
<cfinclude template="#RootDir#includes/pied_site-site_footer-#lang#.cfm">

