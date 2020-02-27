<html>
	<head>
			<link rel="stylesheet" href="css/signup.css">
	</head>
		<body><br><br>
			<form action="addturf.inc.jsp" method="get">
                            
			<label for="tname" class="required"><b>Turf Name</b></label>
                        <input type="text" placeholder="Enter Turf Name" name="tname" required>

		        <label for="tphone" class="required"><b>Turf Phone</b></label>
		        <input type="text" placeholder="Enter Business Phone" name="tphone" required>

		        <label for="taddr" class="required"><b>Turf Address</b></label>
		        <input type="text" placeholder="Enter Address" name="taddr" required>

		        <label for="taddr" class="required"><b>Rate per Hour</b></label>
		        <input type="text" placeholder="Enter Price" name="rph" required>

				<label for="taddr" class="required"><b>enter the name of the Turf image</b></label>
		        <input type="text" placeholder="name must be in .jpg format" name="img" required>

                        <input type="file" name="photo" value="attach" accept="image" required>

                    <div class="clearfix">
                            <button type="button" onClick="window.location.href = 'index.jsp';" class="cancelbtn">Cancel</button>
                            <button type="submit" class="signupbtn">Add Turf</button>
		        </div>
				</div>
			</form>
		</body>
</html>
