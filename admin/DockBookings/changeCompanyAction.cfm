<cfoutput>
     <CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
      
      <CFELSE>
      
    </CFIF>
    
</cfoutput>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT VNID
FROM Vessels
WHERE CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" /> AND Name = <cfqueryparam value="#vesselNameURL#" cfsqltype="cf_sql_varchar" />
</cfquery>

<!---
<cfoutput query="getVessel">
#BRIDURL#
<br />
#newUserName#
<br />
#VNID#
</cfoutput>--->


<cfquery name="insertdata" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
UPDATE Bookings
SET
<cfoutput query="getVessel">	VNID = <cfqueryparam value="#Trim(VNID)#" cfsqltype="cf_sql_integer" />, </cfoutput>
	UID = <cfqueryparam value="#Trim(newUserName)#" cfsqltype="cf_sql_integer" />
WHERE BRID = <cfqueryparam value="#BRIDURL#" cfsqltype="cf_sql_integer" />
</cfquery>

<cflocation url="#RootDir#admin/DockBookings/bookingManage.cfm">

