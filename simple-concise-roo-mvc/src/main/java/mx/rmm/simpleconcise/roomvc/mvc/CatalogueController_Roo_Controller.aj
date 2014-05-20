// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roomvc.mvc;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import mx.rmm.simpleconcise.roomvc.model.Catalogue;
import mx.rmm.simpleconcise.roomvc.model.CatalogueStatus;
import mx.rmm.simpleconcise.roomvc.mvc.CatalogueController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect CatalogueController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String CatalogueController.create(@Valid Catalogue catalogue, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, catalogue);
            return "catalogues/create";
        }
        uiModel.asMap().clear();
        catalogue.persist();
        return "redirect:/catalogues/" + encodeUrlPathSegment(catalogue.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String CatalogueController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Catalogue());
        return "catalogues/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String CatalogueController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("catalogue", Catalogue.findCatalogue(id));
        uiModel.addAttribute("itemId", id);
        return "catalogues/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String CatalogueController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("catalogues", Catalogue.findCatalogueEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Catalogue.countCatalogues() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("catalogues", Catalogue.findAllCatalogues(sortFieldName, sortOrder));
        }
        return "catalogues/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String CatalogueController.update(@Valid Catalogue catalogue, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, catalogue);
            return "catalogues/update";
        }
        uiModel.asMap().clear();
        catalogue.merge();
        return "redirect:/catalogues/" + encodeUrlPathSegment(catalogue.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String CatalogueController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Catalogue.findCatalogue(id));
        return "catalogues/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String CatalogueController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Catalogue catalogue = Catalogue.findCatalogue(id);
        catalogue.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/catalogues";
    }
    
    void CatalogueController.populateEditForm(Model uiModel, Catalogue catalogue) {
        uiModel.addAttribute("catalogue", catalogue);
        uiModel.addAttribute("cataloguestatuses", Arrays.asList(CatalogueStatus.values()));
    }
    
    String CatalogueController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
