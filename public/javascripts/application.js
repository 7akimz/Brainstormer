$(function() {
  var faye = new Faye.client('http://localhost:9292/faye');
  faye.subscribe("/messages/new", function(data) {
    alert(data);
  });
});
