package org.polina.bank.session;

import java.util.List;
import javax.ejb.Local;
import org.polina.bank.entity.Client;
import org.polina.bank.entity.Person;

@Local
public interface PersonSessionBeanLocal {
    Person getPerson(String login, String password);

    Person getPersonByClientId(Client clid);

    Person getPersonById(Integer id);

    int lastId();

    void addPerson(Person person);

    List<Person> findByLogin(String login);

    void editPerson(Person client);
}
