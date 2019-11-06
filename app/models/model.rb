# this is a simple model example
# check https://datamapper.org/getting-started.html
class Transaction
	include DataMapper::Resource
	property :id, Serial,      :key => true  			    # An auto-increment integer key
	property :date,	 				DateTime
	property :sourceCurrence,      	String    # A varchar type string, for short strings
	property :sourceValue,   		Numeric 
	property :destinationCurrence,  String    
	property :destinationValue,   	Numeric

end
