# Orbital_20

This is the Repository for Orbital project.

## Team Name
GYXX

## Level of Achievement
Genemi

## Aim and Motivation
We, college students, all have the problem of procrastinating our assignment till the last minutes. It’s not that we don’t want to get all the work done early, sometimes, there are just too many assignments and we don’t even know where to start.
                    
With that in mind, time management is really crucial for university life, if you want to have a life other than worrying about all the homework all day. Spending one night rushing everything right before the deadline is not the solution, and clearly does not guarantee good quality! 

We want to make a time management application for IOS, so that student can arrange their assignments on the calendar, and use tomato timer during the study time without being distracted by this fantastic world. Also, we provide the analysis of the procedure of finishing this assignment (whether keep delaying the task,etc.). Using this analysis, users can reflect on themselves about how they feel the assignment, what they can improve, how to be more efficient? We will provide a template for the reflection

## Basic Feature
- Adding/deleting an assignment.
- Arrange the assignment by the due date.
- List of assignments and categorize them.

## Extension Feature
- Notification when the user quit the application 
- Alert if the input is not in a correct format
- Store statistic about the amount of time the user spent on a certain module
- Use the pie chart to display the percentage of time spent on different modules


## Milestone #3

### 1.Bugs squashed
- The StudyView only displays the fixed time. 
  
  **Reason**: Careless implementation.
  
  **Solution**: Using the TimeInterval type in SwiftUI, change the duration of each task to the TimeInterval, and noted down the current time, we can get the expected finishing time.
- Deleting tasks will cause a runtime error.

  **Reason**: The core data will have an internal operation to change the optional value of data structure to nil. We didn't handle the optional value.
  
  **Solution**: Handle the optional by giving a default value (An empty string for each component)
  
 ### 2.Feature Implemented (Bold are newly updated functions for Milestone#3)
 #### a. User Interface  
- **Using tab view to navigate between the 3 components**
- **Using a pie chart and a list representation of the statistic data (How much time you spent on certain module)**
- **Using sheet as a better way to show the new task view**
- **Fix the nested navigation view**
- **A different view to show completed task (cross out the name)**

#### b. Functionality
- Add tasks to the global task list
- Add modules to the module list
- Add tasks under each module
- Link each task to the corresponding study view
- Setting the timer in the study view
- **Extend the timer after current timer stop**
- **Collect the statistic data for each module**
- **Multi-select the module and delete them**
- **Ordering the task by the due date**

#### c. Notification and Alert
- **Schedule the notification one day before the due date**
- **Schedule the notification at the planned time**
- **Alert when using input an empty string at module name, task name or duration**
- **Notify user when they backward to phone in study view**

### 3. Problem Encounter
#### a. User Interface
- We do not want to show the tab bar when the user is creating a new task. At first, we use a button to toggle whether show the NewTaskView or not, but it does not give a nice representation, and tab bar will remain there when creating a new task. We try to pass around one variable called *ShowFullScreen*, but this gives a worse structure of the code. So we use the build-in view modifier sheet to solve the problem.

- Apply OOP principle on the UI file. Last month, we didn't care about the OOP principle. Now we solve this by abstract out some similar view into one file. Eg. TaskListView and ModuleTaskList, NewTaskView and ModuleTaskCreationView.

- Nest navigation view. We fix the nest navigation view by abstract out some navigationlinks since we should only have one NavigationView from the parent view to the children's view.

#### b. Functionality
- Implement extend but the timer does not work. This is because we need another state called *end*. In the previous version, we only have 3 states, *initial, pause, running*. But we need the state *end* to implement a function that can extend the timer when the current timer is over. Without this, some functions in timer will clash, since we cannot differentiate the *initial* and *end* states. In this case, we set the timer to *initial* when the time is set, and set the timer to *end* when the timer is over. So we only trigger the "extend" in *end* state. 

- Creating a new task cannot work using the sheet associate with the view. When we use the sheet to present the view that displays new task creation, the core data would have an error. This is because the environment context is lost. We need to associate an environment variable to the sheet, so that core data is accessible inside the sheet.

- At first, I cannot collect the statistic from the timer. We play around with the date and found that we can note down the start timer whenever the start button for the timer is triggered. And collect the time using TimeInterval when the timer comes to the end, or the pause button is triggered. Using this method, we can collect the time that the user spent on a certain module.

- We tried to do multi-select and delete using the build-in function of core data, but we didn't achieve to do that. What we do is set a new variable *multi-select mode* to trigger a different representation of the interface, and maintain an optional array to collect the task that needs to be deleted. In this way, when press the *delete* button under the multi-select mode, it will delete the task that has been selected. 

- We tried to trigger the multi-select mode by a long-press gesture. But we found it cannot work well (maybe is the problem with the simulator). So we just add an *edit* button on the TaskListView. 

- Adding a new task when creating a new module will result in an unexpected alert. This is because I did not consider the situation when creating a module, the module name has fixed. So one @State variable will be empty.

### 4. User Testing
We give our app to some users to perform a certain task to understand the usability of the app.

The task includes:
- Add new module without any task
- Add new task inside an added module
- Add new task
- Study using our study timer
- View their statistic on the statistic view

Findings:
- Some users suggest that the view that is used to add a new module is not well-looking. Maybe the label of the back button should be just plain text instead of the image.
- It is quite easy to use the basic functionality, all users can figure out without any instruction
- The statistic representation can give users a good idea about how they spend time on different modules.
- Some users suggest that we should note down the time spent on a certain task and next time they enter the app, the timer will be set to the time remaining for a certain task. But our intension is that users did not leave this page until they finish their plan time. This design does not think about usability.
- They think the tab view is a good way to represent the main page.

Conclusion:
The app is satisfactory since most users can use it easily and most functionality is good. But there is some UX design that still needs to be considered. 
