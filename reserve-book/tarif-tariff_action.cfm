<cfif lang EQ 'e'>
	<cfset language.lengthError = "The 'Misc' text has exceeded the maximum alotted number of 150 words.">
<cfelse>
	<cfset language.lengthError = "Vous avez d&eacute;pass&eacute; le nombre maximum permis de 150 mots dans la bo�te de texte &laquo; Divers &raquo;">
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.otherText") AND Len(form.otherText) GT 1000>
	<cfoutput>#ArrayAppend(Errors, "#language.lengthError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/tarif-tariff.cfm?lang=#lang#&BRID=#url.BRID#" addtoken="no">
</cfif>

<cfquery name="submitTariffForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE TariffForms
	SET		<cfif isDefined("Form.BookFee") AND Form.BookFee EQ "on">
					BookFee = '1',
				<cfelse>
					BookFee = '0', 
				</cfif>
				<cfif isDefined("Form.FullDrain") AND Form.FullDrain EQ "on">
					FullDrain = '1', 
				<cfelse>
					FullDrain = '0',
				</cfif>
				<cfif isDefined("Form.VesselDockage") AND Form.VesselDockage EQ "on">
					VesselDockage = '1', 
				<cfelse>
					VesselDockage = '0', 
				</cfif>
				<cfif isDefined("Form.CargoDockage") AND Form.CargoDockage EQ "on">
					CargoDockage = '1', 
				<cfelse>
					CargoDockage = '0', 
				</cfif>
				<cfif isDefined("Form.WorkVesselBerthNorth") AND Form.WorkVesselBerthNorth EQ "on">
					WorkVesselBerthNorth = '1', 
				<cfelse>
					WorkVesselBerthNorth = '0',  
				</cfif>
				<cfif isDefined("Form.NonworkVesselBerthNorth") AND Form.NonworkVesselBerthNorth EQ "on">
					NonworkVesselBerthNorth = '1', 
				<cfelse>
					NonworkVesselBerthNorth = '0', 
				</cfif>
				<cfif isDefined("Form.VesselBerthSouth") AND Form.VesselBerthSouth EQ "on">
					VesselBerthSouth = '1', 
				<cfelse>
					VesselBerthSouth = '0', 
				</cfif>
				<cfif isDefined("Form.CargoStore") AND Form.CargoStore EQ "on">
					CargoStore = '1', 
				<cfelse>
					CargoStore = '0', 
				</cfif>
				<cfif isDefined("Form.TopWharfage") AND Form.TopWharfage EQ "on">
					TopWharfage = '1', 
				<cfelse>
					TopWharfage = '0', 
				</cfif>
				<cfif isDefined("Form.CraneLightHook") AND Form.CraneLightHook EQ "on">
					CraneLightHook = '1', 
				<cfelse>
					CraneLightHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneMedHook") AND Form.CraneMedHook EQ "on">
					CraneMedHook = '1', 
				<cfelse>
					CraneMedHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneBigHook") AND Form.CraneBigHook EQ "on">
					CraneBigHook = '1', 
				<cfelse>
					CraneBigHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneHyster") AND Form.CraneHyster EQ "on">
					CraneHyster = '1', 
				<cfelse>
					CraneHyster = '0', 
				</cfif>
				<cfif isDefined("Form.CraneGrove") AND Form.CraneGrove EQ "on">
					CraneGrove = '1', 
				<cfelse>
					CraneGrove = '0', 
				</cfif>
				<cfif isDefined("Form.Forklift") AND Form.Forklift EQ "on">
					Forklift = '1', 
				<cfelse>
					Forklift = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPrimary") AND Form.CompressPrimary EQ "on">
					CompressPrimary = '1', 
				<cfelse>
					CompressPrimary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressSecondary") AND Form.CompressSecondary EQ "on">
					CompressSecondary = '1', 
				<cfelse>
					CompressSecondary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPortable") AND Form.CompressPortable EQ "on">
					CompressPortable = '1', 
				<cfelse>
					CompressPortable = '0', 
				</cfif>
				<cfif isDefined("Form.Tug") AND Form.Tug EQ "on">
					Tug = '1', 
				<cfelse>
					Tug = '0', 
				</cfif>
				<cfif isDefined("Form.FreshH2O") AND Form.FreshH2O EQ "on">
					FreshH2O = '1', 
				<cfelse>
					FreshH2O = '0', 
				</cfif>
				<cfif isDefined("Form.Electric") AND Form.Electric EQ "on">
					Electric = '1', 
				<cfelse>
					Electric = '0',  
				</cfif>
				<cfif isDefined("Form.TieUp") AND Form.TieUp EQ "on">
					TieUp = '1', 
				<cfelse>
					TieUp = '0', 
				</cfif>
				<cfif isDefined("Form.Commissionaire") AND Form.Commissionaire EQ "on">
					Commissionaire = '1', 
				<cfelse>
					Commissionaire = '0',  
				</cfif>
				<cfif isDefined("Form.OvertimeLabour") AND Form.OvertimeLabour EQ "on">
					OvertimeLabour = '1', 
				<cfelse>
					OvertimeLabour = '0', 
				</cfif>
				<cfif isDefined("Form.LightsStandard") AND Form.LightsStandard EQ "on">
					LightsStandard = '1', 
				<cfelse>
					LightsStandard = '0', 
				</cfif>
				<cfif isDefined("Form.LightsCaisson") AND Form.LightsCaisson EQ "on">
					LightsCaisson = '1',
				<cfelse>
					LightsCaisson = '0',
				</cfif>
				<cfif isDefined("Form.Other") AND Form.Other EQ "on" AND trIM(Form.otherText) NEQ "">
					otherText = <cfqueryparam value="#Form.otherText#" cfsqltype="cf_sql_varchar" />,
					Other = '1'
				<cfelse>
					otherText = '',
					Other = '0'
				</cfif>
				WHERE BRID = <cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<!--- queries to populate details in e-mail sent to dock administrators --->

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, CID
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VNID = Vessels.VNID
	WHERE	BRID = (<cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />)
</cfquery>
	
<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	firstname + ' ' + lastname AS UserName, Email, Companies.Name AS CompanyName
	FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID 
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE	Users.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND Companies.CID = <cfqueryparam value="#getDetails.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="BookingDates" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT     EndDate, StartDate
FROM       Bookings
WHERE     (BRID = <cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />)
</cfquery>
	<cfoutput>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Drydock Booking Request - Services and Facilities Requested" type="html">
			<p>#getUser.userName# of <em>#getUser.companyName#</em> has filled out the on-line Tariff of Dock Charges form for their drydock booking of vessel <strong>#getDetails.VesselName#</strong> from #DateFormat(BookingDates.StartDate, 'mmm d, yyyy')# to #DateFormat(BookingDates.EndDate, 'mmm d, yyyy')#.</p>
		</cfmail>
	</cfoutput>

<cflocation addtoken="no" url="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#&BRID=#url.BRID#">

