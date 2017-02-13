package org.polina.bank.session;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.polina.bank.entity.Account;
import org.polina.bank.entity.Client;
import org.polina.bank.entity.Person;

@Stateless
public class ClientSessionBean implements ClientSessionBeanLocal {//, ClientSessionBeanRemote {

    @PersistenceContext(unitName = "bankpu")
    private EntityManager em;

    @Override
    public Client getClientByPersonId(Person personId) {
        try {
            Query q = em.createNamedQuery("Client.findByPersonId", Client.class);
            q.setParameter("personId", personId);
            Client client = (Client) q.getSingleResult();
            Query q2 = em.createNamedQuery("Account.findByClientId");
            q2.setParameter("clientId", client);
            client.setAccountList(q2.getResultList());

            return client;
        } catch (NoResultException nre) {
            return null;
        }
    }

    @Override
    public Client getClientByID(Integer id) {
        try {
            Query q = em.createNamedQuery("Client.findById", Client.class);
            q.setParameter("id", id);
            Client client = (Client) q.getSingleResult();
            Query q2 = em.createNamedQuery("Account.findByClientId");
            q2.setParameter("clientId", client);
            client.setAccountList(q2.getResultList());
            return client;

        } catch (NoResultException nre) {
            return null;
        }

    }

    @Override
    public Account getAccountById(Integer id) {
        Query q = em.createNamedQuery("Account.findById", Account.class);
        q.setParameter("id", id);
        return (Account) q.getSingleResult();
    }

    @Override
    public void transferMoney(Account from, Account to, Double amount) {
        from.setMoney(from.getMoney() - amount);
        to.setMoney(to.getMoney() + amount);
        em.merge(from);
        em.merge(to);
    }

    @Override
    public void deactivateAccount(Account account) {
        account.setIsopen(false);
        em.merge(account);
    }

    @Override
    public void activateAccount(Account account) {
        account.setIsopen(true);
        em.merge(account);
    }

    @Override
    public void addAccount(Account account, Client client) {
        client.addAccount(account);
        em.merge(client);
        em.persist(account);
    }

    @Override
    public void addClient(Client client) {
        em.persist(client);
    }

    @Override
    public void editClient(Client client) {
        em.merge(client);
    }

    @Override
    public int clientLastId() {
        Query q = em.createNamedQuery("Client.findAll");
        Client result = (Client) q.setMaxResults(1).getSingleResult();
        System.out.println("client: "
                + result.getId()
                + " "
                + result.getPersonId().getId()
                + ""
                + ""
                + ""
                + ""
                + "");
        return result.getId();
    }

    @Override
    public int accountLastId() {
        Query q = em.createNamedQuery("Account.findAll");
        Account result = (Account) q.setMaxResults(1).getSingleResult();
        System.out.println("account: "
                + result.getId()
                + " "
                + result.getClientId().getId()
                + " "
                + result.getMoney()
                + ""
                + ""
                + "");
        return result.getId();
    }
}
