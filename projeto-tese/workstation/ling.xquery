xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node(), $to as node())
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
declare variable $search := request:get-parameter("phenomenon", ("dat"));
let $ling-features := doc('../ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#linguistic']/tei:fs
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
return
    <html
        xmlns="http://www.w3.org/1999/xhtml"
        lang="en"
        xml:lang="en">
        <head>
            <title>Resultados</title>
            <meta
                charset="utf-8"
                lang="pt"/>
            <meta
                name="viewport"
                content="width=device-width, initial-scale=1"/>
            <link
                href="css/project.css"
                rel="stylesheet"
                type="text/css"/>
            <script
                src="javascript/menu.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/language.js"
                type="text/javascript">/**/</script>
            <script
                src="http://code.jquery.com/jquery-latest.min.js"
                type="text/javascript">/**/</script>
            <script
                src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/sidebar.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/tooltip.js"
                type="text/javascript">/**/</script>
            <!--#include virtual="ssi/favicon.html"-->
        </head>
        <body><!--#include virtual="ssi/header.html"-->
            <main>
                <h1>Variantes de língua</h1>
                <div
                    class="multiple">
                    <section>
                        {
                            for $result in $search
                            return
                                (<h2>{$ling-features[./@xml:id = $result]//tei:string[@xml:lang eq 'pt']/text()}</h2>,
                                <h3
                                    id="graphs{$result}">Período</h3>,
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    width="950"
                                    height="100">
                                    {
                                        
                                        let $fen := $readings[matches(@ana, concat('#', $result))]
                                        for $period at $pos in
                                        for $i in distinct-values($poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]/tei:floruit/@period)
                                        order by count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:floruit[@period = $i]/../@xml:id]) descending
                                        return
                                            $i
                                        let $count := count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:floruit[@period = $period]/../@xml:id])
                                        let $sum := count($fen)
                                        let $percentage := round-half-to-even((100 * $count div $sum), 2)
                                        order by $count descending
                                        return
                                            <g>
                                                <rect
                                                    fill="#2B3966"
                                                    height="20"
                                                    width="{$count * 6.5}"
                                                    x="70"
                                                    y="{$pos * 20}"
                                                    stroke="black"
                                                    stroke-width="2"/>
                                                <text
                                                    fill="black"
                                                    font-size="12"
                                                    x="{80 + $count * 6.5}"
                                                    y="{$pos * 20 + 14}"
                                                >{' (' || $percentage || '%)'}</text>
                                                <text
                                                    fill="black"
                                                    x="10"
                                                    y="{$pos * 20 + 18}"
                                                >Per. {$period}</text>
                                            </g>
                                    }</svg>,
                                <h4>Testemunho</h4>,
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    width="950"
                                    height="100">
                                    {
                                        
                                        let $fen := $readings[matches(@ana, concat('#', $result))]
                                        for $wit at $pos in
                                        for $i in distinct-values($fen/tokenize(./@wit, '\s'))
                                        order by count($fen[./tokenize(@wit, '\s') = $i]) descending
                                        return
                                            $i
                                        let $count := count($fen[@wit = $wit])
                                        let $sum := count($fen)
                                        let $percentage := round-half-to-even((100 * $count div $sum), 2)
                                        order by $count descending
                                        return
                                            <g>
                                                <rect
                                                    fill="blue"
                                                    height="20"
                                                    width="{$count * 6.5}"
                                                    x="70"
                                                    y="{$pos * 20}"
                                                    stroke="black"
                                                />
                                                <text
                                                    fill="black"
                                                    font-size="12"
                                                    x="{80 + $count * 6.5}"
                                                    y="{$pos * 20 + 14}"
                                                >{' (' || $percentage || '%)'}</text>
                                                <text
                                                    fill="black"
                                                    x="10"
                                                    y="{$pos * 20 + 18}"
                                                >Ms. {substring($wit, 2)}</text>
                                                
                                                {
                                                    let $hand := $songs[.//tei:rdg[. intersect $fen[@wit = $wit]]]/tei:head//tei:rdg[@wit = $wit]/@hand
                                                    let $distinctHands := distinct-values($hand)
                                                    for $h in 1 to count($distinctHands)
                                                    let $x := count($songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]]
                                                    //tei:rdg[. intersect $fen][@wit = $wit])
                                                    let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]][.//tei:rdg[. intersect $fen]]
                                                    let $conta := count($div//tei:rdg[. intersect $fen[@wit = $wit]])
                                                    order by $h descending
                                                    return
                                                        <g>
                                                            <rect
                                                                fill="#2B3966"
                                                                height="20"
                                                                width="{$conta * 6.5}"
                                                                x="{$x * 6.5 + 70}"
                                                                y="{$pos * 20}"
                                                                stroke="black"
                                                                stroke-width="2"/>
                                                            <text
                                                                fill="white"
                                                                font-size="10.5"
                                                                x="{($x * 6.5 + 68) + (($conta * 6.5) div 2)}"
                                                                y="{$pos * 20 + 12}">{substring($distinctHands[$h], 2)}</text>
                                                        </g>
                                                }
                                            </g>
                                    }</svg>
                                )
                        }
                    </section>
                    <aside
                        id="move">
                        <div
                            class="pt">
                            <h3>Conteúdos</h3>
                            <ul>
                                {
                                    for $result in $search
                                    return
                                        (<li>{$ling-features[./@xml:id = $result]//tei:string[@xml:lang eq 'pt']}
                                            <ul>
                                                <li><a
                                                        href="#graphs{$result}">Gráficas</a></li>
                                                <li><a
                                                        href="#ling{$result}">Tabela</a></li>
                                            </ul>
                                        </li>)
                                }
                            </ul>
                        </div>
                    </aside>
                </div>
            </main>
            <div
                id="footer"></div>
        </body>
    </html>
