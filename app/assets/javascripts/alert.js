document.addEventListener('DOMContentLoaded', () => {

    // Get all "navbar-burger" elements
    const $alert = Array.prototype.slice.call(document.querySelectorAll('.notification .delete'), 0);
  
    // Check if there are any navbar burgers
    if ($alert.length > 0) {
  
      // Add a click event on each of them
      $alert.forEach( el => {
        el.addEventListener('click', (event) => {
  
          // Get the target from the "data-target" attribute
          const target = event.target;
          const $target = target.parentElement;
  
          $target.parentNode.removeChild($target);
  
        });
      });
    }
  
  });