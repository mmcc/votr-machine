var total_votes;
var unique_id;
var my_votes = 0;

function disableVoting() {
  alert("This round's over! New round starting...");
  window.location.reload();
}

function update_votes(message) {
  console.log("Message Recieved");
  total_votes = message.total_votes;
  $.each(message.items, function(index, value) {
    $("#item_" + this.id + " .votes").text(this.votes);
  });
  update_percentages(message);
}

function update_percentages(message) {
  total_votes = message.total_votes;
  $.each(message.items, function(index, value) {
    percentage = this.votes / total_votes;
    $("#item_" + this.id + " .progress .bar").width(percentage * 100 + "%");
  });
}

$(function () {
  $('.delete-item').click(function(event) {
    event.preventDefault();
    var $link = $(this);
    $.ajax({
      type: 'DELETE',
      url: $link.attr('href'),
      success: function (response) {
        $link.remove();
        console.log(response);
      },
      error: function (response) {
        console.log("Error: Item not deleted.");
        alert("Item could not be deleted.");
      }
    });
  });
});