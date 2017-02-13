<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Менеджер</title>
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
        window.alert("Учетная запись создана!");
        window.location("manager.jsp?managerPers=<%=request.getParameter("managerPers")%>");
    </script>
    <%
            break;
        case 2:
    %>
    <script>
        window.alert("Учетная запись не создана! Учетная запись с таким login существует!");
        window.location("manager.jsp?managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;

        case 3:
    %>
    <script>
        window.alert("Учетная запись не создана! Введены некорректные параметры!");
        window.location("manager.jsp?managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;
        case 4:
    %>
    <script>
        window.alert("Клиент не найден!");
        window.location("manager.jsp?managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
            break;
        case 5:
    %>
    <script>
        window.alert("Клиент не найден! Ошибка чтения параметров!");
        window.location("manager.jsp?managerPers=<%=request.getParameter("managerPers")%>");

    </script>
    <%
                    break;
            }

        } catch (Exception e) {

        }
        ManagerSessionBeanLocal managerSB;
        PersonSessionBeanLocal personSB;
        Manager manager;
        Person person;

        String username;
        String password;

        try {
            InitialContext ic = new InitialContext();
            managerSB = (ManagerSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ManagerSessionBean!org.polina.bank.session.ManagerSessionBeanLocal");
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");

            if (request.getParameter("managerPers") != null) {
                person = personSB.getPersonById(Integer.parseInt(request.getParameter("managerPers")));
                manager = managerSB.getManagerByPersonId(person);
            } else if (!request.getParameter("login").equals(null) || !request.getParameter("password").equals(null)) {
                username = request.getParameter("login");
                password = request.getParameter("password");
                person = personSB.getPerson(username, password);
                manager = managerSB.getManagerByPersonId(person);
            } else {
                //Ошибка поиска учетной записи
                response.sendRedirect("index.jsp?errcode=1");
                return;
            }
            if (manager == null) {
                //Менеджер не найден
                response.sendRedirect("index.jsp?errcode=3");
                return;
            }

        } catch (Exception e) {
            //Ошибка поиска учетной записи
            response.sendRedirect("index.jsp?errcode=3");
            return;
        }
    %>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="form-body">
                        <label >Здравствуйте, <%=person.getFname() + " " + person.getLname()%>!</label>
                        <br><label>Введите ID клиента:</label>
                        <form id="alterClient" action="alterClient.jsp">
                            <input type="text" name="clientId" required>
                            <input type="hidden" name="managerPers" value=<%=person.getId()%>> 
                            <button  type="submit"> Выбрать</button>
                        </form>

                        <form id="newClient" action="newClient.jsp">
                            <input type="hidden" name="managerPers" value=<%=person.getId()%>> 
                            <button class="bigbtn" type="submit">Новый Клиент</button>
                        </form>
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
