[ ![Codeship Status for kellylougheed/participation](https://app.codeship.com/projects/5fcf5ac0-b11a-0134-b937-46f0c3813803/status?branch=master)](https://app.codeship.com/projects/193223) [![Coverage Status](https://coveralls.io/repos/github/kellylougheed/participation/badge.svg?branch=master)](https://coveralls.io/github/kellylougheed/participation?branch=master)

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

<img src="http://participation.herokuapp.com/assets/gradebook-91d0ddd474ec628a9365a51c2a366941.png" style="border: 1px solid #aaaaaa; box-shadow: 2px 2px 5px rgba(0,0,0,0.5);" /><br/><br/>

<li> Students' point values can be cleared and set back to the default. This action can be done on all students in a class at one time.</li><br/>

<li> Teachers can add comments about individual students that are dated for future reference.</li><br/>

<li> Devise manages users, security, and logins.</li><br/>

<li> The data is queried and stored with PostgreSQL.</li><br/>
</ul>
