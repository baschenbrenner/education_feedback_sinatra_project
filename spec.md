Specifications for the Sinatra Assessment

Specs:

 x - Use Sinatra to build the app
 x - Use ActiveRecord for storing information in a database
 x - Include more than one model class (list of model class names e.g. User, Post, Category)
    I have three models, students, teachers and feedback
 x - Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
    I have three has_many relationships, teachers have many students, students have many feedbacks, and teachers have many feedbacks through students
 x - Include user accounts
    Teachers and students have user accounts
 x - Ensure that users can't modify content created by other users
    I put if/else selectors under all get routes that led to sensitive areas. Because I had two types of users I added a key called :user_type to sessions to distinguish between the two different kinds of users.
 x - Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
     I have a way to make new feedback, edit feedback, delete feedback and of course review the feedback given previously by a student. The teacher has access to review feedback from individual students and to see aggregate feedback from all students.
 x- Include user input validations
    I have made form fields required and added routes to deal with differentiated types of input - in the create new feedback form students can input new feedback written in a text box or they can select from feedback that is generated from a list of previous responses (limited to one word options to avoid getting more personal feedback)
 x - Display validation failures to user with error message (example form URL e.g. /posts/new)
    I included flash[:message] messages in all the routes it was appropriate. I am not 100% happy with this part of the site because they are not consistently shown and I'm having trouble understanding why. In one case a <br/> before the <% if flash.has? ... code made the message not appear. In the ActionDispatch::Flash resource I found online it says that the flash only sticks around for the very next action. I would like to talk more about this in the review of the project.

x-  Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  I don't know what is meant by install instructions or a contributors guide, but I included some thoughts in the README about the purpose of the web app.
  
Confirm

 x - You have a large number of small Git commits
 x - Your commit messages are meaningful
 x - You made the changes in a commit that relate to the commit message
 x - You don't include changes in a commit that aren't related to the commit message
