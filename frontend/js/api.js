// API Helper Utility for Career Recommendation System
const API_BASE = 'http://localhost:8080/api';

// Helper function to get current user from localStorage
function getCurrentUser() {
    const userStr = localStorage.getItem('currentUser');
    return userStr ? JSON.parse(userStr) : null;
}

// Helper function to save current user
function setCurrentUser(user) {
    if (user) {
        localStorage.setItem('currentUser', JSON.stringify(user));
    } else {
        localStorage.removeItem('currentUser');
    }
}

// Helper function to check auth and redirect if not logged in
function requireAuth(redirectUrl = 'login.html') {
    const user = getCurrentUser();
    if (!user) {
        window.location.href = redirectUrl;
        return null;
    }
    return user;
}

// Helper function to perform API requests
async function apiRequest(endpoint, method = 'GET', data = null) {
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        credentials: 'include' // allow session cookies
    };

    if (data && (method === 'POST' || method === 'PUT' || method === 'PATCH')) {
        options.body = JSON.stringify(data);
    }

    try {
        const response = await fetch(`${API_BASE}${endpoint}`, options);
        
        let result;
        const contentType = response.headers.get('content-type');
        if (contentType && contentType.includes('application/json')) {
            result = await response.json();
        } else {
            const text = await text();
            result = { message: text };
        }

        if (!response.ok) {
            throw new Error(result.message || result.error || `Error ${response.status}`);
        }

        return result;
    } catch (err) {
        console.error(`API Error on ${endpoint}:`, err);
        throw err;
    }
}

// Global Logout function
function logoutUser() {
    localStorage.removeItem('currentUser');
    localStorage.removeItem('adminUser');
    fetch(`${API_BASE}/logout`, { method: 'GET', credentials: 'include' }).catch(() => {});
    window.location.href = 'login.html';
}
