shinyUI(bootstrapPage(title="Aviation data",
  includeCSS("css/styles.css"),
  includeCSS("http://fonts.googleapis.com/css?family=Lato:400,700"),    
  div(class="container",
  h1("30 years of airplane accidents",HTML("<small>USA and international waters</small>")),
  fluidRow(column(width=12,
           uiOutput("ggvis_ui"),
           ggvisOutput("ggvis")
           )
  ),
  fluidRow(
    column(width=12,
           HTML("<p><small>Incidents from the <a href=\"http://www.ntsb.gov/aviationquery\">NTSB database</a> with 5+ fatalities.</small>"),
           p("Created using the",
             a(href="https://github.com/rstudio/ggvis", "ggvis"),
             "interactive charting library with inspiration from the",a(href="http://www.nytimes.com/interactive/2012/05/17/business/dealbook/how-the-facebook-offering-compares.html?_r=0","NYT."),HTML("<br>"),
           "Find the code at", a(href="https://github.com/arthur-flam/airplanes", "@arthur-flam/airplanes"),HTML("<br>"),
           em("Thanks to ",a(href="https://github.com/ramnathv", "Ramnath Vaidyanathan"),
             ", ", a(href="https://github.com/hadley","Hadley Wickham"),
             "and ", a(href="https://github.com/timelyportfolio","Timelyportfolio"), "for their work on interactive visualizations with R."))
    )
  ),
  HTML("<div><a href=\"https://twitter.com/ArthurFlam\" class=\"twitter-follow-button\" data-show-count=\"false\">Follow @ArthurFlam</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script></div>"),
  HTML(" <div id=\"disqus_thread\"></div>
    <script type=\"text/javascript\">
        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        var disqus_shortname = 'arthur-shinyapps'; // required: replace example with your forum shortname

        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href=\"http://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
    <a href=\"http://disqus.com\" class=\"dsq-brlink\">comments powered by <span class=\"logo-disqus\">Disqus</span></a>
    ")
)))