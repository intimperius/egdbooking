<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Jetty Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/JettyBookings/editJettyBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
				<a href="bookingmanage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Change Booking Status
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Booking Status
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BookingID" default="">
				
				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfelseif IsDefined("Form.BookingID")>
					<cfset Variables.BookingID = Form.BookingID>
				<cfelse>
					<cflocation url="#returnTo#?#urltoken##dateValue#&amp;referrer=#url.referrer#" addtoken="no">
				</cfif>
				
				<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 
						Bookings.BookingID, 
						StartDate, 
						EndDate, 
						Vessels.VesselID, 
						Vessels.Name AS VesselName, 
						Companies.Name AS CompanyName, 
						NorthJetty
					FROM 
						Bookings INNER JOIN Jetties
							ON Bookings.BookingID = Jetties.BookingID
						INNER JOIN Vessels
							ON Vessels.VesselID = Bookings.VesselID
						INNER JOIN Companies 
							ON Companies.CompanyID = Vessels.CompanyID
					WHERE 
						Bookings.BookingID = '#Variables.BookingID#'
						
				</cfquery>
				
				<cfset Variables.VesselID = theBooking.VesselID>
				<cfset Variables.VesselName = theBooking.VesselName>
				<cfset Variables.CompanyName = theBooking.CompanyName>
				<cfset Variables.Start = CreateODBCDate(theBooking.StartDate)>
				<cfset Variables.End = CreateODBCDate(theBooking.EndDate)>
				<cfset Variables.Jetty = "North Landing Wharf">
				<cfif theBooking.NorthJetty EQ 0>
					<cfset Variables.Jetty = "South Jetty">
				</cfif>
				
				<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
					<cfset Variables.Start = CreateODBCDate(form.StartDate)>
					<cfset Variables.End = CreateODBCDate(form.EndDate)>
				</cfif>
				
				
				<cfform action="chgStatus_2p_action.cfm?#urltoken#&amp;referrer=#URLEncodedFormat(url.referrer)#" method="post" name="change2pending">
					Are you sure you want to change this booking's status to pending?
				<br /><br />
					<cfoutput>
					<input type="hidden" name="BookingID" value="#Form.BookingID#" />
					<table style="width:85%; padding-left:15px;" >
					<tr>
						<td id="Vessel" style="width:25%;" align="left">Vessel:</td>
						<td headers="Vessel"><input type="hidden" name="vesselID" value="<cfoutput>#Variables.VesselID#</cfoutput>" /><cfoutput>#Variables.VesselName#</cfoutput></td>
					</tr>
					<tr>
						<td id="Company" align="left">Company:</td>
						<td headers="Company"><cfoutput>#Variables.CompanyName#</cfoutput></td>
					</tr>		
					<tr>
						<td id="Start" align="left">Start Date:</td>
						<td headers="Start"><cfoutput>#DateFormat(Variables.Start,"mmm dd, yyyy")#</cfoutput></td>
					</tr>
					
					<tr>
						<td id="End" align="left">End Date:</td>
						<td headers="End"><cfoutput>#DateFormat(Variables.End,"mmm dd, yyyy")#</cfoutput></td>
					</tr>
					<tr>
						<td id="Jetty" align="left">Jetty:</td>
						<td headers="Jetty"><cfoutput>#Variables.Jetty#</cfoutput></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					</table>
					</cfoutput>
					
					<table align="center">
					<tr>
						<td>
						<input type="submit" value="submit" class="textbutton" />
						<cfoutput><input type="button" onclick="self.location.href='#returnTo#?#urltoken##dateValue#&amp;referrer=#URLEncodedFormat(url.referrer)#&amp;bookingID=#Variables.bookingID###id#Variables.bookingid#'" value="Cancel" class="textbutton" />
						</td>
					</tr>
					</table>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
