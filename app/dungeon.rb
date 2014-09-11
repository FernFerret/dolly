#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dungeon < Browser::Storage
	def self.all
		(@list || []).map(&:new)
	end

	def self.inherited(klass)
		(@list ||= []) << klass
	end

	def self.paths
		@paths ||= {}
	end

	def self.story(value)
		paths[:story] = value
	end

	def self.path(number, value)
		paths[number] = value
	end

	def self.title(value = nil)
		value ? @title = value : @title
	end

	def self.waypoint(value = nil)
		value ? @waypoint = value : @waypoint
	end

	def initialize
		super(`window`, "dungeon.#{name}")
	end

	def title
		self.class.title
	end

	def name
		self.class.name.match(/([^:]+$)/)[0]
	end

	def paths
		self.class.paths
	end

	def waypoint
		self.class.waypoint
	end

	def earnings
		total = 0

		each {|path, done|
			if done
				total += paths[path]

				if path != :story
					total += 26
				end
			end
		}

		total
	end

	def tokens
		total = 0

		each {|path, done|
			if path != :story && done
				total += 60
			end
		}

		total
	end

	def done?(path)
		self[path]
	end

	def done(path)
		unless paths.has_key? path
			raise ArgumentError, "unknown path: #{path}"
		end

		self[path] = true
	end

	def reset(path = nil)
		if path
			unless self.class.paths.has_key? path
				raise ArgumentError, "unknown path: #{path}"
			end

			self[path] = false
		else
			clear
		end
	end

	class AC < self
		title    'Ascalonian Catacombs'
		waypoint '[&BIYBAAA=]'

		story 50

		path 1, 1_55
		path 2, 1_55
		path 3, 1_55
	end

	class CM < self
		title    "Caudecus's Manor"
		waypoint '[&BPoAAAA=]'

		story 50

		path 1, 1_05
		path 2, 1_05
		path 3, 1_05
	end

	class TA < self
		title    'Twilight Arbor'
		waypoint '[&BEEFAAA=]'

		story 50
		
		path 1, 1_05
		path 2, 1_05
		path 3, 2_05
	end

	class SE < self
		title    "Sorrow's Embrace"
		waypoint '[&BD8FAAA=]'

		story 50

		path 1, 1_05
		path 2, 1_05
		path 3, 1_05
	end

	class CoF < self
		title    'Citadel of Flame'
		waypoint '[&BEAFAAA=]'

		story 50

		path 1, 1_05
		path 2, 1_05
		path 3, 1_05
	end

	class HotW < self
		title    'Honor of the Waves'
		waypoint '[&BEMFAAA=]'

		story 50

		path 1, 1_05
		path 2, 1_05
		path 3, 1_05
	end

	class CoE < self
		title    'Crucible of Eternity'
		waypoint '[&BEIFAAA=]'

		story 50

		path 1, 1_05
		path 2, 1_05
		path 3, 1_05
	end

	class Arah < self
		title    'Ruined City of Arah'
		waypoint '[&BCADAAA=]'

		story 50

		path 1, 3_05
		path 2, 3_05
		path 3, 1_05
		path 4, 3_05
	end
end
