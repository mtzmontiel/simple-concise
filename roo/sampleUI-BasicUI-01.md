---
title: "Roo 01"
description: "Sample Use Case - Basic UI now with Spring Roo"
layout: post
up: "sampleUC-BasicUI"
next: "roo/sampleUI-BasicUI-02"
tags: []
---
Spring roo shares some ideas with forge and differ on quite a lot, other
authors have done a better job [differencing this two tools][forgefaq]

[forgefaq]:http://forge.jboss.org/docs/using/faq.html

To kickstart let's launch Roo's command line and create a new project.


{% highlight bash %}
simple-concise-code/simple-concise-roo$ roo
    ____  ____  ____  
   / __ \/ __ \/ __ \ 
  / /_/ / / / / / / / 
 / _, _/ /_/ / /_/ /  
/_/ |_|\____/\____/    1.2.5.RELEASE [rev 8341dc2]


Welcome to Spring Roo. For assistance press TAB or type "hint" then hit ENTER.



roo> project --topLevelPackage mx.rmm.simpleconcise.roo 
Created ROOT/pom.xml
Created SRC_MAIN_RESOURCES
Created SRC_MAIN_RESOURCES/log4j.properties
Created SPRING_CONFIG_ROOT
Created SPRING_CONFIG_ROOT/applicationContext.xml

{% endhighlight %}

The second step is setup our persistence engine.

{% highlight bash %}
jpa setup --database H2_IN_MEMORY --provider HIBERNATE 
Created SPRING_CONFIG_ROOT/database.properties
Updated SPRING_CONFIG_ROOT/applicationContext.xml
Created SRC_MAIN_RESOURCES/META-INF/persistence.xml
Updated ROOT/pom.xml [added dependencies com.h2database:h2:1.3.172, org.hibernate:hibernate-core:4.2.2.Final, org.hibernate:hibernate-entitymanager:4.2.2.Final, org.hibernate.javax.persistence:hibernate-jpa-2.0-api:1.0.1.Final, commons-collections:commons-collections:3.2.1, org.hibernate:hibernate-validator:4.3.1.Final, javax.validation:validation-api:1.0.0.GA, javax.transaction:jta:1.1, org.springframework:spring-jdbc:${spring.version}, org.springframework:spring-orm:${spring.version}, commons-pool:commons-pool:1.5.6, commons-dbcp:commons-dbcp:1.4]

{% endhighlight %}

Now let's create our basic enum.

{% highlight bash %}
roo> enum type --class ~.domain.CatalogueStatus 
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/domain
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/domain/CatalogueStatus.java

~.model.Catalogue roo> enum type --class ~.model.CatalogueStatus 
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueStatus.java
~.model.CatalogueStatus roo> enum constant --name DRAFT 
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueStatus.java
~.model.CatalogueStatus roo> enum constant --name PUBLISHED
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueStatus.java
~.model.CatalogueStatus roo> enum constant --name HIDDEN
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueStatus.java

{% endhighlight %}

Now our entity, here we will see a first difference, spring roo heavily uses
aspectJ and allows us to create tests cases for our entities.

{% highlight bash %}
roo> entity jpa --class ~.model.Catalogue --testAutomatically 
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue.java
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand.java
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueIntegrationTest.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Configurable.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Jpa_Entity.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Jpa_ActiveRecord.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_ToString.aj
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand_Roo_Configurable.aj
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand_Roo_DataOnDemand.aj
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueIntegrationTest_Roo_Configurable.aj
Created SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueIntegrationTest_Roo_IntegrationTest.aj

{% endhighlight %}

Next let's add the basic fields excluding the reference to CatalogueStatus
enum for now.

{% highlight bash %}
~.model.Catalogue roo> field string --fieldName code --notNull 
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue.java
Updated SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand_Roo_DataOnDemand.aj
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Jpa_ActiveRecord.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_JavaBean.aj

~.model.Catalogue roo> field string --fieldName description --notNull 
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue.java
Updated SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand_Roo_DataOnDemand.aj
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Jpa_ActiveRecord.aj
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_JavaBean.aj

{% endhighlight %}

Next let's setup our GUI scaffold using JSF, please note that Roo uses
spring MVC by default.

{% highlight bash %}
web jsf setup
Created ROOT/src/main/webapp
Created ROOT/src/main/webapp/index.html
Created ROOT/src/main/webapp/viewExpired.xhtml
Created ROOT/src/main/webapp/resources/images
Created ROOT/src/main/webapp/resources/images/csv.png
Created ROOT/src/main/webapp/resources/images/de.png
Created ROOT/src/main/webapp/resources/images/en.png
Created ROOT/src/main/webapp/resources/images/es.png
Created ROOT/src/main/webapp/resources/images/excel.png
Created ROOT/src/main/webapp/resources/images/favicon.ico
Created ROOT/src/main/webapp/resources/images/fr.png
Created ROOT/src/main/webapp/resources/images/pdf.png
Created ROOT/src/main/webapp/resources/images/roo_logo.png
Created ROOT/src/main/webapp/resources/images/springsource-logo.png
Created ROOT/src/main/webapp/resources/images/xml.png
Created ROOT/src/main/webapp/resources/css
Created ROOT/src/main/webapp/resources/css/standard.css
Created ROOT/src/main/webapp/resources/js
Created ROOT/src/main/webapp/resources/js/calendar.js
Created ROOT/src/main/webapp/templates
Created ROOT/src/main/webapp/templates/content.xhtml
Created ROOT/src/main/webapp/templates/footer.xhtml
Created ROOT/src/main/webapp/templates/header.xhtml
Created ROOT/src/main/webapp/templates/layout.xhtml
Created ROOT/src/main/webapp/templates/menu.xhtml
Created ROOT/src/main/webapp/pages
Created ROOT/src/main/webapp/pages/main.xhtml
Updated ROOT/pom.xml [added dependencies com.sun.faces:jsf-api:2.1.2, com.sun.faces:jsf-impl:2.1.2, org.primefaces:primefaces:3.5, org.primefaces.themes:south-street:1.0.10, org.springframework:spring-web:${spring.version}, javax.el:el-api:2.2, commons-fileupload:commons-fileupload:1.2.2, commons-io:commons-io:2.1; added repositories http://download.java.net/maven/2, http://repository.primefaces.org; updated project type to war]
Created SRC_MAIN_WEBAPP/WEB-INF
Created SRC_MAIN_WEBAPP/WEB-INF/web.xml

{% endhighlight %}

Finally we generate all scaffolding.

{% highlight bash %}
roo> web jsf all --package ~.web
Created ROOT/src/main/resources/mx/rmm/simpleconcise/roo/web/i18n
Created ROOT/src/main/resources/mx/rmm/simpleconcise/roo/web/i18n/messages_de.properties
Created ROOT/src/main/resources/mx/rmm/simpleconcise/roo/web/i18n/messages_en.properties
Created ROOT/src/main/resources/mx/rmm/simpleconcise/roo/web/i18n/messages_es.properties
Created ROOT/src/main/resources/mx/rmm/simpleconcise/roo/web/i18n/messages_fr.properties
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/CatalogueBean.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/converter
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/converter/CatalogueConverter.java
Created SRC_MAIN_WEBAPP/WEB-INF/faces-config.xml
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/ApplicationBean.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/util
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/util/LocaleBean.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/util/ViewExpiredExceptionExceptionHandlerFactory.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/util/ViewExpiredExceptionExceptionHandler.java
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/util/MessageFactory.java
Created SRC_MAIN_WEBAPP/pages/catalogue.xhtml
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/converter/CatalogueConverter_Roo_Converter.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/converter/CatalogueConverter_Roo_Configurable.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/ApplicationBean_Roo_ApplicationBean.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/ApplicationBean_Roo_Configurable.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/CatalogueBean_Roo_Serializable.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/CatalogueBean_Roo_Configurable.aj
Created SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/CatalogueBean_Roo_ManagedBean.aj

{% endhighlight %}

Our landing page looks like this, with a menu on the left side and 
localization options on the bottom row.

<img src="{{site.url}}/assets/images/suc-bui-roo/001.png" />

Navigating on Catalogue/create we are prompted for the required fields.

<img src="{{site.url}}/assets/images/suc-bui-roo/002.png" />

With expected validations in place.

<img src="{{site.url}}/assets/images/suc-bui-roo/003.png" />

After succesfull creation we are redirected to the list all page.

<img src="{{site.url}}/assets/images/suc-bui-roo/004.png" />


Current metrics

~~~
.aj
  921 total
.java
 301 total
.properties
 124 total
.xhtml
  280 total
.xml
  593 total

~~~

Let's continue with our enum on the first sample.

{% highlight bash %}
roo> field enum --class ~.model.Catalogue --type ~.model.CatalogueStatus --fieldName status --enumType STRING --notNull 
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue.java
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/web/CatalogueBean_Roo_ManagedBean.aj
Updated SRC_TEST_JAVA/mx/rmm/simpleconcise/roo/model/CatalogueDataOnDemand_Roo_DataOnDemand.aj
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_Jpa_ActiveRecord.aj
Updated SRC_MAIN_JAVA/mx/rmm/simpleconcise/roo/model/Catalogue_Roo_JavaBean.aj
~.model.Catalogue roo> web jsf all --package ~.web

{% endhighlight %}

Now our creation dialog asks for the status and another difference, the 
value of status can be captured or selected

<img src="{{site.url}}/assets/images/suc-bui-roo/005.png" />

After succesfull creation we are redirected to the list all page.

<img src="{{site.url}}/assets/images/suc-bui-roo/006.png" />

Other thing we are missing are the search fields so all the results are
shown on the same table albeit paginated

