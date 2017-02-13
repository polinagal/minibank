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
    </head>
    <%@page import="javax.naming.*, org.polina.bank.session.*, org.polina.bank.entity.*" %>
    <%
        ManagerSessionBeanLocal managerSB;
        PersonSessionBeanLocal personSB;
        ClientSessionBeanLocal clientSB;
        Client client;
        Person person;
        String fname;
        String lname;
        String login;
        String password;
        Date dob;
        Person newPerson;

        try {
            InitialContext ic = new InitialContext();
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");

            person = personSB.getPersonById(Integer.parseInt(request.getParameter("clientPers")));
            client = clientSB.getClientByPersonId(person);

            if (client == null || person == null) {
                response.sendRedirect("index.jsp?&errcode=1");//
                return;
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp?&errcode=1");
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

            newPerson = new Person(person.getId(), fname, lname, login, password, dob);

            List<Person> personByLogin = personSB.findByLogin(login);
            if (personByLogin.size() >= 2) {
                response.sendRedirect("alterClient.jsp?managerPers="
                        + request.getParameter("managerPers")
                        + "&clientPers="
                        + request.getParameter("clientPers")
                        + "&errcode=2");
            } else if (personByLogin.size() == 1 && personByLogin.get(0).equals(person) || personByLogin.size()==0 ) {
                personSB.editPerson(newPerson);
                response.sendRedirect("alterClient.jsp?managerPers="
                        + request.getParameter("managerPers")
                        + "&clientPers="
                        + request.getParameter("clientPers")
                        + "&errcode=1");
            }
            else {
                response.sendRedirect("alterClient.jsp?managerPers="
                        + request.getParameter("managerPers")
                        + "&clientPers="
                        + request.getParameter("clientPers")
                        + "&errcode=2");
            }

        } catch (Exception ex) {
            response.sendRedirect("alterClient.jsp?managerPers="
                    + request.getParameter("managerPers")
                    + "&clientPers="
                    + request.getParameter("clientPers")
                    + "&errcode=3");
            return;
        }

    %>

</html>
