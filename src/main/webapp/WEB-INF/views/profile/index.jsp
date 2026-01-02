<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="content" value="profile_content.jsp" />
<jsp:include page="../../shared/layout.jsp" />

<!-- profile_content.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="pageTitle" value="My Profile - ConcertHub" scope="request" />

<div class="max-w-6xl mx-auto">
    <!-- Profile Header -->
    <div class="flex items-center mb-8">
        <div class="w-16 h-16 concert-gradient rounded-full flex items-center justify-center text-white text-2xl font-bold mr-4">
            ${user.fullName.charAt(0)}
        </div>
        <div>
            <h1 class="text-2xl font-bold">My Profile</h1>
            <p class="text-gray-600">Manage your account and preferences</p>
        </div>
    </div>
    
    <!-- Tab Navigation -->
    <div class="flex border-b border-gray-200 mb-8">
        <a href="/concert/profile"
           class="px-6 py-3 border-b-2 border-purple-600 text-purple-600 font-medium">
            <i class="fas fa-user mr-2"></i> Profile
        </a>
        <a href="/concert/profile/tickets"
           class="px-6 py-3 text-gray-600 hover:text-purple-600 font-medium">
            <i class="fas fa-ticket-alt mr-2"></i> My Tickets
        </a>
        <a href="/concert/profile/delete"
           class="px-6 py-3 text-gray-600 hover:text-purple-600 font-medium">
            <i class="fas fa-trash-alt mr-2"></i> Delete Account
        </a>
    </div>
    
    <!-- Profile Information -->
    <div class="bg-white rounded-2xl shadow-lg p-8">
        <h2 class="text-xl font-bold mb-6">Personal Information</h2>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label class="block text-gray-600 mb-2 font-medium">Full Name</label>
                <div class="p-3 bg-gray-50 rounded-lg border">
                    ${user.fullName}
                </div>
            </div>
            
            <div>
                <label class="block text-gray-600 mb-2 font-medium">Email</label>
                <div class="p-3 bg-gray-50 rounded-lg border">
                    ${user.email}
                </div>
            </div>
            
            <div>
                <label class="block text-gray-600 mb-2 font-medium">Phone Number</label>
                <div class="p-3 bg-gray-50 rounded-lg border">
                    ${user.phoneNumber != null ? user.phoneNumber : 'Not provided'}
                </div>
            </div>
            
            <div>
                <label class="block text-gray-600 mb-2 font-medium">Address</label>
                <div class="p-3 bg-gray-50 rounded-lg border">
                    ${user.address != null ? user.address : 'Not provided'}
                </div>
            </div>
        </div>
        
        <div class="mt-8">
            <h3 class="text-lg font-bold mb-4">Account Statistics</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="bg-purple-50 p-4 rounded-xl">
                    <div class="text-2xl font-bold text-purple-600">${user.orders.size()}</div>
                    <p class="text-gray-600">Total Orders</p>
                </div>
                <div class="bg-green-50 p-4 rounded-xl">
                    <div class="text-2xl font-bold text-green-600">
                        <c:set var="totalTickets" value="0" />
                        <c:forEach var="order" items="${user.orders}">
                            <c:set var="totalTickets" value="${totalTickets + order.tickets.size()}" />
                        </c:forEach>
                        ${totalTickets}
                    </div>
                    <p class="text-gray-600">Tickets Purchased</p>
                </div>
                <div class="bg-blue-50 p-4 rounded-xl">
                    <div class="text-2xl font-bold text-blue-600">Member</div>
                    <p class="text-gray-600">Account Type</p>
                </div>
            </div>
        </div>
    </div>
</div>