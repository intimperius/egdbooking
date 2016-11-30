<cfif lang EQ "eng">
	<cfset language.manageUser = "Manage your Esquimalt Graving Dock account">
	<cfset language.introduction = "You can register an account to book space at the Esquimalt Graving Dock or retrieve your forgotten password.">
	<cfset language.register = "Register an account">
	<cfset language.forgot = "Forgot your password">
	<cfset language.returnlogin = "Sign in to book a space">
	<cfset language.required = "required">
	<cfset language.bookspace = "Book space">
	<cfset language.moreinformation = "For more information">
	<cfset language.learnmore = "Learn more about the ">
	<cfset language.importantnotices = "Important notices about the Esquimalt Graving Dock">
	<cfset language.contact = "Contact Esquimalt Graving Dock">

	<cfset language.dcdescription = "Allows users to create and manage their account to the Esquimalt Graving Dock online space booking system, and to recover or to modify their password.">
	<cfset language.dccreator = "Government of Canada, Public Works and Government Services, Real Property Branch">
	<cfset language.dctitle = "Manage your Esquimalt Graving Dock account – Booking space at the Esquimalt Graving Dock – Esquimalt Graving Dock – Vessels design, construction and maintenance – Marine transportation – Transport and infrastructure">
	<cfset language.dcsubject = "Government of Canada; marine installations; wharfs; vessels; ships">
	<cfset language.dckeywords = "access to Esquimalt Graving Dock booking space system, create an account, register an account, forgotten password, change password, EGD">
<cfelse>
	<cfset language.manageUser = "TBD">
	<cfset language.introduction = "TBD">
	<cfset language.register = "Inscription pour les comptes">
	<cfset language.forgot = "Oubli du mot de passe">
	<cfset language.returnlogin = "TBD">
	<cfset language.required = "obligatoire">
	<cfset language.bookspace = "TBD">
	<cfset language.moreinformation = "TBD">
	<cfset language.learnmore = "TBD">
	<cfset language.importantnotices = "TBD">
	<cfset language.contact = "TBD">

	<cfset language.dcdescription = "TBD">
	<cfset language.dccreator = "TBD">
	<cfset language.dctitle = "TBD">
	<cfset language.dcsubject = "TBD">
	<cfset language.dckeywords = "TBD">
</cfif>

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset language.dcdatemodified = DateFormat(GetFile.DateLastModified, "yyyy-mm-dd")>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.dctitle#"" />
	<meta name=""keywords"" content=""#language.dckeywords#"" />
	<meta name=""description"" content=""#language.dcdescription#"" />
	<meta name=""dcterms.description"" content=""#language.dcdescription#"" />
	<meta name=""dcterms.creator"" content=""#language.dccreator#"" />
	<meta name=""dcterms.subject"" content=""#language.dcsubject#"" />
	<meta name=""dcterms.modified"" content=""#language.dcdatemodified#"" />
	<title>#language.dctitle#</title>">
	<cfset request.title = language.manageUser />

<cfinclude template="#RootDir#includes/tete-header-loggedout-#lang#.cfm">

<cfoutput>
<h1 property="name" id="wb-cont">#language.manageUser#</h1>
<p>#language.introduction#</p>
<div class="wb-tabs update-hash">
	<div class="tabpanels">
		<details id="ajout-add">
			<summary>#language.register#</summary>
			<cfinclude template="#RootDir#ols-login/utilisateurajout-useradd.cfm">
		</details>
		<details id="oubli-forgot">
			<summary>#language.forgot#</summary>
			<cfinclude template="#RootDir#ols-login/passeoubli-passforgot.cfm">
		</details>
	</div>
</div>

<div>
	<h2>#language.bookspace#</h2>
	<ul><li>
	<a href="#RootDir#index-#lang#.cfm">#language.returnlogin#</a>
	</li></ul>
</div>

<div>
	<h2>#language.moreinformation#</h2>
	<ul><li>
	#language.learnmore#<a href="http://www.tpsgc-pwgsc.gc.ca/biens-property/cse-egd/index-#lang#.html">#language.esqGravingDock#</a>
	</li></ul>
	<ul><li>
	<a href="http://www.tpsgc-pwgsc.gc.ca/biens-property/cse-egd/avis-notices-#lang#.html">#language.importantnotices#</a>
	</li></ul>
	<ul><li>
	<a href="http://www.tpsgc-pwgsc.gc.ca/biens-property/cse-egd/cn-cu-#lang#.html">#language.contact#</a>
	</li></ul>
</div>

</cfoutput>

<cfinclude template="#RootDir#includes/pied_site-site_footer-#lang#.cfm">
