var PLDA = require('./build/Release/plda');

console.log("The PLDA V8 add-on:");
console.log(PLDA);
console.log();

var model = new PLDA.LDAModel();

console.log("A PLDA model instance:");
console.log(model);
console.log();
