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

import mx.rmm.simpleconcise.forge.model.Catalogue;
import mx.rmm.simpleconcise.forge.model.CatalogueStatus;

/**
 * Backing bean for Catalogue entities.
 * <p>
 * This class provides CRUD functionality for all Catalogue entities. It focuses
 * purely on Java EE 6 standards (e.g. <tt>&#64;ConversationScoped</tt> for
 * state management, <tt>PersistenceContext</tt> for persistence,
 * <tt>CriteriaBuilder</tt> for searches) rather than introducing a CRUD framework or
 * custom base class.
 */

@Named
@Stateful
@ConversationScoped
public class CatalogueBean implements Serializable
{

   private static final long serialVersionUID = 1L;

   /*
    * Support creating and retrieving Catalogue entities
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

   private Catalogue catalogue;

   public Catalogue getCatalogue()
   {
      return this.catalogue;
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
         this.catalogue = this.example;
      }
      else
      {
         this.catalogue = findById(getId());
      }
   }

   public Catalogue findById(java.lang.Long id)
   {

      return this.entityManager.find(Catalogue.class, id);
   }

   /*
    * Support updating and deleting Catalogue entities
    */

   public String update()
   {
      this.conversation.end();

      try
      {
         if (this.id == null)
         {
            this.entityManager.persist(this.catalogue);
            return "search?faces-redirect=true";
         }
         else
         {
            this.entityManager.merge(this.catalogue);
            return "view?faces-redirect=true&id=" + this.catalogue.getId();
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
         Catalogue deletableEntity = findById(getId());

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
    * Support searching Catalogue entities with pagination
    */

   private int page;
   private long count;
   private List<Catalogue> pageItems;

   private Catalogue example = new Catalogue();

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

   public Catalogue getExample()
   {
      return this.example;
   }

   public void setExample(Catalogue example)
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
      Root<Catalogue> root = countCriteria.from(Catalogue.class);
      countCriteria = countCriteria.select(builder.count(root)).where(
            getSearchPredicates(root));
      this.count = this.entityManager.createQuery(countCriteria)
            .getSingleResult();

      // Populate this.pageItems

      CriteriaQuery<Catalogue> criteria = builder.createQuery(Catalogue.class);
      root = criteria.from(Catalogue.class);
      TypedQuery<Catalogue> query = this.entityManager.createQuery(criteria
            .select(root).where(getSearchPredicates(root)));
      query.setFirstResult(this.page * getPageSize()).setMaxResults(
            getPageSize());
      this.pageItems = query.getResultList();
   }

   private Predicate[] getSearchPredicates(Root<Catalogue> root)
   {

      CriteriaBuilder builder = this.entityManager.getCriteriaBuilder();
      List<Predicate> predicatesList = new ArrayList<Predicate>();

      String code = this.example.getCode();
      if (code != null && !"".equals(code))
      {
         predicatesList.add(builder.like(builder.lower(root.<String> get("code")), '%' + code.toLowerCase() + '%'));
      }
      String description = this.example.getDescription();
      if (description != null && !"".equals(description))
      {
         predicatesList.add(builder.like(builder.lower(root.<String> get("description")), '%' + description.toLowerCase() + '%'));
      }
      CatalogueStatus status = this.example.getStatus();
      if (status != null)
      {
         predicatesList.add(builder.equal(root.get("status"), status));
      }

      return predicatesList.toArray(new Predicate[predicatesList.size()]);
   }

   public List<Catalogue> getPageItems()
   {
      return this.pageItems;
   }

   public long getCount()
   {
      return this.count;
   }

   /*
    * Support listing and POSTing back Catalogue entities (e.g. from inside an
    * HtmlSelectOneMenu)
    */

   public List<Catalogue> getAll()
   {

      CriteriaQuery<Catalogue> criteria = this.entityManager
            .getCriteriaBuilder().createQuery(Catalogue.class);
      return this.entityManager.createQuery(
            criteria.select(criteria.from(Catalogue.class))).getResultList();
   }

   @Resource
   private SessionContext sessionContext;

   public Converter getConverter()
   {

      final CatalogueBean ejbProxy = this.sessionContext.getBusinessObject(CatalogueBean.class);

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

            return String.valueOf(((Catalogue) value).getId());
         }
      };
   }

   /*
    * Support adding children to bidirectional, one-to-many tables
    */

   private Catalogue add = new Catalogue();

   public Catalogue getAdd()
   {
      return this.add;
   }

   public Catalogue getAdded()
   {
      Catalogue added = this.add;
      this.add = new Catalogue();
      return added;
   }
}