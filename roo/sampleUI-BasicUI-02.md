---
title: "Roo 02"
description: "Sample Use Case - Sample 02 One to Many"
layout: post
up: "sampleUC-BasicUI"
previous: "roo/sampleUI-BasicUI-01"
next: "roo/sampleUI-BasicUI-03"
tags: []
---

Building sample 02 we start with the N part of the relation then the Container

{% highlight bash %}
entity jpa --class ~.model.Item --testAutomatically 
field string --fieldName code --notNull 
field string --fieldName description --notNull 
entity jpa --class ~.model.Container --testAutomatically 
field string --fieldName code --notNull 
field string --fieldName description --notNull 

{% endhighlight %}

now the tricky relation

{% highlight bash %}
field set --fieldName items --class ~.model.Container --type ~.model.Item --mappedBy container --fetch EAGER --cardinality ONE_TO_MANY 

field reference --fieldName container --class ~.model.Item --type ~.model.Container --notNull 
web jsf all --package ~.web

{% endhighlight %}

Now fire up our server. The menu is updated.

<img src="{{site.url}}/assets/images/suc-bui-roo/007.png" />

On create we find our first bump, we cannot see the relation from this side but we are able to create a Container.

<img src="{{site.url}}/assets/images/suc-bui-roo/008.png" />

The all catalogs view is paginated by default which is a nice thing.

<img src="{{site.url}}/assets/images/suc-bui-roo/009.png" />

On the detail view no surprises.

<img src="{{site.url}}/assets/images/suc-bui-roo/010.png" />

So let's add some Items

<img src="{{site.url}}/assets/images/suc-bui-roo/011.png" />

The field to select the container is another nice thing to see,
it autocompletes with current options.

<img src="{{site.url}}/assets/images/suc-bui-roo/012.png" />

Nothing new on the view all page of Item

<img src="{{site.url}}/assets/images/suc-bui-roo/013.png" />

And here we find another not so nice thing, we se the id of Container
instead of a friendly text or toString.

<img src="{{site.url}}/assets/images/suc-bui-roo/014.png" />

I'm missing a table view for the 1-N relation which I suppose is done by
custom coding or via another roo plugin. Besides for spring it's natural
to use Spring MVC instead of JSF so perhaps it is an error on my behalf but
I'm trying to use standard APIs whenever possible.

Current metrics are:

~~~
.css
 174 total
.js
 106 total
.aj
  2884 total
.java
  435 total
.xml
 1143 total
.xhtml
  904 total
  
~~~

