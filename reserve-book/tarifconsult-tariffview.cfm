<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.viewTariffHeading = "View Tariff of Dock Charges">
	<cfset language.keywords = language.masterKeywords & ", View of Tariff od Dock Charges">
	<cfset language.description = "Allows user to view information on services requested for a booking and the fees associated with them.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Item">
	<cfset language.services = "Services and Facilities">
	<cfset language.fees = "Fees">
	<cfset language.tableSummary = "This table displays the selected services for the booking.">
	<cfset language.misc = "Misc">
	<cfset language.miscText = "Please include scope of work and possible services required.">
	<cfset language.pricesVary = "prices vary">
<cfelse>
	<cfset language.viewTariffHeading = "Consulter le formulaire de tarif des droits de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", Consulter le formulaire de tarif des droits de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir l'information sur les services demand&eacute;s et les frais qui y sont associ&eacute;s.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Article">
	<cfset language.services = "Services et installations">
	<cfset language.fees = "frais">
	<cfset language.tableSummary = "">
	<cfset language.misc = "Divers&nbsp;">
	<cfset language.miscText = "Veuillez inclure l'&eacute;tendue des travaux et les services qui seront peut-&ecirc;tre requis.">
	<cfset language.pricesVary = "les prix varient">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.ViewTariffHeading# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.ViewTariffHeading# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	TariffForms
	<cfif isDefined("url.BRID")>WHERE	BRID = '#url.BRID#'</cfif>
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Vessels.CID, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
	<cfif isDefined("url.BRID")>WHERE	Bookings.BRID = '#url.BRID#'</cfif>
</cfquery>

<cfif lang EQ 'eng'>
	<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	item, serviceE AS service, fee, abbreviation, flex
		FROM	TariffFees
		ORDER BY sequence
	</cfquery>
<cfelse>
	<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	item, serviceF AS service, fee, abbreviation, flex
		FROM	TariffFees
		ORDER BY sequence
	</cfquery>
</cfif>

<cflock timeout="20" scope="session" throwontimeout="no" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.CID
		FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
				INNER JOIN UserCompanies ON Vessels.CID = UserCompanies.CID
		WHERE	Bookings.Deleted = 0 <cfif isdefined("url.BRID")>AND Bookings.BRID = #url.BRID#</cfif>
				AND UserCompanies.UID = #session.UID# AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfif getCompanies.recordCount EQ 0 OR getDetails.recordCount EQ 0>
	<cfif isDefined("url.BRID")>
		<cfif isDefined("url.referrer") AND url.referrer eq "archive">
			<cflocation addtoken="no" url="#RootDir#reserve-book/archives.cfm?lang=#lang#&CID=#url.CID#">
		<cfelse>
			<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
		</cfif>
	</cfif>
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.ViewTariffHeading#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.ViewTariffHeading#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<cfif isDefined("url.BRID")>
				<cfoutput>
					<h2>#getDetails.CompanyName#: #getDetails.VesselName#</h2>
					<h3>#LSDateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #LSDateFormat(getDetails.EndDate, 'mmm d, yyyy')#</h3>
				</cfoutput></cfif>

				<table summary="#language.tablesummary#">
				<cfoutput>
					<tr>
						<th id="checkHeader" style="width:5%;"><label for="other">&nbsp;</label></th>
						<th id="itemHeader" style="width:4%;"><strong>#language.Item#</strong></th>
						<th id="serviceHeader" class="feesformheader"><strong>#language.Services#</strong></th>
						<th id="feeHeader" style="width:19%;"><strong>#language.Fees#</strong></th>
					</tr>

					<tr>
						<td headers="checkHeader"><input id="other" name="other" type="checkbox" <cfif isDefined("url.BRID")><cfif getForm.other EQ 1>checked="true"</cfif></cfif> disabled="disabled" /></td>
						<td headers="itemHeader">&nbsp;</td>
						<td headers="serviceHeader">
							<table>
								<tr>
									<td>#language.Misc#:</td>
									<td><textarea name="otherText" cols="32" rows="3" disabled="disabled"><cfif isDefined("url.BRID")><cfif getForm.other EQ 1>#getForm.otherText#</cfif></cfif></textarea></td>
								</tr>
								<tr><td colspan="2">(#language.miscText#)</td></tr>
							</table>
						</td>
						<td headers="feeHeader">&nbsp;</td>
					</tr>
				</cfoutput>

				<cfoutput query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>

					<tr class="#rowClass#">
						<td headers="checkHeader">
							<cfif fee NEQ "">
								<cfset Variables.Abbr = "getForm." & #abbreviation#>
								<input name="#abbreviation#" id="#abbreviation#" type="checkbox" <cfif isDefined("url.BRID")><cfif Evaluate(Variables.Abbr) EQ 1>checked="true"</cfif></cfif> disabled="disabled" />
							</cfif>
						</td>
						<td headers="itemHeader">
							<strong>
								<cfif fee NEQ "">
									<label for="#abbreviation#">#item#</label>
								<cfelse>
									#item#
								</cfif>
							</strong>
						</td>
						<td headers="serviceHeader">
							<cfif fee NEQ "">
								<label for="#abbreviation#">#service#</label>
							<cfelse>
								#service#
							</cfif>
						</td>
						<cfif fee NEQ "">
							<cfif flex EQ 0>
						<td headers="feeHeader"><label for="#abbreviation#"><strong>#LSCurrencyFormat(fee)#</strong></label></td>
							<cfelse>
						<td headers="feeHeader"><label for="#abbreviation#"><strong>#language.pricesVary#</strong></label></td>
							</cfif>
						<cfelse>
						<td headers="feeHeader">&nbsp;</td>
						</cfif>
					</tr>
				</cfoutput>
				</table>
				<div class="buttons">
					<cfif isDefined("url.referrer") AND url.referrer eq "archive">
						<cfoutput><a href="#RootDir#reserve-book/archives.cfm?lang=#lang#&amp;CID=#url.CID#" class="textbutton">#language.Back#</a></cfoutput>
					<cfelse>
						<cfoutput><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getDetails.CID#" class="textbutton">#language.Back#</a></cfoutput>
					</cfif>
				</div>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

