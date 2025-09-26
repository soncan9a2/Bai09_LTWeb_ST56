<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="layout.jsp">
    <jsp:param name="title" value="Categories Management" />
    <jsp:param name="content" value="categories-content.jsp" />
</jsp:include>

<!-- categories-content.jsp content -->
<div class="row">
    <div class="col-12">
        <h1 class="mb-4">Categories Management</h1>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>GraphQL Queries</h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <h6>1. Tất cả categories:</h6>
                    <div class="graphql-query">
                        <pre><code>query {
  allCategories {
    id
    name
    images
    products {
      id
      title
      price
    }
  }
}</code></pre>
                    </div>
                    <button class="btn btn-primary" onclick="executeAllCategoriesQuery()">Execute Query</button>
                </div>
                
                <div class="mb-3">
                    <h6>2. Category theo ID:</h6>
                    <div class="input-group mb-2">
                        <input type="number" id="categoryIdQuery" class="form-control" placeholder="Category ID" value="1">
                        <button class="btn btn-success" onclick="executeCategoryByIdQuery()">Get Category</button>
                    </div>
                    <div class="graphql-query">
                        <pre><code>query {
  categoryById(id: 1) {
    id
    name
    images
    products {
      id
      title
      price
    }
  }
}</code></pre>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>CRUD Operations</h5>
            </div>
            <div class="card-body">
                <form id="categoryForm">
                    <div class="mb-3">
                        <label class="form-label">Name:</label>
                        <input type="text" id="categoryName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Images:</label>
                        <input type="text" id="categoryImages" class="form-control" placeholder="image.jpg">
                    </div>
                    <div class="mb-3">
                        <button type="button" class="btn btn-success" onclick="createCategory()">Create Category</button>
                        <button type="button" class="btn btn-warning" onclick="updateCategory()">Update Category</button>
                        <button type="button" class="btn btn-danger" onclick="deleteCategory()">Delete Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5>Query Results</h5>
            </div>
            <div class="card-body">
                <div id="queryResults" class="result-area">
                    <p class="text-muted">Click on a query button to see results here...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function executeGraphQLQuery(query, variables = {}) {
    return fetch('/graphql', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            query: query,
            variables: variables
        })
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('queryResults').innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        return data;
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('queryResults').innerHTML = '<div class="alert alert-danger">Error: ' + error.message + '</div>';
    });
}

function executeAllCategoriesQuery() {
    const query = `
        query {
            allCategories {
                id
                name
                images
                products {
                    id
                    title
                    price
                }
            }
        }
    `;
    executeGraphQLQuery(query);
}

function executeCategoryByIdQuery() {
    const categoryId = document.getElementById('categoryIdQuery').value;
    const query = `
        query {
            categoryById(id: ${categoryId}) {
                id
                name
                images
                products {
                    id
                    title
                    price
                }
            }
        }
    `;
    executeGraphQLQuery(query);
}

function createCategory() {
    const input = {
        name: document.getElementById('categoryName').value,
        images: document.getElementById('categoryImages').value
    };
    
    const mutation = `
        mutation CreateCategory($input: CategoryInput!) {
            createCategory(input: $input) {
                id
                name
                images
            }
        }
    `;
    
    executeGraphQLQuery(mutation, { input });
}

function updateCategory() {
    const categoryId = prompt("Enter Category ID to update:");
    if (categoryId) {
        const input = {
            name: document.getElementById('categoryName').value,
            images: document.getElementById('categoryImages').value
        };
        
        const mutation = `
            mutation UpdateCategory($id: ID!, $input: CategoryInput!) {
                updateCategory(id: $id, input: $input) {
                    id
                    name
                    images
                }
            }
        `;
        
        executeGraphQLQuery(mutation, { id: categoryId, input });
    }
}

function deleteCategory() {
    const categoryId = prompt("Enter Category ID to delete:");
    if (categoryId) {
        const mutation = `
            mutation DeleteCategory($id: ID!) {
                deleteCategory(id: $id)
            }
        `;
        executeGraphQLQuery(mutation, { id: categoryId });
    }
}
</script>
