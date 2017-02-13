package org.polina.bank.session;

import javax.ejb.Local;
import org.polina.bank.entity.Manager;
import org.polina.bank.entity.Person;

@Local
public interface ManagerSessionBeanLocal {

    Manager  getManagerByPersonId(Person personid);

    int lastId();
    
}
