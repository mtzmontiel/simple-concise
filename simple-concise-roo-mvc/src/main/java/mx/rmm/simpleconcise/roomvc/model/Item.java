package mx.rmm.simpleconcise.roomvc.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.persistence.ManyToOne;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Item {

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
    @NotNull
    @ManyToOne
    private Container container;
}
