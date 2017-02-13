package org.polina.bank.session;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.polina.bank.entity.Manager;
import org.polina.bank.entity.Person;

@Stateless
public class ManagerSessionBean implements ManagerSessionBeanLocal {

    @PersistenceContext(unitName = "bankpu")
    private EntityManager em;

    @Override
    public Manager getManagerByPersonId(Person personId) {
        try {
            Query q = em.createNamedQuery("Manager.findByPersonId", Manager.class);
            q.setParameter("personId", personId);
            return (Manager) q.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    @Override
    public int lastId() {
        Query q = em.createNamedQuery("Manager.findAll");
        Manager result = (Manager) q.setMaxResults(1).getSingleResult();
        return result.getId();
    }
}
