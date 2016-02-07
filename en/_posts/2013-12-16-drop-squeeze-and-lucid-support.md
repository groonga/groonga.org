---
layout: post.en
title: Drop package support for Debian 6.0(squeeze) and Ubuntu
10.04(lucid)
description: Drop package support for Debian 6.0(squeeze) and Ubuntu
10.04(lucid)
---

Drop package support for Debian 6.0(squeeze) and Ubuntu 10.04(lucid)
--------------------------------------------------------------------

We announce that Groonga Project will drop package support for old
releases.

### Target environment

Groonga Project decided to drop providing packages for following
release.

-   Debian 6.0(squeeze)
-   Ubuntu 10.04(lucid)

### End of release

We will drop package support since Groonga 3.1.1 which will be released
at Dec 29, 2013.

### About migration

Please migrate from Debian 6.0(squeeze) or Ubuntu 10.04(lucid) to Debian
7.0(wheezy) or Ubuntu 12.04(precise).

Note that Debian 6.0(squeeze) is "Old stable".

### The reason why we drop package support

Groonga Project provides packages by self hosted the Groonga
repository.
It is aimed to support easy to install, but it requires users to
register the Groonga repository in advance.

We are working on registering Groonga as Debian package so that you
don't have to register it.

Such task needs to support Multiarch, but it is not suported on Debian
6.0(squeeze) and Ubuntu 10.04(lucid).
This is why we will drop package support on above environment.

If you can't migrate to latest environment, please try to build from
source.

-   [Build from source on
    Debian](http://groonga.org/docs/install/debian.html#build-from-source)
-   [Build from source on
    Ubuntu](http://groonga.org/docs/install/ubuntu.html#build-from-source)

### Conclusion

We will continue to release latest Groonga every month!

Let's search by Groonga!
