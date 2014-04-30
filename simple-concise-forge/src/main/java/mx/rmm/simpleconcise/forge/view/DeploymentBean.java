package mx.rmm.simpleconcise.forge.view;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.ejb.SessionContext;
import javax.ejb.Stateful;
import javax.enterprise.context.Conversation;
import javax.enterprise.context.ConversationScoped;
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import mx.rmm.simpleconcise.forge.model.Deployment;
import mx.rmm.simpleconcise.forge.model.Artifact;
import mx.rmm.simpleconcise.forge.model.DeploymentStatus;
import mx.rmm.simpleconcise.forge.model.Server;

/**
 * Backing bean for Deployment entities.
 * <p>
 * This class provides CRUD functionality for all Deployment entities. It focuses
 * purely on Java EE 6 standards (e.g. <tt>&#64;ConversationScoped</tt> for
 * state management, <tt>PersistenceContext</tt> for persistence,
 * <tt>CriteriaBuilder</tt> for searches) rather than introducing a CRUD framework or
 * custom base class.
 */

@Named
@Stateful
@ConversationScoped
public class DeploymentBean implements Serializable
{

   private static final long serialVersionUID = 1L;

   /*
    * Support creating and retrieving Deployment entities
    */

   private java.lang.Long id;

   public java.lang.Long getId()
   {
      return this.id;
   }

   public void setId(java.lang.Long id)
   {
      this.id = id;
   }

   private Deployment deployment;

   public Deployment getDeployment()
   {
      return this.deployment;
   }

   @Inject
   private Conversation conversation;

   @PersistenceContext(unitName = "simple-concise-forge-persistence-unit", type = PersistenceContextType.EXTENDED)
   private EntityManager entityManager;

   public String create()
   {

      this.conversation.begin();
      return "create?faces-redirect=true";
   }

   public void retrieve()
   {

      if (FacesContext.getCurrentInstance().isPostback())
      {
         return;
      }

      if (this.conversation.isTransient())
      {
         this.conversation.begin();
      }

      if (this.id == null)
      {
         this.deployment = this.example;
      }
      else
      {
         this.deployment = findById(getId());
      }
   }

   public Deployment findById(java.lang.Long id)
   {

      return this.entityManager.find(Deployment.class, id);
   }

   /*
    * Support updating and deleting Deployment entities
    */

   public String update()
   {
      this.conversation.end();

      try
      {
         if (this.id == null)
         {
            this.entityManager.persist(this.deployment);
            return "search?faces-redirect=true";
         }
         else
         {
            this.entityManager.merge(this.deployment);
            return "view?faces-redirect=true&id=" + this.deployment.getId();
         }
      }
      catch (Exception e)
      {
         FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(e.getMessage()));
         return null;
      }
   }

   public String delete()
   {
      this.conversation.end();

      try
      {
         Deployment deletableEntity = findById(getId());
         Artifact artifact = deletableEntity.getArtifact();
         artifact.getDeployments().remove(deletableEntity);
         deletableEntity.setArtifact(null);
         this.entityManager.merge(artifact);
         Server server = deletableEntity.getServer();
         server.getDeployments().remove(deletableEntity);
         deletableEntity.setServer(null);
         this.entityManager.merge(server);
         this.entityManager.remove(deletableEntity);
         this.entityManager.flush();
         return "search?faces-redirect=true";
      }
      catch (Exception e)
      {
         FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(e.getMessage()));
         return null;
      }
   }

   /*
    * Support searching Deployment entities with pagination
    */

   private int page;
   private long count;
   private List<Deployment> pageItems;

   private Deployment example = new Deployment();

   public int getPage()
   {
      return this.page;
   }

   public void setPage(int page)
   {
      this.page = page;
   }

   public int getPageSize()
   {
      return 10;
   }

   public Deployment getExample()
   {
      return this.example;
   }

   public void setExample(Deployment example)
   {
      this.example = example;
   }

   public void search()
   {
      this.page = 0;
   }

   public void paginate()
   {

      CriteriaBuilder builder = this.entityManager.getCriteriaBuilder();

      // Populate this.count

      CriteriaQuery<Long> countCriteria = builder.createQuery(Long.class);
      Root<Deployment> root = countCriteria.from(Deployment.class);
      countCriteria = countCriteria.select(builder.count(root)).where(
            getSearchPredicates(root));
      this.count = this.entityManager.createQuery(countCriteria)
            .getSingleResult();

      // Populate this.pageItems

      CriteriaQuery<Deployment> criteria = builder.createQuery(Deployment.class);
      root = criteria.from(Deployment.class);
      TypedQuery<Deployment> query = this.entityManager.createQuery(criteria
            .select(root).where(getSearchPredicates(root)));
      query.setFirstResult(this.page * getPageSize()).setMaxResults(
            getPageSize());
      this.pageItems = query.getResultList();
   }

   private Predicate[] getSearchPredicates(Root<Deployment> root)
   {

      CriteriaBuilder builder = this.entityManager.getCriteriaBuilder();
      List<Predicate> predicatesList = new ArrayList<Predicate>();

      DeploymentStatus status = this.example.getStatus();
      if (status != null)
      {
         predicatesList.add(builder.equal(root.get("status"), status));
      }
      Artifact artifact = this.example.getArtifact();
      if (artifact != null)
      {
         predicatesList.add(builder.equal(root.get("artifact"), artifact));
      }
      Server server = this.example.getServer();
      if (server != null)
      {
         predicatesList.add(builder.equal(root.get("server"), server));
      }

      return predicatesList.toArray(new Predicate[predicatesList.size()]);
   }

   public List<Deployment> getPageItems()
   {
      return this.pageItems;
   }

   public long getCount()
   {
      return this.count;
   }

   /*
    * Support listing and POSTing back Deployment entities (e.g. from inside an
    * HtmlSelectOneMenu)
    */

   public List<Deployment> getAll()
   {

      CriteriaQuery<Deployment> criteria = this.entityManager
            .getCriteriaBuilder().createQuery(Deployment.class);
      return this.entityManager.createQuery(
            criteria.select(criteria.from(Deployment.class))).getResultList();
   }

   @Resource
   private SessionContext sessionContext;

   public Converter getConverter()
   {

      final DeploymentBean ejbProxy = this.sessionContext.getBusinessObject(DeploymentBean.class);

      return new Converter()
      {

         @Override
         public Object getAsObject(FacesContext context,
               UIComponent component, String value)
         {

            return ejbProxy.findById(java.lang.Long.valueOf(value));
         }

         @Override
         public String getAsString(FacesContext context,
               UIComponent component, Object value)
         {

            if (value == null)
            {
               return "";
            }

            return String.valueOf(((Deployment) value).getId());
         }
      };
   }

   /*
    * Support adding children to bidirectional, one-to-many tables
    */

   private Deployment add = new Deployment();

   public Deployment getAdd()
   {
      return this.add;
   }

   public Deployment getAdded()
   {
      Deployment added = this.add;
      this.add = new Deployment();
      return added;
   }
}