+++
title = "mermaid"
date = 2020-03-19T00:00:00+08:00
lastmod = 2020-03-29T03:07:52+08:00
tags = ["mermaid", "chart"]
categories = ["mermaid", "chart"]
draft = false
locale = "en_US"
autoCollapseToc = true
+++

chart tools <b style="color:red">mermaid</b> intergrate with Emacs.

<!--more-->

now we should test how to insert HTML code,yes,i said is real html
code insert into hugo blog.

now we should test it wheather avaliable.but we should select hugo
bolg custom shortcodes insert it.

cause use the mermaid premise is insert mermaid's CDN in html.


## setting mmdb path {#setting-mmdb-path}

```emacs-lisp
(setq ob-mermaid-cli-path "~/.npm_module/node_modules/.bin/mmdc")
```


## test image demo {#test-image-demo}

```text
#+html: <style>.foo img { border:2px solid black; }</style>
#+attr_html: :alt Org mode logo
#+attr_html: :width 300 :class foo
[[https://ox-hugo.scripter.co/test/images/org-mode-unicorn-logo.png]]
```


## test demo {#test-demo}

{{< figure src="/images/mermaid/sequence_diagram.png" >}}


## test demo2 {#test-demo2}

{{< figure src="../../../static/images/mermaid/Pie.png" >}}


## test demo3 {#test-demo3}

```shell
ls -ll 
```


## test demo4 {#test-demo4}

```shell
ls -ll
```