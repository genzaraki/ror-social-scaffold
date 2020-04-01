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