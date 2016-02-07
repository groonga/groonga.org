---
layout: post.en
title: fluent-plugin-groonga
description: The introduction of fluent-plugin-groonga for replication
of groonga databases.
---

2012-12-29, fluent-plugin-groonga 1.0.1 was released. You can use
fluent-plugin-groonga to replicate your groonga databases with
[fluentd](http://fluentd.org/) .

What's "fluent-plugin-groonga" ?
--------------------------------

fluent-plugin-gronga is the fluentd plugin collection. It is implemented
by Ruby.
Usually, fluentd is used as event log collector, but
fluent-plugin-groonga uses fluentd as message router.
Fluent-plugin-groonga implements replication for groonga by transfering
queries to one or more groonga servers.

Without fluent-plugin-groonga, a groonga client and a groonga server
communicate to each other. Fluent-plugin-groonga can send queries from
this client to multiple groonga servers or other fluentds. You can
replicate your groonga databases with fluent-plugin-groonga between
client and servers.

Fluent-plugin-groonga includes two plugins named each "groonga". They
are input plugin and output plugin. Next, please see for their details.

### Input plugin

Input plugin receives groonga commands sent by a groonga client. These
commands ordinary sent to groonga servers.
Next, input plugin send these commands to output plugin via zero or more
fluentds. If no fluentd exists, commands are sent to output plugin
directly.

Input plugin provides two interfaces, HTTP or
[GQTP](/docs/spec/gqtp.html) (groonga original protocol), to receive
groonga commands. These interfaces are compatible of groonga server, so
you can use input plugin as same as groonga server.

### Output plugin

Output plugin sends groonga commands to groonga servers.
This plugin supports all interfaces of groonga (HTTP, GQTP and command).
You don't have to use the same interface as one specified to input
plugin. Additionally, you can use [copy output
plugin](http://docs.fluentd.org/articles/out_copy) to duplicate
commands.

How to install
--------------

To install fluent-plugin-groonga, please run below command only:

    % gem install fluent-plugin-groonga

The source code of fluent-plugin-groonga is [hosting by
GitHub](https://github.com/groonga/fluent-plugin-groonga/) likewise
groonga and related projects.

Documents
---------

[The documents of
fluent-plugin-groonga](http://groonga.org/fluent-plugin-groonga/en/)
contains [examples about replitaion
constitution](http://groonga.org/fluent-plugin-groonga/en/file.constitution.html)
and [how to
configure](http://groonga.org/fluent-plugin-groonga/en/file.configuration.html)
.
With them, please try to replicate your groonga database with
fluent-plugin-groonga!
If you have some troubles or features you want, you can notify us with
groonga's mailing list
([groonga-talk](https://lists.sourceforge.net/lists/listinfo/groonga-talk))
and pull requests in GitHub.
