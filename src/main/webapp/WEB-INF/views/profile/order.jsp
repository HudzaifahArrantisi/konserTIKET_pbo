<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tickets - The Hype Machine</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #1a1a2e;
            --secondary: #16213e;
            --highlight: #e94560;
            --gold: #ffd700;
        }
        
        .gradient-text {
            background: linear-gradient(90deg, var(--gold), var(--highlight));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, var(--highlight), #ff6b8b);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(233, 69, 96, 0.4);
        }
    </style>
</head>
<body class="bg-gray-900 text-white">
  
  <!-- Navbar -->
  <nav class="fixed top-0 left-0 w-full bg-gray-900/90 p-4 z-50">
    <div class="container mx-auto flex justify-between items-center">
      <div class="logo">
        <h1 class="text-2xl font-bold gradient-text">THE HYPE MACHINE</h1>
      </div>
      <div class="flex gap-4">
        <a href="/concert/dashboard" class="btn-primary">
          <i class="fas fa-home mr-2"></i>Dashboard
        </a>
        <a href="/concert/profile" class="btn-primary">
          <i class="fas fa-user mr-2"></i>Profile
        </a>
        <a href="/concert/auth/logout" class="btn-primary bg-red-600">
          <i class="fas fa-sign-out-alt mr-2"></i>Logout
        </a>
      </div>
    </div>
  </nav>

  <!-- Tickets Section -->
  <section class="pt-32 pb-20 px-4">
    <div class="container mx-auto">
      <h1 class="text-4xl md:text-5xl font-bold mb-12 gradient-text">MY TICKETS</h1>
      
      <c:if test="${param.success == 'true'}">
        <div class="mb-6 p-4 bg-green-500/20 border border-green-500 rounded-lg">
          <div class="flex items-center">
            <i class="fas fa-check-circle text-green-400 mr-3 text-xl"></i>
            <p class="text-green-300">Payment successful! Your tickets have been issued.</p>
          </div>
        </div>
      </c:if>
      
      <c:choose>
        <c:when test="${empty paidOrders}">
          <div class="bg-gray-800 rounded-2xl p-12 text-center">
            <i class="fas fa-ticket-alt text-6xl text-gray-600 mb-4"></i>
            <h2 class="text-2xl font-bold mb-4">No tickets yet</h2>
            <p class="text-gray-400 mb-6">Purchase tickets to see them here</p>
            <a href="/concert/dashboard" class="btn-primary inline-block">
              <i class="fas fa-shopping-cart mr-2"></i>Buy Tickets
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <!-- Filter by Day -->
          <div class="mb-8">
            <div class="flex flex-wrap gap-2">
              <button class="filter-btn px-4 py-2 bg-gray-700 rounded-lg hover:bg-gray-600 active" data-day="all">
                All Days
              </button>
              <button class="filter-btn px-4 py-2 bg-gray-700 rounded-lg hover:bg-gray-600" data-day="Day 1">
                Day 1
              </button>
              <button class="filter-btn px-4 py-2 bg-gray-700 rounded-lg hover:bg-gray-600" data-day="Day 2">
                Day 2
              </button>
              <button class="filter-btn px-4 py-2 bg-gray-700 rounded-lg hover:bg-gray-600" data-day="Day 3">
                Day 3
              </button>
            </div>
          </div>
          
          <!-- Tickets Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="tickets-container">
            <c:forEach var="order" items="${paidOrders}">
              <c:forEach var="ticket" items="${order.tickets}">
                <div class="ticket-card bg-gray-800 rounded-2xl overflow-hidden" 
                     data-day="${ticket.ticketCategory.name}">
                  <div class="p-6">
                    <div class="flex justify-between items-start mb-4">
                      <div>
                        <span class="px-3 py-1 bg-purple-600 rounded-full text-sm font-bold">
                          ${ticket.ticketCategory.name}
                        </span>
                        <p class="text-gray-400 text-sm mt-1">Order: ${order.orderNumber}</p>
                      </div>
                      <div class="text-right">
                        <span class="text-green-400 font-bold">PAID</span>
                        <p class="text-gray-400 text-sm">${ticket.createdAt}</p>
                      </div>
                    </div>
                    
                    <div class="text-center my-6">
                      <img src="${ticket.qrCodeData}" alt="QR Code" class="w-48 h-48 mx-auto">
                      <p class="text-sm text-gray-400 mt-2">Scan at entrance</p>
                    </div>
                    
                    <div class="border-t border-gray-700 pt-4">
                      <div class="flex justify-between mb-2">
                        <span class="text-gray-400">Ticket Code</span>
                        <span class="font-bold">${ticket.ticketCode}</span>
                      </div>
                      <div class="flex justify-between mb-2">
                        <span class="text-gray-400">Category</span>
                        <span>${ticket.ticketCategory.description}</span>
                      </div>
                      <div class="flex justify-between">
                        <span class="text-gray-400">Status</span>
                        <span class="${ticket.used ? 'text-red-400' : 'text-green-400'}">
                          ${ticket.used ? 'USED' : 'VALID'}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-gray-900 py-12">
    <div class="container mx-auto px-4 text-center">
      <h3 class="text-2xl gradient-text font-bold mb-6">THE HYPE MACHINE</h3>
      <p class="text-gray-400 mb-8">Festival musik terbesar tahun ini!</p>
      <p class="text-sm text-gray-500">© 2025 The Hype Machine. All Rights Reserved.</p>
    </div>
  </footer>

  <script>
    // Filter tickets by day
    document.querySelectorAll('.filter-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        // Update active button
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        
        const day = btn.dataset.day;
        const tickets = document.querySelectorAll('.ticket-card');
        
        tickets.forEach(ticket => {
          if (day === 'all' || ticket.dataset.day === day) {
            ticket.style.display = 'block';
          } else {
            ticket.style.display = 'none';
          }
        });
      });
    });
  </script>
</body>
</html>