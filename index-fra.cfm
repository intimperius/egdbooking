<cfoutput>

	<cfset language.moreinformation = "TBD">
	<cfset language.learnmore = "TBD">
	<cfset language.importantnotices = "TBD">

<cfsavecontent variable="head">
<title>Booking Space at the EGD - Esquimalt Graving Dock - PWGSC</title>
<meta name="description" content="Companies and individuals can book space for a watercraft at any of the facilities of the Esquimalt Graving Dock on a first-come, first-served basis or can consult the public summary of bookings." />
<meta name="dcterms.description" content="Introduction page for the booking application" />
<meta name="dcterms.title" content="Booking space at the Esquimalt Graving Dock – Esquimalt Graving Dock – Vessels design, construction and maintenance – Marine transportation – Transport and infrastructure" />
<meta name="dcterms.creator" content="Government of Canada, Public Works and Government Services, Real Property Branch" />
<meta name="dcterms.subject" title="gccore" content="Government of Canada; marine installations; wharfs; vessels; ships;" />
<meta name="dcterms.modified" content="2016-10-XX" />
<meta name="keywords" content="Esquimalt Graving Dock, EGD, Drydock, North Landing Wharf, South Jetty,  bookings, space booking, reserve a space, reservation, cancellation, booking dates, docking dates, commercial drydock, dry-dock, ship repair facility" />
</cfsavecontent>
<cfhtmlhead text="#head#">
<cfset request.title = language.bookingSpace>

<cfinclude template="#RootDir#includes/tete-header-loggedout-#lang#.cfm">
<h1 id="wb-cont">#language.bookingSpace#</h1>

<div class="span-4">
<img src="#RootDir#images/EGD_aerial_small.jpg" alt="" width="405" height="342" />
<!--- Previous blurb, before Comms Review edit --->
<!---
<p>To reserve space for a vessel at any of the facilities of the Esquimalt Graving
Dock, please proceed to the <a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> page.  If you experience any problems with the booking application, please
  use the <a href="#EGD_URL#/cn-cu-#lang#.html">#language.contact# <abbr title="#language.esqGravingDock#">#language.egd#</abbr></a> page.</p>
  --->

  <!--- New blurb, after Comms Review edit --->

  <p>tbd</p>

<p style="border: solid 1px gray; padding: 4px"><strong>Les frais</strong><br />Les frais de r&eacute;servation de la cale s&egrave;che d&rsquo;Esquimalt sont de 4&nbsp;800,00$  canadiens, plus 240,00$ de taxe de vente g&eacute;n&eacute;rale (TVG), ce qui donne en  tout 5&nbsp;040,00$ payables en esp&egrave;ces, par ch&egrave;que certifi&eacute; d&rsquo;une banque  canadienne ou par mandat international. Le 1<sup>er</sup> avril 2008, des int&eacute;r&ecirc;ts seront appliqu&eacute;s sur un compte en suspens plus de 30 jours.  Les demandes de r&eacute;servation sont  provisoires jusqu&rsquo;&agrave; ce que les frais de r&eacute;servation soient pay&eacute;s. Les frais de r&eacute;servation ne sont pas remboursables.</p>

<h1>tbd</h1>

<ul>
<li><a href="##login">tbd</a></li>
<li><a href="##bookings">tbd</a></li>
<li><a href="##information">tbd</a></li>
</ul>

<cfinclude template="#RootDir#ols-login/ols-login.cfm">

<cfinclude template="#RootDir#utils/resume-summary_ch.cfm">
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
</div> <!--- this div added because previous closing tag is in removed lower section --->

<!--- Previous content, removed after Comms Review --->

<!---

<p><a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> - Book drydock and jetty space online.</p>
<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">#language.bookingsSummaryDateSelection#</a> - View all bookings.</p>
<p><a href="http://publications.gc.ca/gazette/archives/p2/2009/2009-12-23/pdf/g2-14326.pdf">Archived - Regulations amending the Esquimalt Graving Dock regulations</a></p>
</div>

<cfinclude template="#RootDir#includes/right-menu-droite-eng.cfm">
--->

<cfinclude template="#RootDir#includes/pied_site-site_footer-eng.cfm" />
</cfoutput>

