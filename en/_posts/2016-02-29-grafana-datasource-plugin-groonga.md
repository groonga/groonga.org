---
layout: post.en
title: grafana-datasource-plugin-groonga 0.1.0 has been released
description: grafana-datasource-plugin-groonga 0.1.0 has been released!
---

## grafana-datasource-plugin-groonga 0.1.0 has been released

[grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga) 0.1.0 released. It's the first version of grafana-datasource-plugin-groonga.

grafana-datasource-plugin-groonga is a plugin for [Grafana](http://grafana.org/) that adds a datasource for Groonga. It can visualize data of Groonga.

### Feature

* Visualize numeric column data of a table that is included Time type column.
  * Access Groonga via HTTP.
  * Require Time type column because show data as time series.
  * Excepting numeric type columns are excluded because they are not statistics.

Now, it has only the above features. For example, you can visualize specific column data transition in a table includes logs of every fixed time.

### Future

* Visualize multiple columns in a graph.
* Graph results of drilldown.

The above will be supported in future release.

### Installation

Copy a Git repository or archive of grafana-datasource-plugin-groonga to plugins directory in Grafana. Then, restart Grafana server. See [README](https://github.com/groonga/grafana-datasource-plugin-groonga#installation) for details.

### Usage

First, add datasource as the following screen shot in administration view of Grafana. The following is in a case of to specify a Groonga server running on `http://localhost:10041`.

![grafana-datasource-plugin-groonga-edit-datasource](https://cloud.githubusercontent.com/assets/386687/13377966/27033252-de36-11e5-91a5-14597b34a2c5.png)

Next, add graph on dashboard, and configure metrics as the following screen shot. It's an example that graph a numeric value column of Data table that has Time type column.

![grafana-plugin-datasource-groonga-screenshot](https://cloud.githubusercontent.com/assets/386687/13373741/41058f8e-ddb3-11e5-83fd-d904f810f8fe.png)

See [README](https://github.com/groonga/grafana-datasource-plugin-groonga#usage) for details.

### Feedback

We welcome feedback via [Groonga-talk mailing list](https://lists.sourceforge.net/lists/listinfo/groonga-talk) or [GitHub Issues](https://github.com/groonga/grafana-datasource-plugin-groonga/issues).

### Summary

Introduced the first release of [grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga).

Let's visualize Groonga!
