# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    App uses Sinatra framework
- [x] Use ActiveRecord for storing information in a database
    App uses ActiveRecord to create migrations and databases to store all information for Users, Plants, and Waters
- [x] Include more than one model class (e.g. User, Post, Category)
    Includes User, Plant, and Water models
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    User has many plants
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    Plants belong to a user
    Waters belong to a plant
- [x] Include user accounts with unique login attribute (username or email)
    User model checks for uniqueness of username and email
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    Plants can be created, updated and destroyed only by the user that created them
    Watering Schedules can be created, updated, and destroyed only by the user that created them
    Plants and watering schedules can be read by anyone on the site. 
- [x] Ensure that users can't modify content created by other users
    Controllers check that current user is the same as the user who created the plant/watering schedule before loading the edit page. 
- [x] Include user input validations
    Controllers ensure parameters aren't blank before allowing creation or editing. 
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message