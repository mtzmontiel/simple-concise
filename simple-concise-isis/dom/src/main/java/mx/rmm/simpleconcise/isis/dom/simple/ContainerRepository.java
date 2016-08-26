package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.List;

import javax.inject.Inject;

import org.apache.isis.applib.annotation.DomainService;
import org.apache.isis.applib.annotation.NatureOfService;
import org.apache.isis.applib.query.QueryDefault;
import org.apache.isis.applib.services.registry.ServiceRegistry2;
import org.apache.isis.applib.services.repository.RepositoryService;

@DomainService(nature = NatureOfService.DOMAIN, repositoryFor = Container.class)
public class ContainerRepository {
    @Inject
    RepositoryService repositoryService;
    @Inject
    ServiceRegistry2 serviceRegistry;

    public List<Container> listAll() {
        return repositoryService.allInstances(Container.class);
    }

    public Container create(final String code, Server server) {
        final Container object = new Container(code);
        object.setServer(server);
        serviceRegistry.injectServicesInto(object);
        repositoryService.persist(object);
        return object;
    }

    public List<Container> findByCode(String code) {
        return repositoryService.allMatches(new QueryDefault<Container>(Container.class, "findByCode", "code", code));
    }

}
