xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";

(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node()?, $to as node()?)
{
    (if ($from eq $to)
    then
        $from/string()
    else
        if (substring($from, 1, string-length($from) - 1) eq substring($to, 1, string-length($to) - 1))
        then
            concat($from, '-v')
        else
            concat($from, '-', $to))
};
(:declare variable $selected:= request:get-parameter("song", ("A191"));:)
let $songs := doc('/db/VTLGP/edition/sandim1.xml')//tei:div[@type eq 'poem']
return
    
    <div
        class="multiple">
        <section>
            {
                for $song in $songs
                let $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)]
                return
                    <div
                        id="{$song/substring(@corresp, 2)}"
                        class="poem">
                        <div
                            class="metadata">
                            <h2><span
                                    class="pt">Cantiga</span><span
                                    class="en">Song:</span>
                                {string-join($song//tei:title//tei:idno, ', ')}</h2>
                            <h2><span
                                    class="pt">Autor</span><span
                                    class="en">Author:</span>
                                {$author/tei:persName/string()}</h2>
                            <h2><span
                                    class="pt">Período</span><span
                                    class="en">Period:</span>
                                {$author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()}
                                (<span
                                    class="pt">período</span><span
                                    class="en">period</span>
                                {$author/tei:floruit/@period/string()})</h2>
                        </div>
                        <div
                            class="body">
                            {
                                
                                for $witness in $song/tei:head//tei:rdg
                                return
                                    <div
                                        class="witness">
                                        <h3><span
                                                class="pt">Testemunho</span><span
                                                class="en">Witness</span>: {$witness/substring(@wit, 2)}</h3>
                                        <h4>Text<span
                                                class="pt">o</span>: {$witness/tei:idno/string()}</h4>
                                        <h4><span
                                                class="pt">Localização</span><span
                                                class="en">Location</span>: {local:locus($witness/tei:locus/@from, $witness/tei:locus/@to)}</h4>
                                        <h4><span
                                                class="pt">Copista</span><span
                                                class="en">Copyist</span>: {$witness/substring(@hand, 2)}</h4>
                                        {
                                            for $cobra in $song//tei:lg
                                            return
                                                <ol
                                                    start="{$cobra/tei:l[1]/@n/string()}">
                                                    {
                                                        for $line in $cobra/tei:l
                                                        return
                                                            
                                                            <li>{
                                                                    transform:transform($line/tei:app/tei:rdg[contains(@wit, $witness/@wit)],
                                                                    doc('/db/VTLGP/xslt/reading.xsl'), ())
                                                                }</li>
                                                    }
                                                </ol>
                                        }</div>
                            
                            }
                        </div>
                    </div>
            }
        </section>
        <aside
            id="move"><h3
                class="pt">Cantigas</h3>
            <h3
                class="en">Songs</h3>
            <ul>{
                    for $song in $songs
                    return
                        <li><a
                                href="{$song/@corresp}">{string-join($song//tei:title//tei:idno, ', ')}</a></li>
                }
            
            </ul>
            <p class="dinamic"><span class="pt">Mudar critérios</span><span class="en">Change criteria</span></p>
        </aside>
    </div>