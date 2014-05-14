---
title: "Forge 04"
description: "Sample Use Case - Basic UI 03 - N to M"
layout: post
up: "subaui/sampleUC-BasicUI"
previous: "subaui/forge/sampleUI-BasicUI-03"
next: "subaui/forge/sampleUI-BasicUI-05"
tags: []
---

Lets create our base entities for this example

~~~
[simple-concise-forge]$ java-new-enum --named DeploymentStatus \
  --targetPackage mx.rmm.simpleconcise.forge.model 
***SUCCESS*** Enum mx.rmm.simpleconcise.forge.model.DeploymentStatus was created
[DeploymentStatus.java]$ java-new-enum-const SCHEDULLED  
[DeploymentStatus.java]$ java-new-enum-const DEPLOYED  
[DeploymentStatus.java]$ java-new-enum-const REMOVED 
[DeploymentStatus.java]$ java-new-enum-const CANCELED
[DeploymentStatus.java]$ jpa-new-entity --named Artifact
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Artifact created
[Artifact.java]$ jpa-new-field --named code
***SUCCESS*** Field code created
[Artifact.java]$ constraint-add --onProperty code --constraint NotNull 
***SUCCESS*** Constraint NotNull successfully configured
[Artifact.java]$ jpa-new-entity --named Server  
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Server created
[Server.java]$ jpa-new-field --named code
***SUCCESS*** Field code created
[Server.java]$ constraint-add --onProperty code --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Server.java]$ jpa-new-entity --named Deployment
***SUCCESS*** Entity mx.rmm.simpleconcise.forge.model.Deployment created
[Deployment.java]$ jpa-new-field --named date --type java.util.Date \
  --temporalType TIMESTAMP 
***SUCCESS*** Field date created
[Deployment.java]$ constraint-add --onProperty date --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured
[Deployment.java]$ jpa-new-field --named status \
  --type mx.rmm.simpleconcise.forge.model.DeploymentStatus \
  --enumType STRING   
***SUCCESS*** Field status created
[Deployment.java]$ constraint-add --onProperty status --constraint NotNull
***SUCCESS*** Constraint NotNull successfully configured

~~~

Now the hairy part, N-to-M via Deployment

~~~
[Deployment.java]$ jpa-new-field --named artifact \
  --type mx.rmm.simpleconcise.forge.model.Artifact \
  --relationshipType Many-to-One --inverseFieldName deployments \
  --required --fetchType EAGER 
***SUCCESS*** Relationship Many-to-One created
[Deployment.java]$ jpa-new-field --named server \
  --type mx.rmm.simpleconcise.forge.model.Server \
  --relationshipType Many-to-One --inverseFieldName deployments \
  --required --fetchType EAGER
***SUCCESS*** Relationship Many-to-One created
[Deployment.java]$ scaffold-generate --overwrite \
  --targets mx.rmm.simpleconcise.forge.model.Artifact \
  mx.rmm.simpleconcise.forge.model.Deployment \
  mx.rmm.simpleconcise.forge.model.Server 
***SUCCESS*** Scaffold was generated successfully.

~~~


Current metrics

~~~
.java
 2808 total
.xhtml
 1650 total
.xml
 173 total

~~~

Our menu has the new Entities

<img src="{{site.url}}/assets/images/suc-bui-forge/028.png" />

And the gui for Artifact reflects the 1-N relation with
deployment

<img src="{{site.url}}/assets/images/suc-bui-forge/029.png" />

So let's add a new Artifact

<img src="{{site.url}}/assets/images/suc-bui-forge/030.png" />

And now we begin to see where the problems might be hiding

<img src="{{site.url}}/assets/images/suc-bui-forge/031.png" />

The same story with Server

<img src="{{site.url}}/assets/images/suc-bui-forge/032.png" />

And the timestamp format is not obvious at first sight, a date
time picker should be a better option

<img src="{{site.url}}/assets/images/suc-bui-forge/033.png" />

For now I'll copy paste the sugested format

<img src="{{site.url}}/assets/images/suc-bui-forge/034.png" />

On the Server homepage we can see the new server that we just 
added

<img src="{{site.url}}/assets/images/suc-bui-forge/035.png" />

Now on Artifact we register a new item, capturing a timestamp 
with the expected format

<img src="{{site.url}}/assets/images/suc-bui-forge/036.png" />

Now we have both ends of the N-M relation

<img src="{{site.url}}/assets/images/suc-bui-forge/037.png" />

But on the detail page of artifact there is no relation between 
Artifact and Deployment. What happened?

<img src="{{site.url}}/assets/images/suc-bui-forge/038.png" />

The gui asked for valid inputs for the relation but we never 
idicated to add said relation. Remember the (+) button? Let's 
add one deployment.

<img src="{{site.url}}/assets/images/suc-bui-forge/039.png" />

On pressing save, we get the old alert of Not Null on thate 
even if we do not want to add another deployment.

<img src="{{site.url}}/assets/images/suc-bui-forge/040.png" />

Capturing a timestamp and pressing save we can see that the
fist deployment was created and the one that prompted us to
capture a timestamp was not.

<img src="{{site.url}}/assets/images/suc-bui-forge/041.png" />

On the Deployment homepage we see that only one deployment is 
registered

<img src="{{site.url}}/assets/images/suc-bui-forge/042.png" />

Adding a new deployment is easier from here

<img src="{{site.url}}/assets/images/suc-bui-forge/043.png" />

The results are reflected inmediately on the deployment homepage

<img src="{{site.url}}/assets/images/suc-bui-forge/044.png" />

The detail page of Deployment allows to navigate between both related entities

<img src="{{site.url}}/assets/images/suc-bui-forge/045.png" />

On server we see both deployments now

<img src="{{site.url}}/assets/images/suc-bui-forge/046.png" />

To continue let's find out what went wrong and fix it

You can find source code [here][code-forge-buc-bui-1.3]

[code-forge-buc-bui-1.3]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-forge-buc-bui-1.3

