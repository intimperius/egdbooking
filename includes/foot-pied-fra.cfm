<div class="clear"></div>
<!-- EndEditableContent -->
</div>

<div id="wb-sec" class="no-print"><div id="wb-sec-in">
<cfinclude template="#RootDir#includes/left-menu-gauche-fra.cfm" />
</div>
</div>

<!-- MainContentEnd -->
</main>

<div class="container no-print">
<div class="row pagedetails">
<div class="col-sm-5 col-xs-12 datemod">
<dl id="wb-dtmd">
<dt>Date de modification&#160;:&#32;</dt>
<dd><time property="dateModified"><cfoutput query="GetFile">#DateFormat(GetFile.DateLastModified, "yyyy-mm-dd")#</cfoutput></time></dd>
</dl>
</div>
<div class="clear visible-xs"></div>
<div class="col-sm-4 col-xs-6">
<a href="http://www.canada.ca/fr/contact/retroaction.html" class="btn btn-default"><span class="glyphicon glyphicon-comment mrgn-rght-sm"></span>R&eacute;troaction</a>
</div>
<div class="col-sm-3 col-xs-6 text-right">
<!-- <div class="wb-share" data-wb-share='{"lnkClass": "btn btn-default"}'></div> -->
</div>
<div class="clear visible-xs"></div>
</div>
</div>

<aside class="gc-nttvs container no-print">
<h2>Activit&eacute;s et initiatives du gouvernement du Canada</h2>
<div class="wb-eqht row mrgn-bttm-md" data-ajax-replace="https://cdn.canada.ca/gcweb-cdn-live/features/features-fr.html">
    <p><ul><li><a href="http://www.canada.ca/en/">Visitez la page d'accueil Canada.ca pour voir activit&eacute;s et initiatives du Government of Canada.</a></li></ul></p>
</div>
</aside>

<div id="wb-foot"><div id="wb-foot-in">

<cfoutput>
<footer role="contentinfo" id="wb-info">
<nav role="navigation" class="container visible-sm visible-md visible-lg wb-navcurr">
    <h2 class="wb-inv">&agrave; propos de ce site</h2>
    <div class="row">
        <div class="col-sm-3 col-lg-3">
            <section>
                <h3>Pour nous joindre</h3>
                <ul class="list-unstyled">
                    <li><a class="gl-footer" href="http://www.canada.ca/fr/contact.html">Coordonn&eacute;es</a></li>
                </ul>
            </section>
            <section>
                <h3>Nouvelles</h3>
                <ul class="list-unstyled">
                    <li><a class="gl-footer" href="http://nouvelles.gc.ca/web/index-fr.do">Salle de presse</a></li>
                
                    <li><a class="gl-footer" href="http://nouvelles.gc.ca/web/nwsprdct-fr.do?mthd=tp&amp;crtr.tp1D=1">Communiqu&eacute;s de presse</a></li>
                
                    <li><a class="gl-footer" href="http://nouvelles.gc.ca/web/nwsprdct-fr.do?mthd=tp&amp;crtr.tp1D=3">Avis aux m&eacute;dias</a></li>
                
                    <li><a class="gl-footer" href="http://nouvelles.gc.ca/web/nwsprdct-fr.do?mthd=tp&amp;crtr.tp1D=970">Discours</a></li>
                
                    <li><a class="gl-footer" href="http://nouvelles.gc.ca/web/nwsprdct-fr.do?mthd=tp&amp;crtr.tp1D=980">D&eacute;clarations</a></li>
                </ul>
            </section>
        </div>

        <section class="col-sm-3 col-lg-3">
            <h3>Gouvernement</h3>
            <ul class="list-unstyled">
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/systeme.html">Comment le gouvernement fonctionne</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/min.html">Minist&egrave;res et organismes</a></li>
            
                <li><a class="gl-footer" href="http://pm.gc.ca/fra">Premier ministre</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/ministres.html">Ministres</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/fonctionpublique.html">Fonction publique et force militaire</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/systeme/lois.html">Trait&eacute;s, lois et r&egrave;glements</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/bibliotheques.html">Biblioth&egrave;ques</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/publications.html">Publications</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/gouvernement/statistiques.html">Statistiques et donn&eacute;es</a></li>
            
                <li><a class="gl-footer" href="http://www1.canada.ca/fr/nouveausite.html">&agrave; propos de Canada.ca</a></li>
            </ul>
        </section>

        <section class="col-sm-3 col-lg-3 brdr-lft">
            <h3>Transparence</h3>
            <ul class="list-unstyled">
                <li><a class="gl-footer" href="http://www.canada.ca/fr/transparence/rapports.html">&eacute;tablissement de rapports &agrave; l'&eacute;chelle du gouvernement</a></li>
            
                <li><a class="gl-footer" href="http://ouvert.canada.ca/fr">Gouvernement ouvert</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/transparence/divulgation.html">Divulgation proactive</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/transparence/avis.html">Avis</a></li>
            
                <li><a class="gl-footer" href="http://www.canada.ca/fr/transparence/confidentialite.html">Confidentialit&eacute;</a></li>
            </ul>
        </section>

        <div class="col-sm-3 col-lg-3 brdr-lft">
            <section>
    <h3>R&eacute;troaction</h3>
    <p>
        <a class="gl-footer" href="http://www1.canada.ca/fr/contact/retroaction.html">
            <img src="#RootDir#GCWeb/assets/feedback.png" alt="R&eacute;troaction sur ce site Web">
        </a>
    </p>
</section>
            <section>
    <h3>M&eacute;dias sociaux</h3>
    <p>
        <a class="gl-footer" href="http://www.canada.ca/fr/sociaux.html">
            <img src="#RootDir#GCWeb/assets/social.png" alt="M&eacute;dias sociaux">
        </a>
    </p>
</section>
<section>
    <h3>Centre mobile</h3>
    <p>
        <a class="gl-footer" href="http://www.canada.ca/fr/mobile.html">
            <img src="#RootDir#GCWeb/assets/mobile.png" alt="Centre mobile">
        </a>
    </p>
</section>
        </div>
    </div>
</nav>

<div class="brand">
    <div class="container">
        <div class="row">
            <div class="col-xs-6 visible-sm visible-xs tofpg">
                <a class="gl-footer" href="##wb-cont">Haut de la page
                    <span class="glyphicon glyphicon-chevron-up"></span>
                </a>
            </div>
            <div class="col-xs-6 col-md-12 text-right">
                <object type="image/svg+xml" tabindex="-1" role="img" data="#RootDir#GCWeb/assets/wmms-blk.svg" aria-label="Symbole du gouvernement du Canada">Canada</object>
            </div>
        </div>
    </div>
</div>

</footer>
</cfoutput>
</div></div>

</body>
</html>
