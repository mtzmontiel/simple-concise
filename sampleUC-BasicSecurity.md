---
title: "Basic security - security requirements"
description: "security requirements"
layout: post
previous: "subaui/sampleUC-BasicUI-closing"
tags: []
---

There are many ways to tacle this but let's concentrate just on two different
views, business view and technological view. Both of them converge and there
is quite a lot of references out there.

Business View
=============

Business is mostly interested in this characteristics:

* Who
* What
* When

Who
---

This is a problem of subject identification which means every interaction
whith an application is done by a determined subject who can be a person or
another system. This does not mean that all interactions should be mapped to
a unique user, it means that every interaction should be mapped to a certain 
group of users.

For example an internet facing application can have both registered users and
anonymous users. Business dictates how to treat both kinds of users and that
prompts us to the next characteristic

What
----

What a determined user can do is where most projects fail while defining 
security constraints. Heere we use the 'verbs' that are available in our -/
systems, verbs that allow us to interact with it in combination with 'who'
and with the entities defined in our domain


* Who can do 'verb' with 'entity'
* Anonymus can read/see/query Catalogue
* Data Enterer can register new Catalogue
* SomeOtherRole can update existing Catalogue

That should give basic rules but there is another dimension to this. Here 
we are defining roles and actions by entity but it is also common to have 
restrictions on a subset of entities. Consider this:

* Data Enterer can Publish Catalogues which he Created

Thus there is a need to track 'who' acted on 'something' in order to filter 
available actions and restrict users that do not conform to said rule.

