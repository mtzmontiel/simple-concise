// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;
import mx.rmm.simpleconcise.roomvc.model.Server;

privileged aspect Server_Roo_Jpa_Entity {
    
    declare @type: Server: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Server.id;
    
    @Version
    @Column(name = "version")
    private Integer Server.version;
    
    public Long Server.getId() {
        return this.id;
    }
    
    public void Server.setId(Long id) {
        this.id = id;
    }
    
    public Integer Server.getVersion() {
        return this.version;
    }
    
    public void Server.setVersion(Integer version) {
        this.version = version;
    }
    
}
