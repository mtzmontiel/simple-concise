// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;
import mx.rmm.simpleconcise.roomvc.model.Container;

privileged aspect Container_Roo_Jpa_Entity {
    
    declare @type: Container: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Container.id;
    
    @Version
    @Column(name = "version")
    private Integer Container.version;
    
    public Long Container.getId() {
        return this.id;
    }
    
    public void Container.setId(Long id) {
        this.id = id;
    }
    
    public Integer Container.getVersion() {
        return this.version;
    }
    
    public void Container.setVersion(Integer version) {
        this.version = version;
    }
    
}