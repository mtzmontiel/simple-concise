package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.List;

import javax.inject.Inject;

import org.apache.isis.applib.annotation.AutoComplete;
import org.apache.isis.applib.annotation.DomainService;
import org.apache.isis.applib.annotation.MinLength;
import org.apache.isis.applib.annotation.NatureOfService;
import org.apache.isis.applib.annotation.ParameterLayout;
import org.apache.isis.applib.query.QueryDefault;
import org.apache.isis.applib.services.registry.ServiceRegistry2;
import org.apache.isis.applib.services.repository.RepositoryService;

@DomainService(nature = NatureOfService.DOMAIN, repositoryFor = Server.class)
public class ServerRepository {
    @Inject
    RepositoryService repositoryService;
    @Inject
    ServiceRegistry2 serviceRegistry;

    public List<Server> listAll() {
        return repositoryService.allInstances(Server.class);
    }

    public Server create(final String name) {
        final Server object = new Server(name);
        serviceRegistry.injectServicesInto(object);
        repositoryService.persist(object);
        return object;
    }

    public List<Server> findByName(String name) {
        return repositoryService.allMatches(new QueryDefault<Server>(Server.class, "findByName", "name", name));
    }

    public List<Server> autoComplete(@MinLength(value = 3)String name) {
        return findByName(name);
    }

}
