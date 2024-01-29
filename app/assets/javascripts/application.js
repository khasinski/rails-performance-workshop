// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require bootstrap-sass-official
//= require_self

$(document).ready(function() {
  $('#searchbox').on('keyup', function() {
    var query = $(this).val();
    $.get('/pets.json?q=', { q: query }, function(data) {
      var pets = data.pets;
      var matching_pets_count = data.matching_pets_count;
      var search_results = $('#search-results');

      console.log('search_results pets:', pets);
      var html = '';

      html += pets.map(function(pet) {
        return `<li><a href="${pet.link}"> ${pet.name} (${pet.breed})</a></li>\n`
      }).join('');

      if (matching_pets_count && parseInt(matching_pets_count) > 0) {
        html += '<li role="separator" class="divider"></li>\n'
        html += '<li><a href="/pets?q=' + query + '">See all results (' + matching_pets_count + ')</a></li>\n'
      }

      search_results.html(html);
      if(pets.length > 0){
        search_results.show();
      } else {
        search_results.hide();
      }
    });
  });
});
