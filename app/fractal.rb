#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Fractal < Browser::Storage
	def self.all
		1.upto(50).map {|level|
			new(level)
		}
	end

	attr_reader :level

	def initialize(level)
		super(`window`, "fractal.#{level}")

		@level = level
	end

	def done?
		self[:done]
	end

	def done
		self[:done] = true
	end

	def reset
		self[:done] = false
	end

	def agony
		case level
		when 1  .. 9  then 0
		when 10 .. 19 then 10
		when 20 .. 29 then 25
		when 30 .. 39 then 40
		when 40 .. 49 then 55
		when 50       then 70
		end
	end

	def relics
		case level
		when 1  .. 5  then 5
		when 6  .. 10 then 6
		when 11 .. 15 then 7
		when 16 .. 20 then 8
		when 21 .. 25 then 9
		when 26 .. 30 then 10
		when 31 .. 35 then 11
		when 36 .. 40 then 12
		when 41 .. 45 then 13
		when 46 .. 50 then 14
		end
	end
end
