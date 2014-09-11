#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Boss < Browser::Storage
	At = Struct.new(:hours, :minutes, :seconds)

	def self.all
		(@list || []).map(&:new)
	end

	def self.inherited(klass)
		(@list ||= []) << klass
	end

	def self.times
		@times ||= []
	end

	def self.at(time)
		times << At.new(*time.split(?:).map(&:to_i), 0)
	end

	def self.type(value = nil)
		value ? @type = value : @type
	end

	def self.waypoint(value = nil)
		value ? @waypoint = value : @waypoint
	end

	def self.warmup(value = nil)
		value ? @warmup = At.new(0, *value.split(?:).map(&:to_i)) : @warmup
	end

	def self.duration(value = nil)
		value ? @duration = At.new(0, *value.split(?:).map(&:to_i)) : @duration
	end

	def initialize
		super(`window`, "boss.#{name}")
	end

	def times
		self.class.times
	end

	def type
		self.class.type
	end

	def waypoint
		self.class.waypoint
	end

	def warmup
		self.class.warmup
	end

	def duration
		self.class.duration
	end

	def name
		self.class.name.match(/([^:]+)$/)[1].gsub(/([A-Z])/, ' $1')[1 .. -1]
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

	class ShadowBehemot < self
		type     :low
		waypoint '[&BPwAAAA=]'

		duration '09:00'
		warmup   '01:00'

		at '01:45'
		at '03:45'
		at '05:45'
		at '07:45'
		at '09:45'
		at '11:45'
		at '13:45'
		at '15:45'
		at '17:45'
		at '19:45'
		at '21:45'
		at '23:45'
	end

	class FireElemental < self
		type     :low
		waypoint '[&BEYAAAA=]'

		duration '03:00'
		warmup   '09:00'

		at '00:45'
		at '02:45'
		at '04:45'
		at '06:45'
		at '08:45'
		at '10:45'
		at '12:45'
		at '14:45'
		at '16:45'
		at '18:45'
		at '20:45'
		at '22:45'
	end

	class GreatJungleWurm < self
		type     :low
		waypoint '[&BEEFAAA=]'

		duration '05:00'
		warmup   '02:00'

		at '01:15'
		at '03:15'
		at '05:15'
		at '07:15'
		at '09:15'
		at '11:15'
		at '13:15'
		at '15:15'
		at '17:15'
		at '19:15'
		at '21:15'
		at '23:15'
	end

	class FrozenMaw < self
		type     :low
		waypoint '[&BH4BAAA=]'

		duration '03:30'
		warmup   '04:00'

		at '00:15'
		at '02:15'
		at '04:15'
		at '06:15'
		at '08:15'
		at '10:15'
		at '12:15'
		at '14:15'
		at '16:15'
		at '18:15'
		at '20:15'
		at '22:15'
	end

	class Shatterer < self
		type     :standard
		waypoint '[&BE4DAAA=]'

		duration '07:00'
		warmup   '06:00'

		at '01:00'
		at '04:00'
		at '07:00'
		at '10:00'
		at '13:00'
		at '16:00'
		at '19:00'
		at '22:00'
	end

	class InquestGolemMarkII < self
		type     :standard
		waypoint '[&BNQCAAA=]'

		duration '06:00'
		warmup   '02:00'

		at '02:00'
		at '05:00'
		at '08:00'
		at '11:00'
		at '14:00'
		at '17:00'
		at '20:00'
		at '23:00'
	end

	class ClawOfJormag < self
		type     :standard
		waypoint '[&BHoCAAA=]'

		duration '17:00'
		warmup   '03:00'

		at '02:30'
		at '05:30'
		at '08:30'
		at '11:30'
		at '14:30'
		at '17:30'
		at '20:30'
		at '23:30'
	end

	class TaidhaConvington < self
		type     :standard
		waypoint '[&BNQCAAA=]'

		duration '04:00'
		warmup   '15:00'

		at '00:00'
		at '03:00'
		at '06:00'
		at '09:00'
		at '12:00'
		at '15:00'
		at '18:00'
		at '21:00'
	end

	class ModniirUlgoth < self
		type     :standard
		waypoint '[&BLEAAAA=]'

		duration '04:00'
		warmup   '10:00'

		at '01:30'
		at '04:30'
		at '07:30'
		at '10:30'
		at '13:30'
		at '16:30'
		at '19:30'
		at '22:30'
	end

	class Megadestroyer < self
		type     :standard
		waypoint '[&BM0CAAA=]'

		duration '12:00'
		warmup   '02:00'

		at '00:30'
		at '03:30'
		at '06:30'
		at '09:30'
		at '12:30'
		at '15:30'
		at '18:30'
		at '21:30'
	end

	class EvolvedJungleWurm < self
		type     :hardcore
		waypoint '[&BKoBAAA=]'

		duration '15:00'
		warmup   '10:00'

		at '01:00'
		at '04:00'
		at '08:00'
		at '12:30'
		at '17:00'
		at '20:00'
	end

	class TequatlTheSunless < self
		type     :hardcore
		waypoint '[&BNABAAA=]'

		duration '15:00'
		warmup   '00:00'

		at '00:00'
		at '03:00'
		at '07:00'
		at '11:30'
		at '16:00'
		at '19:00'
	end

	class KarkaQueen < self
		type     :hardcore
		waypoint '[&BNcGAAA=]'

		duration '05:00'
		warmup   '05:00'

		at '02:00'
		at '06:00'
		at '10:30'
		at '15:00'
		at '18:00'
		at '23:00'
	end

	class EyeOfZhaitan < self
		type     :off
		waypoint '[&BPgCAAA=]'
	end

	class RisenHighWizard < self
		type     :off
		waypoint '[&BB8DAAA=]'
	end

	class RhendakTheCrazed < self
		type     :off
		waypoint '[&BNwAAAA=]'
	end
	
	class FoulbearChieftain < self
		type     :off
		waypoint '[&BDwEAAA=]'
	end

	class DredgeCommissar < self
		type     :off
		waypoint '[&BD8FAAA=]'
	end

	class FireShaman < self
		type     :off
		waypoint '[&BO0BAAA=]'
	end

	class Balthazar < self
		type     :temple
		waypoint '[&BPoCAAA=]'
	end

	class Grenth < self
		type     :temple
		waypoint '[&BCIDAAA=]'
	end
	
	class Lyssa < self
		type     :temple
		waypoint '[&BK0CAAA=]'
	end

	class Dwayna < self
		type     :temple
		waypoint '[&BLACAAA=]'
	end

	class Melandru < self
		type     :temple
		waypoint '[&BBsDAAA=]'
	end
end
