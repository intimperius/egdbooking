<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Approve User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve User</title>">
	<cfset request.title ="Approve User">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/userApprove_confirm.cfm">

<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	UID, FirstName, LastName
	FROM 	Users
	WHERE 	UID = <cfqueryparam value="#Form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CID, Name AS CompanyName
	FROM 	Companies
	WHERE 	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
		
		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Approve User
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<div style="text-align:center;">
					<p>Are you sure you want to approve <cfoutput><strong>#getUser.FirstName# #getUser.LastName#</strong></cfoutput>'s
						request to join <cfoutput><strong>#getCompany.companyName#</strong></cfoutput>?</p>
					<cfoutput>
					<form action="userApprove_action.cfm?lang=#lang#" id="approveUser" method="post">
						<input type="hidden" name="UID" value="#Form.UID#" />
						<input type="hidden" name="CID" value="#Form.CID#" />
						<!---a href="javascript:EditSubmit('rejectUser');" class="textbutton">Submit</a--->
						<input type="submit" class="button-accent button" value="Approve" />
						<a href="userApprove.cfm?lang=#lang#" class="textbutton">Cancel</a>
					</form>
					</cfoutput>
				</div>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
