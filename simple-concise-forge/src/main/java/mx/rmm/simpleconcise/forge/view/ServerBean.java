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

import mx.rmm.simpleconcise.forge.model.Server;
import java.util.Iterator;
import mx.rmm.simpleconcise.forge.model.Deployment;

/**
 * Backing bean for Server entities.
 * <p>
 * This class provides CRUD functionality for all Server entities. It focuses
 * purely on Java EE 6 standards (e.g. <tt>&#64;ConversationScoped</tt> for
 * state management, <tt>PersistenceContext</tt> for persistence,
 * <tt>CriteriaBuilder</tt> for searches) rather than introducing a CRUD framework or
 * custom base class.
 */

@Named
@Stateful
@ConversationScoped
public class ServerBean implements Serializable
{

   private static final long serialVersionUID = 1L;

   /*
    * Support creating and retrieving Server entities
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

   private Server server;

   public Server getServer()
   {
      return this.server;
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
         this.server = this.example;
      }
      else
      {
         this.server = findById(getId());
      }
   }

   public Server findById(java.lang.Long id)
   {

      return this.entityManager.find(Server.class, id);
   }

   /*
    * Support updating and deleting Server entities
    */

   public String update()
   {
      this.conversation.end();

      try
      {
         if (this.id == null)
         {
            this.entityManager.persist(this.server);
            return "search?faces-redirect=true";
         }
         else
         {
            this.entityManager.merge(this.server);
            return "view?faces-redirect=true&id=" + this.server.getId();
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
         Server deletableEntity = findById(getId());
         Iterator<Deployment> iterDeployments = deletableEntity.getDeployments().iterator();
         for (; iterDeployments.hasNext();)
         {
            Deployment nextInDeployments = iterDeployments.next();
            nextInDeployments.setServer(null);
            iterDeployments.remove();
            this.entityManager.merge(nextInDeployments);
         }
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
    * Support searching Server entities with pagination
    */

   private int page;
   private long count;
   private List<Server> pageItems;

   private Server example = new Server();

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

   public Server getExample()
   {
      return this.example;
   }

   public void setExample(Server example)
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
      Root<Server> root = countCriteria.from(Server.class);
      countCriteria = countCriteria.select(builder.count(root)).where(
            getSearchPredicates(root));
      this.count = this.entityManager.createQuery(countCriteria)
            .getSingleResult();

      // Populate this.pageItems

      CriteriaQuery<Server> criteria = builder.createQuery(Server.class);
      root = criteria.from(Server.class);
      TypedQuery<Server> query = this.entityManager.createQuery(criteria
            .select(root).where(getSearchPredicates(root)));
      query.setFirstResult(this.page * getPageSize()).setMaxResults(
            getPageSize());
      this.pageItems = query.getResultList();
   }

   private Predicate[] getSearchPredicates(Root<Server> root)
   {

      CriteriaBuilder builder = this.entityManager.getCriteriaBuilder();
      List<Predicate> predicatesList = new ArrayList<Predicate>();

      String code = this.example.getCode();
      if (code != null && !"".equals(code))
      {
         predicatesList.add(builder.like(builder.lower(root.<String> get("code")), '%' + code.toLowerCase() + '%'));
      }

      return predicatesList.toArray(new Predicate[predicatesList.size()]);
   }

   public List<Server> getPageItems()
   {
      return this.pageItems;
   }

   public long getCount()
   {
      return this.count;
   }

   /*
    * Support listing and POSTing back Server entities (e.g. from inside an
    * HtmlSelectOneMenu)
    */

   public List<Server> getAll()
   {

      CriteriaQuery<Server> criteria = this.entityManager
            .getCriteriaBuilder().createQuery(Server.class);
      return this.entityManager.createQuery(
            criteria.select(criteria.from(Server.class))).getResultList();
   }

   @Resource
   private SessionContext sessionContext;

   public Converter getConverter()
   {

      final ServerBean ejbProxy = this.sessionContext.getBusinessObject(ServerBean.class);

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

            return String.valueOf(((Server) value).getId());
         }
      };
   }

   /*
    * Support adding children to bidirectional, one-to-many tables
    */

   private Server add = new Server();

   public Server getAdd()
   {
      return this.add;
   }

   public Server getAdded()
   {
      Server added = this.add;
      this.add = new Server();
      return added;
   }
}