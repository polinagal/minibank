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
        ClientSessionBeanLocal clientSB;
        PersonSessionBeanLocal personSB;
        Client client;
        Person person;
        Double sum;
        Integer duration;
        List<Account> accounts;

        try {
            InitialContext ic = new InitialContext();
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");

            person = personSB.getPersonById(Integer.parseInt(request.getParameter("clientPers")));
            client = clientSB.getClientByPersonId(person);

        } catch (Exception ex) {
            /*String redirect = "alterClient.jsp?managerPers="
                    + request.getParameter("managerPers")
                    + "&clientPers="
                    + request.getParameter("clientPers")
                    + "&errcode=1";*/
            String redirect = "index.jsp?errcode=1";
            response.sendRedirect(redirect);
            return;
        }

        try {
            sum = Double.parseDouble(request.getParameter("amount"));
            duration = Integer.parseInt(request.getParameter("duration"));
        } catch (Exception ex) {
            String redirect = "alterClient.jsp?managerPers="
                    + request.getParameter("managerPers")
                    + "&clientPers="
                    + request.getParameter("clientPers")
                    + "&errcode=5";
            response.sendRedirect(redirect);
            return;

        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd ");
        Date dateStart = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateStart);
        cal.set(Calendar.MONTH, (cal.get(Calendar.MONTH) + duration));
        Date dateEnd = cal.getTime();

        Account account = new Account(clientSB.accountLastId() + 1, client, sum, dateStart, dateEnd, true);
        clientSB.addAccount(account, client);
        String redirect = "alterClient.jsp?managerPers="
                + request.getParameter("managerPers")
                + "&clientPers="
                + request.getParameter("clientPers") 
                + "&errcode=4";
        response.sendRedirect(redirect);


    %>
    
</html>
