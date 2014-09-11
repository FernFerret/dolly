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
	class Bosses::Tier < Lissio::Component
		def initialize(type)
			@type   = type
			@bosses = ::Boss.all.group_by { |b| b.type }[type].map {|boss|
				Boss.new(self, boss)
			}
		end

		def open?
			Application.state["bosses.#@type"]
		end

		def open!
			element.add_class :open
			Application.state["bosses.#@type"] = true
		end

		def close!
			element.remove_class :open
			Application.state.delete("bosses.#@type")
		end

		def type
			case @type
			when :low      then 'Low'
			when :standard then 'Standard'
			when :hardcore then 'Hardcore'
			when :off      then 'Off-Schedule'
			when :temple   then 'Temple'
			end
		end

		on :click, '.type, .arrow' do |e|
			if open?
				close!
			else
				open!
			end
		end

		on 'page:load' do
			@bosses.each {|boss|
				boss.trigger! 'page:load'
			}
		end

		on 'page:unload' do
			@bosses.each {|boss|
				boss.trigger! 'page:unload'
			}
		end

		on :render do
			element.add_class @type

			if open?
				open!
			end
		end

		html do |_|
			_.div.type type
			_.div.arrow do
				_.i.fa.fa[:minus, :square]
				_.i.fa.fa[:plus, :square]
			end

			_.div.bosses do
				@bosses.each {|boss|
					_ << boss
				}
			end
		end

		css do
			position :relative

			rule '.bosses' do
				max height: 0.px
				transition 'max-height', 1.s
				overflow :hidden

				position :relative
				left -25.px

				rule '.boss:last-child' do
					padding bottom: 10.px
				end
			end

			rule '&.open .bosses' do
				max height: 150.px
			end

			rule '.arrow' do
				position :absolute
				top 5.px
				left -20.px
				font size: 10.px
			end

			rule '.arrow .fa-minus-square' do
				display :none
			end

			rule '&.open .arrow' do
				rule '.fa-plus-square' do
					display :none
				end

				rule '.fa-minus-square' do
					display 'inline-block'
				end
			end

			rule '.type' do
				font size: 18.px
				margin bottom: 5.px
			end

			rule '&.low' do
				rule '.type' do
					text shadow: (', 0 0 2px #007a20' * 10)[1 .. -1] +
					             (', 0 0 1px #007a20' * 10)
				end
			end

			rule '&.standard' do
				rule '.type' do
					text shadow: (', 0 0 2px #ff6000' * 10)[1 .. -1] +
					             (', 0 0 1px #ff6000' * 10)
				end
			end

			rule '&.hardcore' do
				rule '.type' do
					text shadow: (', 0 0 2px #b20000' * 10)[1 .. -1] +
					             (', 0 0 1px #b20000' * 10)
				end
			end
		end
	end
end
