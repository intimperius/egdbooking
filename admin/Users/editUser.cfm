<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit User</title>">
	<cfset request.title ="Edit User Profile">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UID, LastName + ', ' + FirstName AS UserName, ReadOnly
	FROM Users
	WHERE Deleted = 0
	ORDER BY LastName
</cfquery>

<cfparam name="form.UID" default="#session.UID#">
<cfif isDefined("url.UID")>
	<cfset form.UID = #url.UID#>
</cfif>


<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CID, Name
	FROM 	Companies
	WHERE 	Companies.Deleted = '0'
	AND		NOT EXISTS
			(	SELECT	UserCompanies.CID
				FROM	UserCompanies
				WHERE	UserCompanies.Deleted = '0'
				AND		UserCompanies.CID = Companies.CID
				AND		UserCompanies.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
			)
	ORDER BY Companies.Name
</cfquery>

<!---<cfparam name="url.UID" default="#form.UID#">
<cfif isDefined("form.UID")>
	<cfset url.UID = #form.UID#>
</cfif>--->

<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name, UserCompanies.Approved, Companies.CID
	FROM	UserCompanies INNER JOIN Users ON UserCompanies.UID = Users.UID
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE	Users.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0
	ORDER BY UserCompanies.Approved DESC, Companies.Name
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Users
	WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>


<cfparam name="variables.ReadOnly" default="#getUser.ReadOnly#">
<cfparam name="variables.FirstName" default="#getUser.FirstName#">
<cfparam name="variables.LastName" default="#getUser.LastName#">
<cfparam name="variables.email" default="#getUser.Email#">


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
					Edit User Profile
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm"><br />
				</cfif>

				<div style="text-align:left;">
					<cfoutput>
					<form action="editUser.cfm?lang=#lang#" id="chooseUserForm" method="post">
						<select name="UID" value="UID" display="UserName" selected="#form.UID#">
							<cfloop query="getUserList">
								<option value="#getUserList.UID#">#getUserList.UserName#</option>
							</cfloop>
						</select>
						<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Edit</a-->
						<input type="submit" name="submitForm" value="View" class="button-accent button" />
					</form>
					</cfoutput>
				</div>

				<cfoutput>
				<form action="editUser_action.cfm?lang=#lang#" id="editUserForm" method="post">
					<div>
            <strong>Edit Profile:</strong><br />
						<label for="firstname">First Name:</label>
						<input name="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" id="firstName" message="Please enter a first name." /><br /><br />
						<label for="lastName">Last Name:</label>
						<input name="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" id="lastName" message="Please enter a last name." /><br /><br />
						Read Only:<br />
							<cfif #variables.ReadOnly# NEQ "1">
							<input type="radio" name="ReadOnly" value="0" checked>No<input type="radio" name="ReadOnly" value="1" />Yes
							<cfelse>
							<input type="radio" name="ReadOnly" value="0" />No<input type="radio" name="ReadOnly" value="1" checked="true" />Yes
							</cfif>
						<br /><br />
						Email:<br />
						<input name="email" type="text" value="#variables.email#" size="25" maxlength="40" required="yes" id="email" />
							
            <!---<td headers="Email"><cfoutput>#variables.email#</cfoutput></td>--->

              <!--a href="javascript:document.editUserForm.submitForm.click();" class="textbutton">Submit</a-->
              <cfif isDefined("form.UID")><cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput></cfif>
              <input type="submit" value="Save Profile Changes" class="button-accent button" />
						</div>
				</form>
				</cfoutput>

				<hr width="65%" align="center">

				<cfoutput query="getUserCompanies">
					<form method="post" action="removeUserCompany_confirm.cfm?lang=#lang#" name="remCompany#CID#">
						<input type="hidden" name="CID" value="#CID#" />
						<input type="hidden" name="UID" value="#form.UID#" />
					</form>
				</cfoutput>

				<table style="width:81%;">
				<tr>
					<cfoutput><td valign="top" colspan="3"><cfif getUserCompanies.recordCount GT 1><strong>User Companies:</strong><cfelse><strong>User Company:</strong></cfif></td></cfoutput>
				</tr>
				<cfoutput query="getUserCompanies">
					<tr>
						<td style="width:50%;" valign="top">#name#</td>
						<td headers="#name#" align="right" valign="top" style="width:20%;"><cfif getUserCompanies.recordCount GT 1><a href="javascript:EditSubmit('remCompany#CID#');" class="textbutton">Remove</a></cfif></td>
						<td headers="#name#" align="right" valign="top" style="width:30%;"><cfif approved EQ 0><i>awaiting approval</i><cfelse>&nbsp;</cfif></td>
					</tr>
				</cfoutput>
				</table>

				<cfoutput>
				<form action="addUserCompany_action.cfm?lang=#lang#" id="addUserCompanyForm" method="post">
        <br />
					<div>
						<label for="companySelect"><b>Add Company:</b></label>
              <select name="CID" id="companySelect" required="yes" message="Please select a company.">
                <option value="">(Please select a company)
                <cfloop query="getCompanies">
                  <cfoutput><option value="#CID#">#Name#</cfoutput>
                </cfloop>
              </select>
              <input type="submit" name="submitForm" value="Add" class="textbutton" />
              <cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput>
              <cfoutput><font size="-2">If the desired company is not listed, click <a href="editUser_addCompany.cfm?lang=#lang#&UID=#form.UID#">here</a> to create one.</font></cfoutput>
					</div>
				</form>
				</cfoutput>

				<hr width="65%" align="center"><br />
        
        <br />
        		<cfoutput>
				<form action="changePassword.cfm?lang=#lang#" method="post" id="changePassForm">
          <div>
						<strong>Change Password:</strong>
						<label for="pass">Password <span class="smallFont">(*min. 8 characters)</span>:</label>
						<input type="password" id="pass" name="password1" required="yes" size="25" message="Please enter a password." /><br />
						<label for="repeatPass">Repeat Password:</label>
						<input type="password" id="repeatPass" name="password2" required="yes" size="25" message="Please repeat the password for verification." /><br />
						<input type="submit" value="Change Password" class="button-accent button" />
						<cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput>
					</div>
					<br />
					<div><cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
				</form>
				</cfoutput>

				<p><em>*Email notification of profile updates is automatically sent to the user after their password is changed or a company is added to their profile.</em></p>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
