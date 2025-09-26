<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GraphQL Demo - ${title}</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"/>
    
    <!-- jQuery and GraphQL -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>var contextPath = "${pageContext.request.contextPath}"</script>
    
    <style>
        .graphql-query {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 1rem;
            margin: 1rem 0;
        }
        .result-area {
            background-color: #e9ecef;
            border: 1px solid #ced4da;
            border-radius: 0.375rem;
            padding: 1rem;
            margin: 1rem 0;
            min-height: 100px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">GraphQL Demo</a>
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/categories">Categories</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/users">Users</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/graphiql" target="_blank">GraphiQL</a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <jsp:include page="${content}" />
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
