App = {
  say: function(string) { console.log(string) },
  ifMultipleOf: function(number, check, callback) {
    (check % number) == 0 ? callback(check) : nil;
  },
  ifEven: function(number, callback) {
    App.ifMultipleOf(2, number, callback);
  },
  proclaimEvenness: function(number) {
    App.say("It would appear that "+number+" is an even number.");
  }
}
App.say("Hello, world!");
App.ifEven(42, App['proclaimEvenness']);
