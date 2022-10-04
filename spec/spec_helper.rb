require_relative '../lib/billing/taxes'
RSpec.configure do |config|
    config.color = true
    config.before(:each) { 
        @interactions = Billing::UserInteractions.new
        @receipt      = Billing::Receipt.new
    }
end
