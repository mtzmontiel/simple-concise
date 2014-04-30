---
title: "Forge 04"
description: "Sample Use Case - Basic UI 03 - N to M"
layout: post
up: "sampleUC-BasicUI"
previous: "forge/sampleUI-BasicUI-03"
next: "forge/sampleUI-BasicUI-04"
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


