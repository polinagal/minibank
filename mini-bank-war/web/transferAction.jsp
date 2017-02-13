<%@page import="org.polina.bank.entity.Account"%>
<%@page import="org.polina.bank.session.ClientSessionBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
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
    <body>
        <%
            ClientSessionBeanLocal clientSB;
            InitialContext ic = new InitialContext();
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");
            Integer acc1;
            Integer acc2;
            Account account1;
            Account account2;
            Double sum;

            try {
                acc1 = Integer.parseInt(request.getParameter("account1"));
                acc2 = Integer.parseInt(request.getParameter("account2"));
                sum = Double.parseDouble(request.getParameter("sum"));
                account1 = clientSB.getAccountById(acc1);
                account2 = clientSB.getAccountById(acc2);

                if (sum <= 0) {
                    response.sendRedirect("client.jsp?clientPers=" + request.getParameter("clientPers") + "&errcode=1");
                } else if (acc1.equals(acc2)) {
                    response.sendRedirect("client.jsp?clientPers=" + request.getParameter("clientPers") + "&errcode=2");
                } else if (sum > account1.getMoney()) {
                    response.sendRedirect("client.jsp?clientPers=" + request.getParameter("clientPers") + "&errcode=3");
                } else {
                    clientSB.transferMoney(account1, account2, sum);
                    response.sendRedirect("client.jsp?clientPers=" + request.getParameter("clientPers") + "&errcode=0");
                }

            } catch (Exception e) {
                response.sendRedirect("client.jsp?clientPers=" + request.getParameter("clientPers") + "&errcode=1");
            }
        %>
    </body>
</html>
