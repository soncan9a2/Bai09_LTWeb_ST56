<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="layout.jsp">
    <jsp:param name="title" value="Home" />
    <jsp:param name="content" value="home.jsp" />
</jsp:include>

<!-- home.jsp content -->
<div class="row">
    <div class="col-12">
        <h1 class="text-center mb-4">GraphQL Demo Application</h1>
        <p class="text-center lead">Quản lý Products, Categories và Users với GraphQL API</p>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-box fa-3x text-primary mb-3"></i>
                <h5 class="card-title">Products</h5>
                <p class="card-text">Quản lý sản phẩm với GraphQL</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Xem Products</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-tags fa-3x text-success mb-3"></i>
                <h5 class="card-title">Categories</h5>
                <p class="card-text">Quản lý danh mục sản phẩm</p>
                <a href="${pageContext.request.contextPath}/categories" class="btn btn-success">Xem Categories</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-users fa-3x text-info mb-3"></i>
                <h5 class="card-title">Users</h5>
                <p class="card-text">Quản lý người dùng</p>
                <a href="${pageContext.request.contextPath}/users" class="btn btn-info">Xem Users</a>
            </div>
        </div>
    </div>
</div>

<div class="row mt-5">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5>GraphQL Endpoints</h5>
            </div>
            <div class="card-body">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <strong>GraphQL Endpoint:</strong> <code>POST /graphql</code>
                    </li>
                    <li class="list-group-item">
                        <strong>GraphiQL Interface:</strong> <a href="/graphiql" target="_blank">/graphiql</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
