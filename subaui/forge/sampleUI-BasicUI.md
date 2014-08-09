---
title: "01.02.01 Basic UI - Forge 01 - Sample Use Case - Basic UI"
description: "Sample Use Case - Basic UI"
layout: post
up: "subaui/sampleUC-BasicUI"
next: "subaui/forge/sampleUI-BasicUI-02"
tags: []
---

Forge is a project by JBoss that aims to accelerate application development 
by means of a Command Line Interface and IDE Plugins, for this sample I'll 
stay with the CLI.

~~~
forge
Using Forge at /home/rmm/bin/forge-distribution-2.5.0.Final
Warning: JAVA_HOME environment variable is not set.

    _____                    
   |  ___|__  _ __ __ _  ___ 
   | |_ / _ \| `__/ _` |/ _ \  \\
   |  _| (_) | | | (_| |  __/  //
   |_|  \___/|_|  \__, |\___| 
                   |___/      

JBoss Forge, version [ 2.5.0.Final ] - JBoss, by Red Hat, Inc. [ http://forge.jboss.org ]
[simple-concise-code]$ project-new --named simple-concise-forge \
  --topLevelPackage mx.rmm.simpleconcise.forge \
  --version 1.0-SNAPSHOT \
  --type war \
  --buildSystem Maven

~~~

Now we have an empty project with this layout

~~~
├── simple-concise-forge
│   ├── pom.xml
│   └── src
│       ├── main
│       │   ├── java
│       │   ├── resources
│       │   └── webapp
│       └── test
│           ├── java
│           └── resources

~~~

Configuring our persistence engine and validation tools

~~~
[simple-concise-forge]$ jpa-setup --jpaVersion 2.0 --container JBOSS_AS7 \
  --provider Hibernate
***SUCCESS*** Persistence (JPA) is installed.
[simple-concise-forge]$ constraint-setup
***SUCCESS*** Bean Validation is installed.

~~~


~~~
simple-concise-forge/
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   ├── resources
    │   │   └── META-INF
    │   │       ├── persistence.xml
    │   │       └── validation.xml
    │   └── webapp
    └── test
        ├── java
        └── resources

9 directories, 3 files

~~~

Sample 01 - Single entity
-------------------------

Adding an entity is quite simple

~~~
[simple-concise-forge]$ jpa-new-entity --named Catalogue
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Catalogue created
[Catalogue.java]$ jpa-new-field --named code \
  --type String --length 10
***SUCCESS*** Field code created
[Catalogue.java]$ jpa-new-field --named description \
  --type String --length 100
***SUCCESS*** Field description created

~~~

Now our structure looks like this

~~~
simple-concise-forge/
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── mx
    │   │       └── rmm
    │   │           └── simpleconcise
    │   │               └── forge
    │   │                   └── model
    │   │                       └── Catalogue.java
    │   ├── resources
    │   │   └── META-INF
    │   │       ├── persistence.xml
    │   │       └── validation.xml
    │   └── webapp
    └── test
        ├── java
        └── resources

14 directories, 4 files


~~~

Forge is able to build all scaffolding UI using JSF and facelets from just 
this previous actions but first some extra setup steps are needed.

~~~
[simple-concise-forge]$ scaffold-setup --provider Faces \
  --facesVersion 2.1 --ejbVersion 3.1 --servletVersion 3.0 --cdiVersion 1.0 
***SUCCESS*** CDI has been installed.
***SUCCESS*** EJB has been installed.
***SUCCESS*** Servlet API has been installed.
***SUCCESS*** JavaServer Faces has been installed.
***SUCCESS*** Scaffold was setup successfully.

~~~

Structure 

~~~
simple-concise-forge/
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── mx
    │   │       └── rmm
    │   │           └── simpleconcise
    │   │               └── forge
    │   │                   └── model
    │   │                       └── Catalogue.java
    │   ├── resources
    │   │   └── META-INF
    │   │       ├── persistence.xml
    │   │       └── validation.xml
    │   └── webapp
    │       ├── error.xhtml
    │       ├── index.html
    │       ├── index.xhtml
    │       ├── resources
    │       │   ├── add.png
    │       │   ├── bootstrap.css
    │       │   ├── false.png
    │       │   ├── favicon.ico
    │       │   ├── forge-logo.png
    │       │   ├── forge-style.css
    │       │   ├── jboss-community.png
    │       │   ├── remove.png
    │       │   ├── scaffold
    │       │   │   ├── pageTemplate.xhtml
    │       │   │   └── paginator.xhtml
    │       │   ├── search.png
    │       │   └── true.png
    │       └── WEB-INF
    │           ├── beans.xml
    │           ├── faces-config.xml
    │           └── web.xml
    └── test
        ├── java
        └── resources

17 directories, 22 files

~~~

Those are just templates, we need to generate scaffolding for specific
entities.

~~~
[simple-concise-forge]$ scaffold-generate --targets \
  mx.rmm.simpleconcise.forge.model.Catalogue 
***SUCCESS*** Scaffold was generated successfully.

~~~

Structure

~~~
simple-concise-forge/
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── mx
    │   │       └── rmm
    │   │           └── simpleconcise
    │   │               └── forge
    │   │                   ├── model
    │   │                   │   └── Catalogue.java
    │   │                   └── view
    │   │                       ├── CatalogueBean.java
    │   │                       └── ViewUtils.java
    │   ├── resources
    │   │   └── META-INF
    │   │       ├── persistence.xml
    │   │       └── validation.xml
    │   └── webapp
    │       ├── catalogue
    │       │   ├── create.xhtml
    │       │   ├── search.xhtml
    │       │   └── view.xhtml

~~~


Let's see what kind of UI forge has generated.

<img src="{{site.url}}/assets/images/suc-bui-forge/001.png" />

Simple enough there is a menu on the left with our scaffolded entity. 

<img src="{{site.url}}/assets/images/suc-bui-forge/002.png" />

Now we see a couple of search fields and buttons to add new entities. 
Adding an entity is quite simple so let's do it.

<img src="{{site.url}}/assets/images/suc-bui-forge/003.png" />

Fill all the fields and press save

<img src="{{site.url}}/assets/images/suc-bui-forge/004.png" />

And now it appears on the list below and we are able to drill into it's 
detailed page

<img src="{{site.url}}/assets/images/suc-bui-forge/005.png" />

Easy and to the point, now let's count lines.

~~~
simple-concise-forge$ for EXTN in \
  `find -type f |  sed -r 's|.*(\.[a-z]*)|\1|g'|sort -u` ;\
  do echo $EXTN ; \
  find -iname "*$EXTN" | xargs wc -l | grep total;\
  done

.css
  5677 total
.java
  514 total
.xhtml
  327 total
.xml
 173 total

~~~

Just about 1 Kloc without taking into consideration language complexities,
I'm just interested on a ballpark line count to correlate vs current 
industry metrics. With this in mind i've just become a lot more "productive"
but there are problems with this implementation that will become very 
troublesome.

You can find the source files [here][code-forge-buc-bui-1.0].

[code-forge-buc-bui-1.0]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-forge-buc-bui-1.0

Let's continue our example by adding our state machine to this.
