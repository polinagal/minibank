<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Страница клиента</title>
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
                case 1:
    %>
    <script>
        window.alert("Изменения в учетную запись внесены!");
        window.location("alterClient.jsp?clientPers=<%=request.getParameter("clientPers")%>&managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;
        case 2:
    %>
    <script>

        window.alert("Изменения не сохранены! Клиент с таким login уже существует!");
        window.location("alterClient.jsp?clientPers=<%=request.getParameter("clientPers")%>&managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;
        case 3:
    %>
    <script>
        window.alert("Изменения не сохранены! Ошибка чтения параметров!");
        window.location("alterClient.jsp?clientPers=<%=request.getParameter("clientPers")%>&managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;

        case 4:
    %>
    <script>
        window.alert("Счет открыт!");
        window.location("alterClient.jsp?clientPers=<%=request.getParameter("clientPers")%>&managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;
        case 5:
    %>
    <script>
        window.alert("Ошибка при открытии счета!");
        window.location("alterClient.jsp?clientPers=<%=request.getParameter("clientPers")%>&managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
                    break;
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

        Integer clientID;
        Integer clientPers;

        InitialContext ic = new InitialContext();
        clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");
        personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");

        try {
            if (request.getParameter("clientId") != null) {
                clientID = Integer.parseInt(request.getParameter("clientId"));
                if (clientID <= 0) {
                    response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=4");
                    return;
                }
                client = clientSB.getClientByID(clientID);
                person = personSB.getPersonByClientId(client);
            } else if (request.getParameter("clientPers") != null) {
                clientPers = Integer.parseInt(request.getParameter("clientPers"));
                if (clientPers <= 0) {
                    response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=4");
                    return;
                }
                person = personSB.getPersonById(clientPers);
                client = clientSB.getClientByPersonId(person);
            } else {
                response.sendRedirect("index.jsp?errcode=1");//no suitable parameters passed
                return;
            }
            if (client == null) {
                response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=4");
                return;
            }
        } catch (Exception e) {
            response.sendRedirect("manager.jsp?managerPers=" + request.getParameter("managerPers") + "&errcode=5");
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
    %>

    <body>



        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="form-body">
                        <br><label>UserID:</label> <%=client.getId()%>
                        <br><label>GlobalID:</label> <%=person.getId()%>
                        <br><label>Имя:</label> <%=person.getFname()%>
                        <br><label>Фамилия:</label> <%=person.getLname()%>
                        <br><label>Дата рождения:</label> <fmt:formatDate value="<%=person.getDob()%>" type="date" />

                        <br><label>Счета клиента:</label>    

                        <%
                            if (accounts.isEmpty()) {
                        %>
                        <p>Нет доступных счетов.</p>
                        <%
                        } else {
                            int idx = 0;
                        %>
                        <table border="1" cellpadding="5">
                            <tr>
                                <th></th>
                                <th>Сумма</th>
                                <th>Дата открытия</th>
                                <th>Дата завершения</th>
                                <th>АКТ</th>
                            </tr>
                            <c:forEach items="<%= accounts%>" var="account">
                                <tr>
                                    <td><fmt:formatNumber value="${account.getId()}" pattern="0000"  /></td>
                                    <td><fmt:formatNumber value="${account.getMoney()}" type ="currency" minFractionDigits="2" maxFractionDigits="2" /></td>
                                    <td><fmt:formatDate value="${ account.getDateStart()}" type="date" /></td>
                                    <td><fmt:formatDate value="${ account.getDateEnd()}" type="date" /></td>
                                    <td bgcolor="${account.isOpen() ? 'green' : 'red'}"></td>
                                </tr>
                            </c:forEach>
                        </table>

                        <div class="row">
                            <%
                                }
                                if (!active.isEmpty()) {

                            %>
                            <div class="col-md-6">
                                <form action="disableAccAction.jsp" >
                                    <select name="account1">
                                        <c:forEach items="<%= active%>" var="acc">
                                            <option value=${acc.getId()}>${acc.toString()}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="clientPers" value="<%=person.getId()%>">
                                    <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">

                                    <button class="bigbtn" type="submit"  >Остановить действие счёта</button>
                                </form>
                            </div>


                            <%
                            } else {
                            %>
                            <div class="col-md-6"></div>
                            <%
                                }
                                if (!notActive.isEmpty()) {
                            %>
                            <div class="col-md-6">
                                <form action="activateAccAction.jsp" >
                                    <select name="account1">
                                        <c:forEach items="<%= notActive%>" var="acc">
                                            <option value=${acc.getId()}>${acc.toString()}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="clientPers" value="<%=person.getId()%>">
                                    <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">

                                    <button class="bigbtn" type="submit">Возобновить действие счёта</button>
                                </form>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="col-md-6">  </div>
                            <%}%>

                        </div>
                        <br>

                        <div class="col-md-6">
                            <form action="editClient.jsp" >  
                                <input type="hidden" name="clientPers" value="<%=person.getId()%>">
                                <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">

                                <button class="bigbtn" type="submit" >Изменить данные клиента</button>
                            </form>
                        </div>
                        <div class="col-md-6">
                            <form action="newAccount.jsp" >  
                                <input type="hidden" name="clientPers" value="<%=person.getId()%>">
                                <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">

                                <button class="bigbtn" id="newAcc" type="submit" >Открыть счет</button>
                            </form>
                        </div>

                    </div>
                </div><!--!!!-->
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-2">
                <p><a href="manager.jsp?managerPers=<%=request.getParameter("managerPers")%>">Вернуться на домашнюю страницу</a></p>
                <p><a href="index.jsp">Вернуться к странице входа в систему</a></p>
            </div>
        </div>
    </div>
</body>
</html>
