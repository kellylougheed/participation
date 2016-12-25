<h1>Participation</h1>

<b>This app was built in Ruby on Rails, JavaScript, jQuery, HTML, CSS, and Bootstrap.</b>

Participation allows teachers to track student participation with a fair, points-based system.

<h2>Features:</h2>

<ul>
<li> Teachers can create multiple classes with rosters of students that are listed alphabetically by last name.</li><br/>

<li> Teachers initialize each class with a maximum number of participation points to earn and a default number that each student starts with. All students are initialized with the default point value.</li><br/>

<img src="http://participation.herokuapp.com/assets/newclass-96908be5e1ecc293f3d8c7a380128370.png"/><br/>

<li> Teachers can add or subtract points from students using the plus or minus buttons, which send an AJAX call to the database.</li><br/>

<li> Points for each student are automatically converted into percentages.</li><br/>

<img src="http://participation.herokuapp.com/assets/gradebook-91d0ddd474ec628a9365a51c2a366941.png"/><br/>

<li> Students' point values can be cleared and set back to the default. This action can be done on all students in a class at one time.</li><br/>

<li> Teachers can add comments about individual students that are dated for future reference.</li><br/>

<img src="http://participation.herokuapp.com/assets/student-ad79fbe931ea895a52c11e805e03706d.png"/><br/>

<li> Devise manages users, security, and logins.</li><br/>

<li> The data is queried and stored with PostgreSQL.</li><br/>
</ul>
