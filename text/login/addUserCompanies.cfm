<!---error checking for adding a company--->
<cfif lang EQ "e">
	<cfset language.selectCompany = "Please select a company.">
<cfelse>
	<cfset language.selectCompany = "Veuillez s&eacute;lectionner une entreprise.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.companyID") AND form.companyID EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.selectCompany#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#">
</cfif>

<!---error checking for new profile info--->
<cfif isDefined("form.Password2")>
	<cfinclude template="#RootDir#includes/errorMessages.cfm">
	<cfif lang EQ "e">
		<cfset language.unmatchedPasswordsError = "Passwords do not match, please retype.">
		<cfset language.pass1ShortError = "Your password must be at least 6 characters.">
		<cfset language.firstnameError = "Please enter your first name.">
		<cfset language.lastnameError = "Please enter your last name.">
	<cfelse>
		<cfset language.unmatchedPasswordsError = "Les mots de passe ne concordent pas, veuillez les retaper.">
		<cfset language.pass1ShortError = "Votre mot de passe doit �tre compos&eacute; d'au moins six caract&egrave;res.">
		<cfset language.firstnameError = "Veuillez entrer votre pr&eacute;nom.">
		<cfset language.lastnameError = "Veuillez entrer votre nom de famille.">
	</cfif>

	<cfset Variables.Errors = ArrayNew(1)>
	<cfset Proceed_OK = "Yes">

	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Email
		FROM	Users
		WHERE 	EMail = '#trim(form.Email)#'
		AND		Deleted = '0'
	</cfquery>

	<cfif getUser.RecordCount GT 0>
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.emailExistsError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>
	<cfif Len(trim(Form.Password1)) LT 6>
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.pass1ShortError# ")#</cfoutput>
		<cfset Proceed_OK = "No">
	<cfelseif Form.Password1 NEQ Form.Password2>
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.unmatchedPasswordsError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<cfif trim(form.firstname) EQ "">
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.firstnameError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>
	<cfif trim(form.lastname) EQ "">
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.lastnameError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<cfif NOT REFindNoCase("^([a-zA-Z_\.\-\']*[a-zA-Z0-9_\.\-\'])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$",#trim(Form.Email)#)>
		<cfoutput>#ArrayAppend(Variables.Errors, "#language.invalidEmailError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<cfif isDefined("url.companies")>
		<cfset Variables.action = "adduser.cfm?lang=#lang#&companies=#url.companies#">
	<cfelse>
		<cfset Variables.action = "adduser.cfm?lang=#lang#">
	</cfif>

	<cfif Proceed_OK EQ "No">
		<cfinclude template="#RootDir#includes/build_return_struct.cfm">
		<cfset Session.Return_Structure.Errors = Variables.Errors>
		<cflocation url="#Variables.action#" addtoken="no">
	</cfif>
</cfif>

<cfif isDefined("form.companyID") OR isDefined("form.firstname")>
	<cfset StructDelete(Session, "Form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif lang EQ "e">
	<cfset language.createUser = "Create New User">
	<cfset language.keywords = "Add New User Account">
	<cfset language.description = "Allows user to create a new user account.">
	<cfset language.company = "Company">
	<cfset language.companies = "Companies">
	<cfset language.remove = "Remove">
	<cfset language.awaitingApproval = "awaiting approval">
	<cfset language.addCompany = "Add Company">
	<cfset language.notListed = "If the desired company is not listed, click">
	<cfset language.here = "here">
	<cfset language.toCreate = "to create one.">
	<cfset language.add = "Add">
	<cfset language.editProfile = "Edit Profile">
	<cfset language.noCompanies = "No Companies">
	<cfset language.yourCompanies = "Your requested companies">
	<cfset language.submitUserRequest = "Submit New User Request">
<cfelse>
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
	<cfset language.keywords = "#language.masterKeywords#" & ", Ajout d'un nouveau compte d'utilisateur">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau compte d'utilisateur.">
	<cfset language.company = "Entreprise">
	<cfset language.companies = "Entreprises">
	<cfset language.remove = "Supprimer">
	<cfset language.awaitingApproval = "en attente d'approbation">
	<cfset language.addCompany = "Ajout d'une entreprise">
	<cfset language.notListed = "Si l'entreprise recherch&eacute;e ne se trouve pas dans la liste, cliquez">
	<cfset language.here = "ici">
	<cfset language.toCreate = "pour en cr&eacute;er une.">
	<cfset language.add = "Ajouter">
	<cfset language.editProfile = "Modification de r&eacute;servation">
	<cfset language.noCompanies = "Aucune entreprise">
	<cfset language.yourCompanies = "Les entreprises que vous avez demand&eacute;es">
	<cfset language.submitUserRequest = "Pr&eacute;senter une nouvelle demande d'utilisateur">
</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.CreateUser#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.CreateUser#</title>">
</cfoutput>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CompanyID, Name
	FROM 	Companies
	WHERE 	Companies.Deleted = '0'
	ORDER BY Companies.Name
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}
//-->
</script>
<!-- End JavaScript Block -->

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt; <a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; <a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; #language.CreateUser#
</div>

<div class="main">
<H1>#language.CreateUser#</H1>


<!---decrpyt user info--->
<cfif isDefined("url.info")><cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(url.info)), "boingfoip")></cfif>

<!---store user info--->
<cfif isDefined("url.info")><cfset Variables.firstname = ListGetAt(userInfo, 1)><cfelseif isDefined("form.firstname")><cfset Variables.firstname = form.firstname></cfif>
<cfif isDefined("url.info")><cfset Variables.lastname = ListGetAt(userInfo, 2)><cfelseif isDefined("form.lastname")><cfset Variables.lastname = form.lastname></cfif>
<cfif isDefined("url.info")><cfset Variables.email = ListGetAt(userInfo, 3)><cfelseif isDefined("form.email")><cfset Variables.email = form.email></cfif>
<cfif isDefined("url.info")><cfset Variables.password1 = ListGetAt(userInfo, 4)><cfelseif isDefined("form.password1")><cfset Variables.password1 = form.password1></cfif>

<!---encrypt user info--->
<cfset Variables.userInfo = ArrayToList(ArrayNew(1))>
<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.firstname)>
<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.lastname)>
<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.email)>
<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.password1)>
<cfset Variables.info = ToBase64(cfusion_encrypt(Variables.userInfo, "boingfoip"))>

<cfif isDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif lang EQ 'e'><table align="center" width="85%"><cfelse><table align="center" width="100%"></cfif>
		<tr>
			<td colspan="3">#language.yourCompanies#: </td>
		</tr>
	<cfif NOT isDefined("url.companies")>
		<tr>
			<td width="8%">&nbsp;</td><td>#language.NoCompanies#</td>
		</tr>
		<cfset companyList = ArrayToList(ArrayNew(1))>
	<cfelse>
		<cfif Len(url.companies) EQ 0>
			<cfset companyList = url.companies>
		<cfelse>
			<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(url.companies))), "shanisnumber1")>
		</cfif>
		<cfif isDefined("form.companyID")>
			<cfif ListFind(companyList, "#form.companyID#") EQ 0>
				<cfset companyList = ListAppend(companyList, "#form.companyID#")>
			</cfif>
		</cfif>

		<cfif Len(companyList) EQ 0>
			<tr>
				<td width="8%">&nbsp;</td><td>#language.NoCompanies#</td>
			</tr>
		</cfif>

		<cfset counter = 1>
		<cfloop index = "ID" list = "#companyList#">
			<cfif Len(companyList) EQ 0>
				<cfset companies = companyList>
			<cfelse>
				<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>
			</cfif>


			<cfset detailsID = "companyDetails#ID#">
			<cfquery name="detailsID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Name, Approved
				FROM	Companies
				WHERE	CompanyID = '#ID#'
			</cfquery>
			<tr>
				<td width="5%">
					<form method="post" action="removeUserCompany_confirm.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#Variables.info#" name="remCompany#ID#">
						<input type="hidden" name="CompanyID" value="#ID#">
					</form>&nbsp;
				</td>
				<td>#detailsID.Name#</td>
				<cfif lang EQ 'e'><td align="left" valign="top" width="45%"><cfelse><td align="left" valign="top" width="50%"></cfif><a href="javascript:EditSubmit('remCompany#ID#');" class="textbutton">#language.Remove#</a>
				&nbsp;<i>#language.awaitingApproval#</i></td>
			</tr>
			<cfset counter = counter + 1>
		</cfloop>
	</cfif>
</table><br>

<cfif Len(companyList) EQ 0>
	<cfset companies = companyList>
<cfelse>
	<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>
</cfif>

<cfform action="addUserCompanies.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#Variables.info#" name="addUserCompanyForm" method="post">
<cfif lang EQ 'e'><table align="center" width="88%"><cfelse><table align="center" width="95%"></cfif>
	<tr>
		<td valign="top"><label for="companies">#language.AddCompany#:</label></td>
		<td>
			<cfselect name="companyID" id="companies" required="yes" message="#language.selectCompany#">
				<option value="">(#language.selectCompany#)
				<cfloop query="getCompanies">
					<cfif ListFind(companyList, "#companyID#") EQ 0>
						<option value="#companyID#">#Name#
					</cfif>
				</cfloop>
			</cfselect>
			<input type="submit" name="submitCompany" value="#language.add#" class="textbutton"><BR>
			<font size="-2">#language.notListed# <a href="addCompany.cfm?lang=#lang#&amp;info=#Variables.info#&amp;companies=#companies#">#language.here#</a> #language.toCreate#</font>
		</td>
	</tr>
</table>
</cfform>


<cfform name="newUserForm" action="addUser_action.cfm?lang=#lang#&amp;info=#Variables.info#">
	<input type="hidden" name="firstname" value="#Variables.firstname#">
	<input type="hidden" name="lastname" value="#Variables.lastname#">
	<input type="hidden" name="email" value="#Variables.email#">
	<input type="hidden" name="password1" value="#Variables.password1#">
	<input type="hidden" name="companies" value="#companies#">
	<br><div align="right"><input type="submit" value="#language.SubmitUserRequest#" class="textbutton">
	<cfif lang EQ 'f'></div><br><div align="right"></cfif>
	<input type="button" onClick="self.location.href='addUser.cfm?lang=#lang#&amp;info=#Variables.info#&amp;companies=#companies#'" value="#language.editProfile#" class="textbutton">
	<input type="button" onClick="self.location.href='login.cfm?lang=#lang#'" value="#language.cancel#" class="textbutton"></div>
</cfform>

</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">