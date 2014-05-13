package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Artifact;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Artifact.class, beanName = "artifactBean")
public class ArtifactBean {
}
