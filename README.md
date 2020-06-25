# Orbital_20

This is the Repository for Orbital project.

## Milestone #2

### 1. Project Status Until The End of June

1. User Interface
-  Basic navigation design
-  Draft about each page

2. Functionality
- Add task to the global task list
- Add module to the module list
- Add task under each module
- Link each task to the corresponding study view
- Setting the timer in the study view
- Go the the current working assignment from main page

Note: Global task list contains all the task recorded in the system, and each module has a task list for itself.
You can add some tasks when you create the module(default assignment)

3. Summary
We have implemented some basic function for this application. But we haven't consider the quality of UI, we only use the default List and NavigationView in 
swift UI. We need to work on the UI design and then implement them with swiftUI. 

### 2. Things Need To Be Done in July
1. User Interface
- Consider the Human Interface Documentation from Apple
- Design the Interface using Adobe XD
- Implement the better design using swiftUI
- Add a view for statistic data (Consider the representation of the data,eg.pie chart...)

2. Functionality
- Implement the extend feature of task (You can extend the study time after the timer stop but the task has not done yet)
- Implement the statistic collection mechanism
- Testing and find out the bugs
- Implement the Notification mechanism
- Implement the ordering of the task
- Implement the auto-reflecting mechanism (Using the time of reflection, give user a feedback about how well they plan the time)
- Detect the backward
- Muti-select and delete

3. Code
- Change the code to a neater way (Consider the OOP principle, but sometimes it's quite hard for view representation)

### 3. Problem Encountered

1. Core Data
- We spend quite a lot of time to figure out how to use the core data in Swift. We need to know how to fetch the result and how to use it. Turns out it quite simple, because 
it is like the normal class.
- I tried to let each Module has a property assignmentList. It is a reasonable design, but it has some problem when I implement the functinality. So I just delete this property. We get the task list of a module by going through all task, and display those with the same module name. But it is not a good design as mentioned above, this is something we need to change.

2. Functionality
- Display of the list: We use the built in List View to represent both module list and task list
- Creation of task under a new module and "raw" new task: We tried to use the same struct NewTaskView to represent both of them, since the only difference is 
creation of task under a new module needs a fixed module name. We tried to do this by adding an Module?（Optional Module）. So when there is a module, we can 
fix the module name, otherwise, just have a normal procedure to create a module. But it seems not work for me. So I just hard code another struct for creation of task
under a new module (or module). But I believe there is a better way, so this should be fixed in July.
- Passing the parameter between the view: At first we are confused about how to pass a parameter between the view since we need to consider the abstraction. Our solution
is using @Binding in the sub-view. So that when the parameter change, it will trigger the change all the way to the root view.
- Delete module and all associate tasks: At first we can only delete the module, but the task associate with it still in the core data. So we write a new deletion function to
achieve to delete all the task associate with this module instead of only deleting the module name in core data
