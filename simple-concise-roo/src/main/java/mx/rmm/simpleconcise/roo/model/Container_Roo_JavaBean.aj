// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roo.model;

import java.util.Set;
import mx.rmm.simpleconcise.roo.model.Container;
import mx.rmm.simpleconcise.roo.model.Item;

privileged aspect Container_Roo_JavaBean {
    
    public String Container.getCode() {
        return this.code;
    }
    
    public void Container.setCode(String code) {
        this.code = code;
    }
    
    public String Container.getDescription() {
        return this.description;
    }
    
    public void Container.setDescription(String description) {
        this.description = description;
    }
    
    public Set<Item> Container.getItems() {
        return this.items;
    }
    
    public void Container.setItems(Set<Item> items) {
        this.items = items;
    }
    
}
