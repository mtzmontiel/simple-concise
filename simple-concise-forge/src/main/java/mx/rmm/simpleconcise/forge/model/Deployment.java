package mx.rmm.simpleconcise.forge.model;

import javax.persistence.Entity;
import java.io.Serializable;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Version;
import java.lang.Override;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.persistence.Enumerated;
import mx.rmm.simpleconcise.forge.model.DeploymentStatus;
import javax.persistence.EnumType;
import mx.rmm.simpleconcise.forge.model.Artifact;
import javax.persistence.ManyToOne;
import mx.rmm.simpleconcise.forge.model.Server;

@Entity
public class Deployment implements Serializable
{

   @Id
   @GeneratedValue(strategy = GenerationType.AUTO)
   @Column(name = "id", updatable = false, nullable = false)
   private Long id;
   @Version
   @Column(name = "version")
   private int version;

   @Column
   @Temporal(TemporalType.TIMESTAMP)
   @NotNull
   private Date date;

   @Enumerated(EnumType.STRING)
   @NotNull
   private DeploymentStatus status;

   @ManyToOne(optional = false)
   private Server server;

   @ManyToOne(optional = false)
   private Artifact artifact;

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
      if (!(obj instanceof Deployment))
      {
         return false;
      }
      Deployment other = (Deployment) obj;
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

   public Date getDate()
   {
      return date;
   }

   public void setDate(Date date)
   {
      this.date = date;
   }

   public DeploymentStatus getStatus()
   {
      return status;
   }

   public void setStatus(DeploymentStatus status)
   {
      this.status = status;
   }

   public Server getServer()
   {
      return this.server;
   }

   public void setServer(final Server server)
   {
      this.server = server;
   }

   public Artifact getArtifact()
   {
      return this.artifact;
   }

   public void setArtifact(final Artifact artifact)
   {
      this.artifact = artifact;
   }
}