class PersonTypeOfBirth < ActiveRecord::Base
  self.table_name = :person_type_of_birth
  self.primary_key = :person_type_of_birth_id
  include EbrsAttribute

  has_many :person_birth_details, foreign_key: "person_type_of_birth_id"
end
