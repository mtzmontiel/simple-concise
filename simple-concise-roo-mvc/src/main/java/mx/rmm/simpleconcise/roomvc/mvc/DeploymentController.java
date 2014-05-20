package mx.rmm.simpleconcise.roomvc.mvc;
import mx.rmm.simpleconcise.roomvc.model.Deployment;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/deployments")
@Controller
@RooWebScaffold(path = "deployments", formBackingObject = Deployment.class)
public class DeploymentController {
}
