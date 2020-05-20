---
title: "Theme preview"
date: 2018-07-10T00:00:00+08:00
lastmod: 2018-07-10T00:00:00+08:00
draft: false
tags: ["hugo", "Theme preview", "even"]
categories: ["Theme preview", "hugo", "even"]

weight: 10
contentCopyright: MIT
mathjax: true
autoCollapseToc: true

---

just is even theme preview

<!--more-->

> Based on [MarkdownPreview test.md](https://github.com/facelessuser/MarkdownPreview/blob/master/examples/test.md).

# Markdown

```
# H1
## H2
### H3
#### H4
##### H5
###### H6
### Duplicate Header
### Duplicate Header
```

# H1
## H2
### H3
#### H4
##### H5
###### H6
### Duplicate Header
### Duplicate Header

## Paragraphs

```
This is a paragraph.
I am still part of the paragraph.

New paragraph.
```

This is a paragraph.
I am still part of the paragraph.

New paragraph.

## Anchor

*Define anchor by `{#section-id}`*

[Something](#section-7)

## Footnote

This is a footnote[^1]

A footnote on "label"[^label]

The footnote for definition[^!DEF]

A footnote with link[^pa]

[^1]: This is a footnote
[^label]: A footnote on "label"
[^pa]: [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
[^!DEF]: The footnote for definition


## Inline

```
`inline block`

<kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>del</kbd>

**bold 1** and __bold 2__

*italic 1*  and _italic 2_

~~strike~~


***bold 1 and italic 1***

___bold 2 and italic 2___

__*bold 2 and italic 1*__

**_bold 1 and italic 2_**


~~*strike italic 1*~~ and *~~strike italic 2~~*

~~_strike italic 2_~~ and  _~~strike italic 2~~_


~~**strike bold 1**~~ and **~~strike bold 1~~**

~~__strike bold 2__~~ and __~~strike bold 2~~__


~~***strike italic 1 bold 1***~~ and ***~~strike italic 1 bold 1~~***

~~___strike italic 2 bold 2___~~ and ___~~strike italic 2 bold 2~~___

**~~*strike italic 1 bold 1*~~** and *~~**strike italic 1 bold 1**~~*

__~~_strike italic 2 bold 2_~~__ and _~~__strike italic 2 bold 2__~~_

**~~_strike italic 2 bold 1_~~** and _~~**strike italic 2 bold 1**~~_

__~~*strike italic 1 bold 2*~~__ and *~~__strike italic 1 bold 2__~~*

```

`inline block`

<kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>del</kbd>

**bold 1** and __bold 2__

*italic 1*  and _italic 2_

~~strike~~


***bold 1 and italic 1***

___bold 2 and italic 2___

__*bold 2 and italic 1*__

**_bold 1 and italic 2_**


~~*strike italic 1*~~ and *~~strike italic 2~~*

~~_strike italic 2_~~ and  _~~strike italic 2~~_


~~**strike bold 1**~~ and **~~strike bold 1~~**

~~__strike bold 2__~~ and __~~strike bold 2~~__


~~***strike italic 1 bold 1***~~ and ***~~strike italic 1 bold 1~~***

~~___strike italic 2 bold 2___~~ and ___~~strike italic 2 bold 2~~___

**~~*strike italic 1 bold 1*~~** and *~~**strike italic 1 bold 1**~~*

__~~_strike italic 2 bold 2_~~__ and _~~__strike italic 2 bold 2__~~_

**~~_strike italic 2 bold 1_~~** and _~~**strike italic 2 bold 1**~~_

__~~*strike italic 1 bold 2*~~__ and *~~__strike italic 1 bold 2__~~*


## Links

```
Web image
![Web Picture](http://www.revolunet.com/static/parisjs8/img/logo-revolunet-carre.jpg "Web Picture")

Local image

contact@revolunet.com

@revolunet

Issue #1

https://github.com/revolunet/sublimetext-markdown-preview/

This is a link https://github.com/revolunet/sublimetext-markdown-preview/.

This is a link "https://github.com/revolunet/sublimetext-markdown-preview/".

With this link (https://github.com/revolunet/sublimetext-markdown-preview/), it still works.
```

Web image
![Web Picture](http://www.revolunet.com/static/parisjs8/img/logo-revolunet-carre.jpg "Web Picture")

Local image
![Local Picture](/apple-touch-icon.png "Local Picture")

www.google.com

contact@revolunet.com

@revolunet

Issue #1

https://github.com/revolunet/sublimetext-markdown-preview/

This is a link https://github.com/revolunet/sublimetext-markdown-preview/.

This is a link "https://github.com/revolunet/sublimetext-markdown-preview/".

With this link (https://github.com/revolunet/sublimetext-markdown-preview/), it still works.

## Abbreviation

Abbreviations source are found in a separate markdown file specified in frontmatter.
```
The HTML specification 
is maintained by the W3C.

*[HTML]: Hyper Text Markup Language
*[W3C]:  World Wide Web Consortium
```

The HTML specification 
is maintained by the W3C.

## Unordered List

```
Unordered List

- item 1
    * item A
    * item B
        more text
        + item a
        + item b
        + item c
    * item C
- item 2
- item 3
```

Unordered List

- item 1
    * item A
    * item B
        more text
        + item a
        + item b
        + item c
    * item C
- item 2
- item 3


## Ordered List

```
Ordered List

1. item 1
    1. item A
    2. item B
        more text
        1. item a
        2. item b
        3. item c
    3. item C
2. item 2
3. item 3
```

Ordered List

1. item 1
    1. item A
    2. item B
        more text
        1. item a
        2. item b
        3. item c
    3. item C
2. item 2
3. item 3

## Task List

```
Task List

- [X] item 1
    * [X] item A
    * [ ] item B
        more text
        + [x] item a
        + [ ] item b
        + [x] item c
    * [X] item C
- [ ] item 2
- [ ] item 3
```

Task List

- [X] item 1
    * [X] item A
    * [ ] item B
        more text
        + [x] item a
        + [ ] item b
        + [x] item c
    * [X] item C
- [ ] item 2
- [ ] item 3

## Mixed Lists

`Really Mixed Lists` should break with `sane_lists` on.

```
Mixed Lists

- item 1
    * [X] item A
    * [ ] item B
        more text
        1. item a
        2. itemb
        3. item c
    * [X] item C
- item 2
- item 3


Really Mixed Lists

- item 1
    * [X] item A
    - item B
        more text
        1. item a
        + itemb
        + [ ] item c
    3. item C
2. item 2
- [X] item 3
```

Mixed Lists

- item 1
    * [X] item A
    * [ ] item B
        more text
        1. item a
        2. itemb
        3. item c
    * [X] item C
- item 2
- item 3


Really Mixed Lists

- item 1
    * [X] item A
    - item B
        more text
        1. item a
        + itemb
        + [ ] item c
    3. item C
2. item 2
- [X] item 3


## Dictionary

```
Dictionary
:   item 1

    item 2

    item 3
```

Dictionary
:   item 1

    item 2

    item 3

## Blocks

```
    This is a block.
    
    This is more of a block.

```

    This is a block.
    
    This is more of a block.


## Block Quotes

```
> This is a block quote
>> How does it look?
```

> This is a block quote.
>> How does it look?
> I think it looks good.

## Fenced Block

Assuming guessing is not enabled.

`````
```
// Fenced **without** highlighting
function doIt() {
    for (var i = 1; i <= slen ; i^^) {
        setTimeout("document.z.textdisplay.value = newMake()", i*300);
        setTimeout("window.status = newMake()", i*300);
    }
}
```

```javascript
// Fenced **with** highlighting
function doIt() {
    for (var i = 1; i <= slen ; i^^) {
        setTimeout("document.z.textdisplay.value = newMake()", i*300);
        setTimeout("window.status = newMake()", i*300);
    }
}
```
`````

```
// Fenced **without** highlighting
function doIt() {
    for (var i = 1; i <= slen ; i^^) {
        setTimeout("document.z.textdisplay.value = newMake()", i*300);
        setTimeout("window.status = newMake()", i*300);
    }
}
```

```javascript
// Fenced **with** highlighting
function doIt() {
    for (var i = 1; i <= slen ; i^^) {
        setTimeout("document.z.textdisplay.value = newMake()", i*300);
        setTimeout("window.status = newMake()", i*300);
    }
}
```

## Tables

```
| _Colors_      | Fruits          | Vegetable         |
| ------------- |:---------------:| -----------------:|
| Red           | *Apple*         | [Pepper](#Tables) |
| ~~Orange~~    | Oranges         | **Carrot**        |
| Green         | ~~***Pears***~~ | Spinach           |
```

| _Colors_      | Fruits          | Vegetable    |
| ------------- |:---------------:| ------------:|
| Red           | *Apple*         | Pepper       |
| ~~Orange~~    | Oranges         | **Carrot**   |
| Green         | ~~***Pears***~~ | Spinach      |

Class or Enum           | Year                                                                                  | Month                                                                                 |                                          Day                                          |                                         Hours                                         |                                        Minutes                                        | Seconds*                                                                              |                                      Zone Offset                                      |                                        Zone ID                                        | toString Output                                    | Where Discussed                                                                                    
----------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:| ------------------------------------------------------------------------------------- |:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------
`Instant`        |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       | `2013-08-20T15:16:26.355Z`                  | [Instant Class](https://docs.oracle.com/javase/tutorial/datetime/iso/instant.html)                 
`LocalDate`      | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | `2013-08-20`                                | [Date Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/date.html)                     
`LocalDateTime`  | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       | `2013-08-20T08:16:26.937`                   | [Date and Time Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/datetime.html)        
`ZonedDateTime`  | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | `2013-08-21T00:16:26.941+09:00[Asia/Tokyo]` | [Time Zone and Offset Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/timezones.html)
`LocalTime`      |                                                                                       |                                                                                       |                                                                                       | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       | `08:16:26.943`                              | [Date and Time Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/datetime.html)        
`MonthDay`       |                                                                                       | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | `--08-20`                                   | [Date Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/date.html)                     
`Year`           | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | `2013`                                      | [Date Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/date.html)                     
`YearMonth`      | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | `2013-08`                                   | [Date Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/date.html)                     
`Month`          |                                                                                       | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       |                                                                                       | `AUGUST`                                    | [DayOfWeek and Month Enums](https://docs.oracle.com/javase/tutorial/datetime/iso/enum.html)        
`OffsetDateTime` | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       | `2013-08-20T08:16:26.954-07:00`             | [Time Zone and Offset Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/timezones.html)
`OffsetTime`     |                                                                                       |                                                                                       |                                                                                       | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       | `08:16:26.957-07:00`                        | [Time Zone and Offset Classes](https://docs.oracle.com/javase/tutorial/datetime/iso/timezones.html)
`Duration`       |                                                                                       |                                                                                       |                                          \**                                          |                                          \**                                          |                                          \**                                          | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       | `PT20H` (20 hours)                          | [Period and Duration](https://docs.oracle.com/javase/tutorial/datetime/iso/period.html)            
`Period`         | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> | <center>![checked](/favicon-16x16.png)</center> |                                                                                       |                                                                                       |                                                                                       |                                         \***                                          |                                         \***                                          | `P10D` (10 days)                            | [Period and Duration](https://docs.oracle.com/javase/tutorial/datetime/iso/period.html)            

## Smart Strong

```
Text with double__underscore__words.

__Strong__ still works.

__this__works__too__
```

Text with double__underscore__words.

__Strong__ still works.

__this__works__too__

## Smarty

```
"double quotes"

'single quotes'

da--sh

elipsis...
```

"double quotes"

'single quotes'

da--sh

elipsis...

## Neseted Fences

````
    ```
    This will still be parsed
    as a normal indented code block.
    ```

```
This will still be parsed
as a fenced code block.
```

- This is a list that contains multiple code blocks.

    - Here is an indented block

            ```
            This will still be parsed
            as a normal indented code block.
            ```

    - Here is a fenced code block:

        ```
        This will still be parsed
        as a fenced code block.
        ```

        > ```
        > Blockquotes?
        > Not a problem!
        > ```
````

    ```
    This will still be parsed
    as a normal indented code block.
    ```

```
This will still be parsed
as a fenced code block.
```

- This is a list that contains multiple code blocks.

    - Here is an indented block

            ```
            This will still be parsed
            as a normal indented code block.
            ```

    - Here is a fenced code block:

        ```
        This will still be parsed
        as a fenced code block.
        ```

        > ```
        > Blockquotes?
        > Not a problem!
        > ```
