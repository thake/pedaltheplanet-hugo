
(function() {
    if(window.disqus_shortname) {
        const d = document;
        const disqusThread = d.getElementById('disqus_thread');
        const disqusCount = d.getElementsByClassName("disqus-comment-count").length > 0;
        if (["localhost", "127.0.0.1"].indexOf(window.location.hostname) != -1) {        
            if(disqusThread) {
                disqusThread.innerHTML = 'Disqus comments not available by default when the website is previewed locally.';
            }
            return;
        }    
        if(disqusThread) {
            const s = d.createElement('script');
            s.async = true;
            s.src = '//' + window.disqus_shortname + '.disqus.com/embed.js';
            s.setAttribute('data-timestamp', +new Date());
            (d.head || d.body).appendChild(s);
        }
        if(disqusCount) {
            const s = d.createElement('script');
            s.async = true;
            s.id="dsq-count-scr";
            s.src = '//' + window.disqus_shortname + '.disqus.com/count.js';            
            (d.head || d.body).appendChild(s);
        }
    }
})();