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
        Double sum;
        Account account;

        try {
            InitialContext ic = new InitialContext();
            managerSB = (ManagerSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ManagerSessionBean!org.polina.bank.session.ManagerSessionBeanLocal");
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");

            System.out.println(request.getParameter("managerPers"));
            person = personSB.getPersonById(Integer.parseInt(request.getParameter("managerPers")));
           // manager = managerSB.getManagerByPersonId(person);
            account = clientSB.getAccountById(Integer.parseInt(request.getParameter("account1")));
//            if (manager == null || person == null) {
//                response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers" + "&errcode=1"));
//
//                return;
//            }

        } catch (Exception e) {
            response.sendRedirect("index.jsp");
            return;
        }
        clientSB.activateAccount(account);
        
        String redirect = "alterClient.jsp?managerPers="
                + request.getParameter("managerPers")
                + "&clientPers="
                + request.getParameter("clientPers");
        System.out.println(redirect);
        response.sendRedirect(redirect);
    %>
</html>