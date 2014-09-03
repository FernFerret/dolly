#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Materials < Browser::Storage
	def initialize
		super(`window`, "materials")
	end

	def done?(name)
		self[name]
	end

	def done(name)
		self[name] = true
	end

	def reset(name = nil)
		if name
			self[name] = false
		else
			clear
		end
	end
end
