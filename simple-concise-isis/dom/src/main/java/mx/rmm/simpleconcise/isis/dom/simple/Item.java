package mx.rmm.simpleconcise.isis.dom.simple;

import javax.jdo.annotations.Column;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;

import org.apache.isis.applib.annotation.Editing;
import org.apache.isis.applib.annotation.Property;

@PersistenceCapable(identityType = IdentityType.DATASTORE)
public class Item implements Comparable<Item> {

    /**
     */
    @Column(allowsNull = "false")
    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    /**
     */
    @Column(allowsNull = "false")
    private String description;

    @Property(editing = Editing.ENABLED)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    /**
     */
    @Column(allowsNull = "false")
    private Container container;

    public Container getContainer() {
        return container;
    }

    public void setContainer(Container container) {
        this.container = container;
    }

    @Override
    public int compareTo(Item o) {
        return code.compareTo(o.code);
    }
}