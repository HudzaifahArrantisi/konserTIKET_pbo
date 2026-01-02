<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Hype Machine - Premium Music Experience</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #1a1a2e;
            --secondary: #16213e;
            --accent: #0f3460;
            --highlight: #e94560;
            --gold: #ffd700;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f5f5f5;
            background-color: var(--primary);
            margin: 0;
            padding: 0;
        }
        
        .gradient-text {a
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
        <c:choose>
          <c:when test="${not empty user}">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-primary">
              <i class="fas fa-home mr-2"></i>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-primary bg-red-600">
              <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/auth/login" class="btn-primary">
              <i class="fas fa-sign-in-alt mr-2"></i>Login
            </a>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn-primary bg-blue-600">
              <i class="fas fa-user-plus mr-2"></i>Register
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="pt-32 pb-20 px-4">
    <div class="container mx-auto text-center">
      <h1 class="text-6xl md:text-8xl font-bold mb-4 gradient-text">THE HYPE MACHINE</h1>
      <p class="text-xl md:text-2xl max-w-2xl mx-auto mb-8 text-gray-200">
        Where Music Meets Extraordinary Experience
      </p>
      
      <div class="flex flex-col sm:flex-row justify-center gap-4">
        <a href="#tickets" class="btn-primary text-lg px-8 py-3">
          <i class="fas fa-ticket-alt mr-2"></i>GET TICKETS
        </a>
        <a href="#about" class="bg-transparent border-2 border-purple-500 text-white px-8 py-3 rounded-full font-bold text-lg hover:bg-purple-500 transition">
          <i class="fas fa-play-circle mr-2"></i>DISCOVER MORE
        </a>
      </div>
    </div>
  </section>

  <!-- Tickets Section -->
  <section id="tickets" class="py-20">
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
              <c:choose>
                <c:when test="${not empty user}">
                  <form action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="ticketCategoryId" value="${status.index + 1}">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="w-full btn-primary py-3">
                      BUY NOW <i class="fas fa-arrow-right ml-2"></i>
                    </button>
                  </form>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/auth/login" class="w-full btn-primary py-3 block text-center">
                    LOGIN TO BUY <i class="fas fa-arrow-right ml-2"></i>
                  </a>
                </c:otherwise>
              </c:choose>
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