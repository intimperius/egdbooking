<cfoutput>

<CFSET variables.urltoken = "lang=#lang#">
<CFIF IsDefined('variables.startDate')>
  <CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.startDate')>
  <CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(url.startDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.endDate')>
  <CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.endDate')>
  <CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(url.endDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.show')>
  <CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
<CFELSEIF IsDefined('url.show')>
  <CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
</CFIF>

</cfoutput>
