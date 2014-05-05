package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Catalogue;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Catalogue.class, beanName = "catalogueBean")
public class CatalogueBean {
}
