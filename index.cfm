<cfoutput>
<!DOCTYPE html>
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
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
<!-- WET 3.0, PWGSC 1.0 file: 1sp-pe-fra-eng.html -->
<!-- TitleStart -->
<title>Bienvenue &ndash; Cale s&egrave;che d'Esquimalt &ndash; TPSGC | Welcome &ndash; Esquimalt Graving Dock &ndash; PWGSC</title>
<!-- TitleEnd -->
<!-- MetadataStart -->
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="The Esquimalt Graving Dock, or EGD, is proud to be federally owned, operated, and maintained. EGD is the largest solid-bottom commercial drydock on the West Coast of the Americas. We are located in an ice free harbour on Vancouver Island near gateways to Alaska and the Pacific Rim." />
<meta name="description" lang="en" content="La Cale s&egrave;che d'Esquimalt (CSE) est la plus importante forme de radoub commerciale de la c&ocirc;te Ouest des Ameriques. Nous sommes situes dans un port ouvert a l'ann&egrave;e longue, sur l'&icirc;le de Vancouver, a proximite des voies d'acces a l'Alaska et aux pays riverains du Pacifique." />
<meta name="dcterms.description" content="La Cale s&egrave;che d'Esquimalt (CSE) est la plus importante forme de radoub commerciale de la c&ocirc;te Ouest des Ameriques. Nous sommes situes dans un port ouvert a l'ann&egrave;e longue, sur l'&icirc;le de Vancouver, a proximite des voies d'acces a l'Alaska et aux pays riverains du Pacifique." />
<meta name="dcterms.description" lang="en" content="The Esquimalt Graving Dock, or EGD, is proud to be federally owned, operated, and maintained. EGD is the largest solid-bottom commercial drydock on the West Coast of the Americas. We are located in an ice free harbour on Vancouver Island near gateways to Alaska and the Pacific Rim." />
<meta name="dcterms.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
<meta name="dcterms.creator" lang="en" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dcterms.title" content="Bienvenue &ndash; Cale s&egrave;che d'Esquimalt &ndash; TPSGC | Welcome &ndash; Esquimalt Graving Dock &ndash; PWGSC" />
<meta name="dcterms.title" lang="en" content="Bienvenue &ndash; Cale s&egrave;che d'Esquimalt &ndash; TPSGC | Welcome &ndash; Esquimalt Graving Dock &ndash; PWGSC" />
<meta name="dcterms.issued" title="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" title="W3CDTF" content="<!--##config timefmt='%Y-%m-%d'--><!--##echo var='LAST_MODIFIED'-->" />
<meta name="dcterms.subject" title="gccore" content="Ship; Wharf" />
<meta name="dcterms.subject" lang="en" title="gccore" content="Navire; Quai" />
<meta name="dcterms.language" title="ISO639-2" content="fra" />
<meta name="dcterms.language" lang="en" title="ISO639-2" content="eng" />
<meta name="keywords" content="Cale s&egrave;che d'Esquimalt, CSE, Demande de r&eacute;servation" />
<meta name="keywords" lang="en" content="Esquimalt Graving Dock, EGD, Booking Request" />
<!-- MetadataEnd -->
<!--[if gte IE 9 | !IE ]><!-->
<link href="#RootDir#GCWeb/assets/favicon.ico" rel="icon" type="image/x-icon">
<link rel="stylesheet" href="#RootDir#GCWeb/css/theme.min.css">
<!--<![endif]-->
<link rel="stylesheet" href="#RootDir#GCWeb/css/messages.min.css">
<!--[if lt IE 9]>
<link href="#RootDir#GCWeb/assets/favicon.ico" rel="shortcut icon" />
<link rel="stylesheet" href="#RootDir#GCWeb/css/messages-ie.min.css" />
<link rel="stylesheet" href="#RootDir#GCWeb/css/ie8-theme.min.css" />
<script src="#RootDir#wet-boew/js/ie8-wet-boew.min.js"></script>
<![endif]-->
<!--[if lte IE 9]>
<![endif]-->
<script type="text/javascript" src="#RootDir#scripts/jquery-1.7.1.min.js"></script>
<noscript><link rel="stylesheet" href="#RootDir#wet-boew/css/noscript.min.css" /></noscript>

<!-- Google Tag Manager DO NOT REMOVE OR MODIFY - NE PAS SUPPRIMER OU MODIFIER -->
<script>dataLayer1 = [];</script>
<!-- End Google Tag Manager -->
</head>

<body class="splash" vocab="http://schema.org/" typeof="WebPage">
<!-- Google Tag Manager DO NOT REMOVE OR MODIFY - NE PAS SUPPRIMER OU MODIFIER -->
<noscript><iframe title="Google Tag Manager" src="//www.googletagmanager.com/ns.html?id=GTM-TLGQ9K" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start': new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j=d.createElement(s),dl=l!='dataLayer1'?'&l='+l:'';j.async=true;j.src='//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer1','GTM-TLGQ9K');</script>
<!-- End Google Tag Manager -->
<div id="bg">
<img src="#RootDir#images/sp-bg-2.jpg" alt="">
</div>
<main role="main">
<div class="sp-hb">
<div class="sp-bx col-xs-12">
<h1 property="name" class="wb-inv">{title}}</h1>
<div class="row">
<div class="col-xs-11 col-md-8">
<object type="image/svg+xml" tabindex="-1" role="img" data="#RootDir#GCWeb/assets/sig-spl.svg" width="283" aria-label="Government of Canada / Gouvernement du Canada"></object>
</div>
</div>

<div style="width: inherit; margin-right: auto; margin-left: auto; text-align: center;">
<h3>Welcome / Bienvenue</h3>
<h2>Esquimalt Graving Dock</br>Cale s&egrave;che d'Esquimalt</h2>
</div>

<div class="row">
<section class="col-xs-6 text-right">
<h2 class="wb-inv">Public Works and Government Services Canada</h2>
<p><a href="#RootDir#index-eng.cfm" class="btn btn-primary">English</a></p>
</section>
<section class="col-xs-6" lang="fr">
<h2 class="wb-inv">Travaux publics et Services gouvernementaux Canada</h2>
<p><a href="#RootDir#index-fra.cfm" class="btn btn-primary">Fran&ccedil;ais</a></p>
</section>
</div>
</div>
<div class="sp-bx-bt col-xs-12">
<div class="row">
<div class="col-xs-7 col-md-8">
<a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" class="sp-lk">Terms & conditions</a> <span class="glyphicon glyphicon-asterisk"></span> <a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-fra.html" class="sp-lk" lang="fr">Avis</a>
</div>
<div class="col-xs-5 col-md-4 text-right mrgn-bttm-md">
<object type="image/svg+xml" tabindex="-1" role="img" data="#RootDir#GCWeb/assets/wmms-spl.svg" width="127" aria-label="Symbol of the Government of Canada / Symbole du gouvernement du Canada"></object>
</div>
</div>
</div>
</div>
</main>
<!--[if gte IE 9 | !IE ]><!-->
<script src="#RootDir#wet-boew/js/wet-boew.min.js"></script><span class="wb-init" id="wb-rsz">&nbsp;</span>
<!--<![endif]-->
<!--[if lt IE 9]>
<script src="#RootDir#wet-boew/js/ie8-wet-boew2.min.js"></script>
<![endif]-->
</body>
</html>

</cfoutput>