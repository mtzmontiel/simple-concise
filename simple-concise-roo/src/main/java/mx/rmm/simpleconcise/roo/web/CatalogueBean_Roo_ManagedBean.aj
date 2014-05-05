// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roo.web;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.el.ELContext;
import javax.el.ExpressionFactory;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.component.html.HtmlOutputText;
import javax.faces.component.html.HtmlPanelGrid;
import javax.faces.context.FacesContext;
import mx.rmm.simpleconcise.roo.model.Catalogue;
import mx.rmm.simpleconcise.roo.web.CatalogueBean;
import mx.rmm.simpleconcise.roo.web.util.MessageFactory;
import org.primefaces.component.inputtext.InputText;
import org.primefaces.component.message.Message;
import org.primefaces.component.outputlabel.OutputLabel;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;

privileged aspect CatalogueBean_Roo_ManagedBean {
    
    declare @type: CatalogueBean: @ManagedBean(name = "catalogueBean");
    
    declare @type: CatalogueBean: @SessionScoped;
    
    private String CatalogueBean.name = "Catalogues";
    
    private Catalogue CatalogueBean.catalogue;
    
    private List<Catalogue> CatalogueBean.allCatalogues;
    
    private boolean CatalogueBean.dataVisible = false;
    
    private List<String> CatalogueBean.columns;
    
    private HtmlPanelGrid CatalogueBean.createPanelGrid;
    
    private HtmlPanelGrid CatalogueBean.editPanelGrid;
    
    private HtmlPanelGrid CatalogueBean.viewPanelGrid;
    
    private boolean CatalogueBean.createDialogVisible = false;
    
    @PostConstruct
    public void CatalogueBean.init() {
        columns = new ArrayList<String>();
        columns.add("code");
        columns.add("description");
    }
    
    public String CatalogueBean.getName() {
        return name;
    }
    
    public List<String> CatalogueBean.getColumns() {
        return columns;
    }
    
    public List<Catalogue> CatalogueBean.getAllCatalogues() {
        return allCatalogues;
    }
    
    public void CatalogueBean.setAllCatalogues(List<Catalogue> allCatalogues) {
        this.allCatalogues = allCatalogues;
    }
    
    public String CatalogueBean.findAllCatalogues() {
        allCatalogues = Catalogue.findAllCatalogues();
        dataVisible = !allCatalogues.isEmpty();
        return null;
    }
    
    public boolean CatalogueBean.isDataVisible() {
        return dataVisible;
    }
    
    public void CatalogueBean.setDataVisible(boolean dataVisible) {
        this.dataVisible = dataVisible;
    }
    
    public HtmlPanelGrid CatalogueBean.getCreatePanelGrid() {
        if (createPanelGrid == null) {
            createPanelGrid = populateCreatePanel();
        }
        return createPanelGrid;
    }
    
    public void CatalogueBean.setCreatePanelGrid(HtmlPanelGrid createPanelGrid) {
        this.createPanelGrid = createPanelGrid;
    }
    
    public HtmlPanelGrid CatalogueBean.getEditPanelGrid() {
        if (editPanelGrid == null) {
            editPanelGrid = populateEditPanel();
        }
        return editPanelGrid;
    }
    
    public void CatalogueBean.setEditPanelGrid(HtmlPanelGrid editPanelGrid) {
        this.editPanelGrid = editPanelGrid;
    }
    
    public HtmlPanelGrid CatalogueBean.getViewPanelGrid() {
        return populateViewPanel();
    }
    
    public void CatalogueBean.setViewPanelGrid(HtmlPanelGrid viewPanelGrid) {
        this.viewPanelGrid = viewPanelGrid;
    }
    
    public HtmlPanelGrid CatalogueBean.populateCreatePanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        javax.faces.application.Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        OutputLabel codeCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        codeCreateOutput.setFor("codeCreateInput");
        codeCreateOutput.setId("codeCreateOutput");
        codeCreateOutput.setValue("Code:");
        htmlPanelGrid.getChildren().add(codeCreateOutput);
        
        InputText codeCreateInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        codeCreateInput.setId("codeCreateInput");
        codeCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.code}", String.class));
        codeCreateInput.setRequired(true);
        htmlPanelGrid.getChildren().add(codeCreateInput);
        
        Message codeCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        codeCreateInputMessage.setId("codeCreateInputMessage");
        codeCreateInputMessage.setFor("codeCreateInput");
        codeCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(codeCreateInputMessage);
        
        OutputLabel descriptionCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        descriptionCreateOutput.setFor("descriptionCreateInput");
        descriptionCreateOutput.setId("descriptionCreateOutput");
        descriptionCreateOutput.setValue("Description:");
        htmlPanelGrid.getChildren().add(descriptionCreateOutput);
        
        InputText descriptionCreateInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        descriptionCreateInput.setId("descriptionCreateInput");
        descriptionCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.description}", String.class));
        descriptionCreateInput.setRequired(true);
        htmlPanelGrid.getChildren().add(descriptionCreateInput);
        
        Message descriptionCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        descriptionCreateInputMessage.setId("descriptionCreateInputMessage");
        descriptionCreateInputMessage.setFor("descriptionCreateInput");
        descriptionCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(descriptionCreateInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid CatalogueBean.populateEditPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        javax.faces.application.Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        OutputLabel codeEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        codeEditOutput.setFor("codeEditInput");
        codeEditOutput.setId("codeEditOutput");
        codeEditOutput.setValue("Code:");
        htmlPanelGrid.getChildren().add(codeEditOutput);
        
        InputText codeEditInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        codeEditInput.setId("codeEditInput");
        codeEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.code}", String.class));
        codeEditInput.setRequired(true);
        htmlPanelGrid.getChildren().add(codeEditInput);
        
        Message codeEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        codeEditInputMessage.setId("codeEditInputMessage");
        codeEditInputMessage.setFor("codeEditInput");
        codeEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(codeEditInputMessage);
        
        OutputLabel descriptionEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        descriptionEditOutput.setFor("descriptionEditInput");
        descriptionEditOutput.setId("descriptionEditOutput");
        descriptionEditOutput.setValue("Description:");
        htmlPanelGrid.getChildren().add(descriptionEditOutput);
        
        InputText descriptionEditInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        descriptionEditInput.setId("descriptionEditInput");
        descriptionEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.description}", String.class));
        descriptionEditInput.setRequired(true);
        htmlPanelGrid.getChildren().add(descriptionEditInput);
        
        Message descriptionEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        descriptionEditInputMessage.setId("descriptionEditInputMessage");
        descriptionEditInputMessage.setFor("descriptionEditInput");
        descriptionEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(descriptionEditInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid CatalogueBean.populateViewPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        javax.faces.application.Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        HtmlOutputText codeLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        codeLabel.setId("codeLabel");
        codeLabel.setValue("Code:");
        htmlPanelGrid.getChildren().add(codeLabel);
        
        HtmlOutputText codeValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        codeValue.setId("codeValue");
        codeValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.code}", String.class));
        htmlPanelGrid.getChildren().add(codeValue);
        
        HtmlOutputText descriptionLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        descriptionLabel.setId("descriptionLabel");
        descriptionLabel.setValue("Description:");
        htmlPanelGrid.getChildren().add(descriptionLabel);
        
        HtmlOutputText descriptionValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        descriptionValue.setId("descriptionValue");
        descriptionValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{catalogueBean.catalogue.description}", String.class));
        htmlPanelGrid.getChildren().add(descriptionValue);
        
        return htmlPanelGrid;
    }
    
    public Catalogue CatalogueBean.getCatalogue() {
        if (catalogue == null) {
            catalogue = new Catalogue();
        }
        return catalogue;
    }
    
    public void CatalogueBean.setCatalogue(Catalogue catalogue) {
        this.catalogue = catalogue;
    }
    
    public String CatalogueBean.onEdit() {
        return null;
    }
    
    public boolean CatalogueBean.isCreateDialogVisible() {
        return createDialogVisible;
    }
    
    public void CatalogueBean.setCreateDialogVisible(boolean createDialogVisible) {
        this.createDialogVisible = createDialogVisible;
    }
    
    public String CatalogueBean.displayList() {
        createDialogVisible = false;
        findAllCatalogues();
        return "catalogue";
    }
    
    public String CatalogueBean.displayCreateDialog() {
        catalogue = new Catalogue();
        createDialogVisible = true;
        return "catalogue";
    }
    
    public String CatalogueBean.persist() {
        String message = "";
        if (catalogue.getId() != null) {
            catalogue.merge();
            message = "message_successfully_updated";
        } else {
            catalogue.persist();
            message = "message_successfully_created";
        }
        RequestContext context = RequestContext.getCurrentInstance();
        context.execute("createDialogWidget.hide()");
        context.execute("editDialogWidget.hide()");
        
        FacesMessage facesMessage = MessageFactory.getMessage(message, "Catalogue");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllCatalogues();
    }
    
    public String CatalogueBean.delete() {
        catalogue.remove();
        FacesMessage facesMessage = MessageFactory.getMessage("message_successfully_deleted", "Catalogue");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllCatalogues();
    }
    
    public void CatalogueBean.reset() {
        catalogue = null;
        createDialogVisible = false;
    }
    
    public void CatalogueBean.handleDialogClose(CloseEvent event) {
        reset();
    }
    
}
