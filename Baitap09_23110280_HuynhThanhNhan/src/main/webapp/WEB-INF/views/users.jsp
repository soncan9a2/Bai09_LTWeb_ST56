<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="layout.jsp">
    <jsp:param name="title" value="Users Management" />
    <jsp:param name="content" value="users-content.jsp" />
</jsp:include>

<!-- users-content.jsp content -->
<div class="row">
    <div class="col-12">
        <h1 class="mb-4">Users Management</h1>
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
                    <h6>1. Tất cả users:</h6>
                    <div class="graphql-query">
                        <pre><code>query {
  allUsers {
    id
    fullname
    email
    phone
    products {
      id
      title
      price
    }
    categories {
      id
      name
    }
  }
}</code></pre>
                    </div>
                    <button class="btn btn-primary" onclick="executeAllUsersQuery()">Execute Query</button>
                </div>
                
                <div class="mb-3">
                    <h6>2. User theo ID:</h6>
                    <div class="input-group mb-2">
                        <input type="number" id="userIdQuery" class="form-control" placeholder="User ID" value="1">
                        <button class="btn btn-success" onclick="executeUserByIdQuery()">Get User</button>
                    </div>
                    <div class="graphql-query">
                        <pre><code>query {
  userById(id: 1) {
    id
    fullname
    email
    phone
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
                <form id="userForm">
                    <div class="mb-3">
                        <label class="form-label">Full Name:</label>
                        <input type="text" id="userFullname" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <input type="email" id="userEmail" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password:</label>
                        <input type="password" id="userPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone:</label>
                        <input type="text" id="userPhone" class="form-control">
                    </div>
                    <div class="mb-3">
                        <button type="button" class="btn btn-success" onclick="createUser()">Create User</button>
                        <button type="button" class="btn btn-warning" onclick="updateUser()">Update User</button>
                        <button type="button" class="btn btn-danger" onclick="deleteUser()">Delete User</button>
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

function executeAllUsersQuery() {
    const query = `
        query {
            allUsers {
                id
                fullname
                email
                phone
                products {
                    id
                    title
                    price
                }
                categories {
                    id
                    name
                }
            }
        }
    `;
    executeGraphQLQuery(query);
}

function executeUserByIdQuery() {
    const userId = document.getElementById('userIdQuery').value;
    const query = `
        query {
            userById(id: ${userId}) {
                id
                fullname
                email
                phone
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

function createUser() {
    const input = {
        fullname: document.getElementById('userFullname').value,
        email: document.getElementById('userEmail').value,
        password: document.getElementById('userPassword').value,
        phone: document.getElementById('userPhone').value
    };
    
    const mutation = `
        mutation CreateUser($input: UserInput!) {
            createUser(input: $input) {
                id
                fullname
                email
                phone
            }
        }
    `;
    
    executeGraphQLQuery(mutation, { input });
}

function updateUser() {
    const userId = prompt("Enter User ID to update:");
    if (userId) {
        const input = {
            fullname: document.getElementById('userFullname').value,
            email: document.getElementById('userEmail').value,
            password: document.getElementById('userPassword').value,
            phone: document.getElementById('userPhone').value
        };
        
        const mutation = `
            mutation UpdateUser($id: ID!, $input: UserInput!) {
                updateUser(id: $id, input: $input) {
                    id
                    fullname
                    email
                    phone
                }
            }
        `;
        
        executeGraphQLQuery(mutation, { id: userId, input });
    }
}

function deleteUser() {
    const userId = prompt("Enter User ID to delete:");
    if (userId) {
        const mutation = `
            mutation DeleteUser($id: ID!) {
                deleteUser(id: $id)
            }
        `;
        executeGraphQLQuery(mutation, { id: userId });
    }
}
</script>
