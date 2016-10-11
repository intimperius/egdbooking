<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List</title>">
	<cfset request.title ="Edit Email List">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getAdministrators" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email, firstname + ' ' + lastname AS AdminName, Administrators.UID
	FROM 	Administrators INNER JOIN Users on Administrators.UID = Users.UID
	WHERE 	users.deleted = 0
	ORDER BY lastname, firstname
</cfquery>

<cfquery name="getEmails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
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

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Edit Email List
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
	</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfinclude template="#RootDir#includes/getStructure.cfm">

<cfoutput>
<form id="emailForm" action="editAdminDetails_action.cfm?lang=#lang#" method="post">
Select any of the following administrators to receive email notification about user activities:
<table style="width:90%;">
	<tr><th>Name</th><th>Email</th><th></th></tr>
	<cfloop query="getAdministrators">
		<tr>
			<td>#AdminName#</td><td>#email#</td><td><input type="checkbox" name="Email#UID#" value="#UID#" <cfif ListContains(getEmails.email, "#email#") NEQ 0>checked</cfif> /></td>
		</tr>
	</cfloop>
</table>

<br />
<div style="text-align:right;"><input type="submit" value="Submit" class="button-accent button" />
<a href="menu.cfm?lang=#lang#">Cancel</a>
</div>
</form>

</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
