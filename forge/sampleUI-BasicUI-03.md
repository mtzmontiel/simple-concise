---
title: "Forge 03"
description: "Sample Use Case - Basic UI 02 - One to Many"
layout: post
up: "sampleUC-BasicUI"
previous: "forge/sampleUI-BasicUI-02"
next: "forge/sampleUI-BasicUI-03"
tags: []
---

Let's add two new Entities

~~~
[simple-concise-forge]$ jpa-new-entity --named Container  
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Container created
[Container.java]$ jpa-new-field --named code 
***SUCCESS*** Field code created
[Container.java]$ constraint-add --onProperty code --constraint NotNull 
***SUCCESS*** Constraint NotNull successfully configured
[Container.java]$ jpa-new-field --named description --type String
***SUCCESS*** Field description created
[Container.java]$ constraint-add --onProperty description --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Container.java]$ jpa-new-entity --named Item
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Item created
[Item.java]$ jpa-new-field --named code --type String
***SUCCESS*** Field code created
[Item.java]$ constraint-add --onProperty code --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Item.java]$ jpa-new-field --named description --type String
***SUCCESS*** Field description created
[Item.java]$ constraint-add --onProperty description --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured

~~~

To add the N-1 relation from Item 

~~~
[Item.java]$ jpa-new-field --named container \
  --type mx.rmm.simpleconcise.forge.model.Container \
  --relationshipType Many-to-One \
  --inverseFieldName items \
  --required \
  --fetchType EAGER 

~~~

And generate templates only for Container and Item

~~~
[Item.java]$ scaffold-generate \
 --targets mx.rmm.simpleconcise.forge.model.Container \
 mx.rmm.simpleconcise.forge.model.Item \
 --overwrite    
***SUCCESS*** Scaffold was generated successfully.

~~~

Our structure looks like this

~~~
simple-concise-forge/
├── pom.xml
├── src
│   ├── main
│   │   ├── java
│   │   │   └── mx
│   │   │       └── rmm
│   │   │           └── simpleconcise
│   │   │               └── forge
│   │   │                   ├── model
│   │   │                   │   ├── Catalogue.java
│   │   │                   │   ├── CatalogueStatus.java
│   │   │                   │   ├── Container.java
│   │   │                   │   └── Item.java
│   │   │                   └── view
│   │   │                       ├── CatalogueBean.java
│   │   │                       ├── ContainerBean.java
│   │   │                       ├── ItemBean.java
│   │   │                       └── ViewUtils.java
│   │   ├── resources
│   │   │   └── META-INF
│   │   │       ├── persistence.xml
│   │   │       └── validation.xml
│   │   └── webapp
│   │       ├── catalogue
│   │       │   ├── create.xhtml
│   │       │   ├── search.xhtml
│   │       │   └── view.xhtml
│   │       ├── container
│   │       │   ├── create.xhtml
│   │       │   ├── search.xhtml
│   │       │   └── view.xhtml
│   │       ├── error.xhtml
│   │       ├── index.html
│   │       ├── index.xhtml
│   │       ├── item
│   │       │   ├── create.xhtml
│   │       │   ├── search.xhtml
│   │       │   └── view.xhtml

~~~

On the main page there are a couple of new elements, Container and Item as
expected.

<img src="{{site.url}}/assets/images/suc-bui-forge/014.png" />

The home page of Container is pretty much the same as in sample 01 with a 
filter section and a results table.

<img src="{{site.url}}/assets/images/suc-bui-forge/015.png" />

On creating a new Container we start to see differences with a specialized
section that allows to register items.

<img src="{{site.url}}/assets/images/suc-bui-forge/016.png" />

Let's add a simple Container with no contents

<img src="{{site.url}}/assets/images/suc-bui-forge/017.png" />

On the homepage of Container we can see our new container

<img src="{{site.url}}/assets/images/suc-bui-forge/018.png" />

Drilling on our container we can see the details and launch an edit action

<img src="{{site.url}}/assets/images/suc-bui-forge/019.png" />

Let's add a new item and press (+) button on the gui

<img src="{{site.url}}/assets/images/suc-bui-forge/020.png" />

We see the new item and a new button to remove it. Proceeding with our 
example let's press save.

<img src="{{site.url}}/assets/images/suc-bui-forge/021.png" />

We are back on Container detail page and the new Item is visible.

<img src="{{site.url}}/assets/images/suc-bui-forge/022.png" />

If we go to the Item homepage we already see the Item that we added to our
first container.

<img src="{{site.url}}/assets/images/suc-bui-forge/023.png" />

When creating another item we are prompted to select an Existing Container

<img src="{{site.url}}/assets/images/suc-bui-forge/024.png" />

Now we have 2 items associated with the same container

<img src="{{site.url}}/assets/images/suc-bui-forge/025.png" />

If we drill down to detail page of the last created item we can see a link
that allows us to see the detail of the related container

<img src="{{site.url}}/assets/images/suc-bui-forge/026.png" />

Which in turn allows us to see both items and we are able to navigate
between both entities in a simple way.

<img src="{{site.url}}/assets/images/suc-bui-forge/027.png" />

Simple as that. In my experience constructing a webapp for a 1-n relation
is error prone and very tedious; we have built an app that can cope with
the original requirements with almost no effort.

* Create Container
* View Container details
* Modify Container details
* Add Item to Container
* View Item details
* Modify Item details
* Remove Item from Container (deleting such item as a side effect)
* Delete Container (deleting items as a side effect)

Current metrics

~~~
.java
 1458 total
.xhtml
  844 total
.xml
 173 total

~~~

This is pretty nice for 2 Kloc and perhaps you are begining to see where 
I'm going with this.

You can find source code [here][code-forge-buc-bui-1.2]

[code-forge-buc-bui-1.2]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-forge-buc-bui-1.2

Let's continue with our complicated example
