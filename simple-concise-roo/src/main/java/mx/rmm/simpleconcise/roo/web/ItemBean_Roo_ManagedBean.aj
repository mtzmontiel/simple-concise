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
import mx.rmm.simpleconcise.roo.model.Container;
import mx.rmm.simpleconcise.roo.model.Item;
import mx.rmm.simpleconcise.roo.web.ItemBean;
import mx.rmm.simpleconcise.roo.web.converter.ContainerConverter;
import mx.rmm.simpleconcise.roo.web.util.MessageFactory;
import org.primefaces.component.autocomplete.AutoComplete;
import org.primefaces.component.inputtext.InputText;
import org.primefaces.component.message.Message;
import org.primefaces.component.outputlabel.OutputLabel;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;

privileged aspect ItemBean_Roo_ManagedBean {
    
    declare @type: ItemBean: @ManagedBean(name = "itemBean");
    
    declare @type: ItemBean: @SessionScoped;
    
    private String ItemBean.name = "Items";
    
    private Item ItemBean.item;
    
    private List<Item> ItemBean.allItems;
    
    private boolean ItemBean.dataVisible = false;
    
    private List<String> ItemBean.columns;
    
    private HtmlPanelGrid ItemBean.createPanelGrid;
    
    private HtmlPanelGrid ItemBean.editPanelGrid;
    
    private HtmlPanelGrid ItemBean.viewPanelGrid;
    
    private boolean ItemBean.createDialogVisible = false;
    
    @PostConstruct
    public void ItemBean.init() {
        columns = new ArrayList<String>();
        columns.add("code");
        columns.add("description");
    }
    
    public String ItemBean.getName() {
        return name;
    }
    
    public List<String> ItemBean.getColumns() {
        return columns;
    }
    
    public List<Item> ItemBean.getAllItems() {
        return allItems;
    }
    
    public void ItemBean.setAllItems(List<Item> allItems) {
        this.allItems = allItems;
    }
    
    public String ItemBean.findAllItems() {
        allItems = Item.findAllItems();
        dataVisible = !allItems.isEmpty();
        return null;
    }
    
    public boolean ItemBean.isDataVisible() {
        return dataVisible;
    }
    
    public void ItemBean.setDataVisible(boolean dataVisible) {
        this.dataVisible = dataVisible;
    }
    
    public HtmlPanelGrid ItemBean.getCreatePanelGrid() {
        if (createPanelGrid == null) {
            createPanelGrid = populateCreatePanel();
        }
        return createPanelGrid;
    }
    
    public void ItemBean.setCreatePanelGrid(HtmlPanelGrid createPanelGrid) {
        this.createPanelGrid = createPanelGrid;
    }
    
    public HtmlPanelGrid ItemBean.getEditPanelGrid() {
        if (editPanelGrid == null) {
            editPanelGrid = populateEditPanel();
        }
        return editPanelGrid;
    }
    
    public void ItemBean.setEditPanelGrid(HtmlPanelGrid editPanelGrid) {
        this.editPanelGrid = editPanelGrid;
    }
    
    public HtmlPanelGrid ItemBean.getViewPanelGrid() {
        return populateViewPanel();
    }
    
    public void ItemBean.setViewPanelGrid(HtmlPanelGrid viewPanelGrid) {
        this.viewPanelGrid = viewPanelGrid;
    }
    
    public HtmlPanelGrid ItemBean.populateCreatePanel() {
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
        codeCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.code}", String.class));
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
        descriptionCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.description}", String.class));
        descriptionCreateInput.setRequired(true);
        htmlPanelGrid.getChildren().add(descriptionCreateInput);
        
        Message descriptionCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        descriptionCreateInputMessage.setId("descriptionCreateInputMessage");
        descriptionCreateInputMessage.setFor("descriptionCreateInput");
        descriptionCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(descriptionCreateInputMessage);
        
        OutputLabel containerCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        containerCreateOutput.setFor("containerCreateInput");
        containerCreateOutput.setId("containerCreateOutput");
        containerCreateOutput.setValue("Container:");
        htmlPanelGrid.getChildren().add(containerCreateOutput);
        
        AutoComplete containerCreateInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        containerCreateInput.setId("containerCreateInput");
        containerCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.container}", Container.class));
        containerCreateInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{itemBean.completeContainer}", List.class, new Class[] { String.class }));
        containerCreateInput.setDropdown(true);
        containerCreateInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "container", String.class));
        containerCreateInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{container.code} #{container.description}", String.class));
        containerCreateInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{container}", Container.class));
        containerCreateInput.setConverter(new ContainerConverter());
        containerCreateInput.setRequired(true);
        htmlPanelGrid.getChildren().add(containerCreateInput);
        
        Message containerCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        containerCreateInputMessage.setId("containerCreateInputMessage");
        containerCreateInputMessage.setFor("containerCreateInput");
        containerCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(containerCreateInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid ItemBean.populateEditPanel() {
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
        codeEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.code}", String.class));
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
        descriptionEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.description}", String.class));
        descriptionEditInput.setRequired(true);
        htmlPanelGrid.getChildren().add(descriptionEditInput);
        
        Message descriptionEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        descriptionEditInputMessage.setId("descriptionEditInputMessage");
        descriptionEditInputMessage.setFor("descriptionEditInput");
        descriptionEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(descriptionEditInputMessage);
        
        OutputLabel containerEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        containerEditOutput.setFor("containerEditInput");
        containerEditOutput.setId("containerEditOutput");
        containerEditOutput.setValue("Container:");
        htmlPanelGrid.getChildren().add(containerEditOutput);
        
        AutoComplete containerEditInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        containerEditInput.setId("containerEditInput");
        containerEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.container}", Container.class));
        containerEditInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{itemBean.completeContainer}", List.class, new Class[] { String.class }));
        containerEditInput.setDropdown(true);
        containerEditInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "container", String.class));
        containerEditInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{container.code} #{container.description}", String.class));
        containerEditInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{container}", Container.class));
        containerEditInput.setConverter(new ContainerConverter());
        containerEditInput.setRequired(true);
        htmlPanelGrid.getChildren().add(containerEditInput);
        
        Message containerEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        containerEditInputMessage.setId("containerEditInputMessage");
        containerEditInputMessage.setFor("containerEditInput");
        containerEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(containerEditInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid ItemBean.populateViewPanel() {
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
        codeValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.code}", String.class));
        htmlPanelGrid.getChildren().add(codeValue);
        
        HtmlOutputText descriptionLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        descriptionLabel.setId("descriptionLabel");
        descriptionLabel.setValue("Description:");
        htmlPanelGrid.getChildren().add(descriptionLabel);
        
        HtmlOutputText descriptionValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        descriptionValue.setId("descriptionValue");
        descriptionValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.description}", String.class));
        htmlPanelGrid.getChildren().add(descriptionValue);
        
        HtmlOutputText containerLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        containerLabel.setId("containerLabel");
        containerLabel.setValue("Container:");
        htmlPanelGrid.getChildren().add(containerLabel);
        
        HtmlOutputText containerValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        containerValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{itemBean.item.container}", Container.class));
        containerValue.setConverter(new ContainerConverter());
        htmlPanelGrid.getChildren().add(containerValue);
        
        return htmlPanelGrid;
    }
    
    public Item ItemBean.getItem() {
        if (item == null) {
            item = new Item();
        }
        return item;
    }
    
    public void ItemBean.setItem(Item item) {
        this.item = item;
    }
    
    public List<Container> ItemBean.completeContainer(String query) {
        List<Container> suggestions = new ArrayList<Container>();
        for (Container container : Container.findAllContainers()) {
            String containerStr = String.valueOf(container.getCode() +  " "  + container.getDescription());
            if (containerStr.toLowerCase().startsWith(query.toLowerCase())) {
                suggestions.add(container);
            }
        }
        return suggestions;
    }
    
    public String ItemBean.onEdit() {
        return null;
    }
    
    public boolean ItemBean.isCreateDialogVisible() {
        return createDialogVisible;
    }
    
    public void ItemBean.setCreateDialogVisible(boolean createDialogVisible) {
        this.createDialogVisible = createDialogVisible;
    }
    
    public String ItemBean.displayList() {
        createDialogVisible = false;
        findAllItems();
        return "item";
    }
    
    public String ItemBean.displayCreateDialog() {
        item = new Item();
        createDialogVisible = true;
        return "item";
    }
    
    public String ItemBean.persist() {
        String message = "";
        if (item.getId() != null) {
            item.merge();
            message = "message_successfully_updated";
        } else {
            item.persist();
            message = "message_successfully_created";
        }
        RequestContext context = RequestContext.getCurrentInstance();
        context.execute("createDialogWidget.hide()");
        context.execute("editDialogWidget.hide()");
        
        FacesMessage facesMessage = MessageFactory.getMessage(message, "Item");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllItems();
    }
    
    public String ItemBean.delete() {
        item.remove();
        FacesMessage facesMessage = MessageFactory.getMessage("message_successfully_deleted", "Item");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllItems();
    }
    
    public void ItemBean.reset() {
        item = null;
        createDialogVisible = false;
    }
    
    public void ItemBean.handleDialogClose(CloseEvent event) {
        reset();
    }
    
}
