<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="layout.jsp">
    <jsp:param name="title" value="Products Management" />
    <jsp:param name="content" value="products-content.jsp" />
</jsp:include>

<!-- products-content.jsp content -->
<div class="row">
    <div class="col-12">
        <h1 class="mb-4">Products Management</h1>
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
                    <h6>1. Tất cả products theo giá từ thấp đến cao:</h6>
                    <div class="graphql-query">
                        <pre><code>query {
  productsByPriceAsc {
    id
    title
    price
    quantity
    description
    category {
      name
    }
    user {
      fullname
    }
  }
}</code></pre>
                    </div>
                    <button class="btn btn-primary" onclick="executeProductsByPriceQuery()">Execute Query</button>
                </div>
                
                <div class="mb-3">
                    <h6>2. Products theo category:</h6>
                    <div class="input-group mb-2">
                        <input type="number" id="categoryId" class="form-control" placeholder="Category ID" value="1">
                        <button class="btn btn-success" onclick="executeProductsByCategoryQuery()">Get Products</button>
                    </div>
                    <div class="graphql-query">
                        <pre><code>query {
  productsByCategory(categoryId: 1) {
    id
    title
    price
    category {
      name
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
                <form id="productForm">
                    <div class="mb-3">
                        <label class="form-label">Title:</label>
                        <input type="text" id="productTitle" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quantity:</label>
                        <input type="number" id="productQuantity" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price:</label>
                        <input type="number" step="0.01" id="productPrice" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description:</label>
                        <textarea id="productDescription" class="form-control"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">User ID:</label>
                        <input type="number" id="productUserId" class="form-control" value="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category ID:</label>
                        <input type="number" id="productCategoryId" class="form-control" value="1">
                    </div>
                    <div class="mb-3">
                        <button type="button" class="btn btn-success" onclick="createProduct()">Create Product</button>
                        <button type="button" class="btn btn-warning" onclick="updateProduct()">Update Product</button>
                        <button type="button" class="btn btn-danger" onclick="deleteProduct()">Delete Product</button>
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


function executeProductsByPriceQuery() {
    const query = `
        query {
            productsByPriceAsc {
                id
                title
                price
                quantity
                description
                category {
                    name
                }
                user {
                    fullname
                }
            }
        }
    `;
    executeGraphQLQuery(query);
}

function executeProductsByCategoryQuery() {
    const categoryId = document.getElementById('categoryId').value;
    const query = `
        query {
            productsByCategory(categoryId: ${categoryId}) {
                id
                title
                price
                category {
                    name
                }
            }
        }
    `;
    executeGraphQLQuery(query);
}

function createProduct() {
    const input = {
        title: document.getElementById('productTitle').value,
        quantity: parseInt(document.getElementById('productQuantity').value),
        price: parseFloat(document.getElementById('productPrice').value),
        description: document.getElementById('productDescription').value,
        userId: parseInt(document.getElementById('productUserId').value),
        categoryId: parseInt(document.getElementById('productCategoryId').value)
    };
    
    const mutation = `
        mutation CreateProduct($input: ProductInput!) {
            createProduct(input: $input) {
                id
                title
                price
            }
        }
    `;
    
    executeGraphQLQuery(mutation, { input });
}

function updateProduct() {
    const productId = prompt("Enter Product ID to update:");
    if (productId) {
        const input = {
            title: document.getElementById('productTitle').value,
            quantity: parseInt(document.getElementById('productQuantity').value),
            price: parseFloat(document.getElementById('productPrice').value),
            description: document.getElementById('productDescription').value,
            userId: parseInt(document.getElementById('productUserId').value),
            categoryId: parseInt(document.getElementById('productCategoryId').value)
        };
        
        const mutation = `
            mutation UpdateProduct($id: ID!, $input: ProductInput!) {
                updateProduct(id: $id, input: $input) {
                    id
                    title
                    price
                }
            }
        `;
        
        executeGraphQLQuery(mutation, { id: productId, input });
    }
}

function deleteProduct() {
    const productId = prompt("Enter Product ID to delete:");
    if (productId) {
        const mutation = `
            mutation DeleteProduct($id: ID!) {
                deleteProduct(id: $id)
            }
        `;
        executeGraphQLQuery(mutation, { id: productId });
    }
}
</script>
