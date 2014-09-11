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
	class Dungeons < Lissio::Component
		def self.title
			'Dungeons'
		end

		def self.icon
			'dungeons.png'
		end

		class Path < Lissio::Component
			def initialize(parent, dungeon, path)
				@parent  = parent
				@dungeon = dungeon
				@path    = path
			end

			on :click do
				if @dungeon.done?(@path)
					@dungeon.reset(@path)
					element.remove_class :done
				else
					@dungeon.done(@path)
					element.add_class :done
				end

				@parent.update
			end

			on :render do
				if @dungeon.done?(@path)
					element.add_class :done
				end
			end

			text do |_|
				if @dungeon.name == 'TA'
					case @path
					when :story then 'S'
					when 1      then 'FW'
					when 2      then 'UP'
					when 3      then '80'
					end
				else
					case @path
					when :story then 'S'
					when 1      then 'P1'
					when 2      then 'P2'
					when 3      then 'P3'
					when 4      then 'P4'
					end
				end
			end

			css do
				cursor :pointer

				rule '&.done' do
					text decoration: 'line-through'
				end
			end
		end

		def initialize
			@dungeons = Dungeon.all
		end

		def update
			earnings = @dungeons.map(&:earnings).reduce(0, :+)
			gold     = (earnings / 100).floor
			silver   = earnings % 100

			element.at_css('.earnings .gold div').inner_text   = gold
			element.at_css('.earnings .silver div').inner_text = silver

			@dungeons.each_with_index {|dungeon, index|
				tokens = dungeon.tokens
				el     = element.at_css(".dungeon:nth-child(#{index + 1}) .icon div")

				if tokens == 0
					el.inner_text = ''
				else
					el.inner_text = tokens
				end
			}
		end

		on :click, '.dungeon .icon' do |e|
			Application.clipboard.set(e.on.data[:waypoint])
		end

		on :render do
			update
		end

		html do |_|
			@dungeons.each do |dungeon|
				_.div.dungeon do
					_.div.icon.data(waypoint: dungeon.waypoint) do
						_.img.src("img/dungeon/#{dungeon.name.downcase}.png")
						_.div
					end

					dungeon.paths.each do |path, value|
						_ << Path.new(self, dungeon, path)
					end
				end
			end

			_.div.style(clear: :both)

			_.div.earnings do
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
			rule '.dungeon' do
				float :left
				margin bottom: 5.px
				width 24.px
				text align: :center

				rule '& > div' do
					margin bottom: 5.px
				end

				rule '.icon' do
					position :relative

					rule 'div' do
						position :absolute
						top 0
						right 0
						font size: 10.px
					end
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
					end

					rule '& > *' do
						display 'inline-block'
						vertical align: :middle
					end
				end
			end
		end
	end
end
