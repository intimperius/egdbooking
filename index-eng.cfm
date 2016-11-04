
<cfoutput>

	<cfset language.moreinformation = "For more information">
	<cfset language.learnmore = "Learn more about the ">
	<cfset language.importantnotices = "Important notices about the Esquimalt Graving Dock">

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

  <p>Companies and individuals can book space for vessels at our facilities on a first-come, first-served basis. You can also consult the public summary of bookings. The Esquimalt Graving Dock is the largest solid-bottom commercial drydock on the West Coast of Americas, which is located in an ice-free harbour on Vancouver Island.</p>

<p style="border: solid 1px gray; padding: 4px"><strong>Fees</strong><br />The Esquimalt Graving Dock booking fee is $4,800.00 Canadian plus $240.00 GST for a total of $5,040.00 payable in cash, certified cheque drawn on a Canadian bank or by an international money order.  Effective April 1, 2008, interest will be applied on any account outstanding over 30 days.  Reservation requests are tentative until the booking fee is paid. Booking fees are non-refundable.</p>

<h1>On this page</h1>

<ul>
<li><a href="##login">Sign in to book or cancel a space</a></li>
<li><a href="##bookings">Consult the public summary of bookings</a></li>
<li><a href="##information">For more information</a></li>
</ul>

<div id="login"></div>
<cfinclude template="#RootDir#ols-login/ols-login.cfm">

<div id="bookings"></div>
<cfinclude template="#RootDir#utils/resume-summary_ch.cfm">

<div id="information"></div>
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
