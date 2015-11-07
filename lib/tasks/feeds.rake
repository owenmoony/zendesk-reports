namespace :feeds do

  desc 'Fetch all the zenddesk tickets'
  task fetch: :environment do

    client = ZendeskAPI::Client.new do |config|
      config.url = 'https://boxdice.zendesk.com/api/v2'
      config.username = ENV['ZENDESK_USER']
      config.token = ENV['ZENDESK_TOKEN']
      config.retry = true
      config.logger = Rails.logger
    end

    client.tickets.all do |ticket|
      File.open("data/#{ticket.id}.json", 'w') do |file|
        file.write(ticket.to_json)
      end
    end
  end
end
