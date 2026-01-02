<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Hype Machine - Dashboard</title>
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
        <a href="/dashboard" class="btn-primary">
          <i class="fas fa-home mr-2"></i>Dashboard
        </a>
        <a href="/cart" class="btn-primary">
          <i class="fas fa-shopping-cart mr-2"></i>Cart
        </a>
        <a href="/profile" class="btn-primary">
          <i class="fas fa-user mr-2"></i>Profile
        </a>
        <a href="/auth/logout" class="btn-primary bg-red-600">
          <i class="fas fa-sign-out-alt mr-2"></i>Logout
        </a>
      </div>
    </div>
  </nav>

  <!-- Welcome Section -->
  <section class="pt-32 pb-20 px-4">
    <div class="container mx-auto text-center">
      <h1 class="text-5xl md:text-7xl font-bold mb-4 gradient-text">WELCOME, ${user.fullName}!</h1>
      <p class="text-xl md:text-2xl max-w-2xl mx-auto mb-8 text-gray-200">
        Ready for the ultimate music experience?
      </p>
    </div>
  </section>

  <!-- Tickets Section -->
  <section class="py-20">
    <div class="container mx-auto px-4">
      <h2 class="text-4xl md:text-5xl font-bold text-center mb-12 gradient-text">AVAILABLE TICKETS</h2>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <c:forEach var="ticket" items="${tickets}" varStatus="status">
          <div class="bg-gray-800 rounded-2xl overflow-hidden shadow-lg">
            <div class="h-48 bg-gradient-to-r from-purple-600 to-pink-500"></div>
            <div class="p-6">
              <h3 class="text-2xl font-bold mb-2">${ticket.label}</h3>
              <p class="text-xl text-green-400 font-bold mb-4">${ticket.price}</p>
              <ul class="mb-6 space-y-2">
                <c:forEach var="feature" items="${ticket.features}">
                  <li class="flex items-center">
                    <i class="fas fa-check text-green-500 mr-3"></i>
                    <span>${feature}</span>
                  </li>
                </c:forEach>
              </ul>
              <form action="/cart/add" method="post">
                <input type="hidden" name="ticketCategoryId" value="${status.index + 1}">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="w-full btn-primary py-3">
                  <i class="fas fa-cart-plus mr-2"></i> ADD TO CART
                </button>
              </form>
            </div>
          </div>
        </c:forEach>
      </div>
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
</body>
</html>