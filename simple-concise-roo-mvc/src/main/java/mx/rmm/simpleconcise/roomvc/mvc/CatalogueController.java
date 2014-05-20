package mx.rmm.simpleconcise.roomvc.mvc;
import mx.rmm.simpleconcise.roomvc.model.Catalogue;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/catalogues")
@Controller
@RooWebScaffold(path = "catalogues", formBackingObject = Catalogue.class)
public class CatalogueController {
}
