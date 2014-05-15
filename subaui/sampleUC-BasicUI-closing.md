---
title: "Sample Use Case - Basic User Interface"
description: "Closing comments on UI"
layout: post
prev: "subaui/forge/roo/sampleUI-BasicUI-03"
next: "sampleUC-BasicSecurity"
tags: []
---
Summing it up there are quite a lot of differences between Roo an Forge,
some of them are evident on code metrics.

Code metrics

   |---
   | Project | aj | java | xml | xhtml |
   |:-:|-:|-:|-:|-:
   | JBoss Forge | 0    | 2757 | 173 | 1450 |
   | Spring Roo  | 5620 | 619  | 593 | 710  |
   |:-:|-:|-:|-:|-:|-:|-:
   | *Diff*      | 5620 | 2138 | 420 | 740  |
   
For instance, aspectj code is not to be touched by human hands and forge 
replaces almost all java code and xhtml code on regeneration. 

A few things on the gui are more pleasante on forge by default and some 
others on roo. I like the tables and finder pages by default on forge but 
creation and edition of entities with relations is nicer with autocomplete
on Roo.

Things I really do not like are Insecure Object References on Forge with
no obvious way to fix it and no calendar picker which should be obvious with
a timestamp-date field. On Roo I am missing search filters although 
pagination by default is nice.

What is impressive is the ammount of time in which a proof of concept with
three different cases is created and tested with this tools.

   |---
   | Project | aj | java | xml | xhtml | *Total* | *Total wo AJ*
   |:-:|-:|-:|-:|-:|-:|-:
   | JBoss Forge | 0    | 2757 | 173 | 1450 | 4380 | 4380
   | Spring Roo  | 5620 | 619  | 593 | 710  | 7542 | 1922
   |:-:|-:|-:|-:|-:|-:|-:
   | *Diff*      | 5620 | 2138 | 420 | 740  | Forge has -3162 | Roo has -2458
   
Removing aspectJ code roo has a big lead and it's strategy for customized
code is cleaner than Forge which I suppose is by implementing extensions.

For now I'll leave UI as is, I would like to try with another tool like 
Acceleo, XTend and Vaadin but let's continue to security.
