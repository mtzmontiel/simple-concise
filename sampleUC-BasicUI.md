---
title: "Sample Use Case - Basic User Interface"
description: "user interface requirements"
layout: post
next: "forge/sampleUI-BasicUI"
tags: []
---

As usual, everything is cloudy until some context or sample is given. 
For this matter I would like to add some simple but complete problems to solve.

Basic UI
========

Case 1
------
I'll use various examples with progressive complexity, let's start with the
simplest one with just One Entity.

Consider a simple entity with 2 attributes.

~~~
  catalogue { code, description }
  
~~~

Functional requirements include at least

* Create Catalogue
* Search/find Catalogue
* View Catalogue details
* Modify Catalogue details
* Remove Catalogue

This is just minimal functional requirements but as is there is no point to code
this unless there is some behaviour associated. Let's add a statemachine to 
Catalogue.

~~~
  enum  catalogueStatus { DRAFT, PUBLISHED, HIDDEN;
    DRAFT -> PUBLISHED ["publish"]
    PUBLISHED -> HIDDEN ["hide"]
    HIDDEN -> PUBLISHED ["publish"]
  }
  
  catalogue { code, description, status : catalogueStatus }
  
~~~

<img src="{{site.url}}/assets/dot/su-baui-catalogue-status.dot.svg" />

Now functinal requirements must include transitioning between states of said 
statemachine.

* Publish Catalogue
* Hide Catalogue


Case 2
------

Consider two entities in master detail arrangement.

~~~
  package (1 -> 1-*) item

~~~

Suppose both have very simple attributes consisting of only code and description.

~~~
  package { code, description }
  
  item { code, description }

  package (1 -> 1-*) item

~~~

Functional requirements include at least

* Create Package
* View Package details
* Modify Package details
* Add Item to Package
* View Item details
* Modify Item details
* Remove Item from Package (deleting such item as a side effect)
* Delete Package (deleting items as a side effect)

Nothing out of ordinary I would think but if you translate this to current JEE 
practices code metrics would be around 4 kloc Java and possibly 
8 kloc xml/xhtml; not very nice and still we are still missing non functional 
requirements.

Case 3
------

Lets consider a N to M relationship with a join class/table

~~~

  artifact
    
  server
  
  enum deploymentStatus {
    SCHEDULLED, DEPLOYED, REMOVED, CANCELED;
    SCHEDULLED -> DEPLOYED -> REMOVED;
    SCHEDULLED -> CANCELED;
  }
  
  deployment { date , status : deploymentStatus }
  
  artifact ( 1 -> n ) deployment
  
  server ( 1 -> m ) deployment

~~~

<img src="{{site.url}}/assets/dot/su-baui-deployment-status.dot.svg" />

Now our user interface is getting a little complicated.
