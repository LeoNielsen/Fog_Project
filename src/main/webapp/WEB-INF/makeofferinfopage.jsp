<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:genericpage>
    <jsp:attribute name="header">
         Info om forespørgsel
    </jsp:attribute>

    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        <main>
            <div class="container pagetitelblock titlesearch" style="margin-top: 54px">
                <div class="row">
                    <div class="col-md-6 introtext">
                        <div class="pageheadline setbreadcrumb">
                            <h1>Forespørgslser</h1>
                            <p class="split">></p>
                            <span class="active">Lav tilbud</span>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <section>
            <div class="container">
                <div class="row">
                    <div class="article-page">
                        <div class="col-md-3 article-page-menu mobile-navigation">
                            <ul class="nav nav-pills nav-stacked" style="padding-bottom: 20px">
                                <li style="width: 100%;" class="active">
                                    <a href="${pageContext.request.contextPath}/fc/makeofferinfopage">Info</a>
                                </li>
                                <li style="width: 100%;">
                                    <a href="${pageContext.request.contextPath}/fc/makeofferadjustmentpage"> Tilpasning af mål</a>
                                </li>
                                <li style="width: 100%;">
                                    <a href="${pageContext.request.contextPath}/fc/makeoffermateriallistpage">Stykliste</a>
                                </li>
                                <li style="width: 100%;">
                                    <a href="${pageContext.request.contextPath}/fc/makeofferpriceadjustmentpage">Prissætning</a>
                                </li>
                                <li style="width: 100%;">
                                    <a href="${pageContext.request.contextPath}/fc/makeofferdrawingpage">Tegninger</a>
                                </li>
                                <li style="width: 100%">
                                    <a href="${pageContext.request.contextPath}/fc/makeofferconfirmpage">Opret tilbud</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <div class="xhtml-string">
                                <h2>Kundeoplysninger</h2>
                                <div class="alert alert-info" style="margin-bottom: 50px">
                                    <div class="row">
                                        <div class="col-xs-12">

                                            <div>
                                                <div>
                                                    <label style="font-weight: bold">Fornavn: </label>
                                                </div>
                                                <div>
                                                    <p>${sessionScope.currentrequest.user.firstname} </p>
                                                </div>
                                            </div>


                                            <div>
                                                <div>
                                                    <label>Efternavn: </label>
                                                </div>
                                                <div>
                                                    <p>${sessionScope.currentrequest.user.lastname} </p>
                                                </div>
                                            </div>

                                            <div>
                                                <div>
                                                    <label>E-mail: </label>
                                                </div>
                                                <div>
                                                    <p>${sessionScope.currentrequest.user.email}</p>
                                                </div>
                                            </div>
                                            <div>
                                                <div>
                                                    <label>Telefon: </label>
                                                </div>
                                                <div>
                                                    <p>${sessionScope.currentrequest.user.phoneNr}</p>
                                                </div>
                                            </div>
                                            <div>
                                                <div>
                                                    <label>Adresse: </label>
                                                </div>
                                                <div>
                                                    <p>${sessionScope.currentrequest.user.streetname} nr. ${sessionScope.currentrequest.user.houseNr}, ${sessionScope.currentrequest.user.city} ${sessionScope.currentrequest.user.zipcode}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <h2>Forespørgslsen</h2>
                                <div class="alert alert-info">
                                    <div style="padding-bottom: 45px">
                                        <h3>model</h3>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div>
                                                    <input type="text" value="Carport med fladt tag" disabled> <!--TODO: carport model bliver ikke gemt-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="padding-bottom: 45px">
                                        <h3>størrelse</h3>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div style="margin-bottom: 15px">
                                                    <label>Carport bredde</label>
                                                    <input type="text" value="${sessionScope.currentrequest.carportWidth} cm" disabled>
                                                </div>
                                                <div>
                                                    <label>Carport længde</label>
                                                    <input type="text" value="${sessionScope.currentrequest.carportLength} cm" disabled>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="padding-bottom: 45px">
                                        <h3>tag</h3>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div style="margin-bottom: 15px">
                                                    <label>Tag-materiale</label>
                                                    <input type="text" value="${sessionScope.currentrequest.roofType}" disabled>
                                                </div>
                                                <div>
                                                    <label>Taghældning</label>
                                                    <input type="text" value="${sessionScope.currentrequest.roofAngle} grader" disabled>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="padding-bottom: 45px">
                                        <h3>redskabsrum</h3>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div style="margin-bottom: 15px">
                                                    <label>Redskabsrum bredde</label>
                                                    <input type="text" value="${sessionScope.currentrequest.shedWidth} cm" disabled>
                                                </div>
                                                <div>
                                                    <label>Redskabsrum længde</label>
                                                    <input type="text" value="${sessionScope.currentrequest.shedLength} cm" disabled>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="padding-bottom: 45px">
                                        <h3>Bemærkning</h3>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div style="margin-bottom: 15px">
                                                    <textarea disabled>${sessionScope.currentrequest.remarks}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="pull-right col-xs-3">
                                    <div class="col-xs-6">
                                        <a class="button" style="color: #b5b9be; cursor: default"><i class="fa fa-chevron-left"></i> Tilbage</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="${pageContext.request.contextPath}/fc/makeofferadjustmentpage" class="button">Næste <i class="fa fa-chevron-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</t:genericpage>
