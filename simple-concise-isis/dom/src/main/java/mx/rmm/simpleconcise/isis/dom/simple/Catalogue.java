package mx.rmm.simpleconcise.isis.dom.simple;

import javax.jdo.annotations.Column;
import javax.jdo.annotations.DatastoreIdentity;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Queries;
import javax.jdo.annotations.Query;

import org.apache.isis.applib.annotation.Action;
import org.apache.isis.applib.annotation.CommandReification;
import org.apache.isis.applib.annotation.DomainObject;
import org.apache.isis.applib.annotation.Editing;
import org.apache.isis.applib.annotation.Property;
import org.apache.isis.applib.annotation.Publishing;
import org.apache.isis.applib.annotation.SemanticsOf;
import org.apache.isis.applib.services.eventbus.PropertyDomainEvent;

@PersistenceCapable(identityType = IdentityType.DATASTORE)
@DatastoreIdentity(strategy = javax.jdo.annotations.IdGeneratorStrategy.IDENTITY, column = "catalogue_id")
@Queries({ @Query(name = "findByCode", language = "JDOQL", //
        value = "SELECT " //
                + "FROM mx.rmm.simpleconcise.isis.dom.simple.Catalogue " //
                + "WHERE code.indexOf(:code) >= 0 ") })
@DomainObject
public class Catalogue {
    public Catalogue(String code) {
        setCode(code);
    }

    @Column(allowsNull = "false")
    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(allowsNull = "false")
    private String description;

    public static class DescriptionDomainEvent extends PropertyDomainEvent<Catalogue, String> {
    }

    @Property(command = CommandReification.ENABLED, publishing = Publishing.ENABLED, domainEvent = DescriptionDomainEvent.class, editing = Editing.ENABLED)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(allowsNull = "false")
    private CatalogueStatus status;

    public CatalogueStatus getStatus() {
        return status;
    }

    public void setStatus(CatalogueStatus status) {
        this.status = status;
    }

    @Action(command = CommandReification.ENABLED, semantics = SemanticsOf.NON_IDEMPOTENT_ARE_YOU_SURE)
    public Catalogue publish() {
        setStatus(CatalogueStatus.PUBLISHED);
        return this;
    }

    public boolean hidePublish() {
        boolean b = CatalogueStatus.PUBLISHED.equals(status);
        System.out.println("Hide Publish: " + b);
        return b;
    }

}
