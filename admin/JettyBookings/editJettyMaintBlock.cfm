<cfif structKeyExists(URL, 'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfoutput>
<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>">
	<cfset request.title = "Edit Maintenance Block">
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
					Edit Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.NorthJetty" default="false">
				<cfparam name="Variables.SouthJetty" default="false">

				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.BRID")>
						<cfset Variables.BRID = #form.BRID#>
					</cfif>
				</cfif>

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfelseif IsDefined("Form.BRID") AND Form.BRID NEQ "">
					<cfquery name="GetBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BRID, Jetties.NorthJetty, Jetties.SouthJetty
						FROM	Bookings, Jetties
						WHERE	Bookings.BRID = Jetties.BRID
						AND		Deleted = '0'
						AND		Status = 'M'
						AND		Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
					</cfquery>

					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.BRID = getBooking.BRID>
				<cfelse>
					<cflocation addtoken="no" url="jettyBookingManage.cfm?lang=#lang#">
				</cfif>

				<cfif Variables.NorthJetty EQ 1>
					<cfset Variables.NorthJetty = true>
				<cfelse>
					<cfset Variables.NorthJetty = false>
				</cfif>
				<cfif Variables.SouthJetty EQ 1>
					<cfset Variables.SouthJetty = true>
				<cfelse>
					<cfset Variables.SouthJetty = false>
				</cfif>

				<cfif IsDefined("Session.form_Structure")>
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
				<form id="EditJettyMaintBlock" action="editJettyMaintBlock_process.cfm?#urltoken#" method="post">
				<input type="hidden" name="BRID" value="#Variables.BRID#" />
				<table style="width:90%;">
          <tr>
            <td id="Start"><label for="startDate">Start Date:<br /><small>#language.dateform#</small></label></td>
            <td headers="Start">
              <input type="text" id="startDate" name="startDate" class="datepicker startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
            </td>
          </tr>
          <tr>
            <td id="End"><label for="endDate">End Date:<br /><small>#language.dateform#</small></label></td>
            <td headers="End">
              <input type="text" id="endDate" name="endDate" class="datepicker endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
            </td>
          </tr>
          <tr><td colspan="2">Please select the jetty/jetties that you wish to book for maintenance:</td></tr>
          <tr>
            <td id="nj"><label for="NorthJetty">North Landing Wharf</label></td>
            <td headers="nj"><input type="checkbox" id="NorthJetty" name="NorthJetty" checked="#Variables.NorthJetty#" /></td></tr>
          <tr>
            <td id="sj"><label for="SouthJetty">South Jetty</label></td>
            <td headers="sj"><input type="checkbox" id="SouthJetty" name="SouthJetty" checked="#Variables.SouthJetty#" /></td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr>
            <td colspan="2" align="center">
              <input type="submit" class="button button-accent" value="Submit" />
              <a href="jettyBookingManage.cfm?#urltoken#" class="textbutton">Cancel</a>
            </td>
          </tr>
				</table>
				</form>


			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
