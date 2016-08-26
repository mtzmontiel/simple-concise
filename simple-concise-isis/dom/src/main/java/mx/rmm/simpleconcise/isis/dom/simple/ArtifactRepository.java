package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.List;

import javax.inject.Inject;

import org.apache.isis.applib.annotation.DomainService;
import org.apache.isis.applib.annotation.NatureOfService;
import org.apache.isis.applib.query.QueryDefault;
import org.apache.isis.applib.services.registry.ServiceRegistry2;
import org.apache.isis.applib.services.repository.RepositoryService;

@DomainService(nature = NatureOfService.DOMAIN, repositoryFor = Artifact.class)
public class ArtifactRepository {

    public List<Artifact> listAll() {
        return repositoryService.allInstances(Artifact.class);
    }

    @Inject
    RepositoryService repositoryService;
    @Inject
    ServiceRegistry2 serviceRegistry;

    public List<Artifact> findByName(String name) {
        return repositoryService.allMatches(new QueryDefault<Artifact>(Artifact.class, "findByName", "name", name));
    }

    public Artifact create(final String name) {
        final Artifact object = new Artifact(name);
        serviceRegistry.injectServicesInto(object);
        repositoryService.persist(object);
        return object;
    }
}
