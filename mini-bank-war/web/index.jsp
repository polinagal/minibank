
<%@page import="org.polina.bank.entity.Index"%>
<%@page import="org.polina.bank.session.ClientSessionBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="org.polina.bank.entity.Person"%>
<%@page import="org.polina.bank.entity.Manager"%>
<%@page import="org.polina.bank.session.PersonSessionBeanLocal"%>
<%@page import="org.polina.bank.session.ManagerSessionBeanLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <title>Вход в систему</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="css/tabs.css">
    <link rel="stylesheet" href="css/main.css">
</head>

<%
    try {
        int errcode = Integer.parseInt(request.getParameter("errcode"));
        switch (errcode) {
            case 0:
                response.sendRedirect("index.jsp");
                break;
            case 1:
%>
<script>
    window.alert("Ошибка поиска учетной записи");
    window.location("index.jsp");

</script>
<%
        break;
    case 2:
%>
<script>
    window.alert("Клиент не найден!");
    window.location("index.jsp");

</script>
<%
        break;

    case 3:
%>
<script>
    window.alert("Менеджер не найден!");
    window.location("index.jsp");
</script>
<%
                break;
        }

    } catch (Exception e) {
    }
    ManagerSessionBeanLocal managerSB;
    PersonSessionBeanLocal personSB;
    ClientSessionBeanLocal clientSB;
    Manager manager;
    Person person;

    InitialContext ic = new InitialContext();
    managerSB = (ManagerSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ManagerSessionBean!org.polina.bank.session.ManagerSessionBeanLocal");
    personSB = (PersonSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/PersonSessionBean!org.polina.bank.session.PersonSessionBeanLocal");
    clientSB = (ClientSessionBeanLocal) ic.lookup("java:global/mini-bank/mini-bank-ejb/ClientSessionBean!org.polina.bank.session.ClientSessionBeanLocal");

    Index.initAll(clientSB.accountLastId(), personSB.lastId(), clientSB.clientLastId(), managerSB.lastId());
%>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="form-body">
                    <ul class="nav nav-tabs final-login">
                        <li class="active"><a data-toggle="tab" href="#sectionA">Клиент</a></li>
                        <li><a data-toggle="tab" href="#sectionB">Менеджер</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="sectionA" class="tab-pane fade in active">
                            <div class="innter-form">
                                <form action="client.jsp" method="POST" class="sa-innate-form" >
                                    <input type="text" name="login" placeholder="Логин" required>
                                    <br><input type="password" name="password" placeholder="Пароль" required>
                                    <br><button type="SUBMIT" >Клиент</button>
                                </form> 
                            </div>
                        </div>
                        <div id="sectionB" class="tab-pane fade">
                            <div class="innter-form">
                                <form action="manager.jsp" method="POST" class="sa-innate-form" >
                                    <input type="text" name="login" placeholder="Логин" required>
                                    <br><input type="password" name="password" placeholder="Пароль" required>
                                    <br><button type="SUBMIT">Менеджер</button>
                                </form> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>