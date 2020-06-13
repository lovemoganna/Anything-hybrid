+++
title = "Curl"
date = 2020-05-24T00:00:00+08:00
lastmod = 2020-05-26T09:02:10+08:00
draft = false
locale = "en_US"
+++

curl 是一个url资源下载器.

<!--more-->


## communication {#communication}

-   Most discussions are held on mailing lists.All issues are
    discussed and handled by bug trackers.

-   Encourage: if you are mailing for the first time,it might be good
    to read a few old mails first to get to learn the culture and
    what's considered good practice.


## Mailling list etiquette(邮件礼仪/规矩) {#mailling-list-etiquette--邮件礼仪-规矩}

其实邮件这玩意也是老外那边传过来的.规矩还是得学学,才能傲游世界.

-   Do not mail a single individual
    
    别光给一个人发邮件.这样的目的就是最大程度的让世界上的人了解所有正
    在发生的问题,以及解决这个问题的过程.

-   Reply or new mail
    
    就是一堆人谈论一个重复的问题,但是这个问题之前已经解决了.你就别在
    那个已经解决的邮件之上讨论了.自己再单独创建一个新邮件讨论就行了,
    就是别污染之前别人的讨论结果.可以在你的邮件里面引用之前的讨论.
    
    仅从技术角度! 老外喜欢高真实度还原事实.

-   Reply to the list
    
    回复给邮件群组的时候,一定要点回复全部,一个软件的开发有时候不是一
    个作者,他可能是一个团队.

-   Use a sensible subject
    
    使用一个简介明了的词,一针见血的指出问题就可以.

-   Do not top-post
    
    回复信息的时候,不要使用自下而上的回复方式.省得麻烦别人还得把邮件
    划到最下方看原始内容.
    
    程序按顺序执行的,搞开发的也一样.随时保持脑路清晰.

-   [quote](https://www.netmeister.org/news/learn2quote.html)

-   Digest(摘要)
    
    一般情况下,加几个脚注就可以解决.

-   Please tell us how you solved the problem
    
    还原过程,陈述事实.

-   Mailling Lists
    1.  curl-users
    
    2.  curl-library
    
    3.  curl-announce

-   Reporting bugs
    1.  A bug is a problem
    
    2.  Problems must be known to get fixed
        
        必须得描述清楚问题,bug才能够被解决
    
    3.  Fixing the poroblems
    
    4.  A good bug report
        
        -   一个好的bug报告必须揭示了发生了什么,以及它发生的过程.
        
        -   声明你正在使用的设备的信息版本号.(一步一步的陈述清楚)
        
        -   在提交报告之后,你可能会按照要求做一些尝试,开发者就会缩小bug
            产生的范围,确保你的问题可以正确的被解决.
        
        -   开发者如果读不懂你提交的bug报告,自然你的问题会被遗弃.也有可
            能人家正在忙别的事,你需要重复提交一份报告(如果觉得bug报告描
            述的不够好,可以修正一下,为了解决问题,需要有百折不挠的精神.)
        
        curl 的bug追踪器设置在 github上面.[curl bug trackers](https://github.com/curl/curl/issues).

<!--listend-->

-   Testing
    
    common problem have memory leak or something fishy in the
    protocol layer.
    
    其中有一个最大的问题是,curl官方的测试套件根本没办法在其他平台运行.所
    以注定会在别的平台有漏洞.

-   Releases
    
    github search

-   Daily snapshots
    
    don't important

-   Install
    
    if you want to build applications against libcurl, you need a
    development package installed to get the include headers and some
    additional documentation.You can then select ta libcurl with the
    TLS backend your prefer:
    
    ```text
    libcurl4-openssl-dev
    libcurl4-nss-dev
    libcurl4-gnutls-dev
    ```


## Network and protocols {#network-and-protocols}


### Networking simplified {#networking-simplified}

Networking means communicating between two endpoints on the
internet.

The internet is just a bunch(一堆) of interconnected
machines(computers really),each using their own private
address.(IP address).

The addresses each machine have can be of different types and
machines can even have temporary addresses.These computers are
often called hosts.(主机)


### Which machine {#which-machine}

When you want to initiate a transfer to one of the machines out
there (a server),you usually do not know its IP address but
instead you usually know its name.The name of the machine you will
talk to is embedded in the URL that you work with when you use
curl.

You might use a URL like `"http://example.com/index.html"`, which
means you will connect to and communicate with the host named
example.com.


### Host name resolving {#host-name-resolving}

Once we know the host name, we need to figure out which IP address
that host has so that we can contact it.

Converting the name to an IP address is often called 'Name
resolving'.The name is "resolved" to one or a set of
addresses. This is usually done by "DNS Server",DNS being like a
big lookup table that can convert names to addresses - all the
names on the Internet, really. Your computer normally already
knows the address of a computer that runs the DNS server as that
is part of setting up the network.


### Establish a connection {#establish-a-connection}

With a list of IP addresses for the host curl wants to
contact,curl sends out a "connect request".The connection curl
wants to establish is called TCP (Transmission Control Protocol)
and it works sort of like connecting an invisible string between
two computers.Once established,it can be used to send a stream of
data in both directions.


### Connects to "port numbers" {#connects-to-port-numbers}

When connecting with TCP to a remote server, a client selects
which port number to do that on.

A port number is just a dedicated place for a particular
service,which allows that same server to listen to to other
services on other port numbers at the same time.


## Command line options {#command-line-options}


## 让我们一起来Hack资源 {#让我们一起来hack资源}

今天我们就来掠取一些有意思的东西吧.

教育分为多面,成绩,富贵啥的先放在一边吧.就先教会孩子怎么保护自己,健康的
活着才是一切的基础.

作为大人,有能力还是多做点吧.很多人把弘扬社会责任变成牟利的工具.

我也不多BB,免费的东西才是最贵的.

天下大事,近收眼底.奈何无为.

孩子在手,长在眼前,岂能不管?(别傻啦吧唧的老打孩子).多动脑子.

落后的脑子怎么能教育出先进的孩子哪?


### Massion {#massion}

重组数据,让农村更加美好.

-   target: <https://www.cxy61.com/girl/child%5Fsexual%5Feducation/child%5Fview.html>
    
    ```shell
    curl https://www.cxy61.com/girl/child_sexual_education/child_view.html
    ```