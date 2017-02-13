
<%@page import="org.polina.bank.entity.Client"%>
<%@page import="org.polina.bank.session.ClientSessionBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="org.polina.bank.entity.Person"%>
<%@page import="org.polina.bank.entity.Manager"%>
<%@page import="org.polina.bank.session.PersonSessionBeanLocal"%>
<%@page import="org.polina.bank.session.ManagerSessionBeanLocal"%>
<%@page import="org.polina.bank.entity.Index"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Редактирование данных клиента клиента</title>

        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="css/tabs.css">
        <link rel="stylesheet" href="css/main.css">
    </head>
    <%
        PersonSessionBeanLocal personSB;
        ClientSessionBeanLocal clientSB;

        Person person;
        Client client;

        try {
            InitialContext ic = new InitialContext();
            personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");
            clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");

            person = personSB.getPersonById(Integer.parseInt(request.getParameter("clientPers")));
            client = clientSB.getClientByPersonId(person);
        } catch (Exception ex) {
            response.sendRedirect("index.jsp?errcode=10");
            return;
        }
    %>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-body">
                        <h2>Редактирование регистрационных данных клиента клиента</h2>

                        <form action="editClientAction.jsp">
                            <br><label>UserID:</label> <%=client.getId()%>
                            <br><label>GlobalID:</label> <%=person.getId()%>
                            <br><label>Имя:</label> <input type="text" name="fname" value=<%=person.getFname()%> required>
                            <br><label>Фамилия:</label> <input type ="text" name="lname" value=<%=person.getLname()%> required>
                            <br><label>Дата рождения:</label><input name="dob" type="date" value=<%=person.getDateAsString()%> required> 
                            <br><label>Логин для входа в систему:</label> <input type ="text" name="login" value=<%=person.getLogin()%> placeholder="Логин" required>
                            <br><label>Пароль для входа в систему:</label> <input type ="text" name="password" value=<%=person.getPassword()%> placeholder="Пароль" required>
                            <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">
                            <input type="hidden" name="clientPers" value="<%=request.getParameter("clientPers")%>">
                            <br><button type="submit">Изменить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>    
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <p><a href="manager.jsp?managerPers=<%=request.getParameter("managerPers")%>">Вернуться на домашнюю страницу</a></p>
                    <p><a href="index.jsp">Вернуться к странице входа в систему</a></p>
                </div>
            </div>
        </div>
    </body>
</html>
