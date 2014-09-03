#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'browser/interval'

module Component
	class Dashboard < Lissio::Component
		def self.title
			'Dolly'
		end

		def self.icon
			'icon.png'
		end

		on 'page:load' do
			@interval = every 60 do
				time    = Time.new
				hours   = 23 - `#{time}.getUTCHours()`
				minutes = 59 - `#{time}.getUTCMinutes()`

				element.at_css('.timer').inner_text = '%02d:%02d' % [hours, minutes]
			end

			@interval.call
		end

		on 'page:unload' do
			@interval.abort
		end

		html do
			div.timer
		end

		css do
			rule '.timer' do
				padding right: 35.px
				text align: :center
				font size: 80.px
			end
		end
	end
end
