package mx.rmm.simpleconcise.roomvc.mvc;
import mx.rmm.simpleconcise.roomvc.model.Container;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/containers")
@Controller
@RooWebScaffold(path = "containers", formBackingObject = Container.class)
public class ContainerController {
}
