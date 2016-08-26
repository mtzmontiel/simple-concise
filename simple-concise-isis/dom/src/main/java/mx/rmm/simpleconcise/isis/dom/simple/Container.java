package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.SortedSet;
import java.util.TreeSet;

import javax.inject.Inject;
import javax.jdo.annotations.Column;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Queries;
import javax.jdo.annotations.Query;

import org.apache.isis.applib.annotation.Action;
import org.apache.isis.applib.annotation.Auditing;
import org.apache.isis.applib.annotation.DomainObject;
import org.apache.isis.applib.annotation.Publishing;
import org.apache.isis.applib.annotation.SemanticsOf;
import org.apache.isis.applib.services.factory.FactoryService;
import org.apache.isis.applib.services.message.MessageService;
import org.apache.isis.applib.services.repository.RepositoryService;

@PersistenceCapable(identityType = IdentityType.DATASTORE)
@DomainObject(auditing = Auditing.ENABLED, objectType = "CONT", publishing = Publishing.ENABLED)
@Queries({ @Query(name = "findByCode", language = "JDOQL", //
        value = "SELECT " //
                + "FROM mx.rmm.simpleconcise.isis.dom.simple.Cpntainer " //
                + "WHERE code.indexOf(:code) >= 0 ") })
public class Container {

    public Container(String code) {
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

    private SortedSet<Item> items = new TreeSet<Item>();

    public SortedSet<Item> getItems() {
        return items;
    }

    public void setItems(SortedSet<Item> items) {
        this.items = items;
    }

    public Container addToItems(Item item) {
        items.add(item);
        return this;
    }

    @Action(semantics = SemanticsOf.NON_IDEMPOTENT)
    public Container addItem(String code, String description) {
        Item item = factory.instantiate(Item.class);
        item.setCode(code);
        item.setDescription(description);
        item.setContainer(this);
        if (items.contains(item)) {
            message.raiseError("Item already exists");
            return this;
        }
        addToItems(item);
        repository.persist(item);
        repository.persist(this);
        return this;
    }

    @Column(allowsNull = "false")
    private Server server;

    public Server getServer() {
        return server;
    }

    public void setServer(Server server) {
        this.server = server;
    }

    @Inject
    private FactoryService factory;
    @Inject
    private RepositoryService repository;

    @Inject
    private MessageService message;
}
