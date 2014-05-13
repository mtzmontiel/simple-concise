package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Server;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Server.class, beanName = "serverBean")
public class ServerBean {
}
