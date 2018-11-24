[![codecov](https://codecov.io/gh/kellylougheed/participation/branch/master/graph/badge.svg)](https://codecov.io/gh/kellylougheed/participation)

<h1>Participation</h1>

<b>This app was built in Ruby on Rails, JavaScript, jQuery, HTML, CSS, and Bootstrap.</b>

Participation allows teachers to track student participation with a fair, points-based system.

<img src="http://www.kellylougheed.com/images/projects/participation.png"/><br/>

<h2>Features:</h2>

<ul>
<li> Teachers can create multiple classes with rosters of students that are listed alphabetically by last name.</li><br/>

<li> Teachers initialize each class with a maximum number of participation points to earn and a default number that each student starts with. All students are initialized with the default point value.</li><br/>

<li> Teachers can add or subtract points from students using the plus or minus buttons, which send an AJAX call to the database.</li><br/>

<li> Points for each student are automatically converted into percentages.</li><br/>

<li> Students' point values can be cleared and set back to the default. This action can be done on all students in a class at one time.</li><br/>

<li> Teachers can add comments about individual students that are dated for future reference.</li><br/>

<li> Teachers can have comments automatically mailed to students.</li><br/>

<li> Devise manages users, security, and logins.</li><br/>

<li> The data is queried and stored with PostgreSQL.</li><br/>
</ul>
