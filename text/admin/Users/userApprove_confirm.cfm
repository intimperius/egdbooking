<cfif isDefined("form.userID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Approve User"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve User</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<CFSET This_Page = "../admin/userApprove_confirm.cfm">

<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	UserID, FirstName, LastName
	FROM 	Users
	WHERE 	UserID = '#Form.UserID#'
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name AS CompanyName
	FROM 	Companies
	WHERE 	CompanyID = '#Form.CompanyID#'
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

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	<A href="userApprove.cfm?lang=#lang#">User Approvals</A> &gt;
	</CFOUTPUT>
	Approve User
</div>

<div class="main">
<H1>Approve User</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<div align="center">
	<p>Are you sure you want to approve <cfoutput><strong>#getUser.FirstName# #getUser.LastName#</strong></cfoutput>'s 
		request to join <cfoutput><strong>#getCompany.companyName#</strong></cfoutput>?</p>
	<cfoutput>
	<form action="userApprove_action.cfm?lang=#lang#" name="approveUser" method="post">
		<input type="hidden" name="UserID" value="#Form.UserID#">
		<input type="hidden" name="CompanyId" value="#Form.CompanyId#">
		<!---a href="javascript:EditSubmit('rejectUser');" class="textbutton">Submit</a--->
		<input type="submit" class="textbutton" value="Approve">
		<input type="button" value="Cancel" onClick="self.location.href='userApprove.cfm?lang=#lang#'" class="textbutton">
	</form>
	</cfoutput>
</div>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">