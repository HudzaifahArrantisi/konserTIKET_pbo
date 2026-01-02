<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - The Hype Machine</title>
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
        <a href="/concert/cart" class="btn-primary bg-purple-600">
          <i class="fas fa-shopping-cart mr-2"></i>Cart
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

  <!-- Cart Section -->
  <section class="pt-32 pb-20 px-4">
    <div class="container mx-auto">
      <h1 class="text-4xl md:text-5xl font-bold mb-8 gradient-text">YOUR CART</h1>
      
      <c:choose>
        <c:when test="${empty cart.items || cart.items.isEmpty()}">
          <div class="bg-gray-800 rounded-2xl p-12 text-center">
            <i class="fas fa-shopping-cart text-6xl text-gray-600 mb-4"></i>
            <h2 class="text-2xl font-bold mb-4">Your cart is empty</h2>
            <p class="text-gray-400 mb-6">Add some tickets to get started!</p>
            <a href="/concert/dashboard" class="btn-primary inline-block">
              <i class="fas fa-ticket-alt mr-2"></i>Browse Tickets
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Cart Items -->
            <div class="lg:col-span-2">
              <div class="bg-gray-800 rounded-2xl p-6">
                <c:forEach var="item" items="${cart.items}">
                  <div class="flex items-center justify-between py-4 border-b border-gray-700 last:border-0">
                    <div class="flex items-center">
                      <div class="w-16 h-16 bg-gradient-to-r from-purple-600 to-pink-500 rounded-lg"></div>
                      <div class="ml-4">
                        <h3 class="font-bold text-lg">${item.ticketCategory.name}</h3>
                        <p class="text-gray-400">${item.ticketCategory.description}</p>
                        <p class="text-green-400 font-bold">
                          IDR <span class="price-value">${item.ticketCategory.price}</span>
                        </p>
                      </div>
                    </div>
                    
                    <div class="flex items-center gap-4">
                      <div class="flex items-center">
                        <form action="/concert/cart/update" method="post" class="flex items-center">
                          <input type="hidden" name="itemId" value="${item.id}">
                          <button type="submit" name="quantity" value="${item.quantity - 1}" 
                                  class="w-8 h-8 bg-gray-700 rounded-l-lg hover:bg-gray-600 ${item.quantity <= 1 ? 'opacity-50 cursor-not-allowed' : ''}"
                                  ${item.quantity <= 1 ? 'disabled' : ''}>
                            <i class="fas fa-minus"></i>
                          </button>
                          <input type="text" value="${item.quantity}" 
                                 class="w-12 h-8 bg-gray-900 text-center border-y border-gray-700" readonly>
                          <button type="submit" name="quantity" value="${item.quantity + 1}" 
                                  class="w-8 h-8 bg-gray-700 rounded-r-lg hover:bg-gray-600">
                            <i class="fas fa-plus"></i>
                          </button>
                        </form>
                      </div>
                      
                      <form action="/concert/cart/remove/${item.id}" method="post">
                        <button type="submit" class="text-red-400 hover:text-red-300 p-2">
                          <i class="fas fa-trash"></i>
                        </button>
                      </form>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>
            
            <!-- Order Summary -->
            <div>
              <div class="bg-gray-800 rounded-2xl p-6 sticky top-32">
                <h2 class="text-2xl font-bold mb-6">Order Summary</h2>
                
                <div class="space-y-4 mb-6">
                  <c:forEach var="item" items="${cart.items}">
                    <div class="flex justify-between">
                      <span>${item.ticketCategory.name} x${item.quantity}</span>
                      <span class="font-bold">
                        IDR <span class="item-total">${item.ticketCategory.price * item.quantity}</span>
                      </span>
                    </div>
                  </c:forEach>
                </div>
                
                <div class="border-t border-gray-700 pt-4 mb-6">
                  <div class="flex justify-between text-xl font-bold">
                    <span>Total</span>
                    <span class="text-green-400">IDR ${cart.totalAmount}</span>
                  </div>
                </div>
                
                <form action="/concert/order/checkout" method="post">
                  <button type="submit" class="w-full btn-primary py-4 text-lg">
                    <i class="fas fa-qrcode mr-2"></i> CHECKOUT WITH QRIS
                  </button>
                </form>
                
                <p class="text-sm text-gray-400 text-center mt-4">
                  You will be redirected to QRIS payment
                </p>
              </div>
            </div>
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
    // Format price display
    document.querySelectorAll('.price-value').forEach(el => {
      el.textContent = parseFloat(el.textContent).toLocaleString('id-ID');
    });
    
    document.querySelectorAll('.item-total').forEach(el => {
      el.textContent = parseFloat(el.textContent).toLocaleString('id-ID');
    });
  </script>
</body>
</html>