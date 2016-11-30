<cfoutput>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif lang EQ "eng">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.keywords = language.masterKeywords & ", Edit Vessel">
	<cfset language.description = "Allows user to edit the details of a vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.reset = "reset">
	<cfset language.anonymousWarning = "Anonymous vessels are only anonymous to other companies' users.  The Esquimalt Graving Dock administrators have access to all vessel information regardless of anonymity.">
	<cfset language.notEditVesselDimensions = "You may not edit the vessel dimensions as this vessel currently has confirmed bookings.  To make dimension changes, please contact EGD Administration.">
	
	
	 <cfset language.vesselLabel = "Vessel:" >
	<cfset language.CompanyNameLabel = "Company Name:" >
	<cfset language.vesselNameLabel = "Name:" >
	<cfset language.LengthLabel = "Length (m):" >
	<cfset language.WidthLabel = "Width (m):" >
	<cfset language.daysLabel = "days:" >
	<cfset language.LloydsIDLabel = "<abbr title='International Maritime Organization'>IMO</abbr> Number:" >
	<cfset language.TonnageLabel = "Tonnage:" >
	<cfset language.anonymousLabel = "Keep this vessel anonymous:">
	
	<cfset language.colon = ":">
<cfelse>
	<cfset language.editVessel = "Modifier le navire">
	<cfset language.keywords = language.masterKeywords & ", Modifier le navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de modifier les d&eacute;tails concernant un navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Raison sociale">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.anonymousWarning = "Les navires anonymes ne sont anonymes qu'aux utilisateurs d'autres entreprises. Les administrateurs de la cale s&egrave;che d'Esquimalt ont acc&egrave;s &agrave; la totalit&eacute; de l'information concernant les navires, peu importe l'anonymat.">
	<cfset language.notEditVesselDimensions = "Vous ne pouvez pas modifier les dimensions du navire, parce que ce dernier fait l'objet de r&eacute;servations confirm&eacute;es. Pour apporter des changements aux dimensions, pri&egrave;re de communiquer avec l'administration de la CSE.">

	<cfset language.vesselLabel = "Navire&nbsp:" >
	<cfset language.CompanyNameLabel = "Raison sociale&nbsp:" >
	<cfset language.vesselNameLabel = "Nom&nbsp:" >
	<cfset language.LengthLabel = "Longueur (m)&nbsp:" >
	<cfset language.WidthLabel = "Largeur (m)&nbsp:" >
	<cfset language.daysLabel = "jours&nbsp:" >
	<cfset language.LloydsIDLabel = "Code d'identification de la Lloyds&nbsp:" >
	<cfset language.TonnageLabel = "Tonnage&nbsp:" >
	<cfset language.anonymousLabel = "Garder ce navire anonyme&nbsp:">
	<cfset language.colon = "&nbsp;:">
	</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
  <meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.editVessel />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfparam name="err_name" default="">
<cfparam name="err_lgt" default="">
<cfparam name="err_wdt" default="">
<cfparam name="err_bst" default="">
<cfparam name="err_btt" default="">
<cfparam name="err_ton" default="">


				<h1 id="wb-cont">#language.editVessel#</h1>

				<CFIF NOT IsDefined('url.VNID') AND Not IsNumeric('url.VNID')>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</CFIF>

				<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
					WHERE VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" />
					AND Vessels.Deleted = 0
				</cfquery>

				<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfif getVesselDetail.recordCount EQ 0>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</cfif>


				<cfif isDefined("form.lloydsID")>
					<cfset variables.Name = form.Name>
					<cfset variables.lloydsID = form.lloydsID>
					<cfset variables.length = form.length>
					<cfset variables.width = form.width>
					<cfset variables.blocksetuptime = form.blocksetuptime>
					<cfset variables.blockteardowntime = form.blockteardowntime>
					<cfset variables.tonnage = form.tonnage>
					<cfif isDefined("form.anonymous") AND form.anonymous EQ "yes">
						<cfset variables.anonymous = 1>
					<cfelse>
						<cfset variables.anonymous = 0>
					</cfif>
				<cfelse>
					<cfset variables.Name = getVesselDetail.Name>
					<cfset variables.lloydsID = getVesselDetail.lloydsID>
					<cfset variables.length = getVesselDetail.length>
					<cfset variables.width = getVesselDetail.width>
					<cfset variables.blocksetuptime = getVesselDetail.blocksetuptime>
					<cfset variables.blockteardowntime = getVesselDetail.blockteardowntime>
					<cfset variables.tonnage = getVesselDetail.tonnage>
					<cfset variables.anonymous = getVesselDetail.anonymous>
				</cfif>

				<cfif not #error("name")# EQ "">
              <cfset err_name = "form-alert" />
        </cfif>
        <cfif not #error("length")# EQ "">
              <cfset err_lgt = "form-alert" />
        </cfif>
        <cfif not #error("width")# EQ "">
              <cfset err_wdt = "form-alert" />
        </cfif>
        <cfif not #error("blocksetuptime")# EQ "">
              <cfset err_bst = "form-alert" />
        </cfif>
        <cfif not #error("blockteardowntime")# EQ "">
              <cfset err_btt = "form-alert" />
        </cfif>
        <cfif not #error("tonnage")# EQ "">
              <cfset err_ton = "form-alert" />
        </cfif>

				<cfinclude template="#RootDir#includes/user_menu.cfm">

        <cfinclude template="#RootDir#includes/getStructure.cfm">
				<form id="editVessel" action="#RootDir#reserve-book/naviremod-vesseledit_action.cfm?lang=#lang#&amp;CID=#getVesselDetail.CID#&amp;VNID=#VNID#" method="post">
					<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
					<div id="actionErrors">#language.notEditVesselDimensions#</div>
					</cfif>
	<fieldset>				
            <legend>#language.vessel#</legend>
            <p>#language.requiredFields#</p>

            <div>
              <label for="CID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.CompanyNameLabel#
              </label>
              <input type="text" disabled="disabled" readonly="readonly" id="CID" name="CID" value="#getVesselDetail.CompanyName#" style="width: 260px;" />
            </div>

			<div>
              <label for="name">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.vesselNameLabel#<span class="form-text">#error("name")#</span>
              </label>
            </div>
            <div class="#err_name#">
              <input name="name" id="name" type="text" value="#variables.name#" size="35" maxlength="100" />
              
            </div>

			<div>
              <label for="LloydsID">#language.LloydsIDLabel#</label>
              <input id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" />
			</div>

		<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
			<div>
                <label for="length">#language.LengthLabel#</label>
                <p>#variables.length# m</p>
                <input type="hidden" id="length" name="length" value="#variables.length#" />
			</div>

			<div>
                <label for="width">#language.WidthLabel#</label>
                <p>#variables.width# m</p>
                <input type="hidden" id="width" name="width" value="#variables.width#" />
			</div>
		<cfelse>
			
            <div>
              <label for="length">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.LengthLabel# <span class="color-medium">(#language.Max##language.colon# #Variables.MaxLength#)</span> <span class="form-text">#error("length")#</span>
              </label>
            </div>
            <div class="#err_lgt#">
              <input name="length" id="length" type="text" value="#variables.length#" size="8" maxlength="8"/>
              
              
			</div>
            
			<div>
              <label for="width">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.WidthLabel# <span class="color-medium">(#language.Max##language.colon# #Variables.MaxWidth#)</span> <span class="form-text">#error("width")#</span>
              </label>
            </div>
            <div class="#err_wdt#">
              <input name="width" id="width" type="text" value="#variables.width#" size="8" maxlength="8" />
              
              
			</div>
		</cfif>

			<div>
              <label for="blocksetuptime" id="block_setup_time">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.BlockSetup# #language.daysLabel#<span class="form-text">#error("blocksetuptime")#</span>
              </label>
            </div>
            <div class="#err_bst#">
              <input name="blocksetuptime" id="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" />
              
			</div>

			<div>
              <label for="blockteardowntime" id="block_teardown_time">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.BlockTeardown# #language.daysLabel#<span class="form-text">#error("blockteardowntime")#</span>
              </label>
            </div>
            <div class="#err_btt#">
              <input name="blockteardowntime" id="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" />
              
			</div>

			<div>
              <label for="tonnage">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.TonnageLabel#<span class="form-text">#error("tonnage")#</span>
              </label>
            </div>
            <div class="#err_ton#">
              <input name="tonnage" id="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" />
              
			</div>

             <div>
              
              <input type="checkbox" id="Anonymous" name="Anonymous" value="Yes" />
			  <label for="Anonymous">#language.anonymousLabel#<sup id="fnb1-ref"><a class="footnote-link" href="##fnb1"><span class="wb-invisible">#language.footnote#</span>1</a></sup></label>
            </div>

            <div>
              <input type="hidden" name="VNID" value="#url.VNID#" />
              <input type="submit" value="#language.Submit#" name="submitForm" class="button button-accent" />
            </div>
	</fieldset>				
				</form>

       <div class="wet-boew-footnotes" role="note">
          <section>
            <h2 id="fnb" class="wb-invisible">Footnotes</h2>
            <dl>
              <dt>Footnote 1</dt>
                <dd id="fnb1">
                  <p>#language.anonymousWarning#</p>
                  <p class="footnote-return"><a href="##fnb1-ref"><span class="wb-invisible">Return to footnote </span>1<span class="wb-invisible"> referrer</span></a></p>
                </dd>
            </dl>
          </section>
        </div>
				
		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>

