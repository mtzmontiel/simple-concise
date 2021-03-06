// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.model;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.rmm.simpleconcise.roomvc.model.Catalogue;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Catalogue_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Catalogue.entityManager;
    
    public static final List<String> Catalogue.fieldNames4OrderClauseFilter = java.util.Arrays.asList("code", "description", "status");
    
    public static final EntityManager Catalogue.entityManager() {
        EntityManager em = new Catalogue().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Catalogue.countCatalogues() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Catalogue o", Long.class).getSingleResult();
    }
    
    public static List<Catalogue> Catalogue.findAllCatalogues() {
        return entityManager().createQuery("SELECT o FROM Catalogue o", Catalogue.class).getResultList();
    }
    
    public static List<Catalogue> Catalogue.findAllCatalogues(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Catalogue o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Catalogue.class).getResultList();
    }
    
    public static Catalogue Catalogue.findCatalogue(Long id) {
        if (id == null) return null;
        return entityManager().find(Catalogue.class, id);
    }
    
    public static List<Catalogue> Catalogue.findCatalogueEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Catalogue o", Catalogue.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<Catalogue> Catalogue.findCatalogueEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Catalogue o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Catalogue.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Catalogue.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Catalogue.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Catalogue attached = Catalogue.findCatalogue(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Catalogue.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Catalogue.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Catalogue Catalogue.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Catalogue merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
