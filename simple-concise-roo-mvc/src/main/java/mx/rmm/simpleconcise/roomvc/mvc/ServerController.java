package mx.rmm.simpleconcise.roomvc.mvc;
import mx.rmm.simpleconcise.roomvc.model.Server;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/servers")
@Controller
@RooWebScaffold(path = "servers", formBackingObject = Server.class)
public class ServerController {
}
