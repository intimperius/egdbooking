<script language="javascript" type="text/javascript">
// used for hacktastic and uglytastic end result, the goal of which is to PREVENT such uglytastic results in Netscape 4.  Upgrade your browsers.  Please.
// Lois Chan, July 2005
function checkIt() {
	//detect Netscape 4.7-
	if (navigator.appName=="Netscape"&&parseFloat(navigator.appVersion)<=4.7) {
		return false;
	}
	return true;
}
</script>

<cfif lang EQ 'e'>
	<cfset language.bookingHomeButton = "Booking Home">
	<cfset language.drydockCalButton = "Drydock Calendar">
	<cfset language.jettyCalButton = "Jetties Calendar">
	<cfset language.requestBookingButton = "Request Booking">
	<cfset language.editProfileButton = "Edit Profile">
	<cfset language.help = "Help">
	<cfset language.logoutButton = "Logout">
<cfelse>
	<cfset language.bookingHomeButton = "Accueil - R&eacute;servation">
	<cfset language.drydockCalButton = "Calendrier de la cale s&egrave;che">
	<cfset language.jettyCalButton = "Calendrier des jet&eacute;es">
	<cfset language.requestBookingButton = "Pr&eacute;senter une r&eacute;servation">
	<cfset language.editProfileButton = "Modifier le profil">
	<cfset language.help = "Aide">
	<cfset language.logoutButton = "Fermer la session">
</cfif>

<cfset Variables.BookingRequestString = "">
<cfif IsDefined("URL.VesselID")>
	<cfset Variables.BookingRequestString = "&VesselID=#URL.VesselID#">
<cfelseif IsDefined("URL.CompanyID")>
	<cfset Variables.BookingRequestString = "&CompanyID=#URL.CompanyID#">
</cfif>
<cfif IsDefined("URL.Date") AND DateCompare(#url.date#, #Now()#, 'd') EQ 1>
	<cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&Date=#URL.Date#">
</cfif>

<CFSET variables.datetoken = "">
<CFIF IsDefined('url.month')>
	<CFSET variables.datetoken = variables.datetoken & "&month=#url.month#">
</CFIF>
<CFIF IsDefined('url.year')>
	<CFSET variables.datetoken = variables.datetoken & "&year=#url.year#">
</CFIF>


<DIV align="center" style="min-height: 30px; ">
<CFOUTPUT>
<a href="#RootDir#text/booking/booking.cfm?lang=#lang#" class="textbutton">#language.BookingHomeButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#text/common/dockCalendar.cfm?lang=#lang##datetoken#" class="textbutton">#language.DrydockCalButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#text/common/jettyCalendar.cfm?lang=#lang##datetoken#" class="textbutton">#language.JettyCalButton#</a>
<DIV style="height: 5px; ">&nbsp;</DIV>
<a href="#RootDir#text/booking/bookingRequest_choose.cfm?lang=#lang##Variables.BookingRequestString#" class="textbutton">#language.RequestBookingButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#text/booking/editUser.cfm?lang=#lang#" class="textbutton">#language.EditProfileButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#text/egd_userdoc-#lang#.html" class="textbutton" target="_blank">#language.Help#</a>
<a href="#RootDir#text/login/logout.cfm?lang=#lang#" class="textbutton">#language.LogoutButton#</a>
</CFOUTPUT>

</DIV>

<CFSET variables.urltoken = "lang=#lang#">
<CFIF IsDefined('variables.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(url.startDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(url.endDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
<CFELSEIF IsDefined('url.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
</CFIF>
