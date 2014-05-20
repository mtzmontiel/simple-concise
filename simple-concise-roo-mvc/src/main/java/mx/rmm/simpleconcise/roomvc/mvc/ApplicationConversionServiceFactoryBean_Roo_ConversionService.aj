// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.mvc;

import mx.rmm.simpleconcise.roomvc.model.Artifact;
import mx.rmm.simpleconcise.roomvc.model.Catalogue;
import mx.rmm.simpleconcise.roomvc.model.Container;
import mx.rmm.simpleconcise.roomvc.model.Deployment;
import mx.rmm.simpleconcise.roomvc.model.Item;
import mx.rmm.simpleconcise.roomvc.model.Server;
import mx.rmm.simpleconcise.roomvc.mvc.ApplicationConversionServiceFactoryBean;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    public Converter<Artifact, String> ApplicationConversionServiceFactoryBean.getArtifactToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Artifact, java.lang.String>() {
            public String convert(Artifact artifact) {
                return new StringBuilder().append(artifact.getName()).toString();
            }
        };
    }
    
    public Converter<Long, Artifact> ApplicationConversionServiceFactoryBean.getIdToArtifactConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Artifact>() {
            public mx.rmm.simpleconcise.roomvc.model.Artifact convert(java.lang.Long id) {
                return Artifact.findArtifact(id);
            }
        };
    }
    
    public Converter<String, Artifact> ApplicationConversionServiceFactoryBean.getStringToArtifactConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Artifact>() {
            public mx.rmm.simpleconcise.roomvc.model.Artifact convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Artifact.class);
            }
        };
    }
    
    public Converter<Catalogue, String> ApplicationConversionServiceFactoryBean.getCatalogueToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Catalogue, java.lang.String>() {
            public String convert(Catalogue catalogue) {
                return new StringBuilder().append(catalogue.getCode()).append(' ').append(catalogue.getDescription()).toString();
            }
        };
    }
    
    public Converter<Long, Catalogue> ApplicationConversionServiceFactoryBean.getIdToCatalogueConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Catalogue>() {
            public mx.rmm.simpleconcise.roomvc.model.Catalogue convert(java.lang.Long id) {
                return Catalogue.findCatalogue(id);
            }
        };
    }
    
    public Converter<String, Catalogue> ApplicationConversionServiceFactoryBean.getStringToCatalogueConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Catalogue>() {
            public mx.rmm.simpleconcise.roomvc.model.Catalogue convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Catalogue.class);
            }
        };
    }
    
    public Converter<Container, String> ApplicationConversionServiceFactoryBean.getContainerToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Container, java.lang.String>() {
            public String convert(Container container) {
                return new StringBuilder().append(container.getCode()).append(' ').append(container.getDescription()).toString();
            }
        };
    }
    
    public Converter<Long, Container> ApplicationConversionServiceFactoryBean.getIdToContainerConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Container>() {
            public mx.rmm.simpleconcise.roomvc.model.Container convert(java.lang.Long id) {
                return Container.findContainer(id);
            }
        };
    }
    
    public Converter<String, Container> ApplicationConversionServiceFactoryBean.getStringToContainerConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Container>() {
            public mx.rmm.simpleconcise.roomvc.model.Container convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Container.class);
            }
        };
    }
    
    public Converter<Deployment, String> ApplicationConversionServiceFactoryBean.getDeploymentToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Deployment, java.lang.String>() {
            public String convert(Deployment deployment) {
                return new StringBuilder().append(deployment.getName()).append(' ').append(deployment.getSchedulledDate()).toString();
            }
        };
    }
    
    public Converter<Long, Deployment> ApplicationConversionServiceFactoryBean.getIdToDeploymentConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Deployment>() {
            public mx.rmm.simpleconcise.roomvc.model.Deployment convert(java.lang.Long id) {
                return Deployment.findDeployment(id);
            }
        };
    }
    
    public Converter<String, Deployment> ApplicationConversionServiceFactoryBean.getStringToDeploymentConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Deployment>() {
            public mx.rmm.simpleconcise.roomvc.model.Deployment convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Deployment.class);
            }
        };
    }
    
    public Converter<Item, String> ApplicationConversionServiceFactoryBean.getItemToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Item, java.lang.String>() {
            public String convert(Item item) {
                return new StringBuilder().append(item.getCode()).append(' ').append(item.getDescription()).toString();
            }
        };
    }
    
    public Converter<Long, Item> ApplicationConversionServiceFactoryBean.getIdToItemConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Item>() {
            public mx.rmm.simpleconcise.roomvc.model.Item convert(java.lang.Long id) {
                return Item.findItem(id);
            }
        };
    }
    
    public Converter<String, Item> ApplicationConversionServiceFactoryBean.getStringToItemConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Item>() {
            public mx.rmm.simpleconcise.roomvc.model.Item convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Item.class);
            }
        };
    }
    
    public Converter<Server, String> ApplicationConversionServiceFactoryBean.getServerToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<mx.rmm.simpleconcise.roomvc.model.Server, java.lang.String>() {
            public String convert(Server server) {
                return new StringBuilder().append(server.getName()).toString();
            }
        };
    }
    
    public Converter<Long, Server> ApplicationConversionServiceFactoryBean.getIdToServerConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, mx.rmm.simpleconcise.roomvc.model.Server>() {
            public mx.rmm.simpleconcise.roomvc.model.Server convert(java.lang.Long id) {
                return Server.findServer(id);
            }
        };
    }
    
    public Converter<String, Server> ApplicationConversionServiceFactoryBean.getStringToServerConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, mx.rmm.simpleconcise.roomvc.model.Server>() {
            public mx.rmm.simpleconcise.roomvc.model.Server convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Server.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getArtifactToStringConverter());
        registry.addConverter(getIdToArtifactConverter());
        registry.addConverter(getStringToArtifactConverter());
        registry.addConverter(getCatalogueToStringConverter());
        registry.addConverter(getIdToCatalogueConverter());
        registry.addConverter(getStringToCatalogueConverter());
        registry.addConverter(getContainerToStringConverter());
        registry.addConverter(getIdToContainerConverter());
        registry.addConverter(getStringToContainerConverter());
        registry.addConverter(getDeploymentToStringConverter());
        registry.addConverter(getIdToDeploymentConverter());
        registry.addConverter(getStringToDeploymentConverter());
        registry.addConverter(getItemToStringConverter());
        registry.addConverter(getIdToItemConverter());
        registry.addConverter(getStringToItemConverter());
        registry.addConverter(getServerToStringConverter());
        registry.addConverter(getIdToServerConverter());
        registry.addConverter(getStringToServerConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}
