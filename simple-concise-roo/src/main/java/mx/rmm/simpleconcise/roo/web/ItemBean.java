package mx.rmm.simpleconcise.roo.web;
import mx.rmm.simpleconcise.roo.model.Item;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = Item.class, beanName = "itemBean")
public class ItemBean {
}
