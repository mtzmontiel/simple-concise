// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roo.model;

import java.util.Date;
import mx.rmm.simpleconcise.roo.model.Artifact;
import mx.rmm.simpleconcise.roo.model.Deployment;
import mx.rmm.simpleconcise.roo.model.DeploymentStatus;
import mx.rmm.simpleconcise.roo.model.Server;

privileged aspect Deployment_Roo_JavaBean {
    
    public String Deployment.getName() {
        return this.name;
    }
    
    public void Deployment.setName(String name) {
        this.name = name;
    }
    
    public Date Deployment.getSchedulledDate() {
        return this.schedulledDate;
    }
    
    public void Deployment.setSchedulledDate(Date schedulledDate) {
        this.schedulledDate = schedulledDate;
    }
    
    public DeploymentStatus Deployment.getStatus() {
        return this.status;
    }
    
    public void Deployment.setStatus(DeploymentStatus status) {
        this.status = status;
    }
    
    public Artifact Deployment.getArtifact() {
        return this.artifact;
    }
    
    public void Deployment.setArtifact(Artifact artifact) {
        this.artifact = artifact;
    }
    
    public Server Deployment.getServer() {
        return this.server;
    }
    
    public void Deployment.setServer(Server server) {
        this.server = server;
    }
    
}
