package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Container;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Container.class, beanName = "containerBean")
public class ContainerBean {
}
