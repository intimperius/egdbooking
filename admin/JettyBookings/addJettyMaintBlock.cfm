<cfoutput>

<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

	
<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""Add Maintenance Block - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords#"" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>Add Maintenance Block - #language.esqGravingDock# - #language.PWGSC#</title>">

<cfsavecontent variable="js">
<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfset request.title = "Add Maintenance Block">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->
		<div class="colLayout">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.SouthJetty" default="false">
				<cfparam name="Variables.NorthJetty" default="false">
				<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, PacificNow)#">
				<cfparam name="Variables.EndDate" default="#DateAdd('d', 1, PacificNow)#">

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfif Variables.SouthJetty EQ 1>
						<cfset Variables.SouthJetty = true>
					<cfelse>
						<cfset Variables.SouthJetty = false>
					</cfif>
					<cfif Variables.NorthJetty EQ 1>
						<cfset Variables.NorthJetty = true>
					<cfelse>
						<cfset Variables.NorthJetty = false>
					</cfif>
				<!---cfelseif IsDefined("Session.Form_Structure")>
					<cfif isDefined("form.SouthJetty")>
						<cfset Variables.SouthJetty = true>
					<cfelse>
						<cfset Variables.SouthJetty = false>
					</cfif>
					<cfif isDefined("form.NorthhJetty")>
						<cfset Variables.NorthJetty = true>
					<cfelse>
						<cfset Variables.NorthJetty = false>
					</cfif--->
				</cfif>
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.StartDate")>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfif isDefined("form.NorthJetty")>
							<cfset Variables.NorthJetty = true>
						<cfelse>
							<cfset Variables.NorthJetty = false>
						</cfif>
						<cfif isDefined("form.SouthJetty")>
							<cfset Variables.SouthJetty = true>
						<cfelse>
							<cfset Variables.SouthJetty = false>
						</cfif>
					</cfif>
				</cfif>


				<!--- -------------------------------------------------------------------------------------------- --->
				<cfform id="AddJettyMaintBlock" action="addJettyMaintBlock_process.cfm?#urltoken#" method="post">
				<input type="hidden" name="BRID" value="#Variables.BRID#" />
				<div>
          <label for="startDate">Start Date:<br /><small>#language.dateform#</small></label>
              <input type="text" id="startDate" name="startDate" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
          <label for="endDate">End Date:<br /><small>#language.dateform#</small></label>
              <input type="text" id="endDate" name="endDate" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
          <br/>
          Please select the jetty/jetties that you wish to book for maintenance:
          <label for="northJetty">North Landing Wharf</label>
					<cfinput type="checkbox" name="NorthJetty" id="northJetty" checked="#Variables.NorthJetty#" /><br />
          <label for="southJetty">South Jetty</label>
          <cfinput type="checkbox" name="SouthJetty" id="southJetty" checked="#Variables.SouthJetty#" />
          <input type="submit" value="Submit" class="button button-accent" />
          <a href="jettyBookingManage.cfm?#urltoken#;">Cancel</a>
				</div>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
