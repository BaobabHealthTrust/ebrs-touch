require 'couchrest_model'

class BirthRegistrationTypeCouchdb < CouchRest::Model::Base
  property :birth_registration_type_id, Integer
  property :name, String
  property :voided, TrueClass, :default => false
  property :void_reason, String
  property :voided_by, Integer
  property :date_voided, Date
  
  timestamps!

  design do
    view :by_birth_registration_type_id
    view :by_name
    view :by_name_and_voided
  end
end