var mongoose = require('mongoose');

var invoiceSchema = mongoose.Schema({
	_customer: {
		type: String,
		ref: 'Customer'
	},
	type: String,
	uid: Number,
	amount: Number,
	currency: String,
});

module.exports = mongoose.model('Invoice', invoiceSchema);
