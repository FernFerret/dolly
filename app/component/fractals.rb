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
	class Fractals < Lissio::Component
		def self.title
			'Fractals'
		end

		def self.icon
			'fractals.png'
		end

		class Level < Lissio::Component
			def initialize(parent, fractal)
				@parent  = parent
				@fractal = fractal
			end

			def method_missing(*args, &block)
				@fractal.__send__(*args, &block)
			end

			on :click do
				if done?
					reset
					element.remove_class :done
				else
					done
					element.add_class :done
				end

				@parent.update
			end

			on :render do
				if done?
					element.add_class :done
				end
			end

			text do |_|
				level
			end

			css do
				cursor :pointer

				rule '&.done' do
					text decoration: 'line-through'
				end
			end
		end

		def initialize
			@fractals = Fractal.all
		end

		def update
			relics = @fractals.reduce 0 do |total, fractal|
				if fractal.done?
					total + fractal.relics * 4
				else
					total
				end
			end

			earnings = 0
			pristine = 0

			@fractals.each_slice(10).each_with_index {|fractals, tier|
				icon = element.at_css(".tier:nth-child(#{tier + 1}) .scale img")

				if fractals.any?(&:done?)
					icon.add_class :done

					pristine += 15

					case tier
					when 0
						relics   += 20
						earnings += 100

					when 1
						relics   += 20
						earnings += 110

					when 2
						relics   += 30
						earnings += 120

					when 3
						relics   += 35
						earnings += 130

					when 4
						relics   += 40
						earnings += 140
					end
				else
					icon.remove_class :done
				end
			}

			element.at_css('.earnings .relics .normal').inner_text = relics

			if pristine > 0
				element.at_css('.earnings .relics .pristine').inner_text = "+#{pristine}"
			end

 			gold   = (earnings / 100).floor
			silver = earnings % 100

			element.at_css('.earnings .gold div').inner_text   = gold
			element.at_css('.earnings .silver div').inner_text = silver
		end

		on :render do
			update
		end

		html do |_|
			@fractals.each_slice 10 do |fractals|
				_.div.tier do
					_.div.scale do
						_.img.src('img/pristine.fractal.relic.png')
					end

					fractals.each do |fractal|
						_ << Level.new(self, fractal)
					end
				end
			end

			_.div.style(clear: :both)

			_.div.earnings do
				_.div.relics do
					_.img.src('img/fractal.relic.png')
					_.div.normal '0'
					_.div.pristine
				end

				_.div.gold do
					_.img.src('img/gold.png')
					_.div '0'
				end

				_.div.silver do
					_.img.src('img/silver.png')
					_.div '0'
				end

			end

			_.div.style(clear: :both)
		end

		css do
			rule '.tier' do
				float :left
				margin bottom: 10.px
				width 38.px
				text align: :center

				rule '.scale img' do
					width 20.px
					height 20.px

					border 1.px, :solid, :black
					border radius: 5.px
					box shadow: [0.px, 0.px, 5.px, 0.px, rgba(50, 50, 50, 0.75)]

					opacity 0.8

					rule '&.done' do
						opacity 1.0
					end
				end

				rule '& > div' do
					margin bottom: 5.px
				end
			end

			rule '.earnings' do
				rule '& > div' do
					float :left
					margin right:  15.px,
					       bottom: 10.px

					rule 'img' do
						vertical align: :middle
						margin right: 5.px
						width 18.px
						height 18.px
					end

					rule '& > *' do
						display 'inline-block'
						vertical align: :middle
					end

					rule '.pristine' do
						margin left: 5.px
					end
				end
			end
		end
	end
end
