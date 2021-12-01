<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:genericpage>
    <jsp:attribute name="header">
         Requests
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>

    <jsp:body>
        <div class="grey-large-container">
            <div class="white-large-box">
                <div class="row-3-grid" style="gap: 20px">
                    <div class="large-title-grid-element">
                        <div class="left-text">
                            <h1>Requests</h1>
                        </div>
                    </div>

                    <div class="col-3-grid">
                        <div class="left-grid">
                            <h2>Requests</h2>
                        </div>
                        <div class="right-grid">
                            <h3>${sessionScope.allrequests.size()} Total</h3>
                        </div>
                    </div>
                    <div>
                        <table class="collapse-table">
                            <tr class="table-labels">
                                <th class="left-text">REQUEST</th>
                                <th>CUSTOMER</th>
                                <th>PHONE</th>
                                <th>ITEMS</th>
                                <th>TOTAL</th>
                                <th>DATE</th>
                                <th>STATUS</th>
                                <th></th>
                            </tr>
                            <c:set var="index" value="-1"></c:set>
                            <c:forEach var="order" items="${sessionScope.allrequests}">
                                <tr>
                                    <th class="left-text"><h3>${order.id}</h3></th>
                                    <th><h3>${order.user.email}</h3></th>
                                    <th><h3>${order.user.phoneNr}</h3></th>
                                    <th><h3>${order.BOM.size()}</h3></th>
                                    <th><h3>${order.totalPrice} kr</h3></th>
                                    <th><h3>${order.orderDate}</h3></th>
                                    <th><h3>${order.status}</h3></th>
                                    <form action="${pageContext.request.contextPath}/fc/orderdetailcommand"
                                          method="post">
                                        <input type="hidden" name="order" value="${index = index + 1}">
                                        <input type="hidden" name="customerorderlist" value="false">
                                        <th><input type="submit" value="make offer" class="purple-button"
                                                   style="padding: 10px 10px; width: 85px"></th>
                                    </form>
                                </tr>

                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>

</t:genericpage>

