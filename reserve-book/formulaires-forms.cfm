<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.keywords = language.masterKeywords & ", Booking Forms">
	<cfset language.description = "Contains informaiton on available forms.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Form">
	<cfset language.schedule = "Schedule 1">
	<cfset language.indemnification = "Indemnification Clause">
	<cfset language.changeForm = "Tentative Vessel and Change Booking Form">
	<cfset language.acrobatrequired = 'The following files may require <a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" rel="external">Adobe Acrobat Reader</a> to be installed.  The links will open in a new window.'>
  <cfset language.formExplanation = "The following forms are used in booking the drydock.<br /><br /><i>Schedule 1</i> and the <i>Indemnification Clause</i> are required to confirm a booking.  The <i>Schedule 1 - Drydock Application Form</i> provides <abbr title='Esquimalt Graving Dock'>EGD</abbr> with vessel details and acts as a formal booking agreement between you and the Esquimalt Graving Dock.  The <i>Indemnification Clause</i> is a legal disclaimer that indemnifies the Crown against liability for injuries or damages.<br /><br />The <i>Tentative Vessel and Change Booking Form</i> is required if you wish to make any changes after submitting a request for booking.">
<cfelse>
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ",  Formulaire de r&eacute;servation">
	<cfset language.description = "Contient de l'information sur les formulaires offerts.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Formulaire">
	<cfset language.schedule = "Tableau 1">
	<cfset language.indemnification = "Clause d'indemnit&eacute;">
	<cfset language.changeForm = "Formulaire de r&eacute;servation provisoire pour les navires et les modifications">
	<cfset language.acrobatrequired = 'Vous pourriez avoir besoin d''<a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" rel="external">Adobe Acrobat Reader</a> pour les fichiers suivants. Les liens ouvriront une nouvelle fen&ecirc;tre.'>
  <cfset language.formExplanation = "Les formulaires suivants servent aux r&eacute;servations de la cale s&egrave;che. <br /><br />Le <em>Tableau 1</em> et la <em>Clause d'indemnisation</em> doivent &ecirc;tre soumis pour que la r&eacute;servation puisse &ecirc;tre confirm&eacute;e. Le <em>Tableau 1 - Formulaire de demande de r&eacute;servation</em> donne &agrave; la <abbr title='Cale S&egrave;che d'Esquimalt'>CSE</abbr> les renseignements n&eacute;cessaires sur le navire et sert d'entente de r&eacute;servation formelle entre vous et la <abbr title='Cale S&egrave;che d'Esquimalt'>CSE</abbr>. La <em>Clause d'indemnisation</em> est un document juridique qui d&eacute;gage la Couronne de toute responsabilit&eacute; en cas de blessures ou de dommages.<br /><br />Vous aurez besoin du formulaire de modification d'une r&eacute;servation si vous voulez apporte un changement apr&egrave;s avoir soumis une demande de r&eacute;servation.">

</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.bookingForms#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.bookingForms#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
				<p>#language.formExplanation#</p>

				<!---p>#language.acrobatrequired#</p--->

				<ul>
					<li>
            <a href="#RootDir#formes-forms/DockBookingApplication.pdf">
            #language.schedule# (#LSDateFormat(CreateDate(2004, 7, 14), 'long')#) [PDF]
            </a>
					</li>
					<li>
            <a href="#RootDir#formes-forms/indemnificationClause.pdf" title="#language.Indemnification#" rel="external">
            #language.Indemnification# (#LSDateFormat(CreateDate(2002, 6, 18), 'long')#) [PDF]
            </a>
          </li>
					<li>
            <a href="#RootDir#formes-forms/Tentative_ChangeForm.pdf" title="#language.changeForm#" rel="external">
            #language.changeForm# [PDF]
            </a>
          </li>
					<li>
          <a href="#RootDir#reserve-book/tarifconsult-tariffview.cfm?lang=#lang#" title="Tariff of Dock Charges">
          Tariff of Dock Charges
          </a>
          </li>
				</ul>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

