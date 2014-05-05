package mx.rmm.simpleconcise.roo.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Catalogue {

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
    @Enumerated(EnumType.STRING)
    private CatalogueStatus status;
}
