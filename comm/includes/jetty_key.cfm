<cfset legend = arrayNew(1) />

<cfset arrayAppend(legend, language.PendBook) />
<cfset arrayAppend(legend, language.TentBook) />
<cfset arrayAppend(legend, language.confirmedInNorthLandingWharf) />
<cfset arrayAppend(legend, language.confirmedInSouthJetty) />

<cfoutput>
  <table class="keytable keyfloat">
    <tr><th colspan="2">#language.legend#</th></tr>
    <tr id="l1">
      <td class="pending">1</td>
      <td class="pending"><a id="pending">#legend[1]#</a></td>
    </tr>
    <tr id="l2">
      <td class="tentative">2</td>
      <td class="tentative"><a id="tentative">#legend[2]#</a></td>
    </tr>
    <tr id="l3">
      <td class="sec1">3</td>
      <td class="sec1"><a id="sec1">#legend[3]#</a></td>
    </tr>
    <tr id="l4">
      <td class="sec2">4</td>
      <td class="sec2"><a id="sec2">#legend[4]#</a></td>
    </tr>
  </table>
</cfoutput>
