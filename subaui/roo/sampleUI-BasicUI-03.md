---
title: "Roo 03"
description: "Sample Use Case - Sample 03 Many to Many"
layout: post
up: "subaui/sampleUC-BasicUI"
previous: "subaui/roo/sampleUI-BasicUI-02"
next: "subaui/roo/sampleUI-BasicUI-03"
tags: []
---
Now to the complicated example

{% highlight bash %}
entity jpa --class ~.model.Artifact --testAutomatically 
field string --fieldName name --notNull 
enum type --class ~.model.DeploymentStatus
enum constant --class ~.model.DeploymentStatus --name SCHEDULLED
enum constant --class ~.model.DeploymentStatus --name DEPLOYED
enum constant --class ~.model.DeploymentStatus --name REMOVED
enum constant --class ~.model.DeploymentStatus --name CANCELED
entity jpa --class ~.model.Deployment --testAutomatically 
field string --fieldName name --notNull 
field date --fieldName schedulledDate --type java.util.Date 
field enum --fieldName status --type ~.model.DeploymentStatus --notNull 
entity jpa --class ~.model.Server --testAutomatically 
field string --fieldName name --notNull 
field reference --fieldName artifact --type ~.model.Artifact --class ~.model.Deployment --notNull 
field reference --fieldName server --type ~.model.Server --class ~.model.Deployment --notNull 
finder list
web jsf all --package mx.rmm.simpleconcise.roo.web

{% endhighlight %}

One big difference with Forge is the date picker by default on
schedulled date field.

<img src="{{site.url}}/assets/images/suc-bui-roo/015.png" />

Status has Autocomplete enabled

<img src="{{site.url}}/assets/images/suc-bui-roo/016.png" />

And both artifact and server also have autocomplete

<img src="{{site.url}}/assets/images/suc-bui-roo/017.png" />
<img src="{{site.url}}/assets/images/suc-bui-roo/018.png" />

List all deployments contains only name and schedulled date but no 
Status which is not what I would like.

<img src="{{site.url}}/assets/images/suc-bui-roo/019.png" />

And on the detail page we see the ID for server and artifact instead
of the name we selected on creation.

<img src="{{site.url}}/assets/images/suc-bui-roo/020.png" />

Current metrics are

~~~
.css
.js
.aj
  5619 total
.java
  618 total
.xml
  593 total
.xhtml
  710 total

~~~

Here we see a lot of aspectJ code which is always overwritten by roo
and the way that we can customize appearance and behaviour is by
implementing on the .java files; roo will delete the code on the aspectj files whenever it detects changes on the java sources.

For example

{% highlight java%}
privileged aspect Artifact_Roo_ToString {
    
    public String Artifact.toString() {
        return ReflectionToStringBuilder.toString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
}
{% endhighlight %}

If we implement a toString method roo will delete those lines on Artifact_Roo_ToString.


You can find sourcecode [here][code-roo-buc-bui-1.7]

[code-roo-buc-bui-1.7]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-roo-buc-bui-1.7
