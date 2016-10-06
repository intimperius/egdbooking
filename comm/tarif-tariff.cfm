
<cfoutput>
<cfif lang EQ "eng">
	<cfset language.keywords = language.masterKeywords & ", Tariff ">
	<cfset language.description = "Tariff of Dock Charges">
	<cfset language.subjects = language.masterSubjects & ", Tariff of Dock Charges">
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Tarif">
	<cfset language.description = "Tarif des Droits de Cale Seche">
	<cfset language.subjects = language.masterSubjects & ", Tarif des Droits de Cale Seche">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.notices# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.tariff# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.tariff />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

  <!-- CONTENT BEGINS | DEBUT DU CONTENU -->
  <div class="center">
    <h1 id="wb-cont">#language.schedule# 1 #language.tariff#</h1>

      <cffile action="read" file="#FileDir#tariff-rate-#lang#.txt" variable="intromsg">
      <div class="option4">
        #intromsg#
      </div>
  </div>
<!-- CONTENT ENDS | FIN DU CONTENU -->


<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm" />
</cfoutput>
