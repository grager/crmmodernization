var mongoose = require('mongoose');

var purchaseSchema = mongoose.Schema({
	_customer: {
		type: String,
		ref: 'Customer'
	},
	type: String
});

module.exports = mongoose.model('Purchase', purchaseSchema);
