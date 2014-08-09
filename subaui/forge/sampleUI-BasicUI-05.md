---
title: "Forge 05 - Sample Use Case - Basic UI 03 - N to M - Fixing it"
description: "Sample Use Case - Basic UI 03 - N to M - Fixing it"
layout: post
up: "subaui/sampleUC-BasicUI"
previous: "subaui/forge/sampleUI-BasicUI-04"
next: "subaui/roo/sampleUI-BasicUI-01"
tags: []
---

What went wrong, first of all the forge is not prepared to be 
used on a N-M relation whith a join class that has attributes.
That was abusive from me but it is not a rare case. So how can we fix this?

If we look into the source code of the create page of Artifact we see standard jsf-facelets code. But let's concentratejust on the section dealing with deployments.

{% highlight html %}
<h:dataTable id="artifactBeanArtifactDeployments"
 styleClass="data-table"
 value="#{forgeview:asList(_collection)}" var="_item">
<h:column>
	<f:facet name="header">
		<h:outputText value="Date"/>
	</f:facet>
	<h:link outcome="/deployment/view">
		<f:param name="id" value="#{_item.id}"/>
		<h:outputText id="itemDate" value="#{_item.date}">
			<f:convertDateTime
			 pattern="MMM d, yyyy hh:mm:ss a" type="both"/>
		</h:outputText>
	</h:link>
	<f:facet name="footer">
		<h:inputText id="deploymentBeanAddDate"
		 value="#{deploymentBean.add.date}">
			<f:convertDateTime
			 pattern="MMM d, yyyy hh:mm:ss a" type="both"/>
		</h:inputText>
		<h:message for="deploymentBeanAddDate"
		 styleClass="error"/>
	</f:facet>
</h:column>
... more code ...
<h:column>
	<f:facet name="header">
		<h:outputText value="Server"/>
	</f:facet>
	<h:link outcome="/deployment/view">
		<f:param name="id" value="#{_item.id}"/>
		<h:outputText id="forgeviewdisplayitemServer"
		 value="#{forgeview:display(_item.server)}"/>
	</h:link>
	<f:facet name="footer">
		<h:selectOneMenu converter="#{serverBean.converter}"
		 id="deploymentBeanAddServer"
		 value="#{deploymentBean.add.server}">
			<f:selectItems
			 itemLabel="#{forgeview:display(_item)}"
			 itemValue="#{_item}" value="#{serverBean.all}"
			 var="_item"/>
		</h:selectOneMenu>
		<h:message for="deploymentBeanAddServer"
		 styleClass="error"/>
	</f:facet>
</h:column>
<h:column footerClass="remove-column" 
  headerClass="remove-column">
	<h:commandLink action="#{_collection.remove(_item)}"
	  styleClass="remove-button"/>
	<f:facet name="footer">
		<h:commandLink 
		action="#{_collection.add(deploymentBean.added)}" 
		  id="artifactBeanArtifactDeploymentsAdd"
		  styleClass="add-button">
			<f:setPropertyActionListener 
			  target="#{deploymentBean.add.artifact}" 
			  value="#{artifactBean.artifact}"/>
		</h:commandLink>
	</f:facet>
</h:column>
</h:dataTable>
{% endhighlight %}

Here we see a couple of ugly things hardcoded, time stamp patterns and almost all h:outputText. Still there is no referenca to validation logic but this block references the Scaffolding Bean that handles Deployment entity.

Looking at the source code of artifact, the field referencing deployments has no strange things.

{% highlight java %}
@OneToMany(mappedBy = "artifact", cascade = CascadeType.ALL)
   private Set<Deployment> deployments = new HashSet<Deployment>();
{% endhighlight %}

Same story with the fields on Deployment

{% highlight java %}
@Column
@Temporal(TemporalType.TIMESTAMP)
@NotNull
private Date date;

@Enumerated(EnumType.STRING)
@NotNull
private DeploymentStatus status;

@ManyToOne(optional = false)
private Artifact artifact;

@ManyToOne(optional = false)
private Server server;
{% endhighlight %}

If we take a look on the Bean controlling Artifact still there is no specific logic about the validations that impide normal UI usage.

{% highlight java %}
public String update()
{
  this.conversation.end();

  try
  {
     if (this.id == null)
     {
        this.entityManager.persist(this.artifact);
        return "search?faces-redirect=true";
     }
     else
     {
        this.entityManager.merge(this.artifact);
        return "view?faces-redirect=true&id=" + this.artifact.getId();
     }
  }
  catch (Exception e)
  {
     FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(e.getMessage()));
     return null;
  }
}

{% endhighlight %}

On deployment controller the code is the same, duplicated in fact.

{% highlight java %}
public String update()
{
  this.conversation.end();

  try
  {
     if (this.id == null)
     {
        this.entityManager.persist(this.deployment);
        return "search?faces-redirect=true";
     }
     else
     {
        this.entityManager.merge(this.deployment);
        return "view?faces-redirect=true&id=" + this.deployment.getId();
     }
  }
  catch (Exception e)
  {
     FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(e.getMessage()));
     return null;
  }
}
{% endhighlight %}

And with that a few other troublesome things become apparent. Did you see the Insecure Direct Object reference exposed?

{% highlight java %}
return "view?faces-redirect=true&id=" 
  + this.deployment.getId();
{% endhighlight %}

We'll skip that for now and treat it on Security. 

What is constraining our GUI is Validation API that is chained on JSF lifecycle so there is no easy way to fix it but there are workarounds.

The server log shows what happened with the interaction with RDBMS

~~~
10:53:04,045 INFO  [stdout]  Hibernate: 
10:53:04,046 INFO  [stdout]      call next value for hibernate_sequence
10:53:04,048 INFO  [stdout]  Hibernate: 
10:53:04,049 INFO  [stdout]      call next value for hibernate_sequence
10:53:04,051 INFO  [stdout]  Hibernate: 
10:53:04,052 INFO  [stdout]      insert 
10:53:04,052 INFO  [stdout]      into
10:53:04,053 INFO  [stdout]          Artifact
10:53:04,053 INFO  [stdout]          (code, version, id) 
10:53:04,053 INFO  [stdout]      values
10:53:04,054 INFO  [stdout]          (?, ?, ?)
10:53:04,056 INFO  [stdout]  Hibernate: 
10:53:04,057 INFO  [stdout]      insert 
10:53:04,057 INFO  [stdout]      into
10:53:04,057 INFO  [stdout]          Deployment
10:53:04,058 INFO  [stdout]          (artifact_id, date, server_id, status, version, id) 
10:53:04,058 INFO  [stdout]      values
10:53:04,059 INFO  [stdout]          (?, ?, ?, ?, ?, ?)
~~~

With this in mind we can split interaction in two steps, creating leaf sides of the N-M relation and then joining them on the Deployment side.

Let's update our model to reflect this, first removing existing methods and properties and then creating again without inverse name.

{% highlight bash %}

[simple-concise-forge]$ cd src/main/java/mx/rmm/simpleconcise/forge/model/Artifact.java
[Artifact.java]$ rm deployments
[Artifact.java]$ rm setDeployments
[Artifact.java]$ rm getDeployments
[Artifact.java]$ cd .. 
[model]$ cd Server.java
[Server.java]$ rm deployments
[Server.java]$ rm setDeployments
[Server.java]$ rm getDeployments
[Server.java]$ cd ..
[model]$ cd Deployment.java
[Deployment.java]$ rm server
[Deployment.java]$ rm setServer
[Deployment.java]$ rm getServer
[Deployment.java]$ rm artifact
[Deployment.java]$ rm setArtifact
[Deployment.java]$ rm getArtifact
[Deployment.java]$ jpa-new-field --named server \
  --type mx.rmm.simpleconcise.forge.model.Server \
  --relationshipType Many-to-One  --required \
  --fetchType EAGER                                                 ***SUCCESS*** Relationship Many-to-One created
[Deployment.java]$ jpa-new-field --named artifact \
  --type mx.rmm.simpleconcise.forge.model.Artifact \
  --relationshipType Many-to-One  --required \
  --fetchType EAGER
***SUCCESS*** Relationship Many-to-One created
[Deployment.java]$ scaffold-generate --overwrite --targets \
  mx.rmm.simpleconcise.forge.model.Artifact \
  mx.rmm.simpleconcise.forge.model.Deployment \
  mx.rmm.simpleconcise.forge.model.Server                    ***SUCCESS*** Scaffold was generated successfully.

{% endhighlight %}

Now our interface does not allow to create relations from Artifact and server

<img src="{{site.url}}/assets/images/suc-bui-forge/047.png" />

But on deployment it is required

<img src="{{site.url}}/assets/images/suc-bui-forge/048.png" />

And we can register deployments as needed.

<img src="{{site.url}}/assets/images/suc-bui-forge/049.png" />

Please note that this is a work around and can possibly lead to errors if we have complex relations between various entities.

All of this solves our initial requirements except for the timestamp which we'll look into later, lots of duplicated code and a security vulnerability, right?

Wrong, we are still missing the statemachine flows.

We'll continue with another tool trying to solve the same scenarios

Current code metrics

~~~
.java
 2757 total
.xml
 173 total
.xhtml
 1450 total

~~~

You can find source code [here][code-forge-buc-bui-1.4]

[code-forge-buc-bui-1.4]:https://github.com/mtzmontiel/simple-concise/releases/tag/code-forge-buc-bui-1.4
