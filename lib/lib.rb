module Lib
  require 'bean'
  require 'json'

  def self.new_child(params)
   core_person = CorePerson.create(
        :person_type_id     => PersonType.where(name: 'Client').last.id,
    )

    person = Person.create(
        :person_id          => core_person.id,
        :gender             => params[:person][:gender].first,
        :birthdate          => params[:person][:birthdate].to_date.to_s
     )

    PersonName.create(
        :person_id          => core_person.id,
        :first_name         => params[:person][:first_name],
        :middle_name        => params[:person][:middle_name],
        :last_name          => params[:person][:last_name]
    )

    person
  end

  def self.new_mother(person, params,mother_type)
    if params[:person][:type_of_birth].to_s.include? "Twin"
      mother_person = Person.find(params[:person][:prev_child_id]).mother
    elsif params[:person][:type_of_birth].to_s.include? "Triplet"
      mother_person = Person.find(params[:person][:prev_child_id]).mother
    else
        mother = params[:person][:mother]

        if mother[:first_name].blank?
          return nil
        end

        core_person = CorePerson.create(
            :person_type_id     => PersonType.where(name: mother_type).last.id,
        )

        mother[:citizenship] = 'Malawian' if mother[:citizenship].blank?
        mother_person = Person.create(
            :person_id          => core_person.id,
            :gender             => 'F',
            :birthdate          => ((mother[:birthdate].to_date.present? rescue false) ? mother[:birthdate].to_date : "1900-01-01"),
            :birthdate_estimated => ((mother[:birthdate].to_date.present? rescue false) ? 0 : 1)
        )

        PersonName.create(
            :person_id          => core_person.id,
            :first_name         => mother[:first_name],
            :middle_name        => mother[:middle_name],
            :last_name          => mother[:last_name]
        )

        cur_district_id         = Location.locate_id_by_tag(mother[:current_district], 'District')
        cur_ta_id               = Location.locate_id(mother[:current_ta], 'Traditional Authority', cur_district_id)
        cur_village_id          = Location.locate_id(mother[:current_village], 'Village', cur_ta_id)

        home_district_id        = Location.locate_id_by_tag(mother[:home_district], 'District')
        home_ta_id              = Location.locate_id(mother[:home_ta], 'Traditional Authority', home_district_id)
        home_village_id         = Location.locate_id(mother[:home_village], 'Village', home_ta_id)

        PersonAddress.create(
            :person_id          => core_person.id,
            :current_district   => cur_district_id,
            :current_ta         => cur_ta_id,
            :current_village    => cur_village_id,
            :home_district   => home_district_id,
            :home_ta            => home_ta_id,
            :home_village       => home_village_id,

            :current_district_other   => mother[:foreigner_home_district],
            :current_ta_other         => mother[:foreigner_current_ta],
            :current_village_other    => mother[:foreigner_current_village],
            :home_district_other      => mother[:foreigner_home_district],
            :home_ta_other            => mother[:foreigner_home_ta],
            :home_village_other       => mother[:foreigner_home_village],

            :citizenship            => Location.where(country: mother[:citizenship]).last.id,
            :residential_country    => Location.locate_id_by_tag(mother[:residential_country], 'Country')
        )
    end
    unless mother_person.blank?
      PersonRelationship.create(
              person_a: person.id, person_b: mother_person.person_id,
              person_relationship_type_id: PersonRelationType.where(name: mother_type).last.id
      )
    end
    mother_person
  end

  def self.new_father(person, params, father_type)
    if params[:person][:type_of_birth].to_s.include? "Twin"
      father_person = Person.find(params[:person][:prev_child_id]).father
    elsif params[:person][:type_of_birth].to_s.include? "Triplet"
      father_person = Person.find(params[:person][:prev_child_id]).father
    else
      father = params[:person][:father]
      father[:citizenship] = 'Malawian' if father[:citizenship].blank?
      father[:residential_country] = 'Malawi' if father[:residential_country].blank?

      if father[:first_name].blank?
        return nil
      end

      core_person = CorePerson.create(
          :person_type_id     => PersonType.where(name: father_type).last.id,
      )

      father_person = Person.create(
          :person_id          => core_person.id,
          :gender             => 'F',
          :birthdate          => (father[:birthdate].blank? ? "1900-01-01" : father[:birthdate].to_date),
          :birthdate_estimated => (father[:birthdate].blank? ? 1 : 0)
      )

      PersonName.create(
          :person_id          => core_person.id,
          :first_name         => father[:first_name],
          :middle_name        => father[:middle_name],
          :last_name          => father[:last_name]
      )

      cur_district_id         = Location.locate_id_by_tag(father[:current_district], 'District')
      cur_ta_id               = Location.locate_id(father[:current_ta], 'Traditional Authority', cur_district_id)
      cur_village_id          = Location.locate_id(father[:current_village], 'Village', cur_ta_id)

      home_district_id        = Location.locate_id_by_tag(father[:home_district], 'District')
      home_ta_id              = Location.locate_id(father[:home_ta], 'Traditional Authority', home_district_id)
      home_village_id         = Location.locate_id(father[:home_village], 'Village', home_ta_id)

      PersonAddress.create(
          :person_id          => core_person.id,
          :current_district   => cur_district_id,
          :current_ta         => cur_ta_id,
          :current_village    => cur_village_id,
          :home_district   => home_district_id,
          :home_ta            => home_ta_id,
          :home_village       => home_village_id,

          :current_district_other   => father[:foreigner_home_district],
          :current_ta_other         => father[:foreigner_current_ta],
          :current_village_other    => father[:foreigner_current_village],
          :home_district_other      => father[:foreigner_home_district],
          :home_ta_other            => father[:foreigner_home_ta],
          :home_village_other       => father[:foreigner_home_village],

          :citizenship            => Location.where(country: father[:citizenship]).last.id,
          :residential_country    => Location.locate_id_by_tag(father[:residential_country], 'Country')
      )
    end
    unless father_person.blank?
      PersonRelationship.create(
              person_a: person.id, person_b: father_person.person_id,
              person_relationship_type_id: PersonRelationType.where(name: father_type).last.id
      )
    end
    father_person
  end

  def self.new_informant(person, params)

    informant_person = nil; core_person = nil

    informant = params[:person][:informant]
    informant[:citizenship] = 'Malawian' if informant[:citizenship].blank?
    informant[:residential_country] = 'Malawi' if informant[:residential_country].blank?

    if params[:person][:type_of_birth].to_s.include? "Twin"
      informant_person = Person.find(params[:person][:prev_child_id]).informant
    elsif params[:person][:type_of_birth].to_s.include? "Triplet"
      informant_person = Person.find(params[:person][:prev_child_id]).informant

    elsif params[:informant_same_as_mother] == 'Yes'

      if params[:relationship] == "orphaned" || params[:relationship] == "adopted"
          informant_person = person.adoptive_mother
      else
         informant_person = person.mother
      end
    elsif params[:informant_same_as_father] == 'Yes'
      if params[:relationship] == "opharned" || params[:relationship] == "adopted"
          informant_person = person.adoptive_father
      else
         informant_person = person.father
      end
    else

      core_person = CorePerson.create(
          :person_type_id => PersonType.where(:name => 'Informant').last.id
      )

      informant_person = Person.create(
          :person_id          => core_person.id,
          :gender             => "N/A",
          :birthdate          => (informant[:birthdate].blank? ? "1900-01-01" : informant[:birthdate].to_date),
          :birthdate_estimated => (informant[:birthdate].blank? ? 1 : 0),
      )

      PersonName.create(
          :person_id   => informant_person.id,
          :first_name  => informant[:first_name],
          :middle_name => informant[:middle_name],
          :last_name   => informant[:last_name]
      )

      cur_district_id         = Location.locate_id_by_tag(informant[:current_district], 'District')
      cur_ta_id               = Location.locate_id(informant[:current_ta], 'Traditional Authority', cur_district_id)
      cur_village_id          = Location.locate_id(informant[:current_village], 'Village', cur_ta_id)

      home_district_id        = Location.locate_id_by_tag(informant[:home_district], 'District')
      home_ta_id              = Location.locate_id(informant[:home_ta], 'Traditional Authority', home_district_id)
      home_village_id         = Location.locate_id(informant[:home_village], 'Village', home_ta_id)

      PersonAddress.create(
          :person_id          => core_person.id,
          :current_district   => cur_district_id,
          :current_ta         => cur_ta_id,
          :current_village    => cur_village_id,
          :home_district   => home_district_id,
          :home_ta            => home_ta_id,
          :home_village       => home_village_id,
          :citizenship            => Location.where(country: informant[:citizenship]).last.id,
          :residential_country    => Location.locate_id_by_tag(informant[:residential_country], 'Country'),
          :address_line_1         => informant[:addressline_1],
          :address_line_2         => informant[:addressline_2]
      )

    end

    PersonRelationship.create(
        person_a: person.id, person_b: informant_person.id,
        person_relationship_type_id: PersonRelationType.where(name: 'Informant').last.id
    )

    if informant[:phone_number].present?
      PersonAttribute.create(
          :person_id                => informant_person.id,
          :person_attribute_type_id => PersonAttributeType.where(name: 'cell phone number').last.id,
          :value                    => informant[:phone_number],
          :voided                   => 0
      )
    end

    informant_person
  end

  def self.new_birth_details(person, params)
    if params[:person][:type_of_birth].to_s.include? "Twin"
      return self.birth_details_multiple(person,params[:person][:prev_child_id].to_i)
    elsif params[:person][:type_of_birth].to_s.include? "Triplet"
      return self.birth_details_multiple(person,params[:person][:prev_child_id].to_i)
    end
    person_id = person.id; place_of_birth_id = nil; location_id = nil; other_place_of_birth = nil
    person = params[:person]

    if SETTINGS['application_mode'] == 'FC'
      place_of_birth_id = Location.where(name: 'Hospital').last.id
      location_id = SETTINGS['location_id']
    else
      place_of_birth_id = Location.locate_id_by_tag(person[:place_of_birth], 'Place of Birth')

      if person[:place_of_birth] == 'Home'
        district_id = Location.locate_id_by_tag(person[:birth_district], 'District')
        ta_id = Location.locate_id(person[:birth_ta], 'Traditional Authority', district_id)
        village_id = Location.locate_id(person[:birth_village], 'Village', ta_id)
        location_id = [village_id, ta_id, district_id].compact.first #Notice the order

      elsif person[:place_of_birth] == 'Hospital'
        map =  {'Mzuzu City' => 'Mzimba',
                'Lilongwe City' => 'Lilongwe',
                'Zomba City' => 'Zomba',
                'Blantyre City' => 'Blantyre'}

        person[:birth_district] = map[person[:birth_district]] if person[:birth_district].match(/City$/)

        district_id = Location.locate_id_by_tag(person[:birth_district], 'District')
        location_id = Location.locate_id(person[:hospital_of_birth], 'Health Facility', district_id)

        location_id = [location_id, district_id].compact.first

      else #Other
        location_id = Location.where(name: 'Other').last.id #Location.locate_id_by_tag(person[:birth_district], 'District')
        other_place_of_birth = params[:other_birth_place_details]
      end
    end

    reg_type = SETTINGS['application_mode'] =='FC' ? BirthRegistrationType.where(name: 'Normal').first.birth_registration_type_id :
        BirthRegistrationType.where(name: params[:relationship]).last.birth_registration_type_id

    details = PersonBirthDetail.create(
        person_id:                                person_id,
        birth_registration_type_id:               reg_type,
        place_of_birth:                           place_of_birth_id,
        birth_location_id:                        location_id,
        other_birth_location:                     other_place_of_birth,
        birth_weight:                             person[:birth_weight],
        type_of_birth:                            PersonTypeOfBirth.where(name: (person[:type_of_birth] || 'Other')).last.id,
        parents_married_to_each_other:            (person[:parents_married_to_each_other] == 'No' ? 0 : 1),
        date_of_marriage:                         (person[:date_of_marriage].to_date.to_s rescue nil),
        gestation_at_birth:                       (params[:gestation_at_birth].to_f rescue nil),
        number_of_prenatal_visits:                (params[:number_of_prenatal_visits].to_i rescue nil),
        month_prenatal_care_started:              (params[:month_prenatal_care_started].to_i rescue nil),
        mode_of_delivery_id:                      (ModeOfDelivery.where(name: person[:mode_of_delivery]).first.id rescue 1),
        number_of_children_born_alive_inclusive:  (params[:number_of_children_born_alive_inclusive] rescue nil),
        number_of_children_born_still_alive:      (params[:number_of_children_born_still_alive] rescue nil),
        level_of_education_id:                    (LevelOfEducation.where(name: person[:level_of_education]).last.id rescue 1),
        court_order_attached:                     (person[:court_order_attached] == 'Yes' ? 1 : 0),
        parents_signed:                           (person[:parents_signed] == 'Yes' ? 1 : 0),
        form_signed:                              (person[:parents_signed] == 'Yes' ? 1 : 0),
        informant_relationship_to_person:          params[:person][:informant][:relationship_to_person],
        other_informant_relationship_to_person:   (params[:person][:informant][:relationship_to_person] == "Other" ? (params[:person][:informant][:other_relationship_to_child] rescue nil) : nil),
        acknowledgement_of_receipt_date:          (person[:acknowledgement_of_receipt_date].to_date rescue nil),
        location_created_at:                      SETTINGS['location_id'],
        date_registered:                          (Date.today.to_s)
    )

    return details
  
  end

  def self.birth_details_multiple(person,prev_child_id)
    prev_details = PersonBirthDetail.where(person_id: prev_child_id).first
    prev_details_keys = prev_details.attributes.keys
    prev_details_keys = prev_details_keys - ['person_id','person_birth_details_id']

    details = PersonBirthDetail.new
    details["person_id"] = person.id
    prev_details_keys.each do |field|
        details[field] = prev_details[field]
    end
    details.save!
    
    return details
  end

  def self.workflow_init(person,params)
    status = nil
    is_record_a_duplicate = params[:person][:duplicate] rescue nil
    if is_record_a_duplicate.present?
        if SETTINGS["application_mode"] == "FC"
          status = PersonRecordStatus.new_record_state(person.id, 'FC-POTENTIAL DUPLICATE')
        else
          status = PersonRecordStatus.new_record_state(person.id, 'DC-POTENTIAL DUPLICATE')
        end

        potential_duplicate = PotentialDuplicate.create(person_id: person.id,created_at: (Time.now))
        if potential_duplicate.present?
             is_record_a_duplicate.split("|").each do |id|
                potential_duplicate.create_duplicate(id)
             end
        end
    else
       status =PersonRecordStatus.new_record_state(person.id, 'DC-ACTIVE')
    end
    return status
  end
  
end
