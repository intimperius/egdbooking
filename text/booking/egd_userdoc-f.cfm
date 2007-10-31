<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>
			Système de réservation en ligne de la Cale sèche d'Esquimalt : Guide de l'utilisateur
		</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
        <STYLE type="text/css">
 body, th, td {
  font-size: 12pt;
 }
 
 th.link_from {
  background-color: #9999CC;
  color: #000000;
 }
	
 th.link_to {
  background-color: #CC99CC;
  color: #000000;
 }
 
 th {
  color: #FFFFFF;
  background-color: #339999;
 }
 
 .small {
  font-size: 10pt;
 }
 
 div.title {
  font-size: 18pt;
  color: #339999;
  font-weight: bold;
 }
 
 .red {
  color: #FF0000;
 }
 
 .style1 {
	font-size: 14pt;
	font-weight: bold;
 }
 
 .style2 {font-size: 12pt}
 .style8 {
	font-size: 12pt;
	font-style: italic;
 }
 .style10 {font-size: 14pt}
 .style11 {
	font-size: 13pt;
	font-weight: bold;
 }
 .style12 {
	font-weight: bold;
	font-style: italic;
 }

H1 {
	font-family: verdana, sans-serif;
	font-size: 160%;
	color: #669900;
	margin-bottom: 10px;
	border-bottom: 1px dashed;
	letter-spacing: 2px;
	font-weight: normal;
}

a, a:active {
	color: #CC7700;
	text-decoration: none;
}

a:visited {
	color: #996600;
}

a:hover {
	color: #FF3300;
	text-decoration: none;
}
</STYLE>
	</HEAD>
	
	<BODY bgcolor="#FFFFFF" text="#000000">
	
			
	<div align="center" class="style1">
	  <table width="58%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%">
            <p><a name="Top"></a><h1>Cale sèche d'Esquimalt (CSE)</h1>       
            <h1>Système de réservation en ligne : Guide de l'utilisateur</h1>       
            <p class="style1">Table des matières</p>       
            <p align="left"><span class="style2"><strong><a href="#Overview">1.        
            Aperçu</a></strong></span></p>
            <div style="padding-left:0px;"><strong><a href="#GettingStarted">2. 
              Introduction</a></strong><br>
            </div>
            <div style="padding-left:20px;"><em><a href="#SystemReqs">2.1        
              Configuration exigée</a><br>       
              <a href="#CreateAccount">2.2 Créer un compte d'utilisateur</a></em><br>       
            </div>
            <div style="padding-left:40px;">2.2.1 Par où commencer<br>       
			  2.2.2 Compagnie(s) de l'utilisateur<br>       
			  2.2.3 Créer un compte de compagnie<br>       
			  2.2.4 Activer un compte d'utilisateur <br>       
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingIn">2.3 Entrée        
              dans le système</a><br>       
              <a href="#GetPassword">2.4 Récupération du mot de passe</a></em><br>       
                  <br>
            </div>
            <span class="style2">
            <div style="padding-left:0px;"><strong><a href="#UsingApp">3.  
              Utilisation du système de réservation en ligne de la CSE</a></strong></div>       
            </span>
            <div style="padding-left:20px;"><em><a href="#HomePage">3.1 Page de 
              bienvenue</a></em><br></div>
			 <div style="padding-left:40px;">3.1.1 Entreprises<br>      
 				 3.1.2 Réservations       
            </div>
             <div style="padding-left:20px;"><em><a href="#EditProfile">3.2 
              Modifier le profil d'utilisateur</a></em><br>
            </div>
            <div style="padding-left:40px;">3.2.1 Modifier les renseignements        
              personnels<br>
              3.2.2  
              Changement de mot de passe            </div>
            <div style="padding-left:20px;"><em><a href="#Vessels">3.3 Navires</a></em><br>
            </div>
            <div style="padding-left:40px;">3.3.1 Ajouter des navires<br> 
			  3.3.2 Modifier le profil de navires<br> 
			  3.3.3 Supprimer des navires<br> 
            </div>
            <div style="padding-left:20px;"><em><a href="#Bookings">3.4 Réservations</a></em><br>       
            </div>
            <div style="padding-left:40px;">3.4.1 Réserver une cale sèche<br></div>       
			<div style="padding-left:60px;"><span class="style8">3.4.1.1 Demande        
              de dates précises<br>       
				3.4.1.1 Demande de la prochaine période disponible</span><br></div>       
			<div style="padding-left:40px;">
			  3.4.2 Réserver une jetée<br>       
			  3.4.3 Modifier une réservation<br>       
			  3.4.4 Annuler une réservation<br>       
			  3.4.5 Annulations et suppressions pour des raisons administratives<br>       
			  3.4.6 Préavis de 24 heures<br>       
            </div>
            <div style="padding-left:20px;"><em><a href="#Overviews">3.5 Réservations        
              - Vues d'ensemble</a></em><br>       
            </div>
            <div style="padding-left:40px;">3.5.1 Calendriers<br>       
 				 3.5.2 Sommaire des réservations<br>       
            </div>
            <div style="padding-left:20px;"> <em><a href="#Forms">3.6        
              Formulaires pour les réservation</a>s</em><br>      
            </div>
            <div style="padding-left:40px;">
  				3.6.1 Tarifs de droit de cale sèche<br>     
  				3.6.2 Tableau 1<br>       
  				3.6.3 Clause d'indemnisation<br>       
  				3.6.4 Formulaire de modification d'une réservation<br>      
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingOut">3.7 Sortie        
              du système</a></em><br>       
            </div>
            
            <p>           
            <hr width="75%">
            <p><strong><br>
              <br>
            <a name="Overview"></a><span class="style10">1. Aperçu</span></strong><br>       
            <div style="padding-left:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le        
              système de réservation en ligne de la Cale sèche d'Esquimalt        
              (CSE) est une façon pratique de réserver électroniquement des        
              installations de la CSE. Le système permet aux utilisateurs        
              d'observer l'état des réservations qu'ils ont fait pour retenir  
              la cale sèche ou une jetée, et donne accès à toutes les activités        
              connexes.</div>
            <br>
            <a href="#Top">Retour à la table des matières</a>       
            <p></p>
            <p><strong><br>
                  <a name="GettingStarted"></a><span class="style10">2. 
            Introduction</span></strong><br> 
            <div style="padding-left:20px;"><em><a name="SystemReqs"></a><strong class="style11">2.1     
              Configuration exigée</strong></em></div>    
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avant     
              d'entrer dans le système¸ veillez à ce que votre navigateur     
              respecte les paramètres de configuration suivants :       
                <ul>
                  <li><a href="http://browser.netscape.com/ns8/" target="_blank">Netscape 4+</a> (<a href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="_blank">liens 
                    vers de plus vieilles versions</a>), <a href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="_blank">Internet Explorer 4+</a>, 
                    ou <a href="http://www.mozilla.org/products/firefox/" target="_blank">Mozilla Firefox</a></li> 
                  <li>JavaScript activé</li>    
                  <li>Témoins (cookies) activés</li>   
                  <li><a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</a>  
                    installé</li>    
                </ul>
              Pour installer l'un ou l'autre des logiciels requis, cliquez sur     
              les liens ci-dessus. Si vous avez des difficultés à activer le JavaScript     
              ou les témoins, suivez les instructions suivantes :      
                <ul>
                  <li>Netscape 4 : Allez à Édition &gt; Préférences &gt;   
                    Avancé pour activer les deux fonctions. </li>    
                  <li>Netscape 7 ou 8 : Allez à Édition &gt; Préférences.   
                    Vous trouverez les fonctions JavaScript sous Avancé, et   
                    Cookies sous Confidentialité et sécurité.</li>  
                  <li>Internet Explorer 6 : Allez à Outils &gt; Options Internet.   
                    Vous trouverez JavaScript sous Advanced, et Cookies sous   
                    Confidentialité.</li>
                  <li>Mozilla Firefox : Allez à Outils &gt; Options. Vous trouverez   
                    JavaScript sous Fonctionnalités Web, et Cookies sous   
                    Confidentialité.</li>
                </ul>
            </div>
            <a href="#Top">Retour à la table des matières</a>    
            <p></p>
            <p>            
            <div style="padding-left:20px;"> <em><a name="CreateAccount"></a><span class="style11"><strong>2.2     
              Créer un compte d'utilisateur</strong></span></em>    
            </div>
            <div style="padding-left:40px;"><strong>2.2.1 Par où commencer</strong><br>    
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Allez     
              à la page principale du site de la CSE : <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html</a>     
              et cliquez sur «&nbsp;Réservations&nbsp;» dans le menu latéral.     
              Cliquez sur le lien « application des réservations », puis     
              cliquez sur « ajouter un nouveau compte d'utilisateur ». Entrez     
              vos coordonnées, y compris votre prénom, votre nom de famille,     
              un mot de passe de 6 à 10 caractères et votre adresse de     
              courriel, lesquels sont tous des renseignements obligatoires.     
              L'adresse de courriel que vous donnerez sera utilisée pour l'entrée     
              dans le système et les avis que la CSE vous enverra par courriel.     
              Le système ne fait pas la distinction entre les majuscules et les     
              minuscules pour les mots de passe, donc vous pouvez utiliser aussi     
              bien les unes que les autres. Pour un mot de passe plus sécuritaire,     
              nous vous suggérons d'utiliser des lettres et des chiffres.       
              <br>
              <br>
            </div>
            <div style="padding-left:40px;"><strong>2.2.2 Entreprises(s) de  
              l'utilisateur</strong><br>
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;À     
              la prochaine page, ajoutez à votre profil la ou les entreprises que     
              vous représentez. Choisissez votre entreprise dans le menu déroulant     
              et cliquez sur «&nbsp;Ajouter&nbsp;». Vous pouvez le refaire     
              autant de fois qu'il le faut. Si l'entreprise que vous représentez     
              n'est pas énumérée, voir le paragraphe 2.2.3.<br>       
              <br>
            </div>
            <div style="padding-left:40px;"><strong>2.2.3 Créer un compte  
              d'entreprise</strong><br>
            </div>
            <div style="padding-left:60px;">
              <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez sur     
                le lien « ici&nbsp;» sous le menu déroulant (figure 1)     
                pour créer un profil d'entreprise. Tous les champs sont     
                obligatoires, sauf « Adresse 2&nbsp;» et «&nbsp;Fax&nbsp;».     
                En cliquant sur le bouton «&nbsp;soumettre&nbsp;», vous créerez     
                le compte d'entreprise et aviserez la CSE de la demande de création     
                d'un nouveau profil d'entreprise. Le profil d'entreprise devra     
                être approuvé avant que l'on ne puisse l'activer.<br>       
              </div>
            </div>
				<br>
                <div align="center"><img src="../../images/createCompanyLink-f.gif" alt="Figure 1 : Ajouter une nouvelle entreprise"></div>
                <div align="center">Figure 1 : Ajouter une nouvelle entreprise <br>
                
              </div>
            <div style="padding-left:40px;"><br>
            <strong>2.2.4 Activer un compte d'utilisateur</strong>            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              votre ou vos entreprises ont été ajoutées, cliquez sur «     
              Soumettre une demande d'ajout d'un nouvel utilisateur ». Cela     
              aura pour effet de transmettre votre demande de compte et d'en     
              aviser l'administration de la CSE. Votre compte doit être approuvé     
              avant que l'on ne puisse l'activer. Si vous ajoutez plusieurs  
              entreprises à votre profil, il n'est pas nécessaire qu'elles     
              soient toutes approuvées pour que votre compte soit activé. Vous     
              recevrez un avis par courriel lorsqu'une affiliation  
              utilisateur-entreprise est approuvée ou rejetée.       
              <p></p>
            </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>    
            <p>
            <div style="padding-left:20px;"><em><a name="LoggingIn"></a><strong class="style11">2.3     
              Entrée dans le système</strong><br>    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'approbation     
              d'une seule affiliation utilisateur-entreprise est nécessaire     
              pour que le compte soit activé. Lorsque vous recevez un courriel     
              vous avisant que l'une de vos affiliations utilisateur-entreprise     
              est approuvée, entrez dans le système avec l'adresse de courriel     
              et le mot de passe que vous avez indiqués lors de la création de     
              votre compte. Allez à&nbsp; <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html</a>     
              et cliquez sur « Réservations » dans le menu latéral. Cliquez     
              ensuite sur le lien « Application des réservations&nbsp;». Cela     
              vous mènera à la page d'entrée dans le système.</div>       
            <p></p>
            <a href="#Top">Retour à la table des matières</a> <br>    
            <p>            
            <div style="padding-left:20px;"><em><a name="GetPassword"></a><strong class="style11">2.4     
              Récupération du mot de passe</strong><br>    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si     
              vous avez oublié votre mot de passe, cliquez sur le lien « Oubli  
              du mot de passe » de la page d'entrée. Entrez l'adresse     
              de courriel que vous utilisez pour l'entrée dans le système, et     
              votre mot de passe vous sera transmis par courriel.<br>       
            </div>
            <br>
            <a href="#Top">Retour à la table des matières</a>    
            <p></p>
            <p>     <br>       
            <strong><a name="UsingApp"></a><span class="style10">3. Utilisation  
            du     
            système de réservation en ligne de la CSE</span></strong>    
            
            <div style="padding-left:20px;"><em><a name="HomePage"></a><span class="style11"><strong>3.1 
              Page de bienvenue</strong></span></em><br>
            </div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              vous entrez dans l'application, vous arrivez à la « page de     
              bienvenue » du système de réservation. Vous avez accès à     
              toutes les fonctions du système de réservation à partir de     
              cette page. Toutes les principales fonctions sont disponibles à     
              partir de la barre de menus sous le titre de la page (figure 2).     
              Vous pouvez aussi naviguer dans le site au moyen de la piste de     
              navigation (figure 3). La piste de navigation vous indique le     
              chemin que vous avez suivi jusqu'à maintenant dans le site, ce     
              qui peut être très utile si vous voulez revenir en arrière.</div>       
            <br>
                <div align="center"><img src="../../images/userMenuBar-f.gif" alt="Figure 2 : barre de menus"></div>
                <div align="center">Figure 2: barre de menus <br>
                </div>
			<br>
                <div align="center"><img src="../../images/userBreadcrumbs-f.gif" alt="Figure 3 : piste de navigation"></div>
                <div align="center">Figure 3: piste de navigation <br>
            <br>
            </div>
			<div style="padding-left:40px;"><strong>3.1.1 Entreprises</strong></div>
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La     
              page de bienvenue affiche des renseignements sur une entreprise à     
              la fois. Le nom de l'entreprise dont on voit les renseignements     
              est affiché dans le titre. Si vous êtes autorisé à représenter     
              plus d'une entreprise, l'affichage des renseignements de  
              l'entreprise précisée se fera sous la barre de menus, et les noms     
              des autres entreprises seront affichés tout juste en dessous     
              (figure&nbsp;4). Vous pouvez passer d'une entreprise à une autre     
              en cliquant sur leur nom. Le nom de toute entreprise pour laquelle     
              vous attendez l'approbation de représentation apparaîtra tout juste     
              en dessous de votre liste d'entreprises.<br>      
			  <br>
                <div align="center"><img src="../../images/userCompanies-f.gif" alt="Figure 4 : vos entreprises"></div>
                <div align="center">Figure 4: vos entreprises <br>
                </div>
			</div>
			<br>
			<div style="padding-left:40px;"><strong>3.1.2 Réservations</strong></div>    
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Toutes     
              les réservations pour l'entreprise que vous choisissez&nbsp; sont     
              affichées sur la page de bienvenue. Pour une liste complète de     
              toutes les réservations, y compris les réservations passées,     
              cliquez sur le bouton «&nbsp;Toutes les réservations ».<br>       
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les réservations sont ainsi     
              divisées : « Cale sèche&nbsp;», «&nbsp;Quai de débarquement nord » et « Jetée     
              sud ». Seuls les renseignements essentiels sont affichés : nom     
              du navire, dates au bassin, état de la réservation et agent     
              responsable de la réservation. En cliquant sur le nom du navire,     
              vous pouvez voir d'autres renseignements sur la réservation, et     
              vous avez l'option de la modifier ou de l'annuler. Pour les réservations     
              de la cale sèche, il y a aussi un lien menant qui permet de «  
              Consulter le formulaire de tarif&nbsp;» ou d'apporter une «  
              Modification au&nbsp; formulaire de tarif ». Veuillez consulter le paragraphe 3.6.1     
              pour de plus amples renseignements sur les formulaires de tarif.</div>      
		   
            <p><a href="#Top">Retour à la table des matières</a> </p>    
<p>
<div style="padding-left:20px;"><em><a name="EditProfile"></a><span class="style11"><strong>3.2 
  Modifier le profil d'utilisateur</strong></span></em><br></div>
  <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour     
    modifier votre profil, cliquez sur «&nbsp;Modifier le profil&nbsp;» dans     
    la barre de menus. La page «&nbsp;Modifier le profil&nbsp;» est divisée     
    en trois sections, et chacune d'entre elles a son bouton de soumission.<br>       
    <br>
  </div>
  <div style="padding-left:40px;"><strong>3.2.1 Modifier les renseignements 
    personnels</strong><br></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La première     
    section vous permet de modifier votre prénom et votre nom. L'adresse de     
    courriel ne peut pas être modifiée, étant donné qu'il s'agit de votre     
    code d'identification pour l'entrée dans le système. Pour utiliser une     
    adresse de courriel différente, vous devez créer un nouveau compte     
    d'utilisateur.<br>   
    <br>
  </div>
	<div align="center"><img src="../../images/userEditUserName-f.gif" alt="Figure 5 : modifier votre nom"></div>
	<div align="center">Figure 5 : modifier votre nom <br><br>
  </div>
  <div style="padding-left:40px;"><strong>3.2.2 Changement de mot de passe</strong><br>
  </div> 
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La troisième     
    section vous permet de changer votre mot de passe, qui doit compter de 6 à     
    10 caractères.&nbsp; Le système ne fait pas la distinction entre les     
    majuscules et les minuscules pour les mots de passe, donc vous pouvez     
    utiliser aussi bien les unes que les autres. Pour des raisons de sécurité,     
    nous vous suggérons d'utiliser des lettres et des chiffres dans votre mot     
    de passe, et de le changer fréquemment.</div>       
  <br><div align="center"><img src="../../images/editUserPassword-f.gif" alt="Figure 7 : modifier votre mot de passe"></div>
	<div align="center">Figure 7: modifier votre mot de passe <br>
  </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>    
  
  <p> <div style="padding-left:20px;"><em><a name="Vessels"></a><span class="style11"><strong>3.3 
              Navires</strong></span></em><br></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les     
      navires d'une entreprise sont énumérés dans la page de bienvenue sous la     
      rubrique «&nbsp;Navire(s)&nbsp;». Si le navire que vous cherchez n'est     
      pas dans la liste, vérifiez si vous avez bien les renseignements pour la     
      bonne entreprise. Pour voir les renseignement sur le navire, cliquez sur     
      son nom.<br>       
      <br>
    </div>
	<div style="padding-left:40px;"><strong>3.3.1 Ajouter des navires</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      «&nbsp;Ajout d'un navire&nbsp;» sous la liste des navires de  
      l'entreprise. Tous les champs sont obligatoires. Les longueurs et les     
      largeurs sont en mètres, et les temps d'installation et de retrait des  
      tins sont en jours. Le temps d'installation des tins est le nombre de jours nécessaires     
      pour installer les tins de soutien avant que l'eau ne puisse être enlevée     
      de la cale, et le temps de retrait des tins est le nombre de jours nécessaires     
      pour faire l'inverse. Il faut inclure ces temps dans le nombre de jours     
      demandés pour la réservation.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme, toutes les réservations     
      pour ce navire seront affichées sans nom dans les calendriers et les     
      sommaires des réservations. Ainsi, seules les dates et l'état de la réservation     
      sont affichés pendant que celle-ci est en traitement attente de confirmation ou     
      provisoire. Lorsque la confirmation est donnée, l'information     
      additionnelle suivante est affichée&nbsp;: l'entreprise, le nom du navire     
      et sa longueur, les sections réservées ainsi que les dates de la réservation.     
      Tout autre renseignement sur le navire ou la réservation ne peut être vu     
      par les utilisateurs d'autres entreprises. Les administrateurs ont accès     
      à toute l'information sur les réservations et les navires, peu importe  
      si ces derniers sont anonymes ou non.<br>      
    <br></div>
    <div style="padding-left:40px;"><strong>3.3.2 Modifier le profil de navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique «&nbsp;Navire(s) », puis cliquez     
      sur le bouton «&nbsp;Modifier le navire ». Vous pouvez     
      modifier tous les renseignements sur le navire, à l'exception de  
      l'entreprise, à condition que le navire n'ait pas de réservation confirmée.     
      Dans le cas contraire, vous ne pourrez pas modifier les dimensions du     
      navire. Pour ce faire, vous devrez communiquer avec l'administration du     
      CSE. L'administration est avisée lorsque les renseignements sur un navire     
      sont modifiés.<br>       
      <br></div>
    <div style="padding-left:40px;"><strong>3.3.3 Supprimer des navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique «&nbsp;Navire(s), puis cliquez sur     
      le bouton « Supprimer le navire&nbsp;». Les navires ne peuvent être supprimés     
      que s'il ne font l'objet d'aucune demande de réservation. Dans le cas     
      contraire, vous recevrez un message affichant les réservations pour le     
      navire qui doivent être annulées avant que le navire ne puisse être     
      supprimé. Si vous arrivez à supprimer le navire, vous recevrez un avis     
      de confirmation.</div>       
            <p><a href="#Top">Retour à la table des matières</a> </p>    
  <p> <div style="padding-left:20px;"><em><a name="Bookings"></a><span class="style11"><strong>3.4     
              Réservations</strong></span></em></div>
    <div style="padding-left:40px;"><strong>3.4.1 Réserver la cale sèche</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur «&nbsp;Présenter une réservation&nbsp;» sous vos réservations&nbsp;  
      ou sur «&nbsp;Présenter une réservation&nbsp;»    
      dans la barre de menus, puis choisissez l'option de réservation de la    
      cale sèche. Il y a deux façons de réserver la cale sèche : indiquer des    
      dates précises, ou demander le nombre de jours voulus dans la prochaine période    
      libre (p. ex. demander la&nbsp; prochaine période de 10 jours dans l'année    
      qui vient.).<br>       
      <br>
    </div>
	<div style="padding-left:60px;"><span class="style12">3.4.1.1 Demande de    
      dates précises</span><br></div>   
	  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous    
        les champs sont obligatoires pour la réservation. Il faut choisir  
        l'entreprise et le navire au moyen des menus déroulants, et il faut préciser    
        les dates du début et de la fin de la période réservée. Vous pouvez    
        entrer manuellement les dates «&nbsp;mm/jj/aaaa&nbsp;» ou utiliser les    
        boutons calendriers. Lorsque vous cliquez sur l'un de ces boutons, un    
        petit calendrier apparaît, dans lequel vous pouvez cliquer sur la date    
        choisie. Cette date sera entrée dans la boîte de date correspondante.    
        Lorsque vous choisissez des dates de bassin, veuillez vous assurer de    
        tenir compte du temps nécessaire pour installer et retirer les tins.  (<em>Nota    
        </em>: les dates de bassin sont inclusives, p.&nbsp;ex. une réservation    
        de trois jours se fera du 1<sup>er</sup> mai au 3 mai.)<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si la cale sèche est disponible pour les    
        dates demandées, vote demande sera soumise. Si rien n'est disponible    
        pour les dates précisées, vous avez le choix d'essayer de nouvelles    
        dates, ou de maintenir votre demande dans l'espoir d'une annulation.    
        Veuillez consulter le paragraphe 3.4.6 pour de plus amples    
        renseignements sur le processus de préavis de 24&nbsp;heures pour les    
        annulations.<br>    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque votre réservation est soumise, un    
        avis est transmis par courriel à l'administration de la CSE, et vous    
        recevez un formulaire de tarif des droits de cale sèche. Il s'agit d'un formulaire    
        facultatif; pour de plus amples renseignements, voir le paragraphe 3.6.1.<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe à l'administration de la CSE    
        d'approuver la réservation; toutefois, lorsque vous avez reçu l'avis    
        de confirmation de la réservation par courriel, vous devez envoyer les    
        formulaires appropriées - le tableau 1 et la clause d'indemnisation -    
        ainsi que les frais de réservation de 3 500 $ avant que la réservation    
        ne puisse être confirmée. Prière de consulter la section 3.6 pour de    
        plus amples renseignements sur les formulaires requis.<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre réservation est approuvée et que    
        d'autres réservations provisoires sont faites pour la même période,    
        la politique de préavis de 24 heures sera appliquée (section 3.4.6).    
        Vous serez avisé par courriel de la confirmation éventuelle de votre réservation.<br>       
        <br>
        </div>
    <div style="padding-left:60px;"><span class="style12">3.4.1.2 Demande de la    
      prochaine période disponible</span></div>   
	<div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous les    
      champs sont obligatoires; il faut donc choisir l'entreprise et le navire    
      au moyen de menus déroulants, une période doit être précisée de la façon    
      décrite au paragraphe 3.4.1.1, et le nombre de jours requis pour la réservation    
      doit être précisé. Le nombre de jours pour la réservation doit être    
      inférieur ou égal à la durée de la période précisée.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande, on    
      vous donnera la prochaine période disponible pour la durée de la réservation    
      précisée. Si c'est acceptable, vous pouvez faire la réservation; sinon,    
      vous pouvez essayer une autre période. (<em>Nota </em>: Lorsque vous    
      utilisez l'autre méthode de réservation qui prend les dates précises,    
      si votre période précisée n'est pas disponible, votre réservation sera    
      approuvée et vous serez mis sur une liste d'attente au cas où une    
      annulations surviendrait, et la politique de préavis de 24 heures sera    
      appliquée. Prière de consulter le paragraphe 3.4.6 pour de plus amples    
      renseignements. (La méthode qui consiste à demander la prochaine période    
      disponible n'offre pas cette option.)<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de réservation,    
      un avis est transmis par courriel à l'administration de la CSE, et vous    
      voyez apparaître le formulaire des tarifs de radoub. Il s'agit d'un    
      formulaire optionnel; pour de plus amples renseignements, voir le    
      paragraphe 3.6.1.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe à    
      l'administration de la CSE d'approuver la réservation; toutefois, lorsque    
      vous avez reçu l'avis de confirmation de la réservation par courriel,    
      vous devez envoyer les formulaires appropriées - le tableau 1 et la    
      clause d'indemnisation - ainsi que les frais de réservation de 3 500 $    
      avant que la réservation ne puisse être confirmée. Prière de consulter    
      la section 3.6 pour de plus amples renseignements sur les formulaires    
      requis.<br>    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre réservation est approuvée et que    
      d'autres réservations provisoires sont faites pour la même période, la    
      politique de préavis de 24 heures sera appliquée (section 3.4.6). Vous    
      serez avisé par courriel de la confirmation éventuelle de votre réservation.<br>       
	</div>
	<div style="padding-left:40px;"><strong>3.4.2 Réserver une jetée</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur « Présenter une réservation » sous vos réservations ou dans la barre des menus, et choisissez l'option de réservation    
      d'une jetée. Tous les champs sont obligatoires pour la réservation d'une    
      jetée. Vous pouvez choisir l'entreprise, le navire et la jetée au moyen    
      des menus déroulants. Les dates du début et de la fin de période voulue    
      peuvent être précisées de la façon décrite au paragraphe 3.4.1.1.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de réservation,    
      l'administration de la CSE en est avisée. Pour que la réservation soit    
      confirmée, vous devez faire parvenir les formulaires du tableau 1 et de    
      la clause d'indemnisation. Prière de consulter le paragraphe 3.6 pour de    
      plus amples renseignements sur les formulaires demandés. Vous serez avisé    
      par courriel de la confirmation éventuelle de votre réservation. Il n'y    
      a pas de frais pour la réservation d'une jetée, mais si le navire    
      n'arrive pas aux dates indiquées, l'entreprise se verra facturer des    
      frais de réservation.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.3 Modifier des réservations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les réservations    
      ne peuvent être modifiées en ligne. Si vous souhaitez modifier une réservation,    
      vous devez communiquer avec l'administration de la CSE et transmettre par    
      courrier ou par fax une copie papier du formulaire de modification d'une réservation.    
      Une version PDF de ce formulaire est disponible en ligne. Pour l'ouvrir,    
      allez à la page de bienvenue et cliquez sur « Formulaires de réservation&nbsp;»    
      en haut de la liste de vos réservations.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.4 Annuler des réservations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il est    
      possible d'annuler des réservations. Pour ce faire, cliquez sur le nom du    
      navire dans la liste des réservations sur la page de bienvenue ou la page    
      des réservations archivées, puis cliquez sur le bouton «&nbsp;Demander    
      l'annulation&nbsp;». Lorsque vous demandez une annulation,    
      l'administration de la CSE sera avisée de la demande, et votre annulation    
      sera considérée comme en traitement jusqu'à ce que vous receviez un autre    
      avis. Si vous ne recevez pas d'avis d'annulation de votre réservation,    
      cela veut dire que celle-ci est maintenue.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.5 Annulations et suppressions 
      administratives</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'administration    
      de la CSE a la capacité d'annuler les réservations actuelles, ainsi que    
      de supprimer les réservations passées. Vous serez avisé par courriel si    
      l'une de vos réservations est annulée. Si l'administration supprime une réservation    
      passée, vous ne serez pas avisé, mais vous remarquerez toutefois    
      qu'elle n'est plus affichée dans la liste de vos réservations archivées.<br>       
      <br>
    </div>
  	<div style="padding-left:40px;"><strong>3.4.6 Préavis de 24 heures</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La CSE    
      maintient une politique de préavis de 24&nbsp;heures en ce qui concerne les    
      listes d'attente. Si plusieurs réservations provisoires indiquent la même    
      période de cale sèche, la politique veut que le principe du premier    
      arrivé, premier servi s'applique. Par conséquent, la première  
      entreprise    
      qui a demandé la période la reçoit, à condition qu'elle paye les frais    
      de réservation et soumette les formulaires requis.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cependant, si une autre entreprise plus    
      bas dans la liste paye les frais de réservation et fournit les    
      formulaires en premier, toutes les entreprises ayant des demandes de réservation    
      provisoires faites antérieurement auront 24 heures de préavis pour payer    
      les frais de réservation, en commençant par le début de la liste. 
      L'entreprise en haut de la liste sera avisée la première. Si elle choisit de    
      ne pas prendre la période, la prochaine entreprise sera avisée, et ainsi    
      de suite. Si aucune de ces entreprises ne paye les frais de réservation    
      dans le délai alloué, l'entreprise originale qui fait la demande de    
      confirmation reçoit la période. La même politique s'applique lorsque    
      des périodes deviennent disponibles en raison d'annulations.<br>       
    </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>   
     
  <p> <div style="padding-left:20px;"><em><a name="Overviews"></a><span class="style11"><strong>3.5    
              Réservations - Vue d'ensemble</strong></span></em></div>   
    <div style="padding-left:40px;"><strong>3.5.1 Calendriers</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La barre    
      de menus du haut donne accès aux calendriers de la cale sèche et des jetées.    
      Des tableaux mensuels et trimestriels sont disponibles (figure 8). Les    
      calendriers affichent par défaut le mois en cours, mais on peut voir    
      d'autres mois au moyen des menus déroulants. Chaque jour affiche un    
      sommaire des réservations confirmées pour chaque section ou chaque jetée,    
      ainsi que le nombre de réservations en traitement ou provisoires pour cette    
      journée. En cliquant sur une date, vous voyez un sommaire plus détaillé    
      des réservations pour la journée en question.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme et si la réservation    
      n'est pas confirmée, le calendrier indiquera « Navire de haute mer&nbsp;»,    
      et ne donnera que l'état de la réservation et les dates d'amarrage.    
      Lorsque la réservation est confirmée, quelques renseignements    
      additionnels limités sont affichés. Pour les navires que tous peuvent    
      voir, un lien mènent à des renseignements plus détaillés sur la réservation    
      et le navire.<br>        
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.5.2 Sommaire des réservations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;À    
      partir de toutes les pages du calendrier, vous avez accès à un lien « Résumé des réservations » tout juste sous la barre de menus du haut    
      (figure 8). Le résumé des réservations est un tableau regroupant    
      l'information donnée dans les calendriers. Il affiche le nom et la    
      longueur du navire, l'état de la réservation, la ou les sections ou la    
      jetée réservées, les dates d'amarrage et la date où la demande de réservation    
      a été soumise. On peut faire afficher une version facile à imprimer en    
      cliquant sur le bouton «&nbsp;Voir la version imprimable&nbsp;».<br>       
    </div>
	<div align="center"><img src="../../images/userCalMenu-f.gif" alt="Figure 8 : Vue d'ensemble des r&eacute;servations"></div>
	<div align="center">Figure 8 : Vue d'ensemble des réservations <br><br>   
 	 </div>
            <a href="#Top">Retour à la table des matières</a> <br>   
    <br>
    <div style="padding-left:20px;"><em><a name="Forms"></a><span class="style11">3.6    
      Formulaires pour les réservations</span></em></div>   
    <div style="padding-left:40px;"><strong>3.6.1 Tarifs des droits de cale sèche</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le    
      formulaire des tarifs de droits de cale sèche est un formulaire optionnel qui vous    
      permet de préciser les services et les installations dont vous aurez    
      besoin, et qui permettra ainsi à la CSE d'avoir les ressources dont vous 
      aurez besoin durant la période que vous réservez. Lorsque votre réservation    
      est confirmée, vous devriez confirmer également vos besoins exacts    
      directement avec la CSE. <br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le formulaire s'affichera après que   
      vous aurez demandé une réservation. Vous pouvez le remplir à ce   
      moment-là, ou décider de le faire plus tard. Si vous voulez modifier vos   
      entrées ou remplir le formulaire plus tard, vous pourrez le faire à   
      partir de la page de bienvenue. Les formulaires des tarifs peuvent être   
      modifiés pour les réservations en traitement et provisoire. Cliquez sur le   
      lien « Modification du formulaire de tarif&nbsp;» dans la liste des réservations   
      pour apporter des changements ou remplir le formulaire pour la première   
      fois. Si une réservation est confirmée, vous pouvez faire afficher le   
      formulaire des tarifs en cliquant sur&nbsp; «&nbsp;Consulter le formulaire 
      de tarif&nbsp;». Pour faire apporter des changements au formulaire de 
      tarif d'une réservation confirmée, prière de communiquer avec la CSE.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.2 Tableau 1</strong><br></div> 
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le   
      tableau 1 donne des renseignements sur le navire, et sert d'entente entre   
      l'agent qui fait la réservation et la CSE. La CSE doit recevoir le   
      tableau 1 avant que la réservation ne puisse être confirmée.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.3 Clause d'indemnisation</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La   
      clause d'indemnisation est une stipulation d'exonération de responsabilité   
      juridique qui&nbsp; dégage la Couronne de toute responsabilité en ce qui   
      concerne les blessures et les dommages qui pourraient être subis durant   
      tout le séjour du navire à la CSE. la CSE doit recevoir ce formulaire   
      avant qu'une réservation ne puisse être confirmée.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.4 Formulaire de modification   
      d'une réservation</strong><br></div>  
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour   
      faire une demande de changement des dates d'une réservation, il faut   
      transmettre le formulaire de modification d'une réservation à la CSE.<br>       
    </div>
            <p align="left"><a href="#Top">Retour à la table des matières</a> </p>  
    <p align="left"><div style="padding-left:20px;"><em><a name="LoggingOut" id="LoggingOut"></a><span class="style11">3.7  
              Sortir du système</span></em><br></div> 
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour  
      sortir du système, cliquez sur le bouton «&nbsp;Fermer la session&nbsp;», dans la  
      barre de menus du haut. Il faut toujours sortir du système pour mettre  
      fin à votre session, afin d'empêcher que d'autres personnes n'entrent  
      dans votre compte sur des ordinateurs partagés.<br>  
    </div>
            <a href="#Top">Retour à la table des matières</a> </td>
        </tr>
      </table>
	<a href="file:///H|/EGDBooking/text/booking/egd_userdoc-e.html">egd_userdoc-e</a></BODY>
</HTML>
