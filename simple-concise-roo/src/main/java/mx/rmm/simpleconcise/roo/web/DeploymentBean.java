package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Deployment;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Deployment.class, beanName = "deploymentBean")
public class DeploymentBean {
}
