@database = YAML.load_file("#{Rails.root}/config/couchdb.yml")[Rails.env]
location_id = SETTINGS['location_id'].to_s.rjust(5, '0').rjust(6, '1')
source = "#{@database['protocol']}://#{@database['username']}:#{@database['password']}@#{@database['host']}:#{@database['port']}/#{@database['prefix']}_#{@database['suffix']}"
target = "#{SETTINGS['sync_protocol']}://#{SETTINGS['sync_username']}:#{SETTINGS['sync_password']}@#{SETTINGS['sync_host']}/#{SETTINGS['sync_database']}"
replicator = "#{@database['protocol']}://#{@database['username']}:#{@database['password']}@#{@database['host']}:#{@database['port']}/_replicate"

doc = JSON.parse(`cd #{Rails.root}/db && curl -H 'Content-Type: application/json' -X GET #{source}/_design/MyLocation#{location_id}`)
if doc["error"].present?
`cd #{Rails.root}/db && curl -H 'Content-Type: application/json' -X PUT -d @filters.js #{source}/_design/MyLocation#{location_id}`
end

doc = JSON.parse(`cd #{Rails.root}/db && curl -H 'Content-Type: application/json' -X GET #{target}/_design/MyLocation#{location_id}`)
if doc["error"].present?
  `cd #{Rails.root}/db && curl -H 'Content-Type: application/json' -X PUT -d @filters.js #{target}/_design/MyLocation#{location_id}`
end

%x[curl -k -H 'Content-Type: application/json' -X POST -d '#{{
    source: source,
    target: target,
    connection_timeout: 10000,
    retries_per_request: 10,
    http_connections: 30,
    filter: ('MyLocation/my_location' + location_id),
    query_params: {
        location_id: location_id
    },
    continuous: true
}.to_json}' "#{replicator}"]

if SETTINGS['application_mode'] == 'DC'
    %x[curl -k -H 'Content-Type: application/json' -X POST -d '#{{
        source: target,
        target: source,
        connection_timeout: 10000,
        retries_per_request: 10,
        http_connections: 30,
        filter: ('MyLocation/my_location' + location_id),
        query_params: {
            location_id: location_id
        },
        continuous: true
         }.to_json}' "#{replicator}/_replicate"]
end



        
                  
        
                
