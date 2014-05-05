package mx.rmm.simpleconcise.roo.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.ManyToMany;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Container {

    /**
     */
    @NotNull
    private String code;

    /**
     */
    @NotNull
    private String description;

    /**
     */
    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "container")
    private Set<Item> items = new HashSet<Item>();
}
