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
- adding/deleting an assignment.
- Arrange the assignment by the due date.
- List of assignments and categorize them.

## Extension Feature
- Entend the study time after the timer finish but the work haven't done
- Notification when user quit the application and alert if the input is not in correct format
- Giving statistic about how much time the user spent on a certain module and use pie chart to display it

## Milestone #3

### 1.Bugs squashed
- The StudyView only display the fixed time. 
  
  **Reason**: Careless implementation.
  
  **Solution**: Using the TimeInterval type in SwiftUI, change the duration of each task to the TimeInterval and noted down the current time, we can get the expected finishing time.
- Deleting task will cause runtime error.

  **Reason**: The core data will have internal operation to change the optional value of data structure to nil. We didn't handle the optional value.
  
  **Solution**: Handle the optional by give a default value (An empty string for each component)
  
 ### 2.Feature Implemented (Bold is the newly update for Milestone#3)
 #### a. User Interface  
- **Using tab view to navigate between the 3 components
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
- **Mutiselect the module and delete them**
- **Ordering the task by the due date**

#### c. Notification and Alert
- **Schedule the notification one day before the due date**
- **Schedule the notification at the planned time**
- **Alert when using input an empty string at module name, task name or duration**

### 3. Problem Encounter
#### a. User Interface
- We do not want to show the tab bar when user creating a new task. At first we use a button to toggle whether show the NewTaskView or not, but it does not give a nice representaiton and tab bar will remain there when creating new task. We try pass around one variable called *ShowFullScreen*, but this gives a worse structure of the code. So we use the build in view modifier sheet to solve the problem.

- Apply OOP principle on the UI file. Last month, we didn't care about the OOP principle. Now we solve this by abstract out some similar view into one file. Eg. TaskListView and ModuleTaskList, NewTaskView and ModuleTaskCreationView.

- Nest navigation view. We fix nest navigation view by abstract out some navigationlinks, since we should only have one NavigationView from the parent view to the children view.
