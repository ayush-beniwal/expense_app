import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart'; //imported to use intl

class NewExpense extends StatefulWidget {
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle =
  //       inputValue; //no need to use setstate as the UI does not update
  // } //we use this function with text field onChanged, and it recieves the input
  // string each time
  final _titleController =
      TextEditingController(); //letting flutter do the heavy work
  //of storing the text input. we can just access titleController.text to access the string
  final _amountController = TextEditingController();
  DateTime? _selectedDate; // ? denotes it can be null
  Category _selectedCaterogy = Category.leisure;

  void _presentDatePicker() async {
    //using flutter's inbuilt date picker
    final now = DateTime.now(); //using DateTime to get the now
    final firstDate =
        DateTime(now.year - 1, now.month, now.day); //using contructor
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now, //the default selected date
      firstDate: firstDate, //the first date that can be selected
      lastDate: now, //the last date can be selected
    ) /*.then((value) => null)*/;
    setState(() {
      _selectedDate = pickedDate; //only done after waiting for pickedDate
    });
    //the showDatePicker returns a Future object. which
    //is a special type of object, and stores a value which we dont have yet, but
    //will get later. It is returned by the showDatePicker, and can be accessed by
    //using a special method called the, which takes a anonymous fn.
    //A more convinient method we will use here, is using the async  await keyword
    //we add async in front of the parentheses of the fn, and await in front of the
    //code which returns the future
    //we can then store it as a value in a variable, using await.
    //What this will do, is basically wait till we get that value, and the code after
    //the function will only be executed once we get that value
  }

  @override
  void dispose() {
    // it is important to implement dispose, otherwise textEditingController, will live
    //on in memory even after the modal closes, and we dont want that.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            TextField(
              //A built in widget for text entry
              // onChanged: _saveTitleInput, This is one way to save input text,
              //by calling onChanged each time the user enters a keystroke
              controller: _titleController,
              maxLength: 50,
              decoration:
                  const InputDecoration(label: Text("Title")), //to add label
              //we use decoration argument, and set it to InputDecoration & set label inside
              //it
            ),
            Row(
              children: [
                Expanded(
                  //we add expanded as textField tries to take as much space
                  //as available on screen, so this will cause problems in a row.
                  // same problem as row inside row or column inside column etc.
                  child: TextField(
                    controller: _amountController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixText: '\$', //adds a prefix text to the field
                        //(we are escaping the dollar with the backslash, as dollar is a special character)
                        label: Text("Enter Amount")),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, //sets where items start from
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // vertical centering
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(
                            _selectedDate!)), //Here, we are setting text as No Date
                    //Selected if it is null, else using formatted to show the selected date.
                    // we use the exclamation mark to tell dart, that the value won't be null

                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.date_range))
                  ],
                ))
              ],
            ),
            Row(
              children: [
                DropdownButton(
                    //to select a catergry
                    value:
                        _selectedCaterogy, //setting the value of the drop down
                    items: Category.values //items which are to be displayed
                        .map(
                          (category) => DropdownMenuItem(
                            value: category, //this is the value that we send to onChanged
                            child: Text(
                              category.name.toUpperCase(), //name used to convert enum to string
                            ),
                          ),
                        )
                        .toList(),
                    //Drop downbutton expects a list of dropdownmenuitems. 
                    //We can convert list of one type to another via map. 
                    //use the map method again, to convert the Category.values enum (which gives)
                    //us a list, to values of DropdownmenuItem. 
                    //Map wants a function which will be executed for each item
                    //The method recieves a value which
                    //is simply catergory, (for each enum value) and a function which returns a
                    //drop down menu item. in the argument for dropdownmenuitem, we set value
                    //as catergory, child as text and call name method on catergory to get its value
                    // We set the value as category, so that flutter knows what sort of value it is
                    //dealing with when we press onChanged.
                    onChanged: (value) {
                      setState(() {  //we set the state to show the current value if its changed
                        if (value == null) { //ensuring value is not null
                          return;
                        }
                        _selectedCaterogy = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); //simply removes overlay from screen
                    },
                    child: const Text("Close")),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Save Expense")),
              ],
            )
          ],
        ) //we use listview when we want scrollabilty
        );
  }
}