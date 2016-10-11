<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Administrator</title>">
	<cfset request.title = "Add Administrator">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UID, LastName + ', ' + FirstName AS UserName
	FROM Users
	WHERE Deleted = 0
	AND NOT EXISTS (SELECT	UID
					FROM	Administrators
					WHERE	Users.UID = Administrators.UID)
	AND EXISTS (SELECT	*
				FROM	UserCompanies
				WHERE	UserCompanies.UID = Users.UID AND Approved = 1)
	ORDER BY LastName, Firstname
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
					Add Administrator
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

			<cfif IsDefined("Session.Return_Structure")>
				<!--- Populate the Variables Structure with the Return Structure.
						Also display any errors returned --->
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			</cfif>

			<!---<div style="text-align:left;">
				<form action="addAdministrator_action.cfm?lang=#lang#" id="chooseUserForm" method="post">
					<select name="UID" value="UID" display="UserName">
					<cfloop query="getUserList">
						<option value="#getUserList.UID#">#getUserList.UserName#</option>
					</cfloop>
					</select>
					<a href="javascript:EditSubmit('chooseUserForm');">Add</a>
				</form>
			</div>--->

			<cfoutput>
			<form action="addAdministrator_action.cfm?lang=#lang#" id="addAdministratorForm" method="post">
				Select User: <select name="UID" value="UID" display="UserName">
				<cfloop query="getUserList">
					<option value="#getUserList.UID#">#getUserList.UserName#</option>
				</cfloop>
				</select>
				&nbsp;&nbsp;&nbsp;
				<!--a href="javascript:EditSubmit('addAdministratorForm');" class="textbutton">Submit</a-->
				<input type="submit" name="submitForm" value="Submit" class="button button-accent" />
				<cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
			</form>
			</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
