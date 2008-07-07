<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.confirmRem = "Confirm Remove Company">
	<cfset language.keywords = "#language.masterKeywords#" & " Remove Company User Represent">
	<cfset language.description = "Confirms that user no longer represents a company.">
	<cfset language.areYouSure = "Are you sure you want to remove yourself from">
	<cfset language.remove = "Remove">
	<cfset language.createUser = "Create New User">
<cfelse>
	<cfset language.confirmRem = "Confirmation de la suppression d'une entreprise">
	<cfset language.keywords = "#language.masterKeywords#" & " Suppression de l'utilisateur-repr&eacute;sentant de l'entreprise">
	<cfset language.description = "Confirme que l'utilisateur ne repr&eacute;sente plus une entreprise.">
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir vous retirer de l'&eacute;l&eacute;ment suivant">
	<cfset language.remove = "Supprimer">
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.confirmRem#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.confirmRem#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif NOT IsDefined('form.companyID')>
	<cflocation addtoken="no" url="entrpdemande-comprequest.cfm?lang=#lang#&amp;info=#url.info#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
</cfquery>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.login#</a> &gt; 
			<a href="#RootDir#ols-login/addUserCompanies.cfm?lang=#lang#&amp;info=#url.info#&amp;companies=#url.companies#">#language.createUser#</a> &gt; 
			#language.confirmRem#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.confirmRem#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<cfoutput>
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfform action="entrpsup-comprem_action.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#" method="post" name="remCompanyConfirmForm">
					<div style="text-align:center;">#language.areYouSure# <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>
				
					<p><div style="text-align:center;">
						<!---a href="javascript:EditSubmit('remCompanyConfirmForm');" class="textbutton">#language.Remove#</a>
						<a href="entrpdemande-comprequest.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#" class="textbutton">#language.Cancel#</a--->
						<input type="submit" value="#language.Remove#" class="textbutton" />
						<input type="button" value="#language.Cancel#" onclick="javascript:self.location.href='addUserCompanies.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#'" class="textbutton" />
					</div></p>
				
					<input type="hidden" name="CompanyID" value="#form.CompanyID#" />
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

