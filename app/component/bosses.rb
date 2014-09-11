#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Component
	class Bosses < Lissio::Component
		def self.title
			'World Bosses'
		end

		def self.icon
			'bosses.png'
		end

		def initialize
			@tiers = [Tier.new(:low),
			          Tier.new(:standard),
			          Tier.new(:hardcore),
			          Tier.new(:off),
			          Tier.new(:temple)]
		end

		on 'page:load' do
			@tiers.each {|tier|
				tier.trigger! 'page:load'
			}
		end

		on 'page:unload' do
			@tiers.each {|tier|
				tier.trigger! 'page:unload'
			}
		end
	
		html do |_|
			@tiers.each {|tier|
				_ << tier
			}
		end
	end
end

require 'component/bosses/boss'
require 'component/bosses/tier'
