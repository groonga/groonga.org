---
layout: post.en
title: grafana-datasource-plugin-groonga 0.1.0 has been released
description: grafana-datasource-plugin-groonga 0.1.0 has been released!
---

## grafana-datasource-plugin-groonga 0.1.0 has been released

We glad to announce [grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga) 0.1.0 release. It's the first release of grafana-datasource-plugin-groonga.

grafana-datasource-plugin-groonga is a plugin for [Grafana](http://grafana.org/) that adds a datasource for Groonga. It makes to be able to visualize data of Groonga easily.

### Features

* Visualize numeric column data of a table that contains Time type column.
  * Access Groonga via HTTP.
  * Require Time type column in data because this plugin shows data in time series.
  * Except for numeric type columns are not covered because they are not statistical information.

Now, this plugin has only the above features. For example, you can visualize specific column data transition in a table that contains logs of every fixed time.

### Plan for the Future

* Visualize multiple columns in a graph.
* Graph results of drilldown.

The above features will be supported in a future release.

### Installation

Copy a Git repository or archive of grafana-datasource-plugin-groonga into plugins directory in Grafana. Then, restart Grafana server. See [README](https://github.com/groonga/grafana-datasource-plugin-groonga#installation) in more details.

### Usage

First, add this datasource like the following screenshot in administration view of Grafana. The following case specifies a Groonga server running on `http://localhost:10041`.

![grafana-datasource-plugin-groonga-edit-datasource](https://cloud.githubusercontent.com/assets/386687/13377966/27033252-de36-11e5-91a5-14597b34a2c5.png)

Next, add graph on dashboard, and configure metrics like the following screenshot. It's an example for the graph which contains a numeric value column of Data table that has Time type column.

![grafana-plugin-datasource-groonga-screenshot](https://cloud.githubusercontent.com/assets/386687/13373741/41058f8e-ddb3-11e5-83fd-d904f810f8fe.png)

See [README](https://github.com/groonga/grafana-datasource-plugin-groonga#usage) for details.

### Feedback

We welcome your feedback via [Groonga-talk mailing list](https://lists.sourceforge.net/lists/listinfo/groonga-talk) or [GitHub Issues](https://github.com/groonga/grafana-datasource-plugin-groonga/issues). Feel free to report your feedback.

### Summary

We announced that the first version of [grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga) has been released.

Let's visualize Groonga's data with the new Grafina data source!
