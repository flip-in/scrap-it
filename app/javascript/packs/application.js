require('jquery')
import "bootstrap";
import flatpickr from "flatpickr";
import {progressBar} from "../plugins/progress_bar"

// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
const dateInput = document.getElementById('pickup_date');

// Check that the query selector id matches the one you put around your form.
if (dateInput) {

flatpickr(dateInput, {
  minDate: "today",
  dateFormat: "Y-m-d", 
  inline: true,
});
}
console.log('im in the file')

progressBar();