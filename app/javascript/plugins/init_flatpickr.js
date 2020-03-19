// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
const pickDates = () => {
  const dateInput = document.getElementById('pickup_date');
  
  // Check that the query selector id matches the one you put around your form.
  if (dateInput) {
    const unavailableDates = JSON.parse(document.querySelector('.pickup-booking-dates').dataset.unavailable)

  flatpickr(dateInput, {
    minDate: "today",
    disable: unavailableDates,
    dateFormat: "Y-m-d", 
    inline: true,
  });
  }

  // const bookedDates = document.querySelectorAll('.flatpickr-day.flatpickr-disabled');
  // bookedDates.forEach(element => {
  //   const date = element.getAttribute("aria-label")
  //   debugger
  // });

  console.log('im in the file')
}  

export {pickDates}