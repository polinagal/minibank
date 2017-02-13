package org.polina.bank.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "ACCOUNT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Account.findAll", query = "SELECT a FROM Account a ORDER BY a.id DESC"),
    @NamedQuery(name = "Account.findById", query = "SELECT a FROM Account a WHERE a.id = :id"),
    @NamedQuery(name = "Account.findByClientId", query = "SELECT a FROM Account a WHERE a.clientId = :clientId"),
    @NamedQuery(name = "Account.findByMoney", query = "SELECT a FROM Account a WHERE a.money = :money"),
    @NamedQuery(name = "Account.findByDateStart", query = "SELECT a FROM Account a WHERE a.dateStart = :dateStart"),
    @NamedQuery(name = "Account.findByDateEnd", query = "SELECT a FROM Account a WHERE a.dateEnd = :dateEnd"),
    @NamedQuery(name = "Account.findByIsopen", query = "SELECT a FROM Account a WHERE a.isopen = :isopen")})
public class Account implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @NotNull
    @Column(name = "ID")
//    @GeneratedValue
    private Integer id;

    @NotNull
    @JoinColumn(name = "CLIENT_ID", referencedColumnName = "ID")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)

    private Client clientId;

    @NotNull
    @Column(name = "MONEY")
    private Double money;

    @NotNull
    @Column(name = "DATE_START")
    @Temporal(TemporalType.DATE)
    private Date dateStart;

    @NotNull
    @Column(name = "DATE_END")
    @Temporal(TemporalType.DATE)
    private Date dateEnd;

    @NotNull
    @Column(name = "ISOPEN")
    private Boolean isopen;

    public Account() {
    }

    public Account(Integer id) {
        this.id = id;
    }

    public Account(Integer id, Client clientId, double money, Date dateStart, Date dateEnd, Boolean isopen) {
        this.id = id;
        this.clientId = clientId;
        this.money = money;
        this.dateStart = dateStart;

        this.dateEnd = dateEnd;
        this.isopen = isopen;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Client getClientId() {
        return clientId;
    }

    public void setClientId(Client clientId) {
        this.clientId = clientId;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public Boolean isOpen() {
        return isopen;
    }

    public void setIsopen(Boolean isopen) {
        this.isopen = isopen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Account)) {
            return false;
        }
        Account other = (Account) object;
        return !((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString() {
        return String.format("%04d", this.id)
                + "\t"
                + String.format("%1$,.2f", this.getMoney());
    }
}
