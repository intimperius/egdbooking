<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">
	<cfset request.title = "Chaneg Company">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<div class="colLayout">
		
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT Companies.CID, Companies.Name
					FROM Companies JOIN Vessels ON Companies.CID = Vessels.CID
					WHERE Companies.Approved = 1 AND Companies.Deleted = 0 AND Vessels.Name = <cfqueryparam value="#vesselNameURL#" cfsqltype="cf_sql_varchar" /> AND Companies.Name <> <cfqueryparam value="#CompanyURL#" cfsqltype="cf_sql_varchar" />
					ORDER BY Companies.Name
				</cfquery>
		
				<cfoutput>
		
				<cfif getCompanyList.recordCount LTE "0">
					<br />#CompanyURL# cannot be changed because #vesselNameURL# isn't available in another company.
				<cfelse>
		
					<cfform action="changeCompany2.cfm" method="post">
					<table>
					  <tr>
						<td><br /><cfinput type="text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="text" style="border:0; color:##FFFFFF" value="#BRIDURL#" name="BRIDURL" required="Yes" readonly="yes" />
						</td>
					  </tr>
					  <tr>
						<td>Original Company: <cfinput type="text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes" /></td>
					  </tr>
					  <tr>
						<td>Original Agent: <cfinput type="text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes" /></td>
					  </tr>
					  <tr>
						<td><br />Change to Company:</td>
					  </tr>
					  <tr>
						<td><cfselect name="newCID" size="1" required="yes">
						  <cfloop query="getCompanyList">
							<option value="#CID#">#Name#</option>
						  </cfloop> </cfselect></td>
					  </tr>
					  <tr>
						<td><input id="submit" type="submit" value="Submit" class="button button-accent" />
					  </tr>
					</table>
					</cfform>
				</cfif>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
