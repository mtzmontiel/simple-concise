package mx.rmm.simpleconcise.isis.dom.simple;

import javax.jdo.annotations.Column;
import javax.jdo.annotations.DatastoreIdentity;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Queries;
import javax.jdo.annotations.Query;

import org.apache.isis.applib.annotation.DomainObject;

@PersistenceCapable(identityType = IdentityType.DATASTORE)
@DatastoreIdentity(strategy = javax.jdo.annotations.IdGeneratorStrategy.IDENTITY, column = "server_id")
@Queries({ @Query(name = "findByName", language = "JDOQL", //
        value = "SELECT " //
                + "FROM mx.rmm.simpleconcise.isis.dom.simple.Server " //
                + "WHERE name.indexOf(:name) >= 0 ") })
@DomainObject(autoCompleteRepository = ServerRepository.class)
public class Server {
    private static final int NAME_LENGTH = 18;
    @Column(allowsNull = "false", length = NAME_LENGTH)
    private String name;

    public Server(String name) {
        setName(name);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
