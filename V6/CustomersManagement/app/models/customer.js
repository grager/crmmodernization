var mongoose = require('mongoose');

var customerSchema = mongoose.Schema({
	fname: String,
	sname: String,
	age: Number
});

module.exports = mongoose.model('Customer', customerSchema);
