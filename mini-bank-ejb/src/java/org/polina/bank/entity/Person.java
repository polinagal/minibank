package org.polina.bank.entity;

import com.google.common.hash.HashCode;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "PERSON")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Person.findAll", query = "SELECT p FROM Person p ORDER BY p.id DESC"),
    @NamedQuery(name = "Person.findById", query = "SELECT p FROM Person p WHERE p.id = :id"),
    @NamedQuery(name = "Person.findByFname", query = "SELECT p FROM Person p WHERE p.fname = :fname"),
    @NamedQuery(name = "Person.findByLname", query = "SELECT p FROM Person p WHERE p.lname = :lname"),
    @NamedQuery(name = "Person.findByLogin", query = "SELECT p FROM Person p WHERE p.login = :login "),
    @NamedQuery(name = "Person.findByLoginAndPassword", query = "SELECT p FROM Person p WHERE p.login = :login AND p.password = :password"),
    @NamedQuery(name = "Person.findByPassword", query = "SELECT p FROM Person p WHERE p.password = :password"),
    @NamedQuery(name = "Person.findByDob", query = "SELECT p FROM Person p WHERE p.dob = :dob")})
public class Person implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @NotNull
    @Column(name = "ID")
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "FNAME")
    private String fname;

    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "LNAME")
    private String lname;

    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "LOGIN")
    private String login;

    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "PASSWORD")
    private String password;

    @NotNull
    @Column(name = "DOB")
    @Temporal(TemporalType.DATE)
    private Date dob;

    public Person() {
    }

    public Person(Integer id) {
        this.id = id;
    }

    public Person(Integer id, String fname, String lname, String login, String password, Date dob) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.login = login;
        this.password = password;
        this.dob = dob;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDob() {
        return dob;
    }

    public String getDateAsString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(this.dob);
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Person)) {
            return false;
        }
        Person other = (Person) object;

        return (this.login.equals(other.login) 
                && Objects.equals(this.id, other.getId()));
    }

    @Override
    public String toString() {
        return this.id + " "
                + this.fname
                + " "
                + this.lname
                + " "
                + this.dob
                + " "
                + this.login
                + " "
                + this.password;
    }

}
