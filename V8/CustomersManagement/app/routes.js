
var Customer = require('./models/customer');
var Purchase = require('./models/purchase');
var Invoice = require('./models/invoice');

var urlPrefix = '/api';

module.exports = function(app,_){

	customersFixture = [
		{
			fname: 'Joe',
			sname: 'Cocker',
			age: 20
		},
		{
			fname: 'Bill',
			sname: 'Murry',
			age: 25
		},
		{
			fname: 'Micheal',
			sname: 'Jordan',
			age: 48
		},
		{
			fname: 'Larry',
			sname: 'The locksmith',
			age: 28
		},
		{
			fname: 'Bart',
			sname: 'Simpson',
			age: 16
		},
		{
			fname: 'Peter',
			sname: 'Griffin',
			age: 45
		}
	];

////////////////////////////////////////////////
//Rest routes

	//find all customers
	app.get(urlPrefix+'/customers', function(req,res){
		//res.json(customersFixture)
		Customer.find(function(err, customers){
			if(err) return console.error(err);
				res.json(customers);
		})
	})

	//find all purchases for a given customer
	app.get(urlPrefix+'/customers/:id/purchases', function(req,res){
		//If customer had an array of purchase refs we could just use populate on the customer.purchases ref
		//But that gives us a second set of reference pointers that could get out of sync if there was a change between customers and purchases
		//Its safer to do a find of all purchases with the customer_id
		Purchase
			.find({_customer: req.params.id})
			.populate('_customer')
			.exec(function(err, purchases){
			if(err) return console.error(err);
				res.json(purchases);
		})
	})

	//find all purchases for a given customer
	app.get(urlPrefix+'/customers/:id/private/purchases/', function(req,res){
		//If customer had an array of purchase refs we could just use populate on the customer.purchases ref
		//But that gives us a second set of reference pointers that could get out of sync if there was a change between customers and purchases
		//Its safer to do a find of all purchases with the customer_id
		Purchase
			.find({_customer: req.params.id},req.params.unchecked)
			.populate('_customer')
			.exec(function(err, purchases){
			if(err) return console.error(err);
				res.json(purchases);
		})
	})

	//find all invoices for a given customer as a private API
	app.get(urlPrefix+'/customers/:id/private/invoices', function(req,res){
		//If customer had an array of invoices refs we could just use populate on the customer.invoices ref
		//Its safer to do a find of all invoices with the customer_id
		Invoice
			.find({_customer: req.params.id})
			.populate('_customer')
			.exec(function(err, invoices){
			if(err) return console.error(err);
				res.json(invoices);
		})
	})

	//create a customer
	app.post(urlPrefix+'/customers', function(req,res){
		var createCustomer = new Customer({
			fname: req.body.fname,
			sname: req.body.sname,
			age: req.body.age
		});
		createCustomer.save(function(err, customers){
			if(err) return console.error(err);

			res.json(createCustomer);
		})
	})

	//update a customer
	app.put(urlPrefix+'/customers/:id', function(req,res){
		//if nothing to do return
		if(req.body == null || req.body == undefined){
			res.json(req.body)
			return
		}

		//else continue to update customer details
		//only update what exists in req.body
		var updateCustomer = {};
		if(req.body.fname != null){
			updateCustomer.fname = req.body.fname;
		}
		if(req.body.sname != null){
			updateCustomer.sname = req.body.sname;
		}
		console.log(updateCustomer);

		Customer.findByIdAndUpdate(req.params.id, updateCustomer, function(err, updatedCustomer){
			if(err) return console.error(err);

			res.json(updatedCustomer);
		})
	});

	app.del(urlPrefix+'/customers/:id', function(req,res){
		Customer.find({_id:req.params.id}).remove(function(err){
			res.json(err);
		});
	})


//////////////////////////////
//Purchases

	//get all purchases
	app.get(urlPrefix+'/purchases', function(req,res){
		Purchase
			.find()
			.populate('_customer')
			.exec(function(err, purchases){
				if(err) return console.error(err);
					res.json(purchases);
			})
	})

	//create an purchase
	app.post(urlPrefix+'/purchases', function(req,res){
		var createPurchase = new Purchase({
			_customer: req.body.customer_id,
			type: req.body.type
		});
		createPurchase.save(function(err, purchases){
			if(err) return console.error(err);

			res.json(createPurchase);
		})
	})

//////////////////////////////
//Invoices

	//get all invoices
		app.get(urlPrefix+'/invoices', function(req,res){
			Invoice
				.find()
				.populate('_invoice')
				.exec(function(err, invoices){
					if(err) return console.error(err);
						res.json(invoices);
				})
		})

		//create an purchase
		app.post(urlPrefix+'/invoices', function(req,res){
			var createInvoice = new Invoice({
				_customer: req.body.customer_id,
				type: req.body.type
			});
			createInvoice.save(function(err, invoices){
				if(err) return console.error(err);

				res.json(createInvoice);
			})
		})

//////////////////////////////
//static routes

	// route to handle all angular requests
	app.get('*', function(req, res) {
		res.sendfile('./public/index.html');
	});

}
