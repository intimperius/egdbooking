<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Company Approval"" />
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Company Approval</title>">
<cfset request.title ="Company Approval">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/companyApprove.cfm">

<cfquery name="GetNewCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CID, Name
	FROM 	Companies
	WHERE 	Deleted = '0'
	AND		Approved = '0'
	ORDER BY Name
</cfquery>



<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
	
	function popUp(pageID) {
		var Cuilfhionn = window.open("<cfoutput>#RootDir#</cfoutput>" + pageID, "viewCompany", "width=500, height=300, top=20, left=20, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
		if (window.focus) {
			Cuilfhionn.focus();
	}
		
		return false;
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->
<h1 id="wb-cont">
	<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
	Company Approval
	<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
</h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfinclude template="#RootDir#includes/getStructure.cfm">
				
<cfif GetNewCompanies.RecordCount EQ 0>
	There are no new companies to approve.
<cfelse>

	<!--- Start of Company Listing --->
	<table id="listManage" class="table-condensed" style="width:90%;">
		
		<tr align="left">
			<th id="firstname">Name</th>
			<th id="abbrev" style="width:120px;">&nbsp;</th>
			<th id="approve" style="width:60px;">&nbsp;</th>
			<th id="reject" style="width:50px;">&nbsp;</th>
		</tr>
		
		<cfoutput query="GetNewCompanies">
		<cfif CurrentRow mod 2>
			<cfset rowClass = "highlight">
		<cfelse>
			<cfset rowClass = "">
		</cfif>
		<tr class="#rowClass#">
			<td headers="firstname"><a href="javascript:void(0);" onclick="popUp('admin/viewCompany.cfm?lang=#lang#&amp;CID=#CID#');">#Name#</a></td>
			<td headers="abbrev"><form action="companyApprove_confirm.cfm?lang=#lang#" method="post" name="App#CID#" style="margin-top: 0; margin-bottom: 0;" id="App#CID#"><label for="abbreviation">Abbrev.: </label><input type="text" name="abbrev" id="abbreviation" maxlength="3" size="4" /><input type="hidden" name="CID" value="#CID#" /></form></td>
			<td headers="approve"><a href="javascript:EditSubmit('App#CID#')" class="textbutton">Approve</a>
			<td headers="reject"><form action="companyReject.cfm?lang=#lang#" method="post" name="Del#CID#" style="margin-top: 0; margin-bottom: 0; "><input type="hidden" name="CID" value="#CID#" /><a href="javascript:EditSubmit('Del#CID#')" class="textbutton">Reject</a>
		</tr>
		</cfoutput>
	</table>
	<!--- End of Company Listing --->
</cfif>
				
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
