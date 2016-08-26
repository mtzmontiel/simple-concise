package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.List;

import javax.inject.Inject;

import org.apache.isis.applib.annotation.DomainService;
import org.apache.isis.applib.annotation.NatureOfService;
import org.apache.isis.applib.query.QueryDefault;
import org.apache.isis.applib.services.registry.ServiceRegistry2;
import org.apache.isis.applib.services.repository.RepositoryService;

@DomainService(nature = NatureOfService.DOMAIN, repositoryFor = Catalogue.class)
public class CatalogueRepository {
    @Inject
    RepositoryService repositoryService;
    @Inject
    ServiceRegistry2 serviceRegistry;

    public List<Catalogue> listAll() {
        return repositoryService.allInstances(Catalogue.class);
    }

    public Catalogue create(final String code, String description) {
        final Catalogue object = new Catalogue(code);
        object.setDescription(description);
        object.setStatus(CatalogueStatus.DRAFT);
        serviceRegistry.injectServicesInto(object);
        repositoryService.persist(object);
        return object;
    }

    public List<Catalogue> findByCode(String code) {
        return repositoryService.allMatches(new QueryDefault<Catalogue>(Catalogue.class, "findByCode", "code", code));
    }

}
