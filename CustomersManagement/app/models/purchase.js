var mongoose = require('mongoose');

var purchaseSchema = mongoose.Schema({
	_customer: {
		type: String,
		ref: 'Customer'
	},
	type: String,
	date: Number,
	description: String,
});

module.exports = mongoose.model('Purchase', purchaseSchema);
