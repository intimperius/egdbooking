<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"">
<META name=""keywords"" lang=""eng"" content="""">
<META name=""description"" lang=""eng"" content="""">
<META name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<META name=""dc.date.published"" content=""2005-07-25"">
<META name=""dc.date.reviewed"" content=""2005-07-25"">
<META name=""dc.date.modified"" content=""2005-07-25"">
<META name=""dc.date.created"" content=""2005-07-25"">
<TITLE>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</TITLE>">

<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfinclude template="#RootDir#ssi/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#ssi/bread-pain-#lang#.cfm"> &gt; 
			Administrative Functions
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#ssi/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
						<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
						Administrative Functions
						<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
						</a></h1>

				<cfform action="intromsgaction.cfm" method="POST">
				  <cffile action="read" file="#FileDir#text\intromsg.txt" variable="intromsg">
				  <cfif #Trim(intromsg)# EQ "">
					Please enter a message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
					<cfelse>
					Please update the message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
				  </cfif>
				  <BR />
				  <BR />
				  <TEXTAREA name="datatowrite" cols="40" rows="5"><cfif #intromsg# is not ""><cfoutput>#intromsg#</cfoutput></cfif>
				</TEXTAREA>
				  <BR />
				  <INPUT id="submit" type="submit" value="Update">
				</cfform>
			</div>	
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#ssi/foot-pied-#lang#.cfm">

