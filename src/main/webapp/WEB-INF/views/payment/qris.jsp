<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QRIS Payment - The Hype Machine</title>
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
        <a href="/concert/profile/orders" class="btn-primary">
          <i class="fas fa-ticket-alt mr-2"></i>My Tickets
        </a>
        <a href="/concert/auth/logout" class="btn-primary bg-red-600">
          <i class="fas fa-sign-out-alt mr-2"></i>Logout
        </a>
      </div>
    </div>
  </nav>

  <!-- Payment Section -->
  <section class="pt-32 pb-20 px-4">
    <div class="container mx-auto max-w-4xl">
      <div class="bg-gray-800 rounded-2xl p-8">
        <div class="text-center mb-8">
          <h1 class="text-4xl font-bold gradient-text mb-4">QRIS PAYMENT</h1>
          <p class="text-gray-400">Scan QR Code below to complete payment</p>
          <div class="flex items-center justify-center gap-2 mt-2">
            <div class="w-3 h-3 bg-green-500 rounded-full animate-pulse"></div>
            <span class="text-green-400">Payment Status: PENDING</span>
          </div>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- QR Code -->
          <div class="bg-white p-8 rounded-2xl">
            <div class="aspect-square flex items-center justify-center">
              <img src="${qrCode}" alt="QRIS Code" class="w-full max-w-xs">
            </div>
            <p class="text-center text-gray-700 mt-4">Scan with your mobile banking app</p>
          </div>
          
          <!-- Order Details -->
          <div>
            <h2 class="text-2xl font-bold mb-6">Order Details</h2>
            
            <div class="space-y-4 mb-6">
              <div class="flex justify-between py-3 border-b border-gray-700">
                <span class="text-gray-400">Order Number</span>
                <span class="font-bold">${order.orderNumber}</span>
              </div>
              
              <div class="flex justify-between py-3 border-b border-gray-700">
                <span class="text-gray-400">Date</span>
                <span>${order.orderDate}</span>
              </div>
              
              <div class="flex justify-between py-3 border-b border-gray-700">
                <span class="text-gray-400">Payment Method</span>
                <span>QRIS</span>
              </div>
              
              <div class="flex justify-between py-3 border-b border-gray-700">
                <span class="text-gray-400">Total Amount</span>
                <span class="text-green-400 font-bold text-xl">IDR ${order.totalAmount}</span>
              </div>
            </div>
            
            <div class="bg-blue-500/20 border border-blue-500 rounded-lg p-4 mb-6">
              <div class="flex items-start">
                <i class="fas fa-info-circle text-blue-400 mt-1 mr-3"></i>
                <div>
                  <h4 class="font-bold mb-1">Payment Instructions</h4>
                  <ul class="text-sm text-gray-300 space-y-1">
                    <li>1. Open your mobile banking / e-wallet app</li>
                    <li>2. Tap "Scan QR Code"</li>
                    <li>3. Point camera at the QR code</li>
                    <li>4. Confirm payment amount</li>
                    <li>5. Click button below after payment</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <form action="/concert/payment/confirm/${order.id}" method="post">
              <button type="submit" class="w-full btn-primary py-4 text-lg">
                <i class="fas fa-check-circle mr-2"></i> I HAVE PAID
              </button>
            </form>
            
            <p class="text-center text-gray-400 text-sm mt-4">
              Payment will be verified automatically
            </p>
          </div>
        </div>
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