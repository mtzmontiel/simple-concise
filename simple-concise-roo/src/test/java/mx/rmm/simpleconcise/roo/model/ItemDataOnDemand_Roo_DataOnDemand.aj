// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package mx.rmm.simpleconcise.roo.model;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import mx.rmm.simpleconcise.roo.model.Container;
import mx.rmm.simpleconcise.roo.model.ContainerDataOnDemand;
import mx.rmm.simpleconcise.roo.model.Item;
import mx.rmm.simpleconcise.roo.model.ItemDataOnDemand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect ItemDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ItemDataOnDemand: @Component;
    
    private Random ItemDataOnDemand.rnd = new SecureRandom();
    
    private List<Item> ItemDataOnDemand.data;
    
    @Autowired
    ContainerDataOnDemand ItemDataOnDemand.containerDataOnDemand;
    
    public Item ItemDataOnDemand.getNewTransientItem(int index) {
        Item obj = new Item();
        setCode(obj, index);
        setContainer(obj, index);
        setDescription(obj, index);
        return obj;
    }
    
    public void ItemDataOnDemand.setCode(Item obj, int index) {
        String code = "code_" + index;
        obj.setCode(code);
    }
    
    public void ItemDataOnDemand.setContainer(Item obj, int index) {
        Container container = containerDataOnDemand.getRandomContainer();
        obj.setContainer(container);
    }
    
    public void ItemDataOnDemand.setDescription(Item obj, int index) {
        String description = "description_" + index;
        obj.setDescription(description);
    }
    
    public Item ItemDataOnDemand.getSpecificItem(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Item obj = data.get(index);
        Long id = obj.getId();
        return Item.findItem(id);
    }
    
    public Item ItemDataOnDemand.getRandomItem() {
        init();
        Item obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Item.findItem(id);
    }
    
    public boolean ItemDataOnDemand.modifyItem(Item obj) {
        return false;
    }
    
    public void ItemDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Item.findItemEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Item' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Item>();
        for (int i = 0; i < 10; i++) {
            Item obj = getNewTransientItem(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
