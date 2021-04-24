<html>
    
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/signup.css">
</head>
    
<body bg-image="images/index/back1.jpg">
        <form action="signup.inc.jsp" method="post" style="border:1px solid #ccc">
          <div class="container">
            <h1>Sign Up</h1>
            <p>Please fill in this form to create an account.</p>
            <hr>

            <label for="name" class="required"><b>Full Name</b></label>
            <input type="text" placeholder="Enter Full Name" name="name" required>

            <label for="phone" class="required"><b>Phone Number</b></label>
            <input type="tel" pattern="^\d{10}$" placeholder="Enter Phone Nmber" name="phone" required>

            <label for="taddr"><b>Player Address</b></label>
            <input type="text" placeholder="Enter Address[Optional]" name="addr">

            <label for="email" class="required"><b>Email-Id</b></label>
            <input type="email" placeholder="Enter Email " name="email" required>

            <label for="psw" class="required"><b>Password</b></label>
            <input type="password" placeholder="Enter Password" name="psw" required>

            <label>
              <input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Remember me
            </label>

            <p><b>Own A Turf?</b><a href="turfreg.jsp" style="color:dodgerblue">Register Here</a>.</p>

            <div class="clearfix">
              <button type="button" onClick="window.location.href = 'index.jsp';" class="cancelbtn">Cancel</button>
              <button type="submit" class="signupbtn">Sign Up</button>
            </div>
          </div>
        </form>
    </body>
</html>
    

