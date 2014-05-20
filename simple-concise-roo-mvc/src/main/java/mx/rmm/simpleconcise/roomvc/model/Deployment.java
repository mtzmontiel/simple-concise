package mx.rmm.simpleconcise.roomvc.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import javax.persistence.Enumerated;
import javax.persistence.ManyToOne;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Deployment {

    /**
     */
    @NotNull
    private String name;

    /**
     */
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date schedulledDate;

    /**
     */
    @NotNull
    @Enumerated
    private DeploymentStatus status;

    /**
     */
    @NotNull
    @ManyToOne
    private Artifact artifact;

    /**
     */
    @NotNull
    @ManyToOne
    private Server server;
}
