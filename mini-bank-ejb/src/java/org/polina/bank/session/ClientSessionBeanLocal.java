package org.polina.bank.session;

import javax.ejb.Local;
import org.polina.bank.entity.Account;
import org.polina.bank.entity.Client;
import org.polina.bank.entity.Person;

@Local
public interface ClientSessionBeanLocal {

    Client getClientByPersonId(Person personId);

    Client getClientByID(Integer id);

    Account getAccountById(Integer id);

    void transferMoney(Account from, Account to, Double amount);

    void deactivateAccount(Account account);

    void addAccount(Account account, Client client);

    void addClient(Client client);

    int clientLastId();

    int accountLastId();

    void activateAccount(Account account);

    void editClient(Client client);

}
