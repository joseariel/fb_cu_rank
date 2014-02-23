@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  
	Entities.FiTypes = 
		"cu"	: { singular: "Credit Union", plural: "Credit Unions" }
		"bank": { singular: "Bank", plural: "Banks" }
		