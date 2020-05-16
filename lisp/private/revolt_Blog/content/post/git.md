+++
title = "git faq"
date = 2020-03-24T00:00:00+08:00
lastmod = 2020-03-24T00:28:55+08:00
tags = ["git"]
categories = ["git"]
draft = false
locale = "zh_CN"
autoCollapseToc = true
+++

slove git using procedure problems.

<!--more-->


## how to insert comment for peer commited git files {#how-to-insert-comment-for-peer-commited-git-files}

one sloved methods:

-   use `git add <single-files>` and does not use `git add -A`.
-   `git commmit -m "you want to insert comment in this file"`

the question is I alerday add all file in git working stage.Now how
to remove these file form working stage.

-   remove single file using `git rm --cache <sing_file_name>`.

now just use the methods sloved the problem.

another slove methods is use **magit**,but need more time test
it.but the question i can't stand it any more.


## how to remove all file in git working stage {#how-to-remove-all-file-in-git-working-stage}

-   [ref1](https://docs.gitlab.com/ee/university/training/topics/unstage.html)
-   [ref2](https://stackoverflow.com/questions/19730565/how-to-remove-files-from-git-staging-area)
    
    To remove All files from stage use reset HEAD where HEAD is the last
    commit of the current branch.
    
    so to unstage everything at once,run this from the root directory
    of your reposistory:
    
    ```code
    git reset HEAD -- . 
    ```