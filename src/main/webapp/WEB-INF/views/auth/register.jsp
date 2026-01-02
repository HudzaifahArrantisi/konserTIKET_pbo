<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - The Hype Machine</title>
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
<body class="bg-gray-900 text-white min-h-screen flex items-center justify-center">
    <div class="w-full max-w-lg">
        <div class="text-center mb-8">
            <h1 class="text-4xl font-bold gradient-text mb-2">JOIN THE HYPE</h1>
            <p class="text-gray-400">Create your account</p>
        </div>
        
        <div class="bg-gray-800 rounded-2xl p-8 shadow-2xl">
            <c:if test="${not empty error}">
                <div class="mb-4 p-3 bg-red-500/20 border border-red-500 rounded-lg">
                    <p class="text-red-300">${error}</p>
                </div>
            </c:if>
            
            <form action="/concert/auth/register" method="post">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <div>
                        <label class="block text-sm font-medium mb-2 text-gray-300">Full Name</label>
                        <div class="relative">
                            <i class="fas fa-user absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="text" name="fullName" required
                                   class="w-full pl-12 pr-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:border-purple-500"
                                   placeholder="John Doe">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium mb-2 text-gray-300">Email</label>
                        <div class="relative">
                            <i class="fas fa-envelope absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="email" name="email" required
                                   class="w-full pl-12 pr-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:border-purple-500"
                                   placeholder="your@email.com">
                        </div>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <div>
                        <label class="block text-sm font-medium mb-2 text-gray-300">Password</label>
                        <div class="relative">
                            <i class="fas fa-lock absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="password" name="password" required
                                   class="w-full pl-12 pr-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:border-purple-500"
                                   placeholder="••••••••">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium mb-2 text-gray-300">Phone Number</label>
                        <div class="relative">
                            <i class="fas fa-phone absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="tel" name="phoneNumber"
                                   class="w-full pl-12 pr-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:border-purple-500"
                                   placeholder="+62 812-3456-7890">
                        </div>
                    </div>
                </div>
                
                <div class="mb-8">
                    <label class="block text-sm font-medium mb-2 text-gray-300">Address</label>
                    <div class="relative">
                        <i class="fas fa-home absolute left-4 top-4 text-gray-400"></i>
                        <textarea name="address" rows="3"
                                  class="w-full pl-12 pr-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:border-purple-500"
                                  placeholder="Your complete address"></textarea>
                    </div>
                </div>
                
                <button type="submit" class="w-full btn-primary py-3 text-lg">
                    <i class="fas fa-user-plus mr-2"></i> Create Account
                </button>
            </form>
            
            <div class="mt-6 text-center">
                <p class="text-gray-400">
                    Already have an account? 
                    <a href="/concert/auth/login" class="text-purple-400 hover:text-purple-300 font-medium">
                        Login here
                    </a>
                </p>
                <a href="/concert" class="text-gray-400 hover:text-white mt-4 inline-block">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Home
                </a>
            </div>
        </div>
    </div>
</body>
</html>