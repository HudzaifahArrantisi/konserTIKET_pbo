<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="content" value="delete_content.jsp" />
<jsp:include page="../../shared/layout.jsp" />

<!-- delete_content.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="pageTitle" value="Delete Account - ConcertHub" scope="request" />

<div class="max-w-2xl mx-auto">
    <!-- Profile Header -->
    <div class="flex items-center mb-8">
        <div class="w-16 h-16 concert-gradient rounded-full flex items-center justify-center text-white text-2xl font-bold mr-4">
            ${user.fullName.charAt(0)}
        </div>
        <div>
            <h1 class="text-2xl font-bold">Delete Account</h1>
            <p class="text-gray-600">Permanently delete your account</p>
        </div>
    </div>
    
    <!-- Tab Navigation -->
    <div class="flex border-b border-gray-200 mb-8">
        <a href="/concert/profile"
           class="px-6 py-3 text-gray-600 hover:text-purple-600 font-medium">
            <i class="fas fa-user mr-2"></i> Profile
        </a>
        <a href="/concert/profile/tickets"
           class="px-6 py-3 text-gray-600 hover:text-purple-600 font-medium">
            <i class="fas fa-ticket-alt mr-2"></i> My Tickets
        </a>
        <a href="/concert/profile/delete"
           class="px-6 py-3 border-b-2 border-purple-600 text-purple-600 font-medium">
            <i class="fas fa-trash-alt mr-2"></i> Delete Account
        </a>
    </div>
    
    <!-- Warning Card -->
    <div class="bg-red-50 border border-red-200 rounded-2xl p-8 mb-6">
        <div class="flex items-start">
            <div class="bg-red-100 text-red-600 rounded-full w-12 h-12 flex items-center justify-center mr-4 flex-shrink-0">
                <i class="fas fa-exclamation-triangle text-xl"></i>
            </div>
            <div>
                <h3 class="text-xl font-bold text-red-800 mb-2">Warning: This action cannot be undone</h3>
                <p class="text-red-700">
                    Deleting your account will permanently remove:
                </p>
                <ul class="list-disc list-inside text-red-700 mt-2 space-y-1">
                    <li>Your profile information</li>
                    <li>All your orders and tickets</li>
                    <li>Your cart items</li>
                    <li>All payment history</li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- Account Summary -->
    <div class="bg-white rounded-2xl shadow-lg p-8 mb-6">
        <h3 class="text-lg font-bold mb-4">Account Summary</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <div class="text-center p-4 bg-gray-50 rounded-lg">
                <div class="text-2xl font-bold text-gray-800">${user.orders.size()}</div>
                <p class="text-gray-600">Active Orders</p>
            </div>
            <div class="text-center p-4 bg-gray-50 rounded-lg">
                <div class="text-2xl font-bold text-gray-800">
                    <c:set var="totalTickets" value="0" />
                    <c:forEach var="order" items="${user.orders}">
                        <c:set var="totalTickets" value="${totalTickets + order.tickets.size()}" />
                    </c:forEach>
                    ${totalTickets}
                </div>
                <p class="text-gray-600">Tickets Purchased</p>
            </div>
            <div class="text-center p-4 bg-gray-50 rounded-lg">
                <div class="text-2xl font-bold text-gray-800">${user.cart.cartItems.size()}</div>
                <p class="text-gray-600">Cart Items</p>
            </div>
        </div>
    </div>
    
    <!-- Confirmation -->
    <div class="bg-yellow-50 border border-yellow-200 rounded-2xl p-8">
        <h3 class="text-lg font-bold mb-4">Confirm Account Deletion</h3>
        <p class="text-yellow-800 mb-6">
            To confirm deletion, please type <span class="font-bold">"DELETE"</span> in the box below:
        </p>
        
        <form action="/concert/profile/delete" method="post" onsubmit="return confirmDeletion()">
            <div class="mb-6">
                <input type="text" id="confirmation" name="confirmation" 
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                       placeholder="Type DELETE here">
            </div>
            
            <div class="flex space-x-4">
                <a href="/concert/profile"
                   class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 py-3 rounded-lg text-center font-bold transition duration-300">
                    <i class="fas fa-times mr-2"></i> Cancel
                </a>
                <button type="submit"
                        class="flex-1 bg-red-600 hover:bg-red-700 text-white py-3 rounded-lg font-bold transition duration-300">
                    <i class="fas fa-trash-alt mr-2"></i> Permanently Delete Account
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function confirmDeletion() {
    const confirmation = document.getElementById('confirmation').value;
    if (confirmation !== 'DELETE') {
        alert('Please type "DELETE" to confirm account deletion.');
        return false;
    }
    return confirm('Are you absolutely sure? This action cannot be undone!');
}
</script>