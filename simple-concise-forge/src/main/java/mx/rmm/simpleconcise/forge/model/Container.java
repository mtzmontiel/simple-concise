package mx.rmm.simpleconcise.forge.model;

import javax.persistence.Entity;
import java.io.Serializable;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Version;
import java.lang.Override;
import javax.validation.constraints.NotNull;
import java.util.Set;
import java.util.HashSet;
import mx.rmm.simpleconcise.forge.model.Item;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@Entity
public class Container implements Serializable
{

   @Id
   @GeneratedValue(strategy = GenerationType.AUTO)
   @Column(name = "id", updatable = false, nullable = false)
   private Long id;
   @Version
   @Column(name = "version")
   private int version;

   @Column
   @NotNull
   private String code;

   @Column
   @NotNull
   private String description;

   @OneToMany(mappedBy = "container", cascade = CascadeType.ALL)
   private Set<Item> items = new HashSet<Item>();

   public Long getId()
   {
      return this.id;
   }

   public void setId(final Long id)
   {
      this.id = id;
   }

   public int getVersion()
   {
      return this.version;
   }

   public void setVersion(final int version)
   {
      this.version = version;
   }

   @Override
   public boolean equals(Object obj)
   {
      if (this == obj)
      {
         return true;
      }
      if (!(obj instanceof Container))
      {
         return false;
      }
      Container other = (Container) obj;
      if (id != null)
      {
         if (!id.equals(other.id))
         {
            return false;
         }
      }
      return true;
   }

   @Override
   public int hashCode()
   {
      final int prime = 31;
      int result = 1;
      result = prime * result + ((id == null) ? 0 : id.hashCode());
      return result;
   }

   public String getCode()
   {
      return code;
   }

   public void setCode(String code)
   {
      this.code = code;
   }

   public String getDescription()
   {
      return description;
   }

   public void setDescription(String description)
   {
      this.description = description;
   }

   @Override
   public String toString()
   {
      String result = getClass().getSimpleName() + " ";
      if (code != null && !code.trim().isEmpty())
         result += "code: " + code;
      if (description != null && !description.trim().isEmpty())
         result += ", description: " + description;
      return result;
   }

   public Set<Item> getItems()
   {
      return this.items;
   }

   public void setItems(final Set<Item> items)
   {
      this.items = items;
   }
}