<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%@page import="javax.naming.*, org.polina.bank.session.*, org.polina.bank.entity.*" %>
    <%
        ManagerSessionBeanLocal managerSB;
        PersonSessionBeanLocal personSB;
        ClientSessionBeanLocal clientSB;
        Manager manager;
        Person person;
        String fname;
        String lname;
        String login;
        String password;
        Date dob;
        List<Account> accounts;
        Person newPerson;
        Client newClient;

        try {
            InitialContext ic = new InitialContext();
            managerSB = (ManagerSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ManagerSessionBean!org.polina.bank.session.ManagerSessionBeanLocal");
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");
        } catch (Exception e) {
            return;
        }
        try {
            fname = request.getParameter("fname");
            lname = request.getParameter("lname");
            login = request.getParameter("login");
            password = request.getParameter("password");

            String dateStr = request.getParameter("dob");
            SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
            dob = formater.parse(dateStr);

            System.out.println(fname);
            System.out.println(lname);
            System.out.println(login);
            System.out.println(password);
            System.out.println(dob);

            System.out.println(Index.personIndex);

            newPerson = new Person(personSB.lastId() + 1, fname, lname, login, password, dob);
            newClient = new Client(clientSB.clientLastId() + 1, newPerson);

            if (personSB.findByLogin(login).size() == 0) {
                personSB.addPerson(newPerson);
                clientSB.addClient(newClient);
                response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=1");
            } else {
                response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=2");
            }

        } catch (Exception ex) {
            response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=3");
            return;
        }

    %>
</html>
