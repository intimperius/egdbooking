<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<CFSET langVar = "eng">
	<cfset language.bookingsSummary = "Esquimalt Graving Dock public bookings summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
	<cfset language.introduction = "Find a public summary of bookings at the Esquimalt Graving Dock.">
	<cfset language.newsearch = "Conduct a new search">
	<cfset language.newsearchlink = "Consult the public summary of bookings">
	<cfset language.bookspace = "Book space">
	<cfset language.bookspacelink = "Sign in to book a space">

	<cfset language.dcdescription = "Allows to consult the public summary of bookings of the Drydock, the North Landing Wharf and the South Jetty facilities at the Esquimalt Graving Dock without signing in or registering an account.">
	<cfset language.dccreator = "Government of Canada, Public Works and Government Services, Real Property Branch">
	<cfset language.dctitle = "Esquimalt Graving Dock public bookings summary – Booking space at the Esquimalt Graving Dock – Esquimalt Graving Dock – Vessels design, construction and maintenance – Marine transportation – Transport and infrastructure">
	<cfset language.dcsubject = "Government of Canada; marine installations; wharfs; vessels; ships">
	<cfset language.dckeywords = "Esquimalt Graving Dock, EGD, Drydock, North Landing Wharf, South Jetty, public bookings summary, bookings, space booking, reserve a space, reservation, booking dates, docking dates, commercial drydock, dry-dock, ship repair facility">
<cfelse>
	<CFSET langVar = "fre">
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations publique de la Cale s&egrave;che d'Esquimalt">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un sommaire de toutes les r&eacute;servations &agrave; partir de maintenant.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
	<cfset language.introduction = "Trouvez un r&eacute;sum&eacute; des r&eacute;servations publique de la Cale s&egrave;che d'Esquimalt.">

	<cfset language.newsearch = "Effectuer une nouvelle recherche">
	<cfset language.newsearchlink = "Consulter le r&eacute;sum&eacute; des r&eacute;servations publique">
	<cfset language.bookspace = "R&eacute;server">
	<cfset language.bookspacelink = "Ouvrir une session pour r&eacute;server">

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
	<cfset request.title = language.bookingsSummary />

<cfinclude template="#RootDir#includes/tete-header-loggedout-#lang#.cfm">

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfparam name="Variables.CalStartDate" default="" />
<cfparam name="Variables.CalEndDate" default="" />

<cfif IsDefined('form.startDate')>
	<cfset Variables.CalStartDate = form.startDate>
</cfif>

<cfif IsDefined('form.endDate')>
	<cfset Variables.CalEndDate = form.endDate>
</cfif>

<cfif not isDate(Variables.CalStartDate) and Variables.CalStartDate neq "">
  <cfset ArrayAppend(Variables.Errors, language.invalidStartError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isDate(Variables.CalEndDate) and Variables.CalEndDate neq "">
  <cfset ArrayAppend(Variables.Errors, language.invalidEndError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="resume-summary_ch.cfm?lang=#lang#" />
</cfif>

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID
WHERE	(Status = 'c' OR Status = 't')
	AND	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Docks.status <> 'T') OR (Docks.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))
	<cfif IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></cfif>
	<cfif IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></cfif>
	
ORDER BY	StartDate, EndDate, VesselName
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	AND (Status ='c' OR Status = 't')
	<cfif IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></cfif>
	<cfif IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></cfif>
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))

ORDER BY	StartDate, EndDate, VesselName
</cfquery>

<cfquery name="getNJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	NorthJetty = 1
</cfquery>

<cfquery name="getSJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	SouthJetty = 1
</cfquery>

<script type="text/javascript">
/* <![CDATA[ */
function popUp(pageID) {
	window.open(pageID + "-e.cfm", pageID, "width=800, height=400, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>
<cfoutput>
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingsSummary#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>
					<p>#language.introduction#</p>

					<ul>
						<li><a href="###language.Drydock#">#language.Drydock#</a></li>
						<li><a href="###language.northLandingWharf#">#language.northLandingWharf#</a></li>
						<li><a href="###language.southJetty#">#language.southJetty#</a></li>
					</ul>

				<a name="#language.Drydock#"></a>
				<h2>#language.Drydock#</h2>
        <cfif getDockBookings.RecordCount neq 0>
          <table class="basic mediumFont public">
            <thead>
              <tr>
                <th id="section" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="getDockBookings">
              <tr <cfif Status eq 'c'>class="confirmed"</cfif>>
                <td headers="section" style="text-align:center;"><cfif Status eq 'c'>
                            <cfif Section1 eq true>1</cfif>
                            <cfif Section2 eq true>
                              <cfif Section1> &amp; </cfif>
                            2</cfif>
                            <cfif Section3 eq true>
                              <cfif Section1 OR Section2> &amp; </cfif>
                            3</cfif>
                          <cfelse>#language.tentative#
                          </cfif></td>
                <td headers="docking">#myDateFormat(StartDate, request.datemask)# - #myDateFormat(EndDate, request.datemask)#</td>
                <td headers="booking">#myDateFormat(BookingTime, request.datemask)#</td>
              </tr>
              </cfloop>
            </tbody>
          </table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>
				
				<a name="#language.northLandingWharf#"></a>
				<h2>#language.northLandingWharf#</h2>
        <cfif getNJBookings.RecordCount neq 0>
          <table class="basic mediumFont public">
            <thead>
              <tr>
                <th id="section2" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking2" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking2" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="getNJBookings">
                <tr <cfif Status eq 'c'>class="confirmed"</cfif>>
                  <td headers="section2"><div style="text-align:center;"><cfif Status eq 'c'>#language.booked#
                                <cfelseif Status eq 't'>#language.tentative#
                                </cfif></div></td>
                  <td headers="docking2">#myDateFormat(StartDate, "mmm d")#<cfif Year(StartDate) neq Year(EndDate)>#myDateFormat(StartDate, ", yyyy")#</cfif> - #myDateFormat(EndDate, request.datemask)#</td>
                  <td headers="booking2">#myDateFormat(BookingTime, request.datemask)#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></td>
                </tr>
                </cfloop>
            </tbody>
					</table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>
				
				<a name="#language.southJetty#"></a>
				<h2>#language.southJetty#</h2>
        <cfif getSJBookings.RecordCount neq 0>
          <table class="basic mediumFont public">
            <thead>
              <tr>
                <th id="section3" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking3" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking3" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
						<cfloop query="getSJBookings">
						<tr <cfif Status eq 'c'>class="confirmed"</cfif>>
							<td headers="section3"><div style="text-align:center;"><cfif Status eq 'c'>#language.booked#
														<cfelseif Status eq 't'>#language.tentative#
														<cfelse>#language.pending#
														</cfif></div></td>
							<td headers="docking3">#myDateFormat(StartDate, request.datemask)# - #myDateFormat(EndDate, request.datemask)#</td>
							<td headers="booking3">#myDateFormat(BookingTime, request.datemask)#</td>
						</tr>
						</cfloop>
					</table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>


<div>
	<h2>#language.newsearch#</h2>
	<ul><li>
	<a href="#RootDir#index-#lang#.cfm">#language.newsearchlink#</a>
	</li></ul>
</div>

<div>
	<h2>#language.bookspace#</h2>
	<ul><li>
	<a href="#RootDir#index-#lang#.cfm">#language.bookspacelink#</a>
	</li></ul>
</div>


</cfoutput>
<cfinclude template="#RootDir#includes/pied_site-site_footer-#lang#.cfm">
