<!--- <cfdump var="#Cookie#"> --->

<cfif lang EQ "eng" OR isDefined("session.AdminLoggedIn")>
	<cfset language.title = "Sign Out">
	<cfset language.thankYou = "Thank you for using the Esquimalt Graving Dock Online Booking System.  You have now been signed out of your session.">
	<cfset language.returnlogin = "Return to Sign In">
<cfelse>
	<cfset language.title = "Fermer la session">
	<cfset language.thankYou = "Merci d'avoir utilis&eacute; le syst&egrave;me de r&eacute;servation en ligne de la Cale s&egrave;che d'Esquimalt. Votre session est maintenant termin&eacute;e.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>

<!---Delete cookies used to pass session variables--->
<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<cfset structDelete(cookie, "AdminEmail")>
	<cfset structDelete(cookie, "AdminLoggedIn")>
	<cfset structDelete(cookie, "EMail")>
	<cfset structDelete(cookie, "FirstName")>
	<cfset structDelete(cookie, "LastName")>
	<cfset structDelete(cookie, "LoggedIn")>
	<cfset structDelete(cookie, "UID")>
	<cfscript>structClear(Session);</cfscript>
</cflock>
<!--- <CFCOOKIE NAME="UID" value="" EXPIRES="Now">
<CFCOOKIE NAME="FirstName" value="" EXPIRES="Now">
<CFCOOKIE NAME="LastName" value="" EXPIRES="Now">
<CFCOOKIE NAME="EMail" value="" EXPIRES="Now">
<CFCOOKIE NAME="LoggedIn" value="0" EXPIRES="Now">
<CFCOOKIE NAME="AdminLoggedIn" value="0" EXPIRES="Now">
<CFCOOKIE NAME="AdminEmail" value="" EXPIRES="Now"> --->


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords# #language.title#"" />
	<meta name=""description"" content=""#language.title#"" />
	<meta name=""dcterms.description"" content=""#language.title#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
	<cfset request.title = language.title />
<cfinclude template="#RootDir#includes/tete-header-loggedout-#lang#.cfm">
<h1 id="wb-cont"><cfoutput>#language.title#</cfoutput></h1>

<cfoutput>
<p>#language.thankYou#</p>
<p><a href="../index-#lang#.cfm" class="textbutton">#language.returnlogin#</a></p>
</cfoutput>

<cfinclude template="#RootDir#includes/pied_site-site_footer-#lang#.cfm">


