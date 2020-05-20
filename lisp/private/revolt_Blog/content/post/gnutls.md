+++
title = "gnutls"
date = 2020-03-22T00:00:00+08:00
lastmod = 2020-03-23T01:29:28+08:00
tags = ["gnutl", "protocol"]
categories = ["gnutl", "protocol"]
draft = false
locale = "zh_CN"
autoCollapseToc = true
+++

learn how to use gnutls slove cask contract melpa.org 443 question.

<!--more-->


## Introduction to GnuTLS {#introduction-to-gnutls}

The Gnutls library consists of three independent parts,namely the
"TLS protocol part",the "Certificate part",and the "Cryptographic
back-end" part.

-   The "TLS protocol part" is the actual protocol implementation,and
    is entirely implemented within the GnuTLS library.
-   The "Certificate part" consists of the certificate parsing,and
    verification functions and it within the GnuTLS library.
-   The "Cryptographic back-end" is provided by the `nettle`&nbsp;[^fn:1] and
    `gmplib`&nbsp;[^fn:2]libraries.

GnuTLS depends on nettls and gmplib,and you will nned to install
it before installing GnuTLS.The nettle library is available
from&nbsp;[^fn:3] ,while gmplib is available form&nbsp;[^fn:2].


## Installing for a software distribution {#installing-for-a-software-distribution}

when install for a software distribution,it is often desirable for
preconfigure GnuTLS with the system-wide paths and files.

There two important configuration options,one sets the trust store
in stystem,which are the CA certificates to be used by programs by
default(if they don't override it),and the other sets to DNSSEC
root key file used by unbound for DNSSEC verification.

For the latter the following configuration option is available,and
if not specified GnuTLS will try to auto-detect the location of
that file.

```code
--with-unbound-root-key-file
```

To set the trust store the following options are available.

```code
--with-default-trust-store-file
--with-default-trust-store-dir
--with-default-trust-store-pkcs11
```

The first option is used to set a `PEM` file which contains a list
of trusted certificates,while the second will read all certificates
in the given path.

The recommended option is the last,which allows to use a `PKCS #11`
trust policy module(策略模块).That module not only provides the
trusted certificates,but allows the categorization of them using
purpose,e.g. CAs can be restricted for e-mail usage only,or
administractive restrictions of CAs,e.g. by restricting a CA to
only issue certificates(颁发证书) for a given DNS domain using
NameConstraints(命名约束).

A publicly available PKCS #11 trust module is p11-kit's trust
module&nbsp;[^fn:4].


### Overview {#overview}

GnuTLS supported security protocols in [Introduction to TLS and
DTLS](#introduction-to-tls-and-dtls),and continue by providing more information on the certificate
authentication in [Certificate authentication](#certificate-authentication),and shared-key as
well anonymous authentication in [Shared-key and anonymous
authentication](#shared-key-and-anonymous-authentication).We elaborate on certificate authentication by
demonstrating advanced usage of the API [More on certificate
authentication](#more-on-certificate-authentication).The core of the TLS library is presented in [How to
use GnuTLS in application](#how-to-use-gnutls-in-application) and example applications are listed 
in [GnuTLS application example](#gnutls-application-example).In [Other included programs](#other-included-programs) the usage of few
include programs that may assist debugging is presented.The last
chapter is [Internal architecture of GnuTLS](#internal-architecture-of-gnutls) that provides a short
introduction to GnuTLS's internal architecture.


## Introduction to TLS and DTLS {#introduction-to-tls-and-dtls}

TLS stands for `Transport layer Security` and is the successor(后继者) of SSL(Secure sockets layer)&nbsp;[^fn:5],the Secure Sockets layer
protocol degined by Netscape&nbsp;[^fn:6].TLS is an Internet
protocol,defined by IEFE[^fn:7],described in [here](https://www.ietf.org/rfc/rfc5246.txt).so we should learn
more about rfc documention.The protocol provides
confidentiality（保密协议）,and authentication layers over any
reliable transport layer.

The DTLS protocol,or "Datagram TLS(数据报传输层安全协议)" in [here](https://www.ietf.org/rfc/rfc4347.txt)
could read that is a protocol with identical goals as TLS, **but
can operate under unreliable transport layers such UDP**.


### <span class="org-todo todo TODO">TODO</span> TLS layer {#tls-layer}

TLS is a layer protocol,and consists of the _record protocol_,the
_handshake protocol_ and the _alert protocol_.

The record protocol is to serve all other protocols and is above
the transport layer.The record protocol offers symmetric
encryption(对称加密),and data authenticity&nbsp;[^fn:8].

The alert protocol offers some signaling(信号) to the other
protocols.It can help informing the peer(通知对方) for the cause
of failures and other error conditions. **The alert protocol is
above the record protocol**.

The handshake protocol is reponsilbe for the securty parameter's
negotiation(参数交换),the initial key exchange and authentication
（初始化密钥的交换和认证）.

[gnutl-layer]( https://www.gnutls.org/manual/gnutls-layers.png)


### The Transport layer {#the-transport-layer}

TLS is not limited to any transport layer and can be used above
any transport layer,as long as it is a reliable one.

DTLS can be used over reliable and unreliable transport
layers.GnuTLS supports TCP and UDP layers transparently using the
Berkeley(伯克利)&nbsp;[^fn:9]Sockets API.Howerver,any transport layer
can be used by providing callbacks for GnuTLS to access the
transport layer.


### The TLS record protocol {#the-tls-record-protocol}

The record protocol is the secure communications provider.It's
purpose is to encrypt,and authenticate packets(包).

The record layer functions can be called at any time after the
handshake process is finished,when there is need to receive or
send data.

In DTLS,howerver,due to re-tranmission timers(重新传输计时器) used in the
handshake out-of-order（乱序） handshake data might be received
for some time(maximum 60 seconds) after the handshake process is
finished.

The functions to access the record protocol are limited to send
and receive functions,which might,given the importance of this
protocol in TLS,seem awkward(尴尬).

This is because the record protocol's parameters are all set by
the handshake protocol. \*The record protocol initially starts with
NULL parameters,which means no encryption,and no MAC is
used\*. _Encryption and authentication begin just after the handshake
protocol has finished._


#### Encryption algorithms used in the record layer {#encryption-algorithms-used-in-the-record-layer}

Confidentiality in the record protocol is achieved by using
symmetric ciphers(对称密码) like AES or CHACHA20. Ciphers are
encryption algorithems that use a single,secret,key to encrypt
and decrypt data.

Early versions of TLS separated between block and stream ciphers
and has message authentication plugged in to them by the
protocol,though later version swithed to using
authenticated-encryption(AEAD) ciphers.The AEAD ciphers are
defined to combine encryption and authentication encryption and
authentication,and as such they are not only more efficient,as
the primitives used are designed to interoperate nicely,but they
are also known to interreperate in a secure way.

The supported in GnuTLS ciphers and MAC algorithes are show in
here:

如果你用过Shadowsockets，里面的加密方式就是那些 Supported ciphers in TLS.

其中对于 MAC的算法比较陌生

| Algorithms           | Description |
|:--------------------:|:-----------:|
| MAC-MD5              |             |
| MAC-SHA1             |             |
| MAC-SHA256           |             |
| MAC-SHA384           |             |
| GOST28147-TC26Z-IMIT |             |
| MAC-AEAD             |             |


#### Compression algorithms and the record layer {#compression-algorithms-and-the-record-layer}

In early versions of TLS the record layer supported
compression.However,that proved to be probelematic in many
ways,and enabled several attacks based on traffic analysis(流量分析) on the transported data.For that newer versions of the
protocol no longer offer compression,and GnuTLS since 3.6.0 no
longer implements any supports for compression.


#### On record padding {#on-record-padding}

The TLS 1.3 protocol allows for extra padding of records to
prevent statistical analysis based on the length of exchanged
messages.GnuTLS takes advantage of this feature,by allowing the
user to specify the amount of padding for a particluar
message.The simplest interface is provided by
`gnutls_record_send2` ,and is made avaliable when under
TLS1.3,alternatively `gnutls_record_can_use_length_hiding` can be
queried.

Note the interface is not sufficient to completely hide the
length of the data.The application code may reveal the data
transferred by leaking(泄漏) its data processing time,or by
leaking the TLS1.3 record processing time by GnuTLS.That is
because under TLS1,3 the padding removal(去除) time depends on
the padding data for an efficient implementation.To make that
processing constant time the `gnutls_init` function must be
called with the flag _GNUTLS\_SAFE\_PADDING\_CHECK_.


### The TLS Alert Protocol(警告协议) {#the-tls-alert-protocol--警告协议}

The alert protocol is there to allow signals to be sent between
peers.These signals are mostly used to inform(通知) the peer about
the cause of a protocol failure.

Some of these signals are used internally by the protocol and the
application protocol does not have to cpoy with
them(e.g. GNUTLS\_A\_CLOSE\_NOTIFY),and others refer to the
application protocol solely(e.g. GNUTLS\_A\_USER\_CANCELLED).

An alert signal includes a level indication which may be either
fatal(致命) or warning(under TLS1.3 all alerts are fatal).Fatal
alters always terminate the current connection,and prevent future
re-negotiations using the current session ID.All supported alert
messages are summarized in the table below.

The alert messages are protected by the record protocol,thus the
information that is included does not leak.You must take extrme
care for the alert information not to leak to a possible
attacker,via public log files etc.

| Alert                                | ID  | Description                                           |
|:------------------------------------:|:---:|:-----------------------------------------------------:|
| GNUTLS\_A\_NO\_APPLICATION\_PROTOCOL | 120 | No supported application protocol could be negotiated |


### The TLS HandShake Protocol {#the-tls-handshake-protocol}

The handshake protocol is reponsible for the ciphersuite
negotiation(密码套接协商),the initial key exchange,and the
authentication of the two peers.

This is fully controlled by the application layer,thus your
program has to set up the required parameters.

The mian handshake function is `gnutls_handshake` 。In the next
paragraphs we elaborate on the handshake protocol,i.e.,the
ciphersuite negotiation.


####  {#}


### TLS Extensions {#tls-extensions}


### How to use TLS in application protocols {#how-to-use-tls-in-application-protocols}


### On SSL 2 and older protocols {#on-ssl-2-and-older-protocols}


## Certificate authentication {#certificate-authentication}


## Shared-key and anonymous authentication {#shared-key-and-anonymous-authentication}


## More on certificate authentication {#more-on-certificate-authentication}


## How to use GnuTLS in application {#how-to-use-gnutls-in-application}


## GnuTLS application example {#gnutls-application-example}


## Other included programs {#other-included-programs}


## Internal architecture of GnuTLS {#internal-architecture-of-gnutls}

[^fn:1]: [Nettle Library](https://en.wikipedia.org/wiki/Nettle%5F(cryptographic%5Flibrary))
[^fn:2]: [gmplib website](https://gmplib.org/)
[^fn:3]: [nettle documention](https://www.lysator.liu.se/~nisse/nettle/)
[^fn:4]: [p11-kits](https://p11-glue.github.io/p11-glue/trust-module.html)
[^fn:5]: [SSL](https://www.ssl.com/faqs/faq-what-is-ssl/)
[^fn:6]: [Netscape](https://en.wikipedia.org/wiki/Netscape)
[^fn:7]: IETF, or Internet Engineering Task Force, is a large open international community of network designers, operators, vendors, and researchers concerned with the evolution of the Internet architecture and the smooth operation of the Internet. It is open to any interested individual.
[^fn:8]: In early versions of TLS compression was optionally available as well. This is no longer the case in recent versions of the protocol.
[^fn:9]: [Berkeley Sockets](https://en.wikipedia.org/wiki/Berkeley%5Fsockets)