<cfoutput>
<!DOCTYPE html>
<!--[if IE 7]><html lang="fr" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="fr" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="fr" class="no-js">
<!--<![endif]-->

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<head>
<meta charset="utf-8" />
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.com/wet-boew/License-eng.txt / wet-boew.github.com/wet-boew/Licence-fra.txt -->
<!-- WET 3.0, PWGSC 1.0 file: 2col-nav-fra.html -->
<!-- MetadataStart -->
<meta name="dcterms.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
<meta name="dcterms.modified" title="W3CDTF" content="#DateFormat(GetFile.DateLastModified, "yyyy-mm-dd")#" />
<meta name="dcterms.language" title="ISO639-2" content="fra" />
<meta name="dcterms.issued" title="W3CDTF" content="2007-09-20" />
<!-- MetadataEnd -->
<cfinclude template="/boew-wet/wet3.0/html5/includes/tete-head.html" />
<!-- CustomScriptsCSSStart -->
<link href="#RootDir#css/custom.css" rel="stylesheet" type="text/css" />
<link href="#RootDir#css/jquery-ui.css" media="screen" rel="stylesheet" type="text/css"/>
<cfif structKeyExists(Session, 'AdminLoggedIn') AND Session.AdminLoggedIn>
  <script src="#RootDir#scripts/prototype.js" type="text/javascript"></script>
  <script src="#RootDir#scripts/calendar.js" type="text/javascript"></script>
  <script src="#RootDir#scripts/common.js" type="text/javascript"></script>
</cfif>
<script type="text/javascript" src="#RootDir#scripts/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="#RootDir#scripts/jquery.ui.datepicker-fr.js"></script>
<script type="text/javascript" src="#RootDir#scripts/application.js"></script>


<!-- CustomScriptsCSSEnd -->
</head>

<body><div id="wb-body-sec">
<div id="wb-skip">
<ul id="wb-tphp">
<li id="wb-skip1"><a href="##wb-cont">Passer au contenu principal</a></li>
<li id="wb-skip2"><a href="##wb-nav">Passer au menu secondaire</a></li>
</ul>
</div>

<div id="wb-head"><div id="wb-head-in"><header>
<!-- HeaderStart -->
<cfinclude template="#RootDir#includes/app_banner_gc-gc_banner_app-fra.cfm" />
<cfinclude template="/site/wet3.0/html5/includes/banner_site-site_banner-fra.html" />


<nav role="navigation">
<!-- Start of nav_mega-mega_nav-fra.html / Début de nav_mega-mega_nav-fra.html -->

<div id="gcwu-psnb"><h2>Menu<span> du site</span></h2><div id="gcwu-psnb-in"><div class="wet-boew-menubar mb-mega"><div>
<ul class="mb-menu" <!---data-ajax-replace="/site/wet3.0/html5/includes/nav_mega-mega_nav-fra.inc"--->>
<li><div><a href="http://www.tpsgc-pwgsc.gc.ca/comm/services-fra.html">Services de TPSGC</a></div></li>
<li><div><a href="http://www.tpsgc-pwgsc.gc.ca/comm/info/index-fra.html">Renseignements pour</a></div></li>
<li><div><a href="http://www.tpsgc-pwgsc.gc.ca/comm/ress-res-fra.html">Ressources TPSGC</a></div></li>
</ul>
</div></div></div></div>
<!-- End of nav_mega-mega_nav-fra.html / Fin De nav_mega-mega_nav-fra.html -->


</nav>


<div id="gcwu-bc"><h2>Fil d'Ariane</h2><div id="gcwu-bc-in">
<ol>
<cfinclude template="/site/wet3.0/html5/includes/app_pain-bread_app-fra.html" />
<cfinclude template="#RootDir#includes/bread-pain-fra.cfm" />
</ol>
</div></div>
<!-- HeaderEnd -->
</header></div></div>

<div id="wb-core"><div id="wb-core-in" class="equalize">
<div id="wb-main" role="main"><div id="wb-main-in">
<!-- MainContentStart --></cfoutput>
