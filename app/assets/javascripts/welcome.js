(function () { 

  $( document ).ready(function() {
    $('.game-button').text(" ");
    $('.game-button').on('click', function() { 
      var node = $(this);
      node.text("X");
      var gameState = { };
      $('.game-button').each(function() { 
	var node = $(this);
	gameState[node.attr('id')] = node.text() || ' ';
      });
      $.get('/update', { 
	gameState: gameState
      }, function(data) { 
	if (data.winner) { 
	  alert("winner: " + data.winner);
	} else {
	  for( var i in data ) { 
	    console.log(i);
	    $('#' + i).text(data[i]);
	  }
	}
      });

    });
  });

})();
