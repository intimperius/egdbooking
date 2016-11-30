<cfscript>StrUCTCLEAR(Session);</cfscript>

<!---Delete cookies used to pass session variables--->
<CFCOOKIE NAME="UID" value="" EXPIRES="Now">
<CFCOOKIE NAME="FirstName" value="" EXPIRES="Now">
<CFCOOKIE NAME="LastName" value="" EXPIRES="Now">
<CFCOOKIE NAME="EMail" value="" EXPIRES="Now">
<CFCOOKIE NAME="LoggedIn" value="0" EXPIRES="Now">
<CFCOOKIE NAME="AdminLoggedIn" value="0" EXPIRES="Now">
<CFCOOKIE NAME="AdminEmail" value="" EXPIRES="Now">

success!