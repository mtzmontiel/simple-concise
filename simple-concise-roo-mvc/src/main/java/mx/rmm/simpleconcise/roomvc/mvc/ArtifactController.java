package mx.rmm.simpleconcise.roomvc.mvc;
import mx.rmm.simpleconcise.roomvc.model.Artifact;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/artifacts")
@Controller
@RooWebScaffold(path = "artifacts", formBackingObject = Artifact.class)
public class ArtifactController {
}
