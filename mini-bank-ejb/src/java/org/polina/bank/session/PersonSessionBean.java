package org.polina.bank.session;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.polina.bank.entity.Client;
import org.polina.bank.entity.Person;

@Stateless
public class PersonSessionBean implements PersonSessionBeanLocal, PersonSessionBeanRemote {

    @PersistenceContext(unitName = "bankpu")
    private EntityManager em;

    @Override
    public Person getPerson(String login, String password) {
        try {
            Query q = em.createNamedQuery("Person.findByLoginAndPassword", Person.class);
            q.setParameter("login", login);
            q.setParameter("password", password);
            return (Person) q.getSingleResult();
        } catch (NoResultException nre) {
            System.out.println("No person with such credentials");
        }
        return null;
    }

    @Override
    public Person getPersonByClientId(Client clid) {
        if (clid == null) {
            return null;
        }
        Query q = em.createNamedQuery("Person.findById", Person.class);
        q.setParameter("id", clid.getPersonId().getId());
        return (Person) q.getSingleResult();
    }

    @Override
    public Person getPersonById(Integer id) {
        Query q = em.createNamedQuery("Person.findById", Person.class);
        q.setParameter("id", id);
        return (Person) q.getSingleResult();
    }

    @Override
    public int lastId() {
        Query q = em.createNamedQuery("Person.findAll");
        Person result = (Person) q.setMaxResults(1).getSingleResult();
        System.out.println(result.getId() 
                + " "
                + result.getFname()
                + " "
                + result.getLname()
                + ""
                + ""
                + "");
        return result.getId();
    }

    @Override
    public void addPerson(Person person) {
        System.out.println("id"
                + person.getId()
                + "\nname: "
                + person.getFname()
                + "\nlname: "
                + person.getLname()
                + "\ndob"
                + person.getDob()
                + ""
                + ""
                + "");
        em.persist(person);
    }
    
    
    

    @Override
    //if entry doen't exist -> 
    public List<Person> findByLogin(String login) {
        Query q = em.createNamedQuery("Person.findByLogin");
        q.setParameter("login", login);
        
        return q.getResultList();
    }

    @Override
    public void editPerson(Person client) {
        em.merge(client);
    }
    
    

}
