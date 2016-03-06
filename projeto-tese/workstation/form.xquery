xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $ling-features := doc('../ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#linguistic']/tei:fs
return
    <html
        xmlns="http://www.w3.org/1999/xhtml"
        lang="en"
        xml:lang="en">
        <head>
            <title>Formulário</title>
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
                src="javascript/show.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/deselect.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/language.js"
                type="text/javascript">/**/</script>
            <!--#include virtual="ssi/favicon.html"-->
        </head>
        <body><!--#include virtual="ssi/header.html"-->
            <main>
                <h1>Fenómenos de variação</h1>
                <h2
                    class="pt">Variantes de língua</h2>
                <form
                    method='POST'
                    action='ling.xquery'>
                    {
                        for $id in $ling-features/@xml:id
                        let $name := $ling-features[@xml:id eq $id]//tei:string[@xml:lang eq 'pt']/string()
                        order by $name
                        return
                            (<input
                                type="checkbox"
                                name="phenomenon"
                                value="{$id}">{$name}</input>, <br/>)
                    
                    }
                    <button
                        class="submit"
                        type="submit">Pesquisa</button>
                </form>
            </main>
        </body>
    </html>