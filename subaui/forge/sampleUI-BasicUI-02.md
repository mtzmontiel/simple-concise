---
title: "Forge 02 - Sample Use Case - Basic UI 01 - Status"
description: "Sample Use Case - Basic UI 01 - Status"
layout: post
up: "subaui/sampleUC-BasicUI"
previous: "subaui/forge/sampleUI-BasicUI"
next: "subaui/forge/sampleUI-BasicUI-03"
tags: []
---

Let's first create an enum for our state machine.

~~~
[simple-concise-forge]$ java-new-enum --named CatalogueStatus \
  --targetPackage mx.rmm.simpleconcise.forge.model
***SUCCESS*** Enum mx.rmm.simpleconcise.forge.model.CatalogueStatus was created
[CatalogueStatus.java]$ java-new-enum-const \
  --enumClass mx.rmm.simpleconcise.forge.model.CatalogueStatus \
  --named DRAFT
[CatalogueStatus.java]$ java-new-enum-const \
  --enumClass mx.rmm.simpleconcise.forge.model.CatalogueStatus \
  --named PUBLISHED
[CatalogueStatus.java]$ java-new-enum-const \
  --enumClass mx.rmm.simpleconcise.forge.model.CatalogueStatus \
  --named HIDDEN
[CatalogueStatus.java]$ ls
DRAFT      HIDDEN     PUBLISHED  

~~~

And add a new field to our existing entity Catalogue

~~~
[CatalogueStatus.java]$ cd ..   
[model]$ cd Catalogue.java
[Catalogue.java]$ jpa-new-field --named status \
  --type mx.rmm.simpleconcise.forge.model.CatalogueStatus \
  --enumType STRING 
***SUCCESS*** Field status created
[Catalogue.java]$ scaffold-generate \
  --targets mx.rmm.simpleconcise.forge.model.Catalogue
***SUCCESS*** Scaffold was generated successfully.

~~~

Metrics

~~~
.java
  541 total
.xhtml
  361 total
.xml
 173 total

~~~

Now our user interface looks a little diferent with a new search field and 
a new column on the table below.

<img src="{{site.url}}/assets/images/suc-bui-forge/006.png" />

On creation we are propted with a selection box for the enum values.

<img src="{{site.url}}/assets/images/suc-bui-forge/007.png" />
<img src="{{site.url}}/assets/images/suc-bui-forge/008.png" />

And everything is ok, right?
<img src="{{site.url}}/assets/images/suc-bui-forge/009.png" />

But there are problems with our UI, there are no restrictions to values set
on fields

<img src="{{site.url}}/assets/images/suc-bui-forge/010.png" />
<img src="{{site.url}}/assets/images/suc-bui-forge/011.png" />

Fortunately this can be fixed in a clean way

~~~
[Catalogue.java]$ constraint-add --onProperty code --constraint NotNull 
***SUCCESS*** Constraint NotNull successfully configured
[Catalogue.java]$ constraint-add --onProperty description \
  --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Catalogue.java]$ constraint-add --onProperty status   --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Catalogue.java]$ scaffold-generate \
  --targets mx.rmm.simpleconcise.forge.model.Catalogue --overwrite
***SUCCESS*** Scaffold was generated successfully.

~~~

Metrics

~~~
.java
  545 total
.xhtml
  360 total
.xml
 173 total

~~~

Our user interface now hints that there are required fields

<img src="{{site.url}}/assets/images/suc-bui-forge/012.png" />

And there are validations in place for said fields

<img src="{{site.url}}/assets/images/suc-bui-forge/013.png" />

But still we are missing how to transition in our statemachine within our
busines case.

<img src="{{site.url}}/assets/dot/su-baui-catalogue-status.dot.svg" />

You can find source code You can find the source files [here][code-forge-buc-bui-1.1].

[code-forge-buc-bui-1.1]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-forge-buc-bui-1.1

For now let's continue with sample 02 of our basic UI requirements

