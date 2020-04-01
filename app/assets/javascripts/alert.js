document.addEventListener('DOMContentLoaded', () => {
    const $alert = Array.prototype.slice.call(document.querySelectorAll('.notification .delete'), 0);
      if ($alert.length > 0) {  
      $alert.forEach( el => {
        el.addEventListener('click', (event) => {
            const target = event.target;
          const $target = target.parentElement;  
          $target.parentNode.removeChild($target);
  
        });
      });
    }
  
  });