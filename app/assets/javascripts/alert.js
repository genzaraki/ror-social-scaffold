document.addEventListener('DOMContentLoaded', function() {
    var $alert = Array.prototype.slice.call(document.querySelectorAll('.notification .delete'), 0);
      if ($alert.length > 0) {  
      $alert.forEach( function(el){
        el.addEventListener('click', function(event){
            var target = event.target;
          var $target = target.parentElement;  
          $target.parentNode.removeChild($target);
  
        });
      });
    }  
  });

  document.addEventListener('DOMContentLoaded', () => {

    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  
    if ($navbarBurgers.length > 0) {
  
      $navbarBurgers.forEach( el => {
        el.addEventListener('click', () => {
  
          const target = el.dataset.target;
          const $target = document.getElementById(target);
  
          el.classList.toggle('is-active');
          $target.classList.toggle('is-active');
  
        });
      });
    }
  
  });