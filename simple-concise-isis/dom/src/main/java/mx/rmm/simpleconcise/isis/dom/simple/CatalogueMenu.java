package mx.rmm.simpleconcise.isis.dom.simple;

import java.util.List;

import org.apache.isis.applib.annotation.Action;
import org.apache.isis.applib.annotation.ActionLayout;
import org.apache.isis.applib.annotation.BookmarkPolicy;
import org.apache.isis.applib.annotation.DomainService;
import org.apache.isis.applib.annotation.DomainServiceLayout;
import org.apache.isis.applib.annotation.MemberOrder;
import org.apache.isis.applib.annotation.NatureOfService;
import org.apache.isis.applib.annotation.ParameterLayout;
import org.apache.isis.applib.annotation.SemanticsOf;
import org.apache.isis.applib.services.eventbus.ActionDomainEvent;

@DomainService(nature = NatureOfService.VIEW_MENU_ONLY, repositoryFor = Catalogue.class)
@DomainServiceLayout(named = "Catalogue", menuOrder = "10")
public class CatalogueMenu {
    @Action(semantics = SemanticsOf.SAFE)
    @ActionLayout(bookmarking = BookmarkPolicy.AS_ROOT)
    @MemberOrder(sequence = "1")
    public List<Catalogue> listAll() {
        return CatalogueRepository.listAll();
    }

    @Action(semantics = SemanticsOf.SAFE)
    @ActionLayout(bookmarking = BookmarkPolicy.AS_ROOT)
    @MemberOrder(sequence = "2")
    public List<Catalogue> findByCode(@ParameterLayout(named = "Code") final String code) {
        return CatalogueRepository.findByCode(code);
    }

    public static class CreateDomainEvent extends ActionDomainEvent<Catalogue> {
    }

    @Action(domainEvent = CreateDomainEvent.class)
    @MemberOrder(sequence = "3")
    public Catalogue create(@ParameterLayout(named = "Code") final String code,
            @ParameterLayout(named = "Description") final String description) {
        return CatalogueRepository.create(code, description);
    }

    @javax.inject.Inject
    CatalogueRepository CatalogueRepository;
}
