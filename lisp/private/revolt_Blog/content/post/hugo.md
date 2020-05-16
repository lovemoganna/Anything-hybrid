+++
title = "hugo faq"
date = 2020-03-20T00:00:00+08:00
lastmod = 2020-03-29T02:15:33+08:00
tags = ["hugo"]
categories = ["hugo"]
draft = false
locale = "en_US"
autoCollapseToc = true
+++

hugo blog feature explore.

<!--more-->


## Create Your Own Shortcodes {#create-your-own-shortcodes}

You can extend hugo's built-in shortcodes by creating your own
using the same templating syntax as that for single and list pages.

you can think of shortcodes as the intermediary between [page and
list templates](#page-and-list-templates) and [basic content files](#basic-content-files).


## Create Custom Shortcodes {#create-custom-shortcodes}

Hugo provides the ability to easily create custom shortcodes to
meet your website's needs.

Add a shortcodes template to your site,in
`~/layouts/shortcodes/rawhtml.html`,and write the fllowing content[^fn:1]:

```text
<!-- raw html>
{{.Inner}}
```

now you could follow the below improt methods call custom
shortcodes:

{{< rawhtml >}}
<p class="speshal-fancy-custom">
This is <strong>raw HTML</strong>, inside Markdown.
</p>
{{< /rawhtml >}}

{{ hightlight html}}
{{< rawhtml >}}
<p class="speshal-fancy-custom">
This is <strong>raw HTML</strong>, inside Markdown.
</p>
{{< /rawhtml >}}
{{ /hightlight }}


## Shortcodes File Location {#shortcodes-file-location}

To create a shortcode,place an HTML template in the
`layouts/shortcodes` directory of your `Directory Structure`.


## Directory Structure {#directory-structure}

-   archetypes
    自定义Page template,just run `hugo new post/test.md`.jsut run
    `hugo run test/test.md`,just make the `/content/test/test.md`,but
    not show in hugo blog.Currrent i can't slove the problem.may be
    should see [Hugo Modules](#hugo-modules).


## Hugo Modules {#hugo-modules}

Hugo Modules are the core building blocks in Hugo.A module can be
your main project or a smaller module or more of the 7 component
types defined in Hugo: static,content,layouts,data,assets,i18n,and
archetypes.

You can combine modules in any combination you like, and even mount
directories form non-Hugo projects,forming a big,virtual unior file
system.


## Use Hugo Modules {#use-hugo-modules}

How to use Hugo Modules to build and manage your site.


### Prerequisite {#prerequisite}

Most of the commands for Hugo Modules requires a newer version of
GO installed and the relevant VCS client.


### Initialize a New Module {#initialize-a-new-module}

Use `hugo mode init` to initialize a new Hugo Module.If it fails
to guess the module path,you must provide it as an argument,e.g.:


### <span class="org-todo done DONE">DONE</span> Hugo modules noobs start fighting {#hugo-modules-noobs-start-fighting}

one important question is : how to run hugo modules?


#### Prepare a Hugo site to test out Hugo Modules {#prepare-a-hugo-site-to-test-out-hugo-modules}

-   Install latest version of go on yuor computer
    
    Make sure that you have installed a recent version of go on
    your computer.
    
    The `hugo mode` commands do not work without doing this.If you
    use the `hugo mod` commands,without installing ****go****,nothing
    happens.You don't get an error message as feedback.

-   Prepare a test site to implement a theme as a Hugo module
    
    The theme `hugo-xmin` are used as an example.


#### <span class="org-todo todo TODO">TODO</span> [here](https://craftsmandigital.net/blog/hugo-modules/#prepare-a-test-site-to-implement-a-theme-as-a-hugo-module) {#here}


## 如何解决嵌套问题？ {#如何解决嵌套问题}


## Use Shortcodes {#use-shortcodes}


## page and list templates {#page-and-list-templates}


## basic content files {#basic-content-files}

{{< highlight text >}} A bunch of code here {{< /highlight >}}


## <span class="org-todo todo TODO">TODO</span> Shortcodes with raw strings parameters {#shortcodes-with-raw-strings-parameters}


## shortcodes with markdown {#shortcodes-with-markdown}

in hugo the `%` delimiters how to works?


## image links {#image-links}

There have a few alternatives for linking to images in Org files
in a way that's compatible with `ox-hugo` and Hugo.

first,we need have the _HUGO\_BASE\_DIR_ be `~/hugo/`.Then the Hugo
static directory will be `~/hugo/static/`.

```text
![Local Picture](/apple-touch-icon.png "Local Picture")
```

\![Local Picture](/apple-touch-icon.png "Local Picture")


## ox-hugo export image in content {#ox-hugo-export-image-in-content}

Conventionally any static content for a hugo site,like images,PDF
files,and other attachments are put in the site `static/`
dierctory.

Files in that directory are served at the site root when the hugo
publishes that site.So all the content in there can be accessed
using the root prefox `/`.So a `static/foo.png` file can be
accessed at `/foo.png`.


### Inline image - unkyperlinked {#inline-image-unkyperlinked}

```text
[[/images/web-image/cat.png]]
```

{{< figure src="/images/web-image/cat.png" >}}


### Inline image - Also hyperlinked to an image {#inline-image-also-hyperlinked-to-an-image}

```text
[[/images/web-image/cat.png][file:/images/web-image/cat.png]]
```

{{< figure src="/images/web-image/cat.png" link="/images/web-image/cat.png" >}}

The style of link is normally used if you want to link a low
resolution image to its higher resolution version.

**NOTE**

The `file:` prefix can be used for the **link component** of the
org link too - it doesn't hurt.

A space in the path in the Description component of the Org link
has to be encoded to **“%20”**.

now i have a picture that name is **"cat 2.png"** .we could use
the following form call it:

```nil
[[/images/web-image/cat%202.png][file:/images/web-image/cat.png]]
```

{{< figure src="/images/web-image/cat.png" >}}


### Regular link to an image {#regular-link-to-an-image}

This style of linking will work for references to non-image files
in the static directory.

```text
[[/images/web-image/cat%202.png][Click here to see "cat 2.png"]]
```

[Click here to see "cat 2.png"](/images/web-image/cat%202.png)


### References to files **outside** the static directory {#references-to-files-outside-the-static-directory}

This is a unique feature of `ox-hugo`.

if a reference is made to a file outside the Hugo static
directory,and if it one of the extensions listed in
`org-hugo-external-file-extensions-allowed-for-copying`,then that
file is copied by `ox-hugo` to the static directory.

check above the variable,have many file types.


### ox-hugo export image size test {#ox-hugo-export-image-size-test}

{{< figure src="https://ox-hugo.scripter.co/test/images/org-mode-unicorn-logo.png" caption="Figure 1: hello,welcome into org mode world,this is [refer](https://ox-hugo.scripter.co/test/posts/figure-shortcode-and-attr-html/) adderess" class="inset" >}}


#### Setting image size {#setting-image-size}

-    setting :width parameter

    ```text
    #+attr_html: :width 50
    #+caption: Below rainbow cat is shown 50 pixel wide.
    [[file:/images/web-image/cat.png]]
    ```
    
    {{< figure src="/images/web-image/cat.png" caption="Figure 2: Below rainbow cat is shown 50 pixel wide." width="50" >}}
    
    {{< figure src="/images/web-image/cat.png" caption="Figure 3: Below rainbow cat is shown 100 pixel wide." width="100" >}}

-    setting :height parameter and :width parameter

    ```text
    #+attr_html: :width 50 :height 100
    #+caption: Below rainbow cat is shown 50 pixel wide.
    [[file:/images/web-image/cat.png]]
    ```
    
    <a id="orgda0fb7e"></a>
    
    \#+attr\_html :width 20 :height 200
    
    {{< figure src="/images/web-image/cat.png" caption="Figure 4: Below rainbow cat is shown 20x200 pixel wide." >}}

-    Multiple ATTR\_HTML

    ```text
    #+html: <style>.foo img { border:2px solid black; }</style>
    #+attr_html: :alt Org mode logo
    #+attr_html: :width 300 :class foo
    [[https://ox-hugo.scripter.co/test/images/org-mode-unicorn-logo.png]]
    ```
    
    <style>.foo img { border:2px solid black; }</style>
    
    <div class="foo">
      <div></div>
    
    <img src="https://ox-hugo.scripter.co/test/images/org-mode-unicorn-logo.png" alt="Org mode logo" width="300" class="foo" />]
    
    </div>


### ox-hugo export html image test {#ox-hugo-export-html-image-test}

[^fn:1]: [refer link](https://anaulin.org/blog/hugo-raw-html-shortcode/)