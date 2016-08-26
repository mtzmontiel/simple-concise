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
import org.apache.isis.applib.annotation.ParameterLayout;
import org.apache.isis.applib.annotation.Property;
import org.apache.isis.applib.annotation.Publishing;
import org.apache.isis.applib.annotation.SemanticsOf;
import org.apache.isis.applib.services.eventbus.ActionDomainEvent;

@PersistenceCapable(identityType = IdentityType.DATASTORE)
@DatastoreIdentity(strategy = javax.jdo.annotations.IdGeneratorStrategy.IDENTITY, column = "artifact_id")
@Queries({ @Query(name = "findByName", language = "JDOQL", //
        value = "SELECT " //
                + "FROM mx.rmm.simpleconcise.isis.dom.simple.Artifact " //
                + "WHERE name.indexOf(:name) >= 0 ") })
@DomainObject
public class Artifact {
    private static final int NAME_LENGTH = 18;
    @Column(allowsNull = "false", length = NAME_LENGTH)
    private String name;

    public Artifact(String name) {
        setName(name);
    }

    public String getName() {
        return name;
    }

    @Property(editing = Editing.DISABLED)
    public void setName(String name) {
        this.name = name;
    }

    public static class UpdateNameDomainEvent extends ActionDomainEvent<Artifact> {
    }

    @Action(command = CommandReification.ENABLED, publishing = Publishing.ENABLED, semantics = SemanticsOf.IDEMPOTENT, domainEvent = UpdateNameDomainEvent.class)
    public Artifact updateName(@ParameterLayout(named = "Name") final String name) {
        setName(name);
        return this;
    }
}
