<%@page import="java.time.LocalDate"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Клиент</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="css/tabs.css">
        <link rel="stylesheet" href="css/main.css">
    </head>
    <%@page import="javax.naming.*, org.polina.bank.session.*, org.polina.bank.entity.*" %>
    <%
        try {
            int errcode = Integer.parseInt(request.getParameter("errcode"));
            switch (errcode) {
                case 0:
    %>
    <script>
        window.alert("Перевод осуществлен!");
        window.location("client.jsp?clientPers=<%=request.getParameter("clientPers")%>");
        
    </script>
    <%
            break;
        case 1:
    %>
    <script>
        
        window.alert("Перевод не осуществлен! Некорректно введена сумма!");
        window.location("client.jsp?clientPers=<%=request.getParameter("clientPers")%>");
    </script>
    <%
            break;
        case 2:
    %>
    <script>
        window.alert("Перевод не осуществлен! Выберите разные счета!");
        window.location("client.jsp?clientPers=<%=request.getParameter("clientPers")%>");
    </script>
    <%
        break;
        case 3:
    %>
    <script>
        window.alert("Перевод не осуществлен! Сумма перевода больше, чем доступная сумма на счёте!");
        window.location("client.jsp?clientPers=<%=request.getParameter("clientPers")%>");
    </script>
    <%
            }

        } catch (Exception e) {
        }
        ClientSessionBeanLocal clientSB;
        PersonSessionBeanLocal personSB;
        Client client;
        Person person;
        List<Account> accounts;
        List<Account> active = new ArrayList<>();
        List<Account> notActive = new ArrayList<>();

        String username;
        String password;
        try {
            InitialContext ic = new InitialContext();
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");

            if (request.getParameter("clientPers") != null) {
                person = personSB.getPersonById(Integer.parseInt(request.getParameter("clientPers")));
                client = clientSB.getClientByPersonId(person);
            } else if (!request.getParameter("login").equals(null) || !request.getParameter("password").equals(null)) {
                username = request.getParameter("login");
                password = request.getParameter("password");
                person = personSB.getPerson(username, password);
                client = clientSB.getClientByPersonId(person);
            } else {
                response.sendRedirect("index.jsp?errcode=1");//
                return;
            }
            if (client == null) {
                response.sendRedirect("index.jsp?errcode=2");
                return;
            }
            accounts = client.getAccountList();

            for (Account acc : accounts) {
                if (acc.isOpen()) {
                    active.add(acc);
                } else {
                    notActive.add(acc);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    %>

    <body>

        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="form-body">
                        <label>Здравствуйте, <%=person.getFname() + " " + person.getLname()%>!</label>
                        <br><br>
                        <ul class="nav nav-tabs final-login">
                            <li class="active"><a data-toggle="tab" href="#sectionA">Ваши счета</a></li>
                            <li><a data-toggle="tab" href="#sectionB">Перевод средств</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="sectionA" class="tab-pane fade in active">
                                <div class="innter-form">
                                    Активные счета:<br>
                                    <%
                                        if (active.isEmpty()) {
                                    %>
                                    <p>Нет зарегистрированных счетов, обратитесь к менеджеру для открытия.</p>
                                    <%
                                    } else {
                                    %>


                                    <table border="1" cellpadding="5">
                                        <tr>
                                            <th></th>
                                            <th>Сумма</th>
                                            <th>Дата открытия</th>
                                            <th>Дата завершения</th>
                                            <th>АКТ</th>
                                        </tr>
                                        <c:forEach items="<%= active%>" var="account">
                                            <tr>
                                                <td><fmt:formatNumber value="${account.getId()}" pattern="0000"  /></td>
                                                <td><fmt:formatNumber value="${account.getMoney()}" type ="currency" minFractionDigits="2" maxFractionDigits="2" /></td>
                                                <td><fmt:formatDate value="${ account.getDateStart()}" type="date" /></td>
                                                <td><fmt:formatDate value="${ account.getDateEnd()}" type="date" /></td>
                                                <td bgcolor="${account.isOpen() ? 'green' : 'red'}"></td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                    <%
                                        }
                                    %>
                                    <br>Неактивные счета:<br>
                                    <%
                                        if (notActive.isEmpty()) {
                                    %>
                                    <p>Нет зарегистрированных счетов, обратитесь к менеджеру для открытия.</p>
                                    <%
                                    } else {
                                    %>


                                    <table border="1" cellpadding="5">
                                        <tr>
                                            <th></th>
                                            <th>Сумма</th>
                                            <th>Дата открытия</th>
                                            <th>Дата завершения</th>
                                            <th>АКТ</th>
                                        </tr>
                                        <c:forEach items="<%= notActive%>" var="account">
                                            <tr>
                                                <td><fmt:formatNumber value="${account.getId()}" pattern="0000"  /></td>
                                                <td><fmt:formatNumber value="${account.getMoney()}" type ="currency" minFractionDigits="2" maxFractionDigits="2" /></td>
                                                <td><fmt:formatDate value="${ account.getDateStart()}" type="date" /></td>
                                                <td><fmt:formatDate value="${ account.getDateEnd()}" type="date" /></td>
                                                <td bgcolor="${account.isOpen() ? 'green' : 'red'}"></td>
                                            </tr>
                                        </c:forEach>
                                        <%
                                            }
                                        %>
                                    </table>
                                </div>
                            </div>
                            <div id="sectionB" class="tab-pane fade">
                                <div class="innter-form">
                                    <form action="transferAction.jsp">
                                        <%
                                            if (active.size()<2) {
                                        %>
                                        <p>Нет доступных счетов для перевода, обратитесь к менеджеру для открытия.</p>
                                        <%
                                        } else {
                                        %>
                                        <p>Для перевода выберите из списка счет списания и счет внесения, а также сумму для перевода</p>
                                        <label>Счет списания:</label>
                                        <select name="account1">
                                            <c:forEach items="<%= active%>" var="acc">
                                                <option value=${acc.getId()}>${acc.toString()}</option>
                                            </c:forEach>
                                        </select>
                                        <br>
                                        <label>Счет зачисления:</label>
                                        <select name="account2">
                                            <c:forEach items="<%= active%>" var="acc">
                                                <option value=${acc.getId()}>${acc.toString()}</option>
                                            </c:forEach>
                                        </select>
                                        <br>
                                        <label>Сумма:</label> 
                                        <br><input type="text" name="sum" >
                                        <input type="hidden" name="clientPers" value="<%=person.getId()%>" required>
                                        <br><input id="dotransfer" type="submit" value="перевести">
                                        <%
                                        }
                                        
                                        %> 
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">

                    <p><a href="index.jsp">Вернуться к странице входа в систему</a></p>
                </div>
            </div>
        </div>                   
    </body>


</html>
