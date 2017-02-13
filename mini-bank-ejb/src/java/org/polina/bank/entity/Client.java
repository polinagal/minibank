package org.polina.bank.entity;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "CLIENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Client.findAll", query = "SELECT c FROM Client c  ORDER BY c.id DESC")
    , @NamedQuery(name = "Client.findById", query = "SELECT c FROM Client c WHERE c.id = :id")
    , @NamedQuery(name = "Client.findByPersonId", query = "SELECT c FROM Client c WHERE c.personId = :personId")})
public class Client implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @NotNull
    @Column(name = "ID")
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @NotNull
    @JoinColumn(name = "PERSON_ID", referencedColumnName = "ID")
    @OneToOne(optional = false, fetch = FetchType.LAZY)
    private Person personId;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "")
    private List<Account> accountList;
    
    public Client() {
    }

    public Client(Integer id) {
        this.id = id;
    }

    public Client(Integer id, Person personId) {
        this.id = id;
        this.personId = personId;
       
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Person getPersonId() {
        
        return personId;
    }

    public void setPersonId(Person personId) {
        this.personId = personId;
    }

    public List<Account> getAccountList() {
        return accountList;
    }

    public void setAccountList(List<Account> accountList) {
        this.accountList = accountList;
        
    }
    
    
    public void addAccount (Account account) {
        accountList.add(account);
    }
    
    
    
    
    

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Client)) {
            return false;
        }
        Client other = (Client) object;
        return !((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString() {
        return "org.polina.bank.entities.jdb.Client[ id=" + id + " ]";
    }
    
}
