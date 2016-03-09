// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.mvc;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import mx.rmm.simpleconcise.roomvc.model.Artifact;
import mx.rmm.simpleconcise.roomvc.mvc.ArtifactController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ArtifactController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String ArtifactController.create(@Valid Artifact artifact, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, artifact);
            return "artifacts/create";
        }
        uiModel.asMap().clear();
        artifact.persist();
        return "redirect:/artifacts/" + encodeUrlPathSegment(artifact.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String ArtifactController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Artifact());
        return "artifacts/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String ArtifactController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("artifact", Artifact.findArtifact(id));
        uiModel.addAttribute("itemId", id);
        return "artifacts/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String ArtifactController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("artifacts", Artifact.findArtifactEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Artifact.countArtifacts() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("artifacts", Artifact.findAllArtifacts(sortFieldName, sortOrder));
        }
        return "artifacts/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String ArtifactController.update(@Valid Artifact artifact, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, artifact);
            return "artifacts/update";
        }
        uiModel.asMap().clear();
        artifact.merge();
        return "redirect:/artifacts/" + encodeUrlPathSegment(artifact.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String ArtifactController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Artifact.findArtifact(id));
        return "artifacts/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String ArtifactController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Artifact artifact = Artifact.findArtifact(id);
        artifact.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/artifacts";
    }
    
    void ArtifactController.populateEditForm(Model uiModel, Artifact artifact) {
        uiModel.addAttribute("artifact", artifact);
    }
    
    String ArtifactController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}