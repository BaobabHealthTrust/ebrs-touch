=begin
birth_registration_types = BirthRegistrationType.all
birth_registration_types.each do |birth_registration_type|
    birth_registration_type_couchdb = BirthRegistrationTypeCouchdb.new
    birth_registration_type_couchdb.birth_registration_type_id = birth_registration_type.birth_registration_type_id
    birth_registration_type_couchdb.name = birth_registration_type.name
    birth_registration_type_couchdb.save
end
=end
birth_registration_type_couchdbs = BirthRegistrationTypeCouchdb.all
birth_registration_type_couchdbs.each do |birth_registration_type_couchdb|
  birth_registration_type = BirthRegistrationType.new
  birth_registration_type.birth_registration_type_id = birth_registration_type_couchdb.birth_registration_type_id
  birth_registration_type.name = birth_registration_type_couchdb.name
  birth_registration_type.save
end



=begin
education_levels = LevelOfEducation.all
education_levels.each do |education_level|
  level_of_education_couchdb = LevelOfEducationCouchdb.new
  level_of_education_couchdb.level_of_education_id = education_level.level_of_education_id
  level_of_education_couchdb.name = education_level.name
  level_of_education_couchdb.save
end
=end
level_of_education_couchdbs = LevelOfEducationCouchdb.all
level_of_education_couchdbs.each do |level_of_education_couchdb|
  education_level = LevelOfEducation.new
  education_level.level_of_education_id = level_of_education_couchdb.level_of_education_id
  education_level.name = level_of_education_couchdb.name
  education_level.save
end

=begin
locations = Location.all
locations.each do |location|
  location_couchdb = LocationCouchdb.new
  location_couchdb.location_id = location.location_id
  location_couchdb.code = location.code
  location_couchdb.name = location.name
  location_couchdb.description = location.description
  location_couchdb.postal_code = location.postal_code
  location_couchdb.country = location.country
  location_couchdb.latitude = location.latitude
  location_couchdb.longitude = location.longitude
  location_couchdb.county_district = location.county_district
  location_couchdb.creator = location.creator
  location_couchdb.changed_by = location.changed_by
  location_couchdb.changed_at = location.changed_at
  location_couchdb.save
end
=end
location_couchdbs = LocationCouchdb.all
location_couchdbs.each do |location_couchdb|
  location = Location.new
  location.location_id = location_couchdb.location_id
  location.code = location_couchdb.code
  location.name = location_couchdb.name
  location.description = location_couchdb.description
  location.postal_code = location_couchdb.postal_code
  location.country = location_couchdb.country
  location.latitude = location_couchdb.latitude
  location.longitude = location_couchdb.longitude
  location.county_district = location_couchdb.county_district
  location.creator = location_couchdb.creator
  location.changed_by = location_couchdb.changed_by
  location.changed_at = location_couchdb.changed_at
  location.save
end
=begin
location_tags = LocationTag.all
location_tags.each do |location_tag|
  location_tag_couch_db = LocationTagCouchdb.new
  location_tag_couch_db.location_tag_id = location_tag.location_tag_id
  location_tag_couch_db.name = location_tag.name
  location_tag_couch_db.description = location_tag.description
  location_tag_couch_db.save
end
=end
location_tag_couch_dbs = LocationTagCouchdb.all
location_tag_couch_dbs.each do |location_tag_couch_db|
  location_tag = LocationTag.new
  location_tag.location_tag_id = location_tag_couch_db.location_tag_id
  location_tag.name = location_tag_couch_db.name
  location_tag.description = location_tag_couch_db.description
  location_tag.save
end

=begin
location_tag_maps = LocationTagMap.all
location_tag_maps.each do |location_tag_map|
  location_tag_map_couch_db = LocationTagMapCouchdb.new
  location_tag_map_couch_db.location_id = location_tag_map.location_id
  location_tag_map_couch_db.location_tag_id = location_tag_map.location_tag_id
  location_tag_map_couch_db.save
end
=end

location_tag_map_couch_dbs = LocationTagMapCouchdb.all
location_tag_map_couch_dbs.each do |location_tag_map_couch_db|
  location_tag_map = LocationTagMap.new
  location_tag_map.location_id = location_tag_map_couch_db.location_id
  location_tag_map.location_tag_id = location_tag_map_couch_db.location_tag_id
  location_tag_map.save
end

=begin
mode_of_deliveries = ModeOfDelivery.all
mode_of_deliveries.each do |delivery_mode|
  mode_of_delivery_couch_db = ModeOfDeliveryCouchdb.new
  mode_of_delivery_couch_db.mode_of_delivery_id = delivery_mode.mode_of_delivery_id
  mode_of_delivery_couch_db.name = delivery_mode.name
  mode_of_delivery_couch_db.description = delivery_mode.description
  mode_of_delivery_couch_db.save
end
=end

mode_of_delivery_couch_dbs = ModeOfDeliveryCouchdb.all
mode_of_delivery_couch_dbs.each do |mode_of_delivery_couch_db|
  delivery_mode = ModeOfDelivery.new
  delivery_mode.mode_of_delivery_id = mode_of_delivery_couch_db.mode_of_delivery_id
  delivery_mode.name = mode_of_delivery_couch_db.name
  delivery_mode.description = mode_of_delivery_couch_db.description
  delivery_mode.description.save
end

=begin
person_attribute_types = PersonAttributeType.all
person_attribute_types.each do |person_attribute_type|
  person_attribute_type_couch_db = PersonAttributeTypesCouchdb.new
  person_attribute_type_couch_db.person_attribute_type_id = person_attribute_type.person_attribute_type
  person_attribute_type_couch_db.name = person_attribute_type.name
  person_attribute_type_couch_db.description = person_attribute_type.description
  person_attribute_type_couch_db.save
end
=end

person_attribute_type_couch_dbs = PersonAttributeTypesCouchdb.all
person_attribute_type_couch_dbs.each do |person_attribute_type_couch_db|
  person_attribute_type = PersonAttributeType.new
  person_attribute_type.person_attribute_type = person_attribute_type_couch_db.person_attribute_type_id
  person_attribute_type.name = person_attribute_type_couch_db.name
  person_attribute_type.description = person_attribute_type_couch_db.description
  person_attribute_type.save
end

=begin
person_relationship_types = PersonRelationType.all
person_relationship_types.each do |person_relationship_type|
  person_relationship_type_couch_db = PersonRelationshipTypesCouchdb.new
  person_relationship_type_couch_db.person_relationship_type_id = person_relationship_type.person_relationship_type_id
  person_relationship_type_couch_db.name = person_relationship_type.name
  person_relationship_type_couch_db.description = person_relationship_type.description
  person_relationship_type_couch_db.description = person_relationship_type.description
  person_relationship_type_couch_db.save
end
=end

person_relationship_type_couch_dbs = PersonRelationshipTypesCouchdb.all
person_relationship_type_couch_dbs.each do |person_relationship_type_couch_db|
  person_relationship_type = PersonRelationType.new
  person_relationship_type.person_relationship_type_id = person_relationship_type_couch_db.person_relationship_type_id
  person_relationship_type.name = person_relationship_type_couch_db.name
  person_relationship_type.description = person_relationship_type_couch_db.description
  person_relationship_type.save
end

=begin
person_type_of_births = PersonTypeOfBirth.all
person_type_of_births.each do |person_type_of_birth|
  person_type_of_births_couch_db = PersonTypeOfBirthsCouchdb.new
  person_type_of_births_couch_db.person_type_of_birth_id = person_type_of_birth.person_type_of_birth_id
  person_type_of_births_couch_db.name = person_type_of_birth.name
  person_type_of_births_couch_db.description = person_type_of_birth.description
  person_type_of_births_couch_db.save
end
=end

person_type_of_births_couch_dbs = PersonTypeOfBirthsCouchdb.all
person_type_of_births_couch_dbs.each do |person_type_of_births_couch_db|
  person_type_of_birth = PersonTypeOfBirth.new
  person_type_of_birth.person_type_of_birth_id = person_type_of_births_couch_db.person_type_of_birth_id
  person_type_of_birth.name = person_type_of_births_couch_db.name
  person_type_of_birth.description = person_type_of_births_couch_db.description
  person_type_of_birth.save
end

=begin
statuses = Status.all
statuses.each do |status|
  status_couch_db = StatusCouchdb.new
  status_couch_db.status_id = status.status_id
  status_couch_db.name = status.name
  status_couch_db.description = status.description
  status_couch_db.save
end
=end

status_couch_dbs = StatusCouchdb.all
status_couch_dbs.each do |status_couch_db|
  status = Status.new
  status.status_id = status_couch_db.status_id
  status.name = status_couch_db.name
  status.description = status_couch_db.description
  status.save
end