<html>

    <head>
        <title>Sign Up</title>
        <link rel="stylesheet" href="css/signup.css">
    </head>

<body>
        <form action="signup.inc.jsp" method="post" style="border:1px solid #ccc">
            
          <div class="container">
            <h1>Sign Up</h1>
            <p>Please fill in this form to create an account.</p>
            <hr>

            <label for="oname" class="required"><b>Owner Name</b></label>
            <input type="text" placeholder="Enter Full Name" name="name" required>

            <label for="psw" class="required"><b>Phone no.</b></label>
            <input type="text" placeholder="Enter Phone No." name="phone" required>

            <label for="email" class="required"><b>Email</b></label>
            <input type="text" placeholder="Enter Email" name="email" required>


            <label for="oaddr" class="required"><b>Owner Address</b></label>
            <input type="text" placeholder="Enter Owner Address" name="addr" required>

            <label for="tname" class="required"><b>Turf Name</b></label>
            <input type="text" placeholder="Enter Turf Name" name="tname" required>

            <label for="tphone" class="required"><b>Turf Phone</b></label>
            <input type="text" placeholder="Enter Business Phone" name="tphone" required>

            <label for="taddr" class="required"><b>Turf Address</b></label>
            <input type="text" placeholder="Enter Address" name="taddr" required>

             <label for="taddr" class="required"><b>Rate per Hour</b></label>
            <input type="text" placeholder="Enter Price" name="rph" required>

            <label for="psw" class="required"><b>Password</b></label>
            <input type="password" placeholder="Enter Password" name="psw" required>

            
            <p><b>Player?</b><a href="SignUp.jsp" style="color:dodgerblue">Register Here</a>.</p>

            <div class="clearfix">
              <button type="button" onClick="window.location.href = 'index.jsp';" class="cancelbtn">Cancel</button>
              <button type="submit" class="signupbtn">Sign Up</button>
            </div>
          </div>
            
        </form>
    </body>
</html>
