<cfinclude template="#RootDir#includes/errorMessages.cfm">

<cfif lang EQ "eng">
	<cfset language.submitJettyBooking = "Submit Jetty Booking Request">
	<cfset language.keywords = language.masterKeywords & ", Jetty Booking Request">
	<cfset language.description = "Allows user to submit a new booking request, jetties section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.reset = "reset">
	<cfset language.requestedJetty = "Requested Jetty">
	<cfset language.Company = "Company">
	<cfset language.warning = "Once this booking is confirmed, your company will be subject to a booking fee should the specified vessel not arrive for the requested time.">
	<cfset language.chooseCompany = "choose a company">
	<cfset language.requestedStatus = "Requested Status">
	
	<cfset language.VesselLabel = "Vessel:">
	<cfset language.startDateLabel = "Start Date:">
	<cfset language.endDateLabel = "End Date:">
	<cfset language.requestedStatusLabel = "Requested Status:">
	<cfset language.requestedJettyLabel = "Requested Jetty:">
<cfelse>
	<cfset language.submitJettyBooking = "Pr&eacute;sentation d'une demande de r&eacute;servation de jet&eacute;e">
	<cfset language.keywords = language.masterKeywords & ", Demande de r&eacute;servation de jet&eacute;e">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation - section des jet&eacute;es.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.requestedJetty = "Jet&eacute;e demand&eacute;e">
	<cfset language.Company = "Entreprise">
	<cfset language.warning = "Une fois la r&eacute;servation confirm&eacute;e, votre entreprise devra payer des frais de r&eacute;servation si le navire indiqu&eacute; n'arrive pas au moment pr&eacute;vu.">
	<cfset language.chooseCompany = "s&eacute;lectionner une entreprise">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
	
	<cfset language.VesselLabel = "Navire&nbsp:">
	<cfset language.startDateLabel = "Date de d&eacute;but&nbsp;:">
	<cfset language.endDateLabel = "Date de fin&nbsp:">
	<cfset language.requestedStatusLabel = "&Eacute;tat demand&eacute;&nbsp:">
	<cfset language.requestedJettyLabel = "Jet&eacute;e demand&eacute;e&nbsp:">
</cfif>

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="#language.submitJettyBooking# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.description" content="#language.description#" />
	<meta name="dcterms.subject" title="gccore" content="#language.subjects#" />
	<title>#language.submitJettyBooking# - #language.esqGravingDock# - #language.PWGSC#</title>
		
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = language.submitJettyBooking />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	VNID, vessels.Name AS VesselName, companies.CID, companies.Name AS CompanyName
		FROM 	Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
				INNER JOIN UserCompanies ON Companies.CID = UserCompanies.CID
				INNER JOIN Users ON UserCompanies.UID = Users.UID
		WHERE 	Users.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
		AND		UserCompanies.Approved = 1
		AND		UserCompanies.Deleted = 0
		AND		Companies.Deleted = '0'
		AND		Companies.Approved = 1
		AND		Vessels.Deleted = '0'
		ORDER BY Companies.Name, Vessels.Name
	</cfquery>
</cflock>


<cfparam name="Variables.VNID" default="">
<cfparam name="Variables.startDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.endDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.Jetty" default="north">
<cfparam name="Variables.Status" default="tentative">
<cfparam name="err_jstart" default="">
<cfparam name="err_jend" default="">
<cfparam name="err_jvess" default="">


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfif IsDefined("URL.Date")>
		<cfset Variables.StartDate = URL.Date>
		<cfset Variables.EndDate = URL.Date>
	</cfif>
</cflock>

				<h1 id="wb-cont"><cfoutput>#language.submitJettyBooking#</cfoutput></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("session.form_structure") and structKeyExists(form, 'VNID')>
					<cfset Variables.VNID = #form.VNID#>
					<cfset Variables.startDate = #form.startDate#>
					<cfset Variables.endDate = #form.endDate#>
					<cfset Variables.Jetty = #form.jetty#>
					<cfset Variables.Status = #form.status#>
				</cfif>
				
				<cfoutput>
				<p>#language.enterInfo#  #language.dateInclusive#</p>

				<form action="#RootDir#reserve-book/jetdemande-jetrequest_confirm.cfm?lang=#lang#" method="post" id="bookingreq">
					<fieldset>
            <legend>#language.booking#</legend>
            <p>#language.requiredFields#</p>

			<div class="#err_jvess#">
              <label for="VNID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
				#language.vesselLabel# 
				
				<!--- condition to check if vessel selected--->
				<br>
				<cfif (isdefined('form.VNID')) AND (form.VNID EQ "")>
				<span class="uglyred">#language.noVesselError#</span>
				</cfif>
				
              
			  </label>  
              <select id="VNID" name="VNID">
                <option value="">(#language.chooseVessel#)</option>
                <cfloop query="companyVessels">
                  <cfset selected = "" />
                  <cfif companyVessels.VNID eq variables.VNID>
                    <cfset selected = "selected=""selected""" />
                  </cfif>
                  <option value="#companyVessels.VNID#" #selected#>#companyVessels.VesselName#</option>
                </cfloop>
              </select>
              
            </div>

			
            <div class="#err_jstart#">
              <label for="StartDate">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.StartDateLabel#
                <br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
				
				<!--- condition to check startdate---> <br>
				<cfif not isDate(Variables.startDate)>
				<cfset Variables.startDate = "01/01/2030"/>
				<span class="uglyred">#language.invalidStartError#</span>
				</cfif>
				
	            </label>
			  <input type="date" id="StartDate" name="startDate" value="#DateFormat(variables.startDate, 'yyyy-mm-dd')#">
             
            </div>

			<div class="#err_jend#">
              <label for="EndDate">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.EndDateLabel#
                <br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
				
				<!--- condition to check enddate ---> <br>
				<cfif not isDate(Variables.endDate)>
				<cfset Variables.endDate =  "01/01/2030"> 
				<span class="uglyred">#language.invalidEndError#</span>
				</cfif>			
				
				<!--- <span class="form-text">#error('EndDate')#</span>--->
	
              </label>
			  <input type="date" id="EndDate" name="endDate" value="#DateFormat(variables.endDate, 'yyyy-mm-dd')#">
             
			</div>

			<div>
              <label for="status">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.requestedStatusLabel#
              </label>
              <select id="status" name="status" >
                <option value="tentative" <cfif Variables.Status EQ "tentative">selected="selected"</cfif>>#language.tentative#</option>
                <option value="confirmed" <cfif Variables.Status EQ "confirmed">selected="selected"</cfif>>#language.confirmed#</option>
              </select>
						</div>

            <div>
              <label for="jetty">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.RequestedJettyLabel#
              </label>
              <select id="jetty" name="jetty" >
                <option value="north"<cfif Variables.Jetty EQ "north"> selected="selected"</cfif>>#language.NorthLandingWharf#</option>
                <option value="south"<cfif Variables.Jetty EQ "south"> selected="selected"</cfif>>#language.SouthJetty#</option>
              </select>
            </div>

            <div>
              <input type="submit" class="button button-accent" value="#language.Submit#" />
            </div>
					</fieldset>
				</form>
				<p>#language.warning#</p>
				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

