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
	class Help < Lissio::Component
		def self.title
			'Help & About'
		end

		def self.icon
			'dashboard.png'
		end

		html do
			span 'help'
		end
	end
end
