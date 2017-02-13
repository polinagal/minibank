<%-- 
    Document   : newAccount
    Created on : Jan 26, 2017, 12:53:42 AM
    Author     : polina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Открытие нового счета</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="css/tabs.css">
        <link rel="stylesheet" href="css/main.css">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="form-body">
                        <h2>Открыть новый счет</h2>
                        <form action="newAccountAction.jsp">
                            <br>Срок действия счета, мес: <select name="duration">
                                <option>1</option>
                                <option>3</option>
                                <option selected="true">6</option>
                                <option>12</option>
                                <option>18</option>
                                <option>24</option>
                            </select>
                            <br>Начальная сумма: <input type ="text" name="amount" value="0">
                            <br><input type="submit" name="Создать">
                            <input type="hidden" name="clientPers" value="<%=request.getParameter("clientPers")%>">
                            <input type="hidden" name="managerPers" value="<%=request.getParameter("managerPers")%>">
                        </form>
                    </div>
                </div>
            </div>       
        </div>        
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <p><a href="manager.jsp?managerPers=<%=request.getParameter("managerPers")%>">Вернуться на свою домашнюю страницу</a></p>
                    <p><a href="index.jsp">Вернуться к странице входа в систему</a></p>
                </div>
            </div>
        </div>



    </body>

</html>


