#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'lissio/component/markdown'

module Component
	class Help < Lissio::Component::Markdown
		def self.title
			'Help & About'
		end

		def self.icon
			'icon.png'
		end

		content <<-MD.gsub(/^\t{3}/m, '')
			Daily Dolly is developed by **meh.6784** and the source is available on
			[GitHub](https://github.com/meh/dolly).

			General
			=======
			Daily Dolly is designed to help you keep track of everything time-gated
			on a daily basis that isn't somehow provided by the standard GW2 UI, this
			includes dungeons, fractals, crafting and world bosses.

			To minimize the window double click the icon on the top left, keep in
			mind this icon will change depending on the section you're viewing but
			its functionality won't change.

			To move the window around click and drag the icon mentioned above.

			To access a section, click on the title next to the icon and select the
			section from the dropdown menu.

			To access the options panel click on the gear icon on the top
			right.

			Dungeons
			========
			Keep track of the dungeon paths you've done, including earnings in gold,
			silver and tokens.

			Clicking on a path will mark it as done, and update the earnings at the
			bottom.

			Fractals
			========
			Keep track of the fractal levels you've done, including earnings in gold,
			silver, fractal relics and pristine fractal relics.
			
			Clicking on a level will mark it as done, and update the earnings at the
			bottom.

			Crafting
			========
			Keep track of the various time-gated craftables, this includes ascended
			mats, items for Mawdrey and miscellanea.

			Clicking on a crafting item will mark it as done.

			World Bosses
			============
			Keep track of the various world bosses in the world, including the
			off-schedule ones.

			Clicking on the waypoint icon will copy the closest waypoint to the
			clipboard.

			Clicking on the world boss name will mark it as done.

			A green timer represents hours and minutes remaining before the
			activation window begins, when one minute is left it will start blinking.

			During the event window the timer represents minutes and seconds passed
			since its beginning, it will be orange during warmup, red during its
			duration, and it will start blinking when it ended.

			*The warmup and duration times are approximations.*

			Options
			=======
			There are various options to adapt Daily Dolly to your liking.

			- `Interface Size` should be the same you configured Guild Wars 2 with.
			- `In-Game Only` allows you to show the interface either only while in
			  game or even on your desktop.
			- `Language` allows you to change the language from a list of GW2
			  supported languages.
		MD

		def children(parent)
			array = []
			el    = parent.next_element

			until el.nil? || el =~ parent.name || el =~ 'h1'
				array << el

				el = el.next_element
			end

			Browser::DOM::NodeSet[array]
		end

		on :click, 'h1' do |e|
			if e.on.at_css('.arrow').class_names.include? :open
				children(e.on).style(display: :none)
				e.on.at_css('.arrow').remove_class :open
			else
				element.css('h1').each {|el|
					el.at_css('.arrow').remove_class :open
					children(el).style(display: :none)
				}

				children(e.on).style(display: :block)
				e.on.at_css('.arrow').add_class :open
			end
		end

		on :render do
			element.css('a').each {|el|
				el[:target] = :_blank
			}

			element.css('h1').each {|el|
				el >> DOM do
					div.arrow do
						img.minus
						img.plus
					end
				end
			}
		end

		css do
			padding right: 30.px
			text align: :justify

			rule '.hotkey', 'pre', 'code' do
				font family: :monospace,
				     size: 10.px
			end

			rule 'a' do
				font weight: :bold
				color :white
				text decoration: :none,
				     shadow: (', 0 0 2px black' * 10)[1 .. -1] +
				             (', 0 0 1px black' * 10)

				rule '&:hover' do
					color :white
					text decoration: :none,
					     shadow: (', 0 0 2px #951111' * 10)[1 .. -1] +
					             (', 0 0 1px #951111' * 10)
				end
			end

			rule 'p:first-child' do
				margin 10.px, 0
			end

			rule '.arrow' do
				font size: 10.px

				rule '.minus' do
					display :none
				end

				rule '&.open' do
					rule '.plus' do
						display :none
					end

					rule '.minus' do
						display 'inline-block'
					end
				end

				rule '.minus' do
					content url('img/minus.png')
					filter grayscale(100.%)
					width 12.px
				end

				rule '.plus' do
					content url('img/plus.png')
					filter grayscale(100.%)
					width 12.px
				end
			end

			rule 'h1' do
				margin 5.px, 0

				rule '&#general' do
					margin top: 10.px
				end

				position :relative

				rule '.arrow' do
					position :absolute
					top 4.px
					left -18.px
				end
			end

			rule 'h2' do
				margin 5.px, 0

				rule '&#timer' do
					margin top: 10.px
				end

				rule '.arrow' do
					display 'inline-block'

					position :relative
					top -2.px

					padding right: 8.px
				end
			end

			rule '& > *' do
				display :none
			end

			rule 'h1', 'p:first-child' do
				display :block
			end

			rule 'p' do
				margin 5.px, 0
			end

			rule 'ul' do
				padding 0
				margin top: 0
				list style: :none

				rule 'li' do
					text indent: -12.px
					padding bottom: 5.px

					rule '&::before' do
						padding right: 5.px
						content '• '.inspect
					end
				end
			end
		end
	end
end
