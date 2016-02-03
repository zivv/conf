EDITOR = "vim";

var no = function() {
  print("Not on my watch.");
};

// Prevent dropping databases
db.dropDatabase = DB.prototype.dropDatabase = no; // Prevent dropping

// collections
DBCollection.prototype.drop = no;

// Prevent dropping indexes
DBCollection.prototype.dropIndex = no;


prompt = function() {
  if (typeof db == 'undefined') {
    return '(nodb)> ';
  }

  // Check the last db operation
  try {
    db.runCommand({
      getLastError: 1
    });
  } catch (e) {
    print(e);
  }

  var d = new Date();

  return (d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()) + " " +
    db + "> ";
}
