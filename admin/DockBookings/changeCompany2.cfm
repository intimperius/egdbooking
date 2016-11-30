<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">
	<cfset request.title = "Change Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT UserCompanies.UID, Users.FirstName, Users.LastName
	FROM UserCompanies JOIN Users ON UserCompanies.UID = Users.UID
	WHERE UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0 AND UserCompanies.CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" />
	</cfquery>
<cfquery name="getCompanyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT Name as CompanyDetail
	FROM Companies
	WHERE CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" />
</cfquery>	

<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Change Company
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>
					
<cfoutput>
	
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<form action="changeCompany3.cfm" method="post">
	<input type="hidden" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes">
	<input type="hidden" value="#BRIDURL#" name="BRIDURL" required="Yes" readonly="yes" />
	<input type="hidden" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes" />
	<input type="hidden" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes" />
	<input type="hidden" value="#newCID#" name="newCID" required="Yes" readonly="yes" />


	<div class="module-info modwide">
		<h2>#vesselNameURL#</h2>
		<ul>
			<b>Original Company:</b> #CompanyURL#<br/>
			<b>Original Agent:</b> #UserNameURL#<br/>
			<b>Change to Company:</b> <cfloop query="getCompanyDetail">#CompanyDetail#</cfloop><br />
		</ul>
	</div>
	<br />
	Change to Agent: <select name="newUserName" size="1" required="yes">
		  <cfloop query="getUserName">
			<option value="#UID#">#LastName#, #FirstName#</option>
		  </cfloop> </select>
	<br /><input id="submit" type="submit" value="Submit" class="button button-accent" />
	  
</form>
</cfoutput>
			
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
