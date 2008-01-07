<!---<cfinclude template="#RootDir#includes/restore_params.cfm">--->
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<CFINCLUDE template="#RootDir#includes/generalLanguageVariables.cfm">
<cfif lang EQ "e">
	<CFSET langVar = "eng">
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
<cfelse>
	<CFSET langVar = "fre">
	<cfset language.bookingsSummary = "R�sum� des r�servations">
	<cfset language.description = "Permet � l'utilisateur de voir un sommaire de toutes les r�servations � partir de maintenant.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R�SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R�serv�">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
</cfif>

<cfhtmlhead text="
<meta name=""dc.title"" lang=""#langVar#"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.bookingsSummary#"">
<meta name=""keywords"" lang=""#langVar#"" content="""">
<meta name=""description"" lang=""#langVar#"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.bookingsSummary#</title>
<style type=""text/css"" media=""screen,print"">@import url(#RootDir#css/events.css);</style>
">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<!-- Start JavaScript Block -->
<!-- End JavaScript Block -->

<CFIF IsDefined('form.startDate')>
	<CFSET Variables.calStartDate = form.startDate>
</CFIF>

<CFIF IsDefined('form.endDate')>
	<CFSET Variables.calEndDate = form.endDate>
</CFIF>

<CFQUERY name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
WHERE	(Status = 'c' OR Status = 't')
	AND	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Docks.status <> 'T') OR (Docks.status = 'T' AND Bookings.startDate >= #PacificNow#))
	<CFIF IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= '#Variables.CalStartDate#'</CFIF>
	<CFIF IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= '#Variables.CalEndDate#'</CFIF>
	
ORDER BY	StartDate, EndDate, VesselName
</CFQUERY>

<CFQUERY name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	AND (Status ='c' OR Status = 't')
	<CFIF IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= '#Variables.CalStartDate#'</CFIF>
	<CFIF IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= '#Variables.CalEndDate#'</CFIF>
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= #PacificNow#))

ORDER BY	StartDate, EndDate, VesselName
</CFQUERY>

<CFQUERY name="getNJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	NorthJetty = 1
</CFQUERY>

<CFQUERY name="getSJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	SouthJetty = 1
</CFQUERY>

<script language="javascript" type="text/javascript">
function popUp(pageID) {
	window.open(pageID + "-e.cfm", pageID, "width=800, height=400, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
}
</script>

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.cfm">#language.PWGSC#</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.esqGravingDock#</a> &gt;
	<a href="../booking-#lang#.cfm">#language.booking#</a> &gt;
	#language.bookingsSummary#
</div>
</cfoutput>

<div class="main">

<!--div style="text-align: right; font-size: 10pt;"><a href="booking.cfm?lang=#lang#">Back</a></div-->

<H1><cfoutput>#language.bookingsSummary#</cfoutput></H1>

<!---CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm"--->
<!--A href="javascript:window.open('bookingsSummary-printable.cfm'); void(0);" class="textbutton">VIEW PRINTABLE VERSION</A>
<BR><BR-->

<H2><cfoutput>#language.Drydock#</cfoutput></H2>
<!-- Begin Dry Docks table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<cfoutput>
	<TR>
		<!---TH id="company" class="calendar" style="font-size: 12px; width: 10%;">#language.COMPANYCaps#</TH--->
		<TH id="section" class="calendar small" style="width: 20%;">#language.SECTIONCaps#</TH>
		<TH id="docking" class="calendar small" style="width: 40%;">#language.DOCKINGCaps#</TH>
		<TH id="booking" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>
	</cfoutput>
	<CFIF getDockBookings.RecordCount neq 0>
		<CFOUTPUT query="getDockBookings">
		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<!---TD class="calendar">#VesselLength#M <CFIF Anonymous>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD--->
			<!---TD headers="company" class="calendar">#abbreviation#</TD--->
			<TD headers="section" class="calendar small"><DIV align="center"><DIV align="center"><CFIF Status eq 'c'>
									<CFIF Section1 eq true>1</CFIF>
									<CFIF Section2 eq true>
										<CFIF Section1> &amp; </CFIF>
									2</CFIF>
									<CFIF Section3 eq true>
										<CFIF Section1 OR Section2> &amp; </CFIF>
									3</CFIF>
								<CFELSE>#language.tentative#
								</CFIF>
								</DIV></TD>
			<TD headers="docking" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End Dry Docks table -->
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.northLandingWharf#</cfoutput></h2>
<!-- Begin North Jetty table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<cfoutput>
	<TR>
		<!---TH id="company2" class="calendar" style="font-size: 12px; width: 10%;">#language.COMPANYCaps#</TH--->
		<TH id="section2" class="calendar small" style="width: 20%;">#language.SECTIONCaps#</TH>
		<TH id="docking2" class="calendar small" style="width: 40%;">#language.DOCKINGCaps#</TH>
		<TH id="booking2" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>
	</cfoutput>
	<CFIF getNJBookings.RecordCount neq 0>
		<CFOUTPUT query="getNJBookings">
		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<!---TD class="calendar">#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD--->
			<!---TD headers="company2" class="calendar">#abbreviation#</TD--->
			<TD headers="section2" class="calendar small"><DIV align="center"><CFIF Status eq 'c'>#language.booked#
										<CFELSEIF Status eq 't'>#language.tentative#
										</CFIF></DIV></TD>
			<TD headers="docking2" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking2" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End North Jetty table -->
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.southJetty#</cfoutput></h2>
<!-- Begin South Jetty table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<cfoutput>
	<TR>
		<!---TH id="company3" class="calendar" style="font-size: 12px; width: 10%;">#language.COMPANYCaps#</TH--->
		<TH id="section3" class="calendar small" style="width: 20%;">#language.SECTIONCaps#</TH>
		<TH id="docking3" class="calendar small" style="width: 40%;">#language.DOCKINGCaps#</TH>
		<TH id="booking3" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>
	</cfoutput>
	<CFIF getSJBookings.RecordCount neq 0>
		<CFOUTPUT query="getSJBookings">
		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<!---TD class="calendar">#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD--->
			<!---TD headers="company3" class="calendar">#abbreviation#</TD--->
			<TD headers="section3" class="calendar small"><DIV align="center"><CFIF Status eq 'c'>#language.booked#
										<CFELSEIF Status eq 't'>#language.tentative#
										<CFELSE>#language.pending#
										</CFIF></DIV></TD>
			<TD headers="docking3" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking3" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<!-- End South Jetty table -->
<CFELSE>
</TABLE>
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>
<BR><BR>

</div>

</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">